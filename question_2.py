# Databricks notebook source
# dbutils.widgets.removeAll()

from collections import defaultdict

dbutils.widgets.text("File Name", "txt_file_2.txt")
file_name = dbutils.widgets.get("File Name")

dbutils.widgets.dropdown("Character Count Type", "All", ["All","Specific"])
character_count_type = dbutils.widgets.get("Character Count Type")

dbutils.widgets.text("Character", "")
character = dbutils.widgets.get("Character")

def lower_string(payload):
   return payload.lower()

def replace_tab(payload):
   return (payload.replace('\t','___'))

def count_alphabet(count_type,character,v_text):
   text = v_text
   if (count_type == 'All'):
       chars = defaultdict(int)

       for char in text:
           chars[char] += 1
       print(chars)       
   else:
       print(text.count(character))

file = open(f"/dbfs/FileStore/{file_name}", "r")
v_data = file.read()
v_data = lower_string(v_data)
v_data = replace_tab(v_lower)
print(v_data)

count_alphabet(character_count_type,character,v_data)
