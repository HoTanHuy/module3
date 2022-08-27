package controller;

import model.Product;
import service.IProductService;
import service.impl.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "controller.ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    private IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action =request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showFormCreate(request,response);
                // thêm mới
                break;
            case "delete":
                // xoá
                break;
            case "edit":
                showFormEdit(request,response);
                // sửa
                break;
            default:
                // trả về trang list
                showListStudent(request, response);
        }
    }

    private void showFormEdit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = this.productService.findById(id);
        RequestDispatcher requestDispatcher;
        request.setAttribute("product", product);
        requestDispatcher = request.getRequestDispatcher("view/product/edit.jsp");
    }

    private void showListStudent(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view/product/list.jsp");
        request.setAttribute("productList", this.productService.findAll());
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void showFormCreate(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view/product/create.jsp");
        try {
            requestDispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                // lấy dữ liêu và lưu vào db
                save(request,response);
                break;
            case "delete":
                // xoá
                delete(request,response);
                break;
            default:
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        int idDelete = Integer.parseInt(request.getParameter("deleteId"));
        boolean check = productService.delete(idDelete);
        String mess ="xoa thành công";
        if (!check){
            mess =" xoá không thành công";
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view/product/list.jsp");
        request.setAttribute("productList", this.productService.findAll());
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String describe = request.getParameter("describe");
        String producer = request.getParameter("producer");
        Product product = new Product(id,name,price,describe,producer);
        boolean check = productService.add(product);
        String mess = "Added!!!";
        if(!check){
            mess = "Not added yet!!!";
        }
        request.setAttribute("mess", mess);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("view/product/create.jsp");
        try {
            requestDispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
