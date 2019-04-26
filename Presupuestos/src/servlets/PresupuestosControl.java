package servlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PresupuestosControl
 */
@WebServlet("/PresupuestosControl")
public class PresupuestosControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PresupuestosControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    PrintWriter out = response.getWriter();

	    out.println(jsonParams("", 0));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    PrintWriter out = response.getWriter();
	    String mensaje = "";
	    
	    switch(request.getParameter("tipo")) {
		    case "C":
		    	 mensaje = setCargo(Float.parseFloat(request.getParameter("saldo")), Float.parseFloat(request.getParameter("cantidad")));
		    	break;
		    case "A":
		    	mensaje = setAbono(Float.parseFloat(request.getParameter("saldo")), Float.parseFloat(request.getParameter("cantidad")));
		    	break;
	    }
	    
	    out.println(mensaje);
	}
	
	private static String setAbono(float saldo, float cantidad){
    	saldo += cantidad;
		
		return jsonParams("Saldo actual: " + String.valueOf(saldo), saldo);		
    }
    
    private static String setCargo(float saldo, float cantidad){
    	if(saldo<cantidad)
    		return jsonParams("Saldo insuficiente ("+String.valueOf(saldo)+" < "+String.valueOf(cantidad)+")", saldo);
    	else{
    		saldo -= cantidad;
    		
    		return jsonParams("Saldo actual: " + String.valueOf(saldo), saldo);
    	}    		
    }
    
    private static String jsonParams(String msg, float saldo) {
    	return "{\"mensaje\": \""+msg+"\", \"saldo\": \""+saldo+"\"}";
    }

}
