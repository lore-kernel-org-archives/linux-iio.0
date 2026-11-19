Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095676;
	b=XsQ338hs+0ZMl2ngFAVNQ7f22Jm0yjWf3RYZGaSXcUxhUQLEwV+DxL8b5DLxFuTvE0CZ
	 Dp6ZBjen+5pwBwwpxGBv64VDZFuypmGSWtp5umPkmXl0pKgClj2nLK58Omh21c1x9qtS8
	 s2aW9DevrGeQ7naUjfnEhSe+YJhw8AcEAC4IWouZhT7dF3n/8DOBflfeBN4+qHcZ7100W
	 xLvycgtAjJLzHpaq8h0cb4ggB4JCJAp7VAiymiRnlJpPq7e4pKKuT727i0zXUcQR6MjVK
	 A4k1+aRQs8x3p8oNWcViuAESeaMiUpNSEGQE5Xx+azMPgX5xXYUsPqNpHTAKENPe83w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
	b=30lbmMdfCDFuXf8QphsDtJjPLfoYSzxspe1vOnejmL5ysobgYhHcsGd0sTClBBo/Hcc1
	 ACzRZjg7nzhbsWPCVCWFWUQ++7l3YBWFfFizShg4g/At88GdNKw3be/82hA1R/ktjlgZ6
	 m4q8nBt5U+oFRU3zBW3pedDH/+phWinrzLkFEr2SE68oT8kBxx5dqm9Pmb4qOcfTEYyvY
	 +r2EgAx0DzVdozeq6kILjMqY8ciWYE23xWHR0tL6eZvuNiDHeCTBGeztAuzqjEWy+AqZE
	 ZgW5g5+NWOGWMtqR1mGkEOM/DvDe3LQ5W2fiZ/QobWzcVXOjMxq2aSH5pV+HD4FfsSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/yC5iIA";
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3D606A333
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 13:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A3D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/yC5iIA
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99e09f4c44bso635330241.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095674; x=1795700474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
        b=v/yC5iIAsBsXt6P8uqDo6Vw/I8BJUSoM+iQPmacHN3OpkKecdynFT0AOqVWvAj0fWG
         CgONLMHCODVbLC2X/D/Px301tyjUwTrcxO0lyK4ZYWLmTsa8RptS5R3e7AsG8W93Nqi+
         AT+ZcY5K1XcUdDTyaZ215eIrv3fW8xSda15x6EKIM1GPSkjKR7a+euy+HDsDXRvGLtld
         ELhdGC373dBSzyZJNeeQDBM+LIr09LHt2nanai7MXMNZHnf5dyD5KHxHN8/IG/LOkDY6
         iYKyKvoZ2xXU29LvvzVkEHM7GVNNt8cXEWfP+OqP1I0zuSI6lvpR7vlhq7VWttpyzFK9
         Pd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095674; x=1795700474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c0G4YZiEJEesEvJcSiHJ7KCJftI/dPzJGtmeIgLqHA=;
        b=jLf+bgnhmb2A8F9TUelbojJYceAvr1kVdpDhKCM6+dvgt5oL67UPnB2a2CwvHsaPe5
         mNhYRTz3prUxbQmonuMjSKh6wQ33Ic6vvhz1OUD9SJegKz/dPsia9uoiHZbCtrH4dCk6
         lyYCKZ/UCEw0kfiaDPgdN2PTL5+z2HEVQXba8IhaDjop4X19fJjCZ11kRPuNxrCz+bK1
         gt2gJ9eglK8C264Rwhh3L1NpM2hI88Qm/Px0mx/HJmVyrp9Psw9tmuaIIhDFHIHIYz5d
         PQFFC/v+KRiD5w0ZIZ2lxjis73rarHJDL4N7hK09hD4ocEwCDV1LZH9wvwILuPWeH8S5
         7khQ==
X-Forwarded-Encrypted: i=1; AL+hErEAc0NqPWy1MxTJ1ZLujz/6rt+yLvfPV677Azeyl2ig2oKOwttqarV/R8ybG6uKEIpNpv9+C8OC7FA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cEp8A7oOV/ILGDzp2vo+PkBA8MayVxSOg7hJJKR5LEeJ1YThM
	27y8cYtMTQimJ5zhCecpEdOEL5OsCu+uDuHrfwNWRKIqFhXBPXqbA9/n
