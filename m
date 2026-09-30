Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D00515989
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788362; cv=none; b=lZIvWJnc7duQEDk0UrMy9O2FszmZyHBc8vBpzBLMfOAY+VJ8itKTZtR5B4CbcK87l1Ysyv4tqyq+Z8c5uZaN1Rs0AJ6flF1zuGxo+496NCdmEiLikXoATjIRQUThMzPx0p5lxPlnmLQmLNq7J7jqLBZsXbaeIxpUK+zBwWQeUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788362; c=relaxed/simple;
	bh=f77Xp17F3ryUSktbgkY9BYOv3VUPFlsynWUp9wiAQlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJ6h89lbSS6kgf+pbgj/vkAQ5aO6Vz2fsmsYJ+FjZVxFmhljpHhi+R0aLROsOhjhQybiR4mx7HzoqMehYSKEUq+BI51hNhiOxPoOuNu+xK+iNk+XcC/mtbXlf2ZCO12cVrk7EQNTX9pEAXn7gmXLtofIU4WPJ3EFVkqKrzfvMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBMjlHst; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBMjlHst"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso2892127b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788360; x=1791393160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hwg3CO3tgd3nJolHxTuonw5jbIxyxt02qyF3nDmMd30=;
        b=JBMjlHst3E8DghQFnHJuwrlE+ZZkje0M71bfk5MOEvOV5qhew+AhHFuXRpRxMZXpW3
         y4yG/HEAPQ8YhUefJkOJzf7eHxV/PRrDLrVIzrA6rWvJsW/XUeBUI4mE7/7uUFE7xROG
         EQ8zBmDDbaUI1Bkkvg3lwEyTESo5bNUkq3/c5g3/Y+cJ3G/jqWrXYBZgLfLMn8emk3lO
         Icjh2yBXFKvfSfM7aHIpeX/HsxFFIuhJEYt+WozCdVfbC86Z++dXBd5fLhQwafFDyNBb
         Pr6wJmbl9dwtDD5jwug6YX/0usc10f8f4wbSuizcH9CnhrXKJbA4whV0qqaq0O1czkBc
         uGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788360; x=1791393160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hwg3CO3tgd3nJolHxTuonw5jbIxyxt02qyF3nDmMd30=;
        b=x++7pPAAKbWcjoHoe4DoAc6d7+J20eVHGLOzKhelydCCB/a2w8sboJaakgwuD3QCdC
         q1JN2iUddvM9xqwbo7BSDZajmGke1M2YJAZlK6ppY+UYo39J4mfz7zTb887lJuZB5B2w
         9C98hCR1bcmH1HgxeIgkXuBY2HKrKy8Zwu08bngWllOFp/pG6VT7AWAPA13tmstgyrRs
         bHWT2Jrcy+wQGDq3u7Ap0b4FMYAiOFcCe/xR4aqqoyAr22ok5X7Z4j1DsofAPSyMEcsU
         dL6BUhkSPOOucfNxIGtUvRFQA0Cl4eCx10XDllDpE7jGcchav7uB5e0TGUCfiybb75c6
         TXQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlJ60BBUGpI6HcsNxfv+SZmNv04kAio4D9EHxvDTp2J2EFWvCRS6okJFhY7Hmdjg+Z9cGMqDAiWec=@vger.kernel.org
X-Gm-Message-State: AFuF++nwGkLGlKlI5M4rbZpgxxJ2fF+xaph+8J7Rq8lvmZGYthjNKNYw
	eDZJN/ZapQtxvBDZ/Kz4D2K3Sv04VVP1taV0c89k8BDpDY3phrf9vnw1
X-Gm-Gg: AYBFou2lLbwOlUwUlArqqDeYhX+C+iTkMHj1ekGu3werDZ/9iaPd7AeBv4aidxBRJUZ
	UHeDU3aB14dthn5Kgq5h5IvKA+zTp3n38in+noGxVD7+DCTVbM8oWdXW4pRXNIKj2l1laab/9N4
	Pl0oRWop8kNUf8SawcbL8rJtVYUYAi+0mhqzdYvBt3fgb773KGXLpKPedDkM8rHDIWIQY2E/POe
	Lx+2nb7Au51F5fCw768OWhKe363dx/LUD5cJTsAzagpEThsX31iY2dcFglBtzWthrNQ1x/7YXb5
	fZFmeawrwNuLVwMLkkh7C1shItYL1bS/gbrZKCJJLcIDvP3scuu8l842WIdGAxqytexTJJweoUQ
	VfLEUqwER1Z01qJin6t+I0PwqJRgce9CT/D2s9iiLkUyQOSVPqmfkkhB2ZbKLJV7wcg+A/qBM/K
	dWfprKHRMTaK2Shi8pMPEsCks+GOwCRmzb7IBs0XI5uBExSu5mEam74kbNa0ZqwNqQPMF3xXjn/
	ckN232rc+2J0Ptoh1NdlMlqkR+O8L9EOaZuydlKk9+o7J8SCw==
X-Received: by 2002:a05:6a00:c48f:b0:888:add:a07d with SMTP id d2e1a72fcca58-8880adda0femr95292b3a.29.1790788360462;
        Wed, 30 Sep 2026 10:12:40 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:40 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 05/10] iio: adc: ti-ads1015: use dev_err_probe() for error handling
Date: Wed, 30 Sep 2026 22:41:59 +0530
Message-Id: <20260930171204.12863-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the error handling paths in ads1015_probe() and
ads1015_client_get_channels_config() by converting dev_err()
calls that are immediately followed by a return statement
over to the modern dev_err_probe() helper.

Note: This patch takes advantage of the previously introduced
local 'dev' pointer when converting the legacy
dev_err(&client->dev, ...) calls, avoiding unnecessary
code churn.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 85280200d050..34d3d31b5ddd 100644
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
@@ -989,18 +987,16 @@ static int ads1015_probe(struct i2c_client *client)
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
-- 
2.39.5

