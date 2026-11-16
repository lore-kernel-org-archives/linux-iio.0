Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870016;
	b=P0sukI/SJBM4cy5zp/8uBCvyf6khK4AMeiNF8jCmfgNesWAYnRxzqzq3lXPRRbqOIG85
	 1TrYAB0doD54hbtfe1OjwhKtkfJmKQ3NqWmNObD4pV9BN5+3B52PhBG06aQjnBtQzPjSm
	 hhea2PJEcFetTZWfKQs6qknLn/dvRST4bcZ/uf6wWDN8ZhUaycKuyW8N5UhZlX7culVgy
	 rbA2qyE6YpZpFSMHs8FoleYj6WpWq7zu6YRQAQzlwysvPLey1yVRocyAG7/7cBTizy2v6
	 uExiIRwIZab+bwgflF4v3+XIGHoURlL00ek5yfTjoOBMvCI6HkSFLYaW79o5hGD6ZKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870016;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=F6oW4ZmByrglAwdMR7r6p9kXbfexkyXhO5YlnrOYLBs=;
	b=t94tHswTAhPk+ZrhvqfJFajcYsuEFc6qOsnxJYLYuMd6UdOOROhgH8VAEAUKn4tzoJmR
	 a8w3yiWbEuXC/tsAJseP+ZNXGdzeRTvZplpc+LVTrsDzXGm7lLuBMX606yHJ+pPGpY5WG
	 YWOTc/76kM3VwswaYYkf9ZdE9TkVA8bmUTROb/pnbQJrw2tjg7qtbtbSX2A9WwaqihpMY
	 bm/h4xFLqgmg0KNic+HSQrbdt/SVLC4BteB/ZfCkwQFCLuXJ5KmW7ffv2zCZ28dxDamIP
	 dyXy8DEZYHpZmhysf06TG8prmMb0mmcpzkVVM911KV740KfabVLxj2GpGy3faGg3vSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1360A261A
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E1360A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b315dd057bso24685247b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870014; x=1795474814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6oW4ZmByrglAwdMR7r6p9kXbfexkyXhO5YlnrOYLBs=;
        b=nAzlFzh3MJh9kqrP5jP313PWEdEOy+x39I8i0QoLX9DEE2MWGMvv9bIRHEwTWcaKFX
         JFJiQ11+R761VX23AunF9ggGFwOl2yggstHdzBtFsRWQryv8ihuk8zLH/kAPMhPZmhux
         vk2PfBJOw54t2XARGQUqoq8F24H5gBqLBuHLcFAIdKkvnMUrDbYdhvUABVUGmmZZpumu
         eKmAZZydLT8QxtfhRwCUlSPqenwkaJCixwuU2R7uSJ82ee4/hd87M/HWnhmsEVl+gOyn
         DMbGuZTLrXW2VOFLtKBkrtWgEeDXe05G5AINZLj6mSlLSEVfMGJq0tVNHYwaUY9Z/kWq
         8qgQ==
X-Gm-Message-State: APuU4Z8WO8eoci+iA4TTh/mJboU/6rqZv6JCNeoCW9e+h8ii9Q2zcnB2
	Cjd29vEPcav1ib7AUfWkkZ3921SVh4p8vU+vtR9af8WgAhtqS339BC9d
X-Gm-Gg: AZFdTZf62hLuRIpHN9j+Ihs9acGzBz8ty6nQSPVUwpsj+ixog1wq6yczWvTpypZv9bY
	mFVbb/FxzK7cwVATZ1++KdwZn212hNxNebyIITxJtFlSHzsG6hsqfDT+YpujuEfAuid7IqMdOQ7
	NywbnImUzYCp9v0N5EYg4hCk696/5RfL2PUC+4eGCxVZ0qQUa1qjgcskp3cdAlDCs3uS/H0iTbb
	2DjdNfrGGDMwQqHFRLgyWUCBMuOmgtY1Ey+vaxVAePS1Tu6DoVqIizScuc1KI/Iu5YYVTk4++YC
	28szGWLTFGZYFcp/Q2jfN0KhEn5a6UG2/mK2qZDN1N84xWq3Tv4I9O4usSTY9xBTn7svIg/Px7e
	3PoohZFuf6xkLKIoXGOmfseNwmSxOHyC6SQmPNvZWXUpRuNmy1YDH6T4DGwYx3GUYrUBjFM6QxD
	zqk5pz+YBsVPXuoOne6T5srgMnWAfNw+8EniDaaKBCp0sKhOj4px2PN4ICQGHhDkHs/wdvQEgeI
	KWJoovETeMv/SHE6zDD8rDnTbZXuFD6ini4154evFim0v09spqQYX+974Ye7vk2Y/SsEBLYA5sA
	I8dsmJL4XLq3RFWgKy2488wD8ySuhA9futJxraF+CWSzdDkgBk4b1ArdS9lfd9f8HwRJ04DS1py
	on2TyAq3nYcZZ/E2Q2wukjrOAw/q1y2Yb1IE=
X-Received: by 2002:a05:690c:39c:b0:8a8:5c3d:903 with SMTP id 00721157ae682-8b4aa441b73mr65561507b3.62.1794870014054;
        Mon, 16 Nov 2026 15:00:14 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:13 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:59:54 -0500
