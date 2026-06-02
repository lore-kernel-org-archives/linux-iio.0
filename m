Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893203E7BC3
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407001; cv=none; b=ipOihPl2bE3iGgVSqTFHyxkv3id1Cg+OuA0mFzDAyRoUzSBZbOnOTDIK4Yd9Zzol9NfINJC+D4rYRjySj46xhpBMmIPnveFiz4cOXHZoFn6UxgZiS5ioI207oLY95XdBAUiIKglMZh+l4CS3DD9Dr9sS+EaQldG9fEphraxFKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407001; c=relaxed/simple;
	bh=Fa9r7MLTB3iX047+Vsi5imvyqmNHFXgMUgJ+vFWwYYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ol5cn9SyVQHbVDBm072ehFy8GZwW5AaMLDFD1+kmRloDdFfs6iM2dksoNpcJ5bR9MPvdpFBclK2Fq4adV+/X8eYA4m9FmvZqHBaDkfrG5Gsg8qD+mEGxjFk+e1eo91r+GTekMeCblk1l6JUeVjDP6giHlxqalQrADfZycCDNxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhQgwWHE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhQgwWHE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf1cda2b17so33394495ad.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406994; x=1781011794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCK/pBOSfb2PmGw6nhVQkWTZvBIjCGaZdFKlWF4SGdk=;
        b=HhQgwWHEFDM2imYhr6+/4KmF0lZaODSCP2/1mK9SfQrvcIojH/PKIYF1xx/sce6pKn
         BudR8RcqFC/9NK7owwpJ+87t4BqsZErQPxZ6r0rEdzrc8mA05H0FZPioTVIK/wHYbIWK
         1Clvgqd8HDlhHDK/FGS+LUOsgC3KmUGnbT9RQ6Vz49qHgu+8WkFNYu5qDfxvSHmyB2FB
         JDQqVNG7SLyYG5IJuyqMwGuuPOkvDdzDNoGma/iig5Tt3ywr4pJ0U7nba/JT3apYn1l4
         OZ7RAYTOVytAN/IVbmJHKDGmRwcHrDDPU/W8iuzW57Qhv/tw4/IS1yBdcBuNXigrCHrG
         R3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406994; x=1781011794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCK/pBOSfb2PmGw6nhVQkWTZvBIjCGaZdFKlWF4SGdk=;
        b=i6H9wckno/ib94PtR1ZCP7WXcnJhSFAcu11EiJ3+C4d2b7UUGvYWHOQkf3jtVCMHe7
         /YLa4YtE5gbh/qjh3bcIw2btLvxaNeyOAC9HTwASWj9VCplPWNHOPfdTQ46S0D7TCkBy
         uwDArBKyPMyNUZUPq72ONXmGpliCEgYMEzW+wLwloRLtzs8T8cD5KGe9Qgv4HJhEOtT8
         UvAOwfXdUVUR/lSbhB8DW5lktsMMJVaBxoEXQLbQgVHVTmOvV4z71OE4Vo1Qa+jRbz3N
         ylj2JHtuSbC4O/FMISh2qoDgV4mM2u4zAMtSay6os65J39BWmV36o9dY/8rm2/giiJTR
         cTdg==
X-Gm-Message-State: AOJu0Yy0bY8mxZ/hMvOjuxtuyk/1CIZo+bKyCQQbC9YsD5u9HEgnluUi
	umrTpbjVLJbA4CWyo41nZNd5FS/arAGi5VRYkIsQ/w9Gw2jNEC9TFJC7f122lA==
X-Gm-Gg: Acq92OHqXzxVgDhQf+eX2c45tDPG3IuCiumMD18Jezy4T5kx1eIsqr0vriNaee5vz/s
	xHJR5oRCwarRxcRBZ1FaOgi5Hjjs/uPvTPHTXJRagJw528/mSPwn/+shuHSddR0DCxnLaF6/teX
	45DtJjp/nUGIj7KOKzqWLjG57eiChmH7eo+nprnaLgxJmppba/axpvKTPlIgle879P6yHYzrR/D
	Ca1BZmeedrZ/ny81wpkA1yLo6cVR7EwjsX7n9vb8k9+zbyMoc7o6+rijU1XgmM4+xo1Tr8LnvGp
	1x8tHXogdCcXnv11+xZcFn7xAbTcA1A8WaV/kcRmfgWTeGgCvprJtuIzNTQ9jAZLqBjUmx+cpJ7
	FvK46Ik4HRzocigndhTsnmAxWvERNJw7XuunTZmiHi3V0yOqnWKi1Yu684RSECTGv8UaL9/ZpQA
	n06JgQumFC+kLNYC5PZMU4YWHSNoJyocWahnwaSLxw4/wDQ6A8ivI9aW4kVCI=
