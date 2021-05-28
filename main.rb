require 'rubygems'
require 'bundler'
Bundler.require

require 'arel'
require 'active_record'
require 'graphviz'
require 'pry'

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    database: 'arel_research',
    host: 'localhost',
    username: 'shu_omura',
    password: 'password'
)
Arel::Table.engine = ActiveRecord::Base

def gviz(arel)
  GraphViz.parse_string(arel.to_dot).output(png: 'arel_research.png')
end

products = Arel::Table.new(:products)
# gviz(products.project('*').where(products[:price].eq(1000)))
res = products.project('*').where(products[:price].eq(1000))
# binding.pry
p res.to_sql

p "======="
