import javax.servlet.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebFilter(filterName = "TestFilter", value = "/*")
public class TestFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
//        config.getInitParameter("requestEncoding");
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding("utf-8");
        }
        response.setContentType("text/json; charset=UTF-8");
        chain.doFilter(request, response);
    }
}
