Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:38540
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751617AbeAEPko (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jan 2018 10:40:44 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w05Fee3K019778
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Fri, 5 Jan 2018 07:40:40 -0800
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support
 to driver
Date: Fri, 5 Jan 2018 15:40:40 +0000
Message-ID: <E2AE62E8D995114A80E27C874A28DB3C97C2C0@NWD2MBX7.ad.analog.com>
References: <20180105152133.9681-1-alexandru.ardelean@analog.com>
In-Reply-To: <20180105152133.9681-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: alexandru.ardelean@analog.com [alexandru.ardelean@analog.com]=0A=
Sent: Friday, January 05, 2018 5:21 PM=0A=
To: linux-iio@vger.kernel.org=0A=
Cc: Ardelean, Alexandru=0A=
Subject: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support to =
driver=0A=
=0A=
From: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
=0A=
Admittedly, this will always use up to=0A=
sizeof(struct ad7192_platform_data) bytes (~12 bytes at most)=0A=
on the stack, during the probing of the device.=0A=
=0A=
But this will maintain most of the other=0A=
init code unchanged.=0A=
=0A=
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
---=0A=
 drivers/staging/iio/adc/ad7192.c | 27 +++++++++++++++++++++++++--=0A=
 1 file changed, 25 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7=
192.c=0A=
index cadfb96734ed..fca988330588 100644=0A=
--- a/drivers/staging/iio/adc/ad7192.c=0A=
+++ b/drivers/staging/iio/adc/ad7192.c=0A=
@@ -610,18 +610,41 @@ static const struct iio_chan_spec ad7193_channels[] =
=3D {=0A=
        IIO_CHAN_SOFT_TIMESTAMP(14),=0A=
 };=0A=
=0A=
+static void ad7192_parse_dt(struct device_node *np,=0A=
+                           struct ad7192_platform_data *pdata)=0A=
+{=0A=
+       of_property_read_u16(np, "adi,reference-voltage-mv", &pdata->vref_m=
v);=0A=
+       of_property_read_u8(np, "adi,clock-source-select", &pdata->clock_so=
urce_sel);=0A=
+       of_property_read_u32(np, "adi,external-clock-Hz", &pdata->ext_clk_h=
z);=0A=
+       pdata->refin2_en =3D of_property_read_bool(np, "adi,refin2-pins-ena=
ble");=0A=
+       pdata->rej60_en =3D of_property_read_bool(np, "adi,rejection-60-Hz-=
enable");=0A=
+       pdata->sinc3_en =3D of_property_read_bool(np, "adi,sinc3-filter-ena=
ble");=0A=
+       pdata->chop_en =3D of_property_read_bool(np, "adi,chop-enable");=0A=
+       pdata->buf_en =3D of_property_read_bool(np, "adi,buffer-enable");=
=0A=
+       pdata->unipolar_en =3D of_property_read_bool(np, "adi,unipolar-enab=
le");=0A=
+       pdata->burnout_curr_en =3D of_property_read_bool(np, "adi,burnout-c=
urrents-enable");=0A=
+}=0A=
+=0A=
 static int ad7192_probe(struct spi_device *spi)=0A=
 {=0A=
        const struct ad7192_platform_data *pdata =3D dev_get_platdata(&spi-=
>dev);=0A=
+       const struct device_node *of_node =3D dev_of_node(&spi->dev);=0A=
+       struct ad7192_platform_data lpdata;=0A=
        struct ad7192_state *st;=0A=
        struct iio_dev *indio_dev;=0A=
        int ret, voltage_uv =3D 0;=0A=
=0A=
-       if (!pdata) {=0A=
-               dev_err(&spi->dev, "no platform data?\n");=0A=
+       if (!pdata && !of_node) {=0A=
+               dev_err(&spi->dev, "no platform data or device tree configu=
ration?\n");=0A=
                return -ENODEV;=0A=
        }=0A=
=0A=
+       if (!pdata) {=0A=
+               memset(&lpdata, 0, sizeof(lpdata));=0A=
+               pdata =3D &lpdata;=0A=
+               ad7192_parse_dt(of_node, pdata);=0A=
=0A=
weird how my compiler did not catch this const qualifier disregard....=0A=
though, this did work on an ARM64 [Raspberry  Pi]=0A=
i guess i'll have to re-spin this as well=0A=
=0A=
+       }=0A=
+=0A=
        if (!spi->irq) {=0A=
                dev_err(&spi->dev, "no IRQ?\n");=0A=
                return -ENODEV;=0A=
--=0A=
2.14.1=0A=
=0A=
