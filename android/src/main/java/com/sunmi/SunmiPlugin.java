package com.sunmi;

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
import woyou.aidlservice.jiuiv5.ICallback;


/**
 * SunmiPlugin
 */
public class SunmiPlugin implements MethodCallHandler {
    public static AidlUtil aidl = AidlUtil.getInstance();

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "sunmi");
        channel.setMethodCallHandler(new SunmiPlugin());
        aidl.connectPrinterService(registrar.context());
        aidl.initPrinter();
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
//        if (call.method.equals("getPlatformVersion")) {
//            result.success("Android " + android.os.Build.VERSION.RELEASE);
//        } else {
//            result.notImplemented();
//        }

        switch (call.method) {
            case "printText":
                String _printText = call.argument("printText");
                int _fontSize = call.argument("fontSize");
                boolean _isBold = call.argument("isBold");
                boolean _isUnderline = call.argument("isUnderline");
                int _alignment = call.argument("alignment");

                aidl.printText(_printText,_fontSize,_isBold,_isUnderline,_alignment);

                result.success("Success");

                break;
            case "printQRCode":
                String _data = call.argument("data");
                int _moduleSize = call.argument("moduleSize");
                int _errorLevel = call.argument("errorLevel");
                _alignment = call.argument("alignment");

                aidl.printQr(_data,_moduleSize,_errorLevel,_alignment);

                break;
            case "printImage":
                String _imagePath = call.argument("imagePath");
                _alignment = call.argument("alignment");

                aidl.printBitmap(_imagePath,_alignment);

                break;
            default:
                result.notImplemented();
        }
    }

    private String getPrinterSerialNo() throws AndroidException {
        return aidl.getPrinterSerialNo();
    }
}
