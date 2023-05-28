# -*- coding: utf-8 -*-
"""pyspark_basic_learning

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/13CxjNWIwpqhp_pnBSyJFwNJVDk9SoGyf
"""

!apt-get install openjdk-8-jdk-headless -qq > /dev/null
!wget -q http://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
!tar xf spark-3.1.1-bin-hadoop3.2.tgz
!pip install -q findspark

import os
os.environ["JAVA_HOME"] = "/usr/lib/jvm/java-8-openjdk-amd64"
os.environ["SPARK_HOME"] = "/content/spark-3.1.1-bin-hadoop3.2"

!ls

import findspark
findspark.init()
from pyspark.sql import SparkSession
spark = SparkSession.builder.master("local[*]").getOrCreate()
spark.conf.set("spark.sql.repl.eagerEval.enabled", True) # Property used to format output tables better
spark

data=spark.read.option('header',True).option("inferSchema",True).csv("/content/housing.csv")

data.show(10)

data.printSchema()

### reading file with custom schema

from pyspark.sql.types import StructType,StructField,  IntegerType, DoubleType
newschema=StructType(
[
StructField("longitude",DoubleType(),True),
StructField("latitude",DoubleType(),True),
StructField("total-rooms",DoubleType(),True)
]
)

datatemp=spark.read.option('header',True).schema(newschema).csv("/content/housing.csv")

datatemp.show(10)
datatemp.printSchema()

## read json
jsondata=spark.read.option('inferSchema',True).json('/content/stk.json')

jsondata.show(10)

## basic functions
data.show(10)

## select a column in df
data.select('longitude').show(10)

data.select('longitude','latitude').show(10)

## col alias
from pyspark.sql.functions import col
data.select(col("longitude").alias('long')).show(10)

## selctexpr - select expr uses sql like statements to select from df
data.selectExpr("longitude as long","latitude as lat").show(10)

data.selectExpr("cast(housing_median_age as int) as int_ages").show(10)

## same using col
data.select(col('housing_median_age').cast('int').alias('int_ages')).show(10)

## withcolumn withColumn(colName : String, col : Column) : DataFrame
## withcolumn can be used to create new column based on exisitng column, updateexisting columns, cast values

data.withColumn("housing_median_age_double",col('housing_median_age')*2).show(10)

#update existing column
data.withColumn("housing_median_age",col('housing_median_age')*2).show(10)

## rename a column withColumnRenamed(col existing, new col name)
data.withColumnRenamed("housing_median_age","hosing_med_ages").show(10)

## drop columns
df=data.withColumn("long",data['longitude'])

df.show(10)

df.drop('long')
## drop doesnt update or change existing dataframe, it returns a new data frame like functions above
df.show(10)

df2=df.drop('long')
df2.show(10)

## where and filter , where is alias for filter
data.filter('total_bedrooms > 1000').show(10)

data.where('total_bedrooms > 1000').show(10)

data.sort('total_bedrooms',ascending=False).show(10)

##aggregations

data.groupBy('longitude').sum('total_rooms').orderBy('sum(total_rooms)',ascending=False).show(10)

# multiple aggregates
from pyspark.sql.functions import sum,avg,max,count

data.groupBy('longitude','latitude').agg(count('*').alias('total_rows')).show(10)

df=data.groupBy('longitude','latitude').agg(sum('total_rooms').alias('sum_rooms'),max('total_rooms')\
                                         .alias('max_rooms')).orderBy('sum_rooms',ascending=False)

df.show(10)

df.filter(('longitude=-121.44') and ('latitude=38.43'))

## writes 

data.write.option('header',True).csv("/content/housing2.csv")

## get number of partitions
print(data.rdd.getNumPartitions)

# using save
data.write.save("/content/housing3.csv",format='csv',mode='overwrite',header=True)

## save as parquet
data.write.save("/content/housing3.parquet",format='parquet',mode='overwrite',header=True)

## save as table
data.write.mode('ignore').saveAsTable("housing")

spark.catalog.listTables()

## using spark sql 
spark.sql("SELECT * FROM housing ORDER BY total_rooms DESC limit 10")
