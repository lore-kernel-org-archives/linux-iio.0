Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DB4746D8
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553114; cv=none; b=bVObRfewht55KZeFFZGiU8zufULsdYWpAZ+oA+ueD6Z+njAgvK3HqzjMySDyrBlpDki2JdvXYl/8Vy9J2dIf/q5oVXgwGCUNwtKMvsrkc/bgIQWw505mPNmxqn5iCc1kKSRfFsa8K4lSE80iD14D/hkCFjdpf4GVtOYgGT+0qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553114; c=relaxed/simple;
	bh=Q3QPfXEGFxoothiTJDvk7VcDlkWfIzKXCxIkN0YIC+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ae5riPMCmB3UpGFGZYF5+9Tx0Bf58vqBizGh34bkSuITZ3EAx5brG/CcNcJ5h2WEjC+sNQrdSXfakYd4RmA9fPd8ryNHdI/C2d/kQGLupZb5HCY7h9eQLpx3I6/qoPLO0VJ2qekZCY00LxNaz/jYM2dxfHJVV66rzv8HLfmDR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQZFUUsG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQZFUUsG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfff5f88dbso14352375ad.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553112; x=1787157912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbwfQtvcIrPGhiFm4QeTVdd0S+tOeW++mabq1fEtHi8=;
        b=hQZFUUsG0WwHAMdcUWmqe0bv2gqwdxWqtBSQ2jMF0svGAWXShtXBN/A5h+8pJL97PL
         8cSbNPWeSj0DiE2loxSZHLZLNqN6PeROg823gVENR+MHa9HXluisxMSf2ZLVPld3Bzsr
         Ri6yyFyUrQfJr+uHt671sEVXw25BtJVDBYSJiHOLZnMV0JS28fAAFccq9nsAMhWupnjF
         7aP+FcM698SHXQOyduHDjjIsRRD+c5QhFHQRTqoCSrS7lNHrj4MI1ObvqgRJ1btu9uQ4
         lyozjR5wLoHkTxhaJP2o9jT9FzUJMptAY5lcFO7ewgP5ylzEuqfz1MQmxOKGWRnLuJrc
         HeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553112; x=1787157912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nbwfQtvcIrPGhiFm4QeTVdd0S+tOeW++mabq1fEtHi8=;
        b=MeRBMJJsVOlrmfVdATWFkrirWqBPc2m4PNsp6EfR08zOVLveXkUDJTnq262tfxUeW4
         l2uX4J52xkjRWSyuKPt1k3ypqk2I7tKkYtJrziApDuc06s/dIJFOegBeILhUdchpDf9Z
         t3zCROX2c/JfXVEaK3qsstjk10W3+39qecJFMC83vJW6HBXH8lK10xo+1Jf5FYxbFtya
         l6B7N8wQhEMdm09VKJH9HT+VnPBxRBPUqw3zL8FONd52ryXmi8EOvv2zbjbhfM33ojWf
         Rcn/8Ve07ExUMlyZVhOjsSmYZZP4/Q3yckFwAWCP96dzEdE+8coiJiqIZsstyO/CdHs6
         QZNg==
X-Forwarded-Encrypted: i=1; AHgh+RoZ/1V3jtes7se+/Rrw7TaH7cOqEooF/PDhE75S2qwruf2xxDkZE2ONcVskrtnwrGuM68kYMTLePPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8JaBxuFaWXro9ZQuGRTdDJkixAR/B/A4Z3gFTAJiY8/olWDw
	xtdQRYn8avSWAoDMIEn7H8/EsBij+rQax0xcpoIw63UC4o3PArms50R2
X-Gm-Gg: AR+sD11lEI7IEcKwC990vvBNT/Najm8ZNmpKqEOCpodZX3siytnDm9KKhSPyEVi4V2Y
	gNAnE4/zkzSagn+BsdDPBy4Nl395u284D4SxL1ioG4CGqe4GKlzUPn3C3PKXnLy7MpctZzpWQCC
	VTE9+ES2q992CV8YopkhGidEcyG/Ovqn4hDvkBxbYbBTc2wL/A5MD4QpbCuNoW6T5bx6sK+yZtb
	muH5GGQ+XvnFWKEYhji5J8CaWdr+WaJ2E2l9oxa8E1z59FFErasogLBM3SIv1LhcfHVS97JscaC
	EEwOwMDOspa32N3eLUw4AwOFPXWcdw4eg9xKSdoz93Xb0kal65Le6J5IRQ/D/9IZLcOTe0JVVNw
	PmuD9GP0MKxExCE1m4rQB4EK+gdot9urFVfG/J+tmwEXk1VuDTxNL/3eskJOUlNDX4MyJnrKQAe
	7A1wkd4dApPaqHAw9T6v/f10vB8dKLKwkLZL3aejTE3tAx1oMz5xQXhSqP/GprKSyUyB/Eza7Xw
	gSJT74dd96gI5pAPuPQN8xNmuWPHhQ3pGC4X0L1zSzDBw==
X-Received: by 2002:a05:6a21:4603:b0:3c3:7f50:fc3a with SMTP id adf61e73a8af0-3cc3f821173mr8451560637.33.1786553112243;
        Wed, 12 Aug 2026 09:45:12 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:11 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 5/8] iio: adc: ti-ads1015: use dev_err_probe() for error handling
Date: Wed, 12 Aug 2026 22:14:30 +0530
Message-Id: <20260812164433.23011-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
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

Note: This patch takes advantage of the previously introduced
local 'dev' pointer when converting the legacy
dev_err(&client->dev, ...) calls, avoiding unnecessary
code churn.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index c88904d7190d..895bce7859d2 100644
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
-		dev_err(&client->dev, "Failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to allocate register map\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
-	if (ret < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
 
 	if (client->irq && chip->has_comparator) {
 		unsigned long irq_trig = irq_get_trigger_type(client->irq);
@@ -1042,10 +1038,10 @@ static int ads1015_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register IIO device\n");
 		pm_runtime_disable(dev);
 		pm_runtime_set_suspended(dev);
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
 	}
 
 	return 0;
-- 
2.39.5

