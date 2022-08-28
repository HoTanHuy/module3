package service;

import model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();
    boolean add(Product product);
    void update(int id , Product product);
    Product findById(int id);
    boolean delete(int id);
}
