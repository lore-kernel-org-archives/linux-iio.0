Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002439;
	b=v0PVWwFIcfijiduazAd2AFSTQ2Wro6pMPG1orZ+Ufh2hK+fU8X2Ozrn01CFzhAcaYCnC
	 747HHU0Y4v9Ogpi4iNMBeH/Xoe69J2FSo+nZ9RGgWLzstclcRdknO50HyernhWxr/jkTJ
	 KuKuMOe6YskbJMihmMru7/tgzo8ejRITjCQwWhbij9GadJV4J68FFC/0AHsDU7YV0yhVW
	 tlPfxRY2QSrqmbSSI/HvaCYwBS412EM6UM5ARGG+/bx8kBjz7FxXSl0HbAR/GpsjYa0gs
	 W7gJpSKe1Es88H47K/ZK50VTrhymOogC3vuKDAp6DGnCCseIVoLaI6Rb4E9tT4afKvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4zRIr24RMockOcBqoMHX9eYkDrHMvoR/ITcYq1Fk2Z8=;
	b=iJE7HVj1ks6fP7TZxj5Co7c4Qxo9/Wtqs/68XxRDzhTxCOHxJbbO9ufeAFBvWkiJ1tl1
	 pQbUfFqj32s6bE1G1THL5IQkNaBtH5Trdccp5k/F28deCzQBU9l3IVSbFsiK1uJVM5zla
	 29UUY9o2h84XmxQ1cv0GB0cBh6K58EXyTyJCxcvFYx81sqd9aBQu1DhntwlYn6cZ+nEIl
	 VKhznrDxTGuZR1j/e3jc4XfFkY/rj9kJp9bjKsPuLydwxayV5BoBn5uNlvguK+buHc5EN
	 4iTEgC1n8v4jtAqgo5sj5AvkRFK1S4Usrom3zgIWqwmKsfUdTuQ5bObSc3seFzlqESA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MMuPfx93;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE4606A331
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 22:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FE4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MMuPfx93
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-84d5e56f876so818816a34.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794002437; x=1794607237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zRIr24RMockOcBqoMHX9eYkDrHMvoR/ITcYq1Fk2Z8=;
        b=MMuPfx93FwNTDasyWxY2ab2EUWi9tQwbpCCbtJXUsw9QamHkjYEo0FdhjSIAwfRDlf
         Aikkt/+1WewCZ8GMLccIGlRypPRQwTy2n2TP9ZpvVDaxmq3sXTgvVjw9N/yuGmK0aEas
         iqgvROfo+AYtgFYAME0n0V4PlSHR/hOaCZrYVQ8ypxR/icoAULBbmTWBHxXcit3Lo/bD
         W4jgJXXeagQtltxC/KbEwW/kp9QiXda4K6curJDy9+AIS3Zrf3gBgfINTff0JVvjqJmX
         glwj4dXyl5zZYcf0rGNgirfF+H7XkdbeEBK8ZLSQDbDfnGTzolydfmP+2026ZFcGr8RZ
         Pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002437; x=1794607237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zRIr24RMockOcBqoMHX9eYkDrHMvoR/ITcYq1Fk2Z8=;
        b=tksOeMNcpN8hUbo0ipkK4wzHzgquOR83klYHJW7Vo+6bnU0U7m57UQNC55Au4n16/K
         YScytzYy/fqJLeiVTs9iSwvvlpmH6S7eComyW6xH4lYySfb8G65Fa0oFxE2azKTwVLH7
         o4T45v4oDCBLXdVBLqMiTyuj4xaQhsmklyMDF91ZpaxdUhlxb+ASJM7eObObqLsvBHFK
         gHeHz2bHP0n0BgkiB163FFv6dcPeQihR4njzMr6T0lKOR6oP05G8zVMv7OON1tgQWSRM
         0XeO6yFoHi4IS2BcRlup9kLZ3uTffSpgzcZ2FlmxS6BLeRLr9akN6d12NzRdIqT+E4OQ
         rXFA==
X-Gm-Message-State: APuU4Z/aTeSSi0rp4pOY9ZLldhL3WPYaizXltZeS+CMepdx+Sjze9S/1
	VaXXDGMV96AluDALD+B8/G0qU/+hSTqZgENcgocG0rF1fVPIRvX+7JgtKlUXpU48gbcOX2wUQnw
	TXjmsnoo=
