Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FE40861A
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185414; cv=none; b=lnKoheTdqldLXuDWN1Mex3eTjFmg/98KKAow2ZpxGiAtCNfXdE4yyLCLbPcpTUmAEE+YhboYkKGo4tWmedVqFRVVLc3zstsyQ7dYKJux/vK34S2+OR2tW7iUZJMvBET9qGUeOJhd6GX1TH6+JTPCfn5Mk4RIU9kgcGTVfwhpojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185414; c=relaxed/simple;
	bh=Q7YgnevcuJEA2r9KmDYoDbclADke6XSQZ/42JtuLJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufIR29pKRCBDGb7dSTLKUEEE4ftHcZrZivy34Ba8mzvUthGKiTWze/xzfwpRrFYjA4IKn5burHHTSaI5z0GM4kK96/pIpXCY1tbt48+zTy5vkX+e1WThSY/YN3b4RdFd/OxYkvwrJXC4cVEbU9knTz+a6xlDQuGLMdM6iwXWH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c86484d35d1so840493a12.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185413; x=1781790213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNpam1TbwdO296xgcg7l4uXi2a4BgIEj5/UIbNIv2nE=;
        b=KdUyz6LcHaud+x8rwVNtCu+AX96liiWgIhB9Znvjk73ExMJtBDXjles7+Qyqf+/zho
         nP0JBVgXBvaRzZ/BRApsS9PSKrXwq+g2gD/+bIW4dZDUupu6tI/xCA1FhYqYSHK2Gk0G
         cam8hRC1XGPhKK2C+ZiqikczjbBkTypXVTYa+UNKOsaJT7NYTM02vRieelU5xjO+4bMz
         PgLaNGiZK7TRJ06ruUDJO0EMz6bHYehDZuGkkqlmh6jv+TexvM+LCAGDxQ8Wsd1zowPZ
         iCl0ORsDekpCrkeEMwIWjd4136z8zeS9jGuIEuSHl4B15q+PalLcD+rTpOXKfoZDKakH
         e0wA==
X-Forwarded-Encrypted: i=1; AFNElJ9j6z2RzDAqxugKJcRpClPJ6XeFo+WPvy0oliyvTD7RyVRVHWieRBlUAN/IART4zs1BSzN84UTRDkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wm9GgxzYR1oHF8CrOuPKEWzUHRmyhjde5yq/OT8JiZ9+KHAa
	ZlCNA+J3X6v5EKPmaq4GeAAOgeOXwM9IbK3lM5Jk+eGTU3NdKIvmyvy9
X-Gm-Gg: Acq92OGyarWAf9MZUN1akDijdjBJJVSwQBTfPoc7/Ykk21VBU/o0Tb5nBcZBQ1A9uol
	OZ1/FNjW9DC+iiJ7ufy+RtMzgKtzEQlLyZvLl8ADotVe+PmPL7fE2tq4yTzbhOdHzx+8sNNpJVF
	/yZRq9k11EjZHDqDpLXDnGHv3cZQj5vYc7YScAZ0keDaCJL/NQwlDmwKQW+FK69UnO6YC+ZIm4F
	16DiqT883LHXh6MlJUIwgpliOJzWASlaQ4le2JXLWALhhjNRC+614UktuQ6XiXodf8q93pt17b/
	b8JMn2xvfwP++9wF3aL/cqUoY0F9i0Fp6xhC4UWG0m1hhW7HwUCbcD9vvFQjX0y+B6rV24XAgQl
	IiTHM9Xs72LGRqNQAeNN7P9adXWucdpMF+0oYpklTSe8fwsmw/c5iA78vfKEQDFX820PJ1fTCWw
	NtHCXsTtMoTQGXGaZjtoe1rCtg6tCh1O+IuedJZeJQ8KEcH/c1GJ3irYYPdgvYCQb9XoGmP2Mpb
	2/jfGKzUmynRQ60DmPUWORICop1lsXS9jtA7wPvGdv7HHAbYpINi6rU0OyF24/M2AxjqaxDaULd
	lpEs9V9iGLdwWkNIORoA
X-Received: by 2002:a05:6a21:6f11:b0:3b4:5c6f:cf30 with SMTP id adf61e73a8af0-3b5e33e3b13mr3499266637.38.1781185412681;
        Thu, 11 Jun 2026 06:43:32 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b20e0sm1757973a12.11.2026.06.11.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:43:32 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Thu, 11 Jun 2026 19:42:30 +0600
Message-ID: <20260611134245.30042-3-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611134245.30042-1-email@sirat.me>
References: <20260611134245.30042-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
argument alignment, and add field definitions for BIT(0).
No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Signed-off-by: Siratul Islam <email@sirat.me>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 38 +++++++++++++++--------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 8302e0049e7c..1782c89d5277 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -82,6 +82,9 @@
 
 #define VL53L1X_OSC_CALIBRATE_MASK	GENMASK(9, 0)
 
+#define VL53L1X_FIRMWARE__SYSTEM_STATUS_BOOTED	BIT(0)
+#define VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY	BIT(0)
+
 /* Inter-measurement period uses PLL divider with 1.075 oscillator correction */
 static const struct u32_fract vl53l1x_osc_correction = {
 	.numerator = 1075,
@@ -191,6 +194,18 @@ static int vl53l1x_stop_ranging(struct vl53l1x_data *data)
 			    VL53L1X_MODE_START_STOP);
 }
 
+static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
+{
+	unsigned int val;
+
+	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
+	return regmap_read_poll_timeout(data->regmap,
+					VL53L1X_REG_GPIO__TIO_HV_STATUS,
+					val, (val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) !=
+					data->gpio_polarity,
+					1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
+}
+
 /*
  * Default configuration blob from ST's VL53L1X Ultra Lite Driver
  * (STSW-IMG009).
@@ -230,10 +245,9 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
 	}
 
 	ret = regmap_read_poll_timeout(data->regmap,
-				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS, val,
-				       val & BIT(0),
-				       1 * USEC_PER_MSEC,
-				       100 * USEC_PER_MSEC);
+				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS,
+				       val, val & VL53L1X_FIRMWARE__SYSTEM_STATUS_BOOTED,
+				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
 	if (ret)
 		return dev_err_probe(dev, ret, "firmware boot timeout\n");
 
@@ -261,12 +275,7 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
 	if (ret)
 		return ret;
 
-	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
-	ret = regmap_read_poll_timeout(data->regmap,
-				       VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
-				       (val & 1) != data->gpio_polarity,
-				       1 * USEC_PER_MSEC,
-				       1000 * USEC_PER_MSEC);
+	ret = vl53l1x_wait_data_ready(data);
 	if (ret)
 		return ret;
 
@@ -461,14 +470,7 @@ static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
 		if (!wait_for_completion_timeout(&data->completion, HZ))
 			return -ETIMEDOUT;
 	} else {
-		unsigned int rdy;
-
-		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
-		ret = regmap_read_poll_timeout(data->regmap,
-					       VL53L1X_REG_GPIO__TIO_HV_STATUS, rdy,
-					       (rdy & 1) != data->gpio_polarity,
-					       1 * USEC_PER_MSEC,
-					       1000 * USEC_PER_MSEC);
+		ret = vl53l1x_wait_data_ready(data);
 		if (ret)
 			return ret;
 	}
-- 
2.54.0

