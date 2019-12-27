package com.sunmi;

import android.app.Activity;
import android.graphics.Bitmap;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.AndroidException;
import android.util.Log;

import com.sunmi.printerhelper.utils.AidlUtil;
import com.sunmi.printerhelper.utils.PrinterCallback;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.view.FlutterMain;
import io.flutter.view.FlutterView;
import woyou.aidlservice.jiuiv5.ICallback;

/**
 * SunmiPlugin
 */
public class SunmiPlugin implements MethodCallHandler {
    public static AidlUtil aidl = AidlUtil.getInstance();
    private final Activity activity;

    private SunmiPlugin(Activity activity){
        this.activity = activity;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "sunmi");
        channel.setMethodCallHandler(new SunmiPlugin(registrar.activity()){

        });
        aidl.connectPrinterService(registrar.context());
        aidl.initPrinter();
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        switch (call.method) {
            case "printText":
                String _printText = call.argument("printText");
                int _fontSize = call.argument("fontSize");
                boolean _isBold = call.argument("isBold");
                boolean _isUnderline = call.argument("isUnderline");
                int _alignment = call.argument("alignment");

                try{
                    aidl.printText(_printText,_fontSize,_isBold,_isUnderline,_alignment,new ICallback.Stub(){
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {

                        }

                        @Override
                        public void onReturnString(String result) throws RemoteException {

                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {
//                            result.success("Success");
                            final int res = code;

                            activity.runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    if(res == 0){//打印成功
                                        result.success("Success");
                                    }else{//打印失败
                                        result.success("Failed");
                                    }
                                }
                            });
                        }
                    });
//                    result.success("Success");
                }catch(Exception e) {
                    result.error("printText Error", "${e.getMessage()}", "Error");
                }
                break;
            case "printQRCode":
                String _data = call.argument("data");
                int _moduleSize = call.argument("moduleSize");
                int _errorLevel = call.argument("errorLevel");
                _alignment = call.argument("alignment");

                try{
                    aidl.printQr(_data, _moduleSize, _errorLevel, _alignment, new ICallback.Stub(){
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {

                        }

                        @Override
                        public void onReturnString(String result) throws RemoteException {

                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {
//                            result.success("Success");
                            final int res = code;

                            activity.runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    if(res == 0){//打印成功
                                       result.success("Success");
                                    }else{//打印失败
//                                        result.error("Failed",null,null);
                                        result.success("Failed");
                                    }
                                }
                            });
                        }
                    });
//                    result.success("Success");
                }catch(Exception e) {
                    result.error("printQRCode Error", "${e.getMessage()", "Error");
                }

                break;
            case "printImage":
                String _imagePath = call.argument("imagePath");
                _alignment = call.argument("alignment");

                try{
                    aidl.printBitmap(_imagePath,_alignment,new ICallback.Stub(){
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {

                        }

                        @Override
                        public void onReturnString(String result) throws RemoteException {

                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {
//                            result.success("Success");
                            final int res = code;

                            activity.runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    if(res == 0){//打印成功
                                        result.success("Success");
                                    }else{//打印失败
//                                        result.error("Failed",null,null);
                                        result.success("Failed");
                                    }
                                }
                            });
                        }
                    });
//                    result.success("Success");
                }catch(Exception e){
                    result.error("printImage Error","${e.getMessage()}","Error");
                }
                break;
            default:
                result.notImplemented();
        }
    }
}
