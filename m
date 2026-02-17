Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362A2D5C74;
	Tue, 17 Feb 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323808; cv=none; b=Y/fj4qu6U7FSK/15eTckmhJ/K5ooGyg3amG7SwzRin8gqeddq3jZQRf1MEgidP1JzYGfE6KDiSpB9M5MaE60WasXEHxLtuhT4DAaHIl5EvN0ciQS2vTmWWm0u01IdF3fPomRX+TJ74V+I5pOi9RSVgP/1Wr2dfGECb6+ZaEryBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323808; c=relaxed/simple;
	bh=rX1P69sdtaumgGfAdEzd/kpdfyrC/RaYgdKXlWIuJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhdFH8BxyB11GTNnC0XNHpAxhl3TFIrRVemIzff0MwhUhggAxIjB0PRPmPZ8n6kiAfXhAxCwSrGiIWxqfyfhEuVnGZOVAesQADueruviqxcgw/0IIIycS4pJbAn+ggv1/Aa0+fHBkEwc6+9e2ZPdNujcph5P1Sn7HwIrvSSjDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbGyUjJa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbGyUjJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323807; x=1802859807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rX1P69sdtaumgGfAdEzd/kpdfyrC/RaYgdKXlWIuJ8U=;
  b=MbGyUjJadeCdFtGJNpmLVAnCmG6WWnfQga5K+h44x6vuKumkkXgH9k4j
   au9UsyNWvg27ekN1JiFLzrVXxE5sxnfgSQ3f7rvCm0YGNY8S0KNwgEIEv
   QLYA3FWvRBALT4WCb8f7E4Q8/c4lDflP07F+Il2NcDetNjB89IkRl1cJu
   2ii2auockwpnW01t7Gt0SRrHTkL7ss9L0+rnIUwZDArAh4veP1L3fvLXC
   xDjJKfUj8+caOVnKbMUCtAg2gXZe4j/hpMyoy593EtxZz9p+ws1m/93/F
   Cr1FIkuWSf+pSBfhJdeI6QmIjGuZThn5izNd09T7IUj6K3OlVE+oWN8dr
   Q==;
X-CSE-ConnectionGUID: HAQMYdgVR/WroJsWNeJKeg==
X-CSE-MsgGUID: kuZZogovQy6kV/r2SgfimA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099164"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099164"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:26 -0800
X-CSE-ConnectionGUID: jF7FbONaQhmTMFtRJATJwQ==
X-CSE-MsgGUID: yYUJ/SG2ScyDil2WqQioqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851651"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 54B0899; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 1/7] iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
Date: Tue, 17 Feb 2026 11:15:11 +0100
Message-ID: <20260217102318.1354103-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
References: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using byte arrays and then explicit castings, change
the types of byte arrays to be __le16 and update the endianness
conversions accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index fae7605f2f5c..6f75c845f258 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -462,7 +462,7 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 
 	return regmap_bulk_write(data->regmap,
 				 GP2AP020A00F_THRESH_REG(th_val_id),
-				 (u8 *)&thresh_buf, 2);
+				 &thresh_buf, sizeof(thresh_buf));
 }
 
 static int gp2ap020a00f_alter_opmode(struct gp2ap020a00f_data *data,
@@ -698,18 +698,18 @@ static int wait_conversion_complete_irq(struct gp2ap020a00f_data *data)
 static int gp2ap020a00f_read_output(struct gp2ap020a00f_data *data,
 					unsigned int output_reg, int *val)
 {
-	u8 reg_buf[2];
+	__le16 reg_buf;
 	int err;
 
 	err = wait_conversion_complete_irq(data);
 	if (err < 0)
 		dev_dbg(&data->client->dev, "data ready timeout\n");
 
-	err = regmap_bulk_read(data->regmap, output_reg, reg_buf, 2);
+	err = regmap_bulk_read(data->regmap, output_reg, &reg_buf, sizeof(reg_buf));
 	if (err < 0)
 		return err;
 
-	*val = le16_to_cpup((__le16 *)reg_buf);
+	*val = le16_to_cpu(reg_buf);
 
 	return err;
 }
@@ -867,8 +867,9 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 {
 	struct iio_dev *indio_dev = data;
 	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
-	u8 op_reg_flags, d0_reg_buf[2];
 	unsigned int output_val, op_reg_val;
+	__le16 d0_reg_buf;
+	u8 op_reg_flags;
 	int thresh_val_id, ret;
 
 	/* Read interrupt flags */
@@ -896,11 +897,11 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 		 * transition is required.
 		 */
 		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_D0_L_REG,
-							d0_reg_buf, 2);
+				       &d0_reg_buf, sizeof(d0_reg_buf));
 		if (ret < 0)
 			goto done;
 
-		output_val = le16_to_cpup((__le16 *)d0_reg_buf);
+		output_val = le16_to_cpu(d0_reg_buf);
 
 		if (gp2ap020a00f_adjust_lux_mode(priv, output_val))
 			goto done;
@@ -967,17 +968,15 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	int i, out_val, ret;
 
 	iio_for_each_active_channel(indio_dev, i) {
-		ret = regmap_bulk_read(priv->regmap,
-				GP2AP020A00F_DATA_REG(i),
-				&priv->buffer[d_size], 2);
+		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_DATA_REG(i),
+				       &priv->buffer[d_size], 2);
 		if (ret < 0)
 			goto done;
 
 		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
 		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
-			out_val = le16_to_cpup((__le16 *)&priv->buffer[d_size]);
+			out_val = get_unaligned_le16(&priv->buffer[d_size]);
 			gp2ap020a00f_output_to_lux(priv, &out_val);
-
 			put_unaligned_le32(out_val, &priv->buffer[d_size]);
 			d_size += 4;
 		} else {
-- 
2.50.1

