Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC4499F12
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851314; cv=none; b=HholuoDMcX5ZrgplfLn46uY2UvhQduCjZEp9G61uRhH8jROnUsAdaaoePHp5+acEy+AIfNQaknUmEn3BgQ5dwbMZ0ThR3ot5aqWYmxI3BBNNMWpmJ/Q5AXJuIgqUDMLp/Mo/wI320nniuv0DjPnTPv798rp/WPXy2uJPaPcrq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851314; c=relaxed/simple;
	bh=igmrSe9EuyQLIlSQs2uRMnO+x4gxn/GFj+X4NNFKQeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RC1l4fQpmjLiUidwKaFD45T0PLbDNxFK71d1rRqpHPGPMBXxK2ZZ4dv08yF12VwP22btZ4LXHpNA6HjuVt+p3lB/VJlpN+lWhsJN/tWArrl1Lc4V81awZMSTtK0n+BzX4ZVMN1K2YAEdVbqrUYrNSf5ql3Xqm3ZvTK55f5duYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXtnkVId; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXtnkVId"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso153834a12.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851313; x=1788456113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVyblNOz28CCR2fJleofXkaBK4JpEkpfnQEO4VXpl3Q=;
        b=MXtnkVIdYioy/kUxU/NZXKvHfyu8abvK1Es5p/E2W4YzswXjplQMJXSjhfTPMPld0R
         0oKIGdS5q01t+xL9HMs+BzAtuPrSKQn1a2nVDSa0I99oa/sd0rkk5CJKm+58APfZlPNb
         ZwPqykp+q1XFUa3m1mlFeTU3fi6QFPdhQe0q/ETLOlj5ggV9yhR5tr82RDHONoe9Gem0
         l5Us0k1j0yILFOWJ9g7ROLvnFLY6xWwDKFLzCjcJ5rUKdmddRWe21vqLqOqc9fP8EHtt
         bzuqtr5wjzJcWrcIlzS5AHgaepg9EKbTZF3FOgNwr6+AdtwNmAoVBkGwpEPLtixc/RqW
         iCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851313; x=1788456113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVyblNOz28CCR2fJleofXkaBK4JpEkpfnQEO4VXpl3Q=;
        b=AuUo6lDHwB4WMRKZ6pcsnztxalo3JWSjn7oUlqCd9NcwWNYH6+YLtGi9WNl71cj4Sj
         3YSSs8p4xk2ILe4wTdzmQIlOeKC6/S/aU+zgKtvSA6Y08ON49V4twYTd0ZH6piOmAPwu
         crrkintD1HNqbKETtIaehWtz+Y4GQF7pJ+chTtGx++I5n0+TgEj80dXNq5sdWnG2QI1W
         qnMLDCZznPhSv2Rte7bKo4h5HA1wwkJ7lAjqQHJSskR6mvQLGhQ9RQQruPVsKVV1e6aH
         tgLq5o525FDvynA2ozeMczezfAVRu2zBRns5v9tEVTqHbezut2m7uK6cie5zMY07GAxq
         /CRw==
X-Forwarded-Encrypted: i=1; AHgh+RqtkGheZhP5C23wAUvRwNJ/qIc759xYSlqIql02IBzpYby4udPt/E6SEV/m8ZtKyP89ZV7O0BhorsU=@vger.kernel.org
X-Gm-Message-State: AFuF++mvYcFMRFGIHldSPgHwmBDJazvZiwQsKSCsrSL66kos5q9rCdTw
	ClaK+fkrx6Shsx69QPQWLYyGQLAQQMHzQsJ2EuANua09SMC3ctr0PKiw
X-Gm-Gg: AR+sD10wqOfjw9srLgQbJFmjB6lgLwQhppL2Xczhk/TPM01RNJ+daF4kVak9t+tSq6T
	BT2CTtmZ8aZvkxOx11XtABWzDvhTypn2Qmu0VAgbmODAthuPDA91S4fzyfNKzXK8sG0dg39lc4x
	kvjVimnEvb1jeRGkEKe+1YcuIGkPWQlen7ZYSFxYUI7G5j6OD7s1jL0aMB4s2jOV1ID3dUBrzr6
	IraFUVPwMjZ6YtQuS7vfxoUf1HFn6l90d5D7nEM+gM5oZzaQmO0qDjjAc7FKLEfDAYij1qxxqlr
	+LRvD6KuXli5oRxd5W8ETb+VmnreaFR1BdVti3/A7HxGHPZ1/tn/zSciyhM44fy4EtLOLQfarV7
	dSrqYAezTRB7yFgVbEfdCaGu6g0esP9L/bbpBfCBqDhxn2XDj9poQkzt7b7YRLcZvroi8xiE2Hl
	w0286e89aI1Y5JhaTqApLmaRprXiZ5gAPjkLul+KrOVRpSScyTdATnqN4Oxv7vCabrqXWLLy1On
	DPdlTYM+4lXFWGMqDPMfqy/AAC/T5XmIOgZ
X-Received: by 2002:a05:6a21:6112:b0:3cd:9f0b:f7a2 with SMTP id adf61e73a8af0-3d267b647damr1085961637.11.1787851312523;
        Thu, 27 Aug 2026 10:21:52 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:52 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 4/8] iio: adc: ti-ads1015: use dev_err_probe() for error handling
Date: Thu, 27 Aug 2026 22:50:56 +0530
Message-Id: <20260827172100.39176-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
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
 drivers/iio/adc/ti-ads1015.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9c1d36db15e8..0d1006041819 100644
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

