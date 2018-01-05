Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:57329
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751495AbeAEPZe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jan 2018 10:25:34 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w05FPViD015872
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Fri, 5 Jan 2018 07:25:31 -0800
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 2/2] staging:iio:docs: add ad7291 doc to detail dt usage
Date: Fri, 5 Jan 2018 15:25:30 +0000
Message-ID: <E2AE62E8D995114A80E27C874A28DB3C97C2A3@NWD2MBX7.ad.analog.com>
References: <20180105152133.9681-1-alexandru.ardelean@analog.com>,<20180105152133.9681-2-alexandru.ardelean@analog.com>
In-Reply-To: <20180105152133.9681-2-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: alexandru.ardelean@analog.com [alexandru.ardelean@analog.com]=0A=
Sent: Friday, January 05, 2018 5:21 PM=0A=
To: linux-iio@vger.kernel.org=0A=
Cc: Ardelean, Alexandru=0A=
Subject: [PATCH 2/2] staging:iio:docs: add ad7291 doc to detail dt usage=0A=
=0A=
urgs... there's a typo in the title=0A=
=0A=
From: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
=0A=
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
---=0A=
 drivers/staging/iio/Documentation/adc/ad7192.txt | 60 ++++++++++++++++++++=
++++=0A=
 1 file changed, 60 insertions(+)=0A=
 create mode 100644 drivers/staging/iio/Documentation/adc/ad7192.txt=0A=
=0A=
diff --git a/drivers/staging/iio/Documentation/adc/ad7192.txt b/drivers/sta=
ging/iio/Documentation/adc/ad7192.txt=0A=
new file mode 100644=0A=
index 000000000000..19efc0a9411c=0A=
--- /dev/null=0A=
+++ b/drivers/staging/iio/Documentation/adc/ad7192.txt=0A=
@@ -0,0 +1,60 @@=0A=
+Analog Devices AD719x ADC Driver=0A=
+=0A=
+1. Overview=0A=
+=0A=
+The driver is intended to work with all AD719x ADC chips=0A=
+from Analog Devices (AD7190, AD7192, AD7193, AD7195).=0A=
+=0A=
+It's based on top of the AD Sigma Delta driver=0A=
+=0A=
+2. Device Tree Configuration=0A=
+=0A=
+Example for use on a Raspberry Pi with interrupt line=0A=
+connected to PIN 25 on the GPIO:=0A=
+=0A=
+       adc_vref: fixedregulator@0 {=0A=
+               reg =3D <0>;=0A=
+=0A=
+               compatible =3D "regulator-fixed";=0A=
+               regulator-name =3D "fixed-supply";=0A=
+               regulator-min-microvolt =3D <3300000>;=0A=
+               regulator-max-microvolt =3D <3300000>;=0A=
+               regulator-boot-on;=0A=
+       };=0A=
+=0A=
+       ad7190@0 {=0A=
+               compatible =3D "ad7190";=0A=
+               reg =3D <0>;=0A=
+               spi-max-frequency =3D <1000000>;=0A=
+               spi-cpol;=0A=
+               spi-cpha;=0A=
+=0A=
+               #interrupt-cells =3D <2>;=0A=
+               interrupts =3D <25 0x2>;=0A=
+               interrupt-parent =3D <&gpio>;=0A=
+               avdd-supply =3D <&adc_vref>;=0A=
+=0A=
+               adi,clock-source-select =3D /bits/ 8 <0>;=0A=
+               adi,reference-voltage-mv =3D /bits/ 16 <3300>;=0A=
+=0A=
+               adi,refin2-pins-enable;=0A=
+               adi,rejection-60-Hz-enable;=0A=
+               adi,chop-enable;=0A=
+               adi,buffer-enable;=0A=
+               adi,burnout-currents-enable;=0A=
+               adi,sinc3-filter-enable;=0A=
+               adi,unipolar-enable;=0A=
+       };=0A=
+=0A=
+Notes (about this example):=0A=
+* be sure to replace `compatible =3D "ad7190";` with=0A=
+  your actual chip model (ad7190, ad7192, ad7193, ad7195)=0A=
+  in order to make sure it works correctly=0A=
+* PIN 25 must also be connected also to the DOUT pin=0A=
+  of the ADC (or MISO on the host)=0A=
+* be sure to add the "/bits/" specifiers ; newer dtc versions=0A=
+  specify the property type/size using this field,=0A=
+  and the driver may not be able to find the property=0A=
+* not all "adi,xxx" parameters are required ;=0A=
+  see the datasheet to get an idea of what you need=0A=
+=0A=
--=0A=
2.14.1=0A=
=0A=