X-Gm-Gg: AYBFou1s0sccfNfmZUtPir7z3YMNCeWPFhUUBU4y1AGGUqKWItkTENSfn5UjAh3UQfP
	xpquNK03OjylVmaateRx1AID0A2plAF5IUQOTqAxeI7chxCmakfn/Me1O2nBt8dR0QPliBSMfTf
	d6/TGx3chBy5EOBwXZzeNdHM6FpWajL7+8jAQq+OlVlszsVgZViY8hN+1fcmowogKV4pvqNmQs6
	Qs+gqaEGSqNMcrfq/7l88o9kwEpSUpC1OF/c0zsxAI/XKG4gh+HHCfUgnL+vUnbWCdRiW5fmChb
	9XSRaSWZy5MQ71sLOp7Cq/GzR15uRSXtc/lz9iDmtc51DavGCOEThpTHfJpvafI9ow1fbh/Zw3r
	0tCISnC0ZjAyhwarH2ygPCbHdq95NuAiXtgGFi7N4AQ/DdBWh36vc83tvtkx00QeF+lRYzfEi00
	83TuD7jYwFkhMxSOb4EeTpgxyl0BmYH9pGlvDweGnv6MJ/hRjkdYZW/oSqszwWtnO7Ydmsh4BWh
	uCjQGDHUNvW4ETt05GH7bh4mG5zIlOtTNeXHcgJeIOVf3NyoY0Na9u7qOyyBs0YGd6fUcpymTz5
	Y5v6rWkFDQE4jS9qqBQFim6Oga20ge6ylD/Cf4410iBSYCel0od+3q1EargqMVVsPQmWaS/Jw1z
	4RVkB1r90RHN1vnbfE9Q=
X-Received: by 2002:a05:6102:2c8d:b0:7d6:49a9:fa61 with SMTP id ada2fe7eead31-7d6ba435c6bmr2530171137.15.1795095673999;
        Thu, 19 Nov 2026 05:41:13 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:13 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 4/4] mfd: mxs-lradc: Convert to devm_clk_get_enabled()
Date: Thu, 19 Nov 2026 10:40:41 -0300
Message-ID: <20261119134041.16611-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRADC clock is acquired with a managed helper but enabled and
disabled manually.

Acquire the LRADC clock with devm_clk_get_enabled() instead of a bare
devm_clk_get() followed by a manual clk_prepare_enable(), so it is
prepared/enabled for the device lifetime and released on unbind.

This conversion makes the code simpler.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v4:
- None.

 drivers/mfd/mxs-lradc.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index aa55f88399ef..c3dd2d80e7f1 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -160,17 +160,10 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	lradc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(lradc->clk)) {
-		dev_err(dev, "Failed to get the delay unit clock\n");
-		return PTR_ERR(lradc->clk);
-	}
-
-	ret = clk_prepare_enable(lradc->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable the delay unit clock\n");
-		return ret;
-	}
+	lradc->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(lradc->clk))
+		return dev_err_probe(dev, PTR_ERR(lradc->clk),
+				     "Failed to get and enable the delay unit clock\n");
 
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 					 &ts_wires);
@@ -193,8 +186,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Unsupported number of touchscreen wires (%d)\n"
 				, ts_wires);
-			ret = -EINVAL;
-			goto err_clk;
+			return -EINVAL;
 		}
 	} else {
 		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
@@ -204,29 +196,17 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_get_irqs(pdev, lradc, data);
 	if (ret)
-		goto err_clk;
+		return ret;
 
 	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to add subdevices\n");
-		goto err_clk;
+		return ret;
 	}
 
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(lradc->clk);
-
-	return ret;
-}
-
-static void mxs_lradc_remove(struct platform_device *pdev)
-{
-	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(lradc->clk);
 }
 
 static struct platform_driver mxs_lradc_driver = {
@@ -235,7 +215,6 @@ static struct platform_driver mxs_lradc_driver = {
 		.of_match_table = mxs_lradc_dt_ids,
 	},
 	.probe = mxs_lradc_probe,
-	.remove = mxs_lradc_remove,
 };
 module_platform_driver(mxs_lradc_driver);
 
-- 
2.43.0