X-Received: by 2002:a17:903:41c6:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2c10cc35557mr37132975ad.8.1780406994403;
        Tue, 02 Jun 2026 06:29:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:29:54 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 02 Jun 2026 18:59:22 +0530
Subject: [PATCH v4 1/5] iio: accel: mma8452: convert to bulk regulator
 usage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-1-26d6dff8fc55@gmail.com>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The "vdd" and "vddio" regulators are always controlled together. Switch
to the regulator bulk API to handle setup, enable, and disable paths in
a single call.

No functional change intended.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

---
changes in v4:
- added explicit header with input from Joshua Crofts
- validate new member of structure with `pahole` and `bloat-o-meter`
  comment from Andy
  ./scripts/bloat-o-meter mma8452-before.o mma8452-after.o
  add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-1013 (-1013)
  Function                                     old     new   delta
  _entry_ptr                                    72      56     -16
  _entry                                       396     308     -88
  mma8452_remove                               646     548     -98
  mma8452_runtime_suspend                      633     467    -166
  mma8452_runtime_resume                       939     639    -300
  mma8452_probe                               4247    3902    -345
  Total: Before=36561, After=35548, chg -2.77%

  pahole before:
    /* size: 288, cachelines: 5, members: 10 */
    /* sum members: 278, holes: 2, sum holes: 10 */

  pahole after:
    /* size: 320, cachelines: 5, members: 9 */
    /* sum members: 310, holes: 2, sum holes: 10 */
  summary: overall size of driver is optimized and all new member are in same cacheline
- v3 link -> https://lore.kernel.org/all/20260505174640.3998281-7-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 60 ++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1403b32e2b21..a44b2138951e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,6 +18,7 @@
  * TODO: orientation events
  */
 
+#include <linux/array_size.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -111,8 +112,7 @@ struct mma8452_data {
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
-	struct regulator *vdd_reg;
-	struct regulator *vddio_reg;
+	struct regulator_bulk_data regs[2];
 
 	/* Ensure correct alignment of time stamp when present */
 	struct {
@@ -1570,25 +1570,15 @@ static int mma8452_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
-				     "failed to get VDD regulator!\n");
-
-	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
-	if (IS_ERR(data->vddio_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
-				     "failed to get VDDIO regulator!\n");
-
-	ret = regulator_enable(data->vdd_reg);
+	data->regs[0].supply = "vdd";
+	data->regs[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regs), data->regs);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable VDD regulator!\n");
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	ret = regulator_enable(data->vddio_reg);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
-		goto disable_regulator_vdd;
-	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regs), data->regs);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulators\n");
 
 	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
@@ -1723,10 +1713,7 @@ static int mma8452_probe(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 
 disable_regulators:
-	regulator_disable(data->vddio_reg);
-
-disable_regulator_vdd:
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 
 	return ret;
 }
@@ -1748,8 +1735,7 @@ static void mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
 
-	regulator_disable(data->vddio_reg);
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 }
 
 #ifdef CONFIG_PM
@@ -1767,15 +1753,9 @@ static int mma8452_runtime_suspend(struct device *dev)
 		return -EAGAIN;
 	}
 
-	ret = regulator_disable(data->vddio_reg);
-	if (ret) {
-		dev_err(dev, "failed to disable VDDIO regulator\n");
-		return ret;
-	}
-
-	ret = regulator_disable(data->vdd_reg);
+	ret = regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 	if (ret) {
-		dev_err(dev, "failed to disable VDD regulator\n");
+		dev_err(dev, "failed to disable regulators\n");
 		return ret;
 	}
 
@@ -1788,16 +1768,9 @@ static int mma8452_runtime_resume(struct device *dev)
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, sleep_val;
 
-	ret = regulator_enable(data->vdd_reg);
-	if (ret) {
-		dev_err(dev, "failed to enable VDD regulator\n");
-		return ret;
-	}
-
-	ret = regulator_enable(data->vddio_reg);
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regs), data->regs);
 	if (ret) {
-		dev_err(dev, "failed to enable VDDIO regulator\n");
-		regulator_disable(data->vdd_reg);
+		dev_err(dev, "failed to enable regulators\n");
 		return ret;
 	}
 
@@ -1815,8 +1788,7 @@ static int mma8452_runtime_resume(struct device *dev)
 	return 0;
 
 runtime_resume_failed:
-	regulator_disable(data->vddio_reg);
-	regulator_disable(data->vdd_reg);
+	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 
 	return ret;
 }

-- 
2.34.1