Subject: [PATCH 5/5] iio: potentiometer: mcp4018: Add Analog Devices AD5246
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
In-Reply-To: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The AD5246 is a 128-position digital rheostat with the same I2C
interface as the MCP4017/18/19: a single data byte writes the 7-bit
wiper and a single-byte read returns it, with no command byte. Add its
four resistance options.

Its resistance is D/128 of the end-to-end value, where the MCP401x's is
D/127, so the scale divisor moves into the per-part config.

The misc ad525x_dpot driver also knows the AD5246, by I2C id only and
through its own sysfs files. It can't provide an IIO channel, which a
consumer such as dpot-dac needs. The AD5272 is likewise in both drivers.

Tested on an AD5246 at 0x2e that sets a fan's speed, described as
adi,ad5246-010 with a vdd-supply. It probes, out_resistance0_raw_available
reads [0 1 127] and out_resistance_scale reads 78.125000000. Raw writes
of 0, 64, 100 and 127 read back the same value, and 128 is rejected.
Writes through iio_write_channel_raw() from an in-kernel consumer of the
channel read back as well (127, 38, 0 and 76).

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5246.pdf
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/Kconfig   |  6 +++---
 drivers/iio/potentiometer/mcp4018.c | 33 +++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index e6a9a3c67845..7945c75f06da 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -70,12 +70,12 @@ config MAX5487
 	  module will be called max5487.
 
 config MCP4018
-	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
+	tristate "Microchip MCP4017/18/19 and Analog Devices AD5246 Digital Potentiometer driver"
 	depends on I2C
 	help
 	  Say yes here to build support for the Microchip
-	  MCP4017, MCP4018, MCP4019
-	  digital potentiometer chips.
+	  MCP4017, MCP4018, MCP4019 digital potentiometer chips
+	  and the Analog Devices AD5246 digital rheostat.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called mcp4018.
diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 0d80bdfdf243..1368d7cfa5b0 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -5,11 +5,13 @@
  * Author: Peter Rosin <peda@axentia.se>
  *
  * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5246.pdf
  *
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
  * mcp4017	1	128		5, 10, 50, 100
  * mcp4018	1	128		5, 10, 50, 100
  * mcp4019	1	128		5, 10, 50, 100
+ * ad5246	1	128		5, 10, 50, 100
  */
 
 #include <linux/err.h>
@@ -23,6 +25,8 @@
 
 struct mcp4018_cfg {
 	int kohms;
+	/* Wiper position divisor: R = raw * kohms / div. */
+	int div;
 };
 
 enum mcp4018_type {
@@ -30,13 +34,22 @@ enum mcp4018_type {
 	MCP4018_103,
 	MCP4018_503,
 	MCP4018_104,
+	AD5246_005,
+	AD5246_010,
+	AD5246_050,
+	AD5246_100,
 };
 
 static const struct mcp4018_cfg mcp4018_cfg[] = {
-	[MCP4018_502] = { .kohms =   5, },
-	[MCP4018_103] = { .kohms =  10, },
-	[MCP4018_503] = { .kohms =  50, },
-	[MCP4018_104] = { .kohms = 100, },
+	[MCP4018_502] = { .kohms =   5, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_103] = { .kohms =  10, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_503] = { .kohms =  50, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_104] = { .kohms = 100, .div = MCP4018_WIPER_MAX, },
+	/* The AD5246's resistance is D / 128 of the end-to-end value. */
+	[AD5246_005] = { .kohms =   5, .div = 128, },
+	[AD5246_010] = { .kohms =  10, .div = 128, },
+	[AD5246_050] = { .kohms =  50, .div = 128, },
+	[AD5246_100] = { .kohms = 100, .div = 128, },
 };
 
 struct mcp4018_data {
@@ -72,7 +85,7 @@ static int mcp4018_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = MCP4018_WIPER_MAX;
+		*val2 = data->cfg->div;
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -125,6 +138,10 @@ static const struct iio_info mcp4018_info = {
 }
 
 static const struct i2c_device_id mcp4018_id[] = {
+	MCP4018_ID_TABLE("ad5246-005", AD5246_005),
+	MCP4018_ID_TABLE("ad5246-010", AD5246_010),
+	MCP4018_ID_TABLE("ad5246-050", AD5246_050),
+	MCP4018_ID_TABLE("ad5246-100", AD5246_100),
 	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
 	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
 	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
@@ -147,6 +164,10 @@ MODULE_DEVICE_TABLE(i2c, mcp4018_id);
 }
 
 static const struct of_device_id mcp4018_of_match[] = {
+	MCP4018_COMPATIBLE("adi,ad5246-005", AD5246_005),
+	MCP4018_COMPATIBLE("adi,ad5246-010", AD5246_010),
+	MCP4018_COMPATIBLE("adi,ad5246-050", AD5246_050),
+	MCP4018_COMPATIBLE("adi,ad5246-100", AD5246_100),
 	MCP4018_COMPATIBLE("microchip,mcp4017-502", MCP4018_502),
 	MCP4018_COMPATIBLE("microchip,mcp4017-103", MCP4018_103),
 	MCP4018_COMPATIBLE("microchip,mcp4017-503", MCP4018_503),
@@ -209,5 +230,5 @@ static struct i2c_driver mcp4018_driver = {
 module_i2c_driver(mcp4018_driver);
 
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
-MODULE_DESCRIPTION("MCP4018 digital potentiometer");
+MODULE_DESCRIPTION("MCP4018 and AD5246 digital potentiometer");
 MODULE_LICENSE("GPL v2");

-- 
Git-155)

