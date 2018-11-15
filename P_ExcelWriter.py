# !pip install xlsxwriter
import pandas as pd

df = pd.DataFrame([{'foo':i,'bar':2*i,'baz':3*i} for i in range(76)])

writer = pd.ExcelWriter('sample_xl.xlsx',engine='xlsxwriter')
# Convert the dataframe to an XlsxWriter Excel object.
df.to_excel(writer, sheet_name='Sheet1')

# Get the xlsxwriter workbook and worksheet objects.
workbook  = writer.book
worksheet = writer.sheets['Sheet1']

# Add some cell formats.
format1 = workbook.add_format({'bg_color': '#FFC7CE',
                               'font_color': '#9C0006'})
format2 = workbook.add_format({'bg_color': '#C6EFCE',
                               'font_color': '#006100'})
# How to add conditional formatting:
# Write a conditional format over a range.
worksheet.conditional_format('B2:D77', {'type': 'cell',
                                         'criteria': '>=',
                                         'value': 50,
                                         'format': format1})
worksheet.conditional_format('B2:D77', {'type': 'cell',
                                         'criteria': '<',
                                         'value': 50,
                                         'format': format2})
# Note: It isn't possible to format any cells that already have a format such
# as the index or headers or any cells that contain dates or datetimes.

# Set the column width and format.
# worksheet.set_column('B:B', 18, format1)

# Set the format but not the column width.
# worksheet.set_column('C:C', None, format2)

# Close the Pandas Excel writer and output the Excel file.
writer.save()
