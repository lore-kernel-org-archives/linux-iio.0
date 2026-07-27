Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEF3CAE95
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180102; cv=none; b=ewQs+NebaFUjYD/+q0dsGEtkoheL9bi7Q5vuGUJtPLTXHnngZvAN6vF2krPZwbjyoJGcAanGP0ytVeJHB/Jbx0tjXTCgkN3gNhlPxiXau2l3V8xwCRRnyf7i/WTxquaRZlpo+Nvb6Jw4w8E+5xPwoWzDgTS2ON8gIbLkPWzgKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180102; c=relaxed/simple;
	bh=Bs29OYHEF8K8r5oXvUOI6VKPXPJ8kX+4WrWbZwwd2nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSznXLeWm7ZopJWfb7Zy/S5UCwAu/tSXbfXmpPGy4T3GmRFfjgkuwlClrFsKyLmu2rCIGGrLyTr0fL7LpENk2Zs+HFGINWZj3rFJGURj4fDqAihrZqcmTdUwP1jcwCRqU2+H/oSKysF06ovbdln8uP0HzKLFCmyyAfWrZ6QgruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4V+R8Wl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4V+R8Wl"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceae1ed204so33474185ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180100; x=1785784900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKE6o8m+ljSJ4i2vRWDLeSZebYZaGpAkdxPwbzGKPVA=;
        b=k4V+R8WleAIt0kaxM2uHJDjHJUPNjgC0UIxzRJcGEqrqhFTJpKgv4r5CPytfA7GgU2
         X9Vl+gDbhasBol86xCuHeWXIYzMn4iisP7a5HrGwNPHww9nVjA86bDx+5KY5EF+vU8mk
         BHiF4uPyNckB+Ox02aRIzk3rjb3OzuC+UQiY1k8dtLNQXwYr9nAsX2OO6Z03lNW3kPui
         V+gS8zMnnngRmvAE1sD0CNltpCjlNw0GDmeA+bAFmD97+ylVXq7ZjPjlDehtw/aSiIys
         nDyuTRhbtfoyXHxcmuE+r5uwtDxKT8jbsiiyDCJGVkm76LAWYZudvT/7y/1JARmAPP16
         V9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180100; x=1785784900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WKE6o8m+ljSJ4i2vRWDLeSZebYZaGpAkdxPwbzGKPVA=;
        b=X6j+8/4xZO1rU26cZoVrxJjfbHlr/IQ5AmeSzl1IzvoG1vVIeplS+fy/V1F7ZWhkqJ
         0KNKpGv7LQKwv83nogd160+8R+DLPPDyOAkvlHqwZ51+eqRBKftbSsVYy8lnMOBUGwB8
         +CVtKtoQcRcw0Z54iSGqWjGMzKHdCbEI7CFXAxDrIbRb6usotjdKKqdSHPggpkgcOOeb
         cVfLVcuVmuQsoooqfshptAGCSKWapnuoqbG+3l8iJcyRbmzlqr+DAQMY6FkZAaNW7aIQ
         LL7hgWZ3zQaOQhrpdYE93FAZX+2RtD164G9GAnt3Lq73ea8c9BENOn+Cu2HK18bm9mbr
         44SA==
X-Forwarded-Encrypted: i=1; AHgh+Rogaf2z6EE9dO+Is4L6pVtXdd+R50gbgimjXzfsgqEk6OK7ZsSrXFpes9S0Najv8xI5h3h7ZTBQS3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSGRMWBUU0M+r2nIOcKHe31ERkzfbKtkKIjcSyoaoqGeGaWzj
	PNoqmtL0nRYry/RlVTKiE7AvfIS5vWEqXy/A/P2lfgLIDk6AMpSzujkt
X-Gm-Gg: AR+sD13UkdRtm618wxR7Tzi8wEKPFxWJTDACUVjMZXRN1/eJfBdO3ST+jPCarrdLS4c
	qviKfE89Kd4emNoYiXFhj2Uza2r2ubm1xcc9cu7dQZ/Eug418CMMDuYeUMrb+OEN18sUV9ErJ8P
	cW+hHSpaH1xw/JiygKONSbt8vJ8uk281+7I/pEu67hu+ICHJejxQLjB0LuIrjg1A0fZWdeI042N
	in/Slq+4pkiRMYNVI/pelFylgLFMMvk0Ry78rSzTlMQs9PIIj2wlbskBajwi4M2my/N7mmwm8w+
	wslw5rps/drEBweolIJXK4WzQd1GythvO/KfFpEEzFc9DPUIezm+/NpsFNROZFOxWsQJDb8XSzY
	05VNcCHUg7OC4uzpHURx6YUvyIiWcFJHBpbHiUxXDjfYlGh7wEjS+pMIKy8S5YYy6SPJljnBNA+
	ZsZ2tgmYSHGSMJgzym8STqGv3HBVrJIoqb3HhIID0LstRU4b7IeXxIdZa0V01an0M=
X-Received: by 2002:a17:903:1968:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2cfde7ae298mr83815205ad.20.1785180100561;
        Mon, 27 Jul 2026 12:21:40 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:40 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 5/6] iio: adc: ti-ads1015: use dev_err_probe() for error handling
Date: Tue, 28 Jul 2026 00:51:01 +0530
Message-Id: <20260727192102.37968-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727192102.37968-1-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the error handling paths in ads1015_probe() and
ads1015_client_get_channels_config()  by converting dev_err()
calls that are immediately followed by a return statement
over to the modern dev_err_probe() helper.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 59ce2f89daeb..a8dba4e5aed3 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -883,18 +883,16 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 
 		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
 			pga = pval;
-			if (pga > 5) {
-				dev_err(dev, "invalid gain on %pfw\n", node);
-				return -EINVAL;
-			}
+			if (pga > 5)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid gain on %pfw\n", node);
 		}
 
 		if (!fwnode_property_read_u32(node, "ti,datarate", &pval)) {
 			data_rate = pval;
-			if (data_rate > 7) {
-				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				return -EINVAL;
-			}
+			if (data_rate > 7)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid data_rate on %pfw\n", node);
 		}
 
 		data->channel_data[channel].pga = pga;
@@ -978,18 +976,16 @@ static int ads1015_probe(struct i2c_client *client)
 	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
 					    &ads1015_regmap_config :
 					    &tla2024_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(dev, "Failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to allocate register map\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
-	if (ret < 0) {
-		dev_err(dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
 
 	if (client->irq && chip->has_comparator) {
 		unsigned long irq_trig = irq_get_trigger_type(client->irq);
-- 
2.39.5

