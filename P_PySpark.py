# pip3 install pyspark

import pyspark

# Below code is Spark 2+
spark = pyspark.sql.SparkSession.builder.appName('test').getOrCreate()

spark.range(10).collect()


#