X-Gm-Gg: AYBFou1kvvK9DWRYjPXOTgNrXqNQY0QhUI/bzn/j0pcX0JLOxwYk44zLHx8do96XTBI
	cMnp+Qdb55clgA/7/zsCyn0LO1QUnVHxhZToixCKQlfxMPwEng/f3gL30+r7o1M8n/6naI2XIbk
	k5MG+4lQNlC1E496kH4GDDwTEPWi7RE+bt4Qr6xi1s9MUjI9/56gNuH5LsMmY4QWcSbx1zr4/wz
	n4CcALAZij0ggmXtd9XdQE502JF3t1PKezYf+grOnTGVDXck0Gmrx70m/mXzdurFoBqbcegZftc
	OkJojBK8Kb1Tm9/4pAZdlg6Fy2dCpVfIOkVAHgb6ZMJSVlCaz4fDI5aRN6JQe003kj2zKk6pWS5
	rxs2JjcSGnJfw/piiZj+qZXP9Y0q08J56emSr6UuaIn72ocFv0oqXPSKqWIeQ9DLxQKsYpMjQbu
	VL3lHkbDnUJJWcWyHBiu+OPOczglMWGW4EF57JzNooDlMznJRY9Hkxjfw3MU/TCT3s3OzvJtPWM
	YIQi4nCOEnhInQJrfRRznElqJF32z8vu7smcYBIsXz5kkdRpyme4M24YKpl5HUO+ihafmLZ71Ej
	cTi7iNZmYvf0SbJ+rrOqZFP+gXKCKBB+7g==
X-Received: by 2002:a05:6808:1a21:b0:4b9:e65b:8c2c with SMTP id 5614622812f47-567e152dcb1mr2603511b6e.26.1794002437217;
        Fri, 06 Nov 2026 14:00:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7f010e4sm2432116b6e.14.2026.11.06.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:00:35 -0800 (PST)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 16:00:06 -0600
Subject: [PATCH v3 1/2] iio: adc: ti-ads112c14: parameterize GPIO register
 field macros
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
Message-Id: <20261106-iio-adc-ti-ads112c14-gpio-v3-1-7578ae66ee19@baylibre.com>
References: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
In-Reply-To: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bAtnUumcuaTuT0OrX4ijsU3VvDIn8fzI9Lr9fbQwzDc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBq7k3yqxofoIHMI56e0DWccHyiSyXkKlv2HKcGB
 mh6xdiWneGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5N8gAKCRDCzCAB/wGP
 wOyOB/0caa18spBg4OxHINaKhalUp26+rrkIfjHSluwbgPUi9QlCrvpRwtp9475qAM/P6gDRamo
 FasNOWZfdvRHsaBtoaOfS55fsqvCYAr/w9SSV7dUsfYnNfHqe5bO6Lsa5hitxbe/cVCSj2kEvyz
 sLaiE11NPr0yvfM04Jynl8FUf5se0bViS8ryPjaUpZja1X6RNIvlgeT4yCKTXxfy2EbYmZkKEa7
 EtYtNzDWKKAkw0AFxXMtuAdS0NqLGWv16uF4YSXnSc0+DZGgnYMs1osX0xNl+DfFoCpub5AKUCP
 950pTZxPlCor3sRig4FQKVpkEJchg/Yj45D1NzjgCH1rLhvd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the per-pin GPIO register field macros with parameterized ones.
This will be used in a later patch to access the fields by GPIO offset.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads112c14.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index c0374bd8d001..498893bd01bc 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -63,10 +63,7 @@
 
 #define ADS112C14_REG_STATUS_LSB			0x03
 #define   ADS112C14_STATUS_LSB_CONV_COUNT		GENMASK(7, 4)
-#define   ADS112C14_STATUS_LSB_GPIO3_DAT_IN		BIT(3)
-#define   ADS112C14_STATUS_LSB_GPIO2_DAT_IN		BIT(2)
-#define   ADS112C14_STATUS_LSB_GPIO1_DAT_IN		BIT(1)
-#define   ADS112C14_STATUS_LSB_GPIO0_DAT_IN		BIT(0)
+#define   ADS112C14_STATUS_LSB_GPIO_DAT_IN(n)		BIT(n)
 
 #define ADS112C14_REG_CONVERSION_CTRL			0x04
 #define   ADS112C14_CONVERSION_CTRL_RESET		GENMASK(7, 2)
@@ -133,10 +130,7 @@
 #define   ADS112C14_DIGITAL_CFG_CODING			BIT(1)
 
 #define ADS112C14_REG_GPIO_CFG				0x0B
-#define   ADS112C14_GPIO_CFG_GPIO3_CFG			GENMASK(7, 6)
-#define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
-#define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
-#define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+#define   ADS112C14_GPIO_CFG_GPIO_CFG(n)		(GENMASK(1, 0) << (2 * (n)))
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
@@ -147,10 +141,7 @@
 #define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DAT_OUT  0
 #define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY	  1
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO1_DAT_OUT	BIT(1)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO0_DAT_OUT	BIT(0)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO_DAT_OUT(n)	BIT(n)
 
 #define ADS112C14_REG_IDAC_MAG_CFG			0x0D
 #define   ADS112C14_IDAC_MAG_CFG_I2MAG			GENMASK(7, 4)
@@ -2514,8 +2505,8 @@ static int ads112c14_probe(struct i2c_client *client)
 		 * order to support open drain option here.
 		 */
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
-					 ADS112C14_GPIO_CFG_GPIO3_CFG,
-					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
 						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
 		if (ret)
 			return ret;
@@ -2550,8 +2541,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	if (clk) {
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
-					 ADS112C14_GPIO_CFG_GPIO3_CFG,
-					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
 						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
 		if (ret)
 			return ret;

-- 
2.53.0

