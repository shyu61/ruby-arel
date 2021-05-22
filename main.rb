require 'rubygems'
require 'bundler'
Bundler.require

require 'arel'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    database: 'arel_research',
    host: 'localhost',
    username: 'shu_omura',
    password: 'password'
)
Arel::Table.engine = ActiveRecord::Base


product = Arel::Table.new(:products)
binding.pry
product.project('*').where(product[:price].eq(1000)).to_sql

p "======="