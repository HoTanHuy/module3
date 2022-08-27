import model.Client;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ClientServlet", value = "/client")
public class ClientServlet extends HttpServlet {
    private static List<Client> clientList = new ArrayList<>();
    static {
        //id,name,birth,address,img
        clientList.add(new Client(1,"Mai Van Hoan","1983-08-20","Ha Noi","https://digitalfuture.vn/wp-content/uploads/2022/03/1647534445_523_TOP-100-Hinh-Anh-Anime-Ngau-Loi-Lanh-Lung-va.jpg"));
        clientList.add(new Client(2,"Nguyen Van Nam","1983-08-21","Bac Giang","https://digitalfuture.vn/wp-content/uploads/2022/03/TOP-100-Hinh-Anh-Anime-Ngau-Loi-Lanh-Lung-va.jpg"));
        clientList.add(new Client(3,"Nguyen Thai Hoa","1983-08-22","Nam Dinh","https://digitalfuture.vn/wp-content/uploads/2022/03/1647534442_780_TOP-100-Hinh-Anh-Anime-Ngau-Loi-Lanh-Lung-va.jpg"));
        clientList.add(new Client(4,"Tran Đang Khoa","1983-08-17","Ha Tay","https://digitalfuture.vn/wp-content/uploads/2022/03/1647534442_241_TOP-100-Hinh-Anh-Anime-Ngau-Loi-Lanh-Lung-va.jpg"));
        clientList.add(new Client(5,"Nguyen Dinh Thi","1983-08-19","Ha Noi","https://digitalfuture.vn/wp-content/uploads/2022/03/1647534443_169_TOP-100-Hinh-Anh-Anime-Ngau-Loi-Lanh-Lung-va.jpg"));
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("client/list.jsp");
        request.setAttribute("clientList",clientList);
        requestDispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
