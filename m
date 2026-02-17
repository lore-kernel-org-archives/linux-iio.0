Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF21324712;
	Tue, 17 Feb 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323812; cv=none; b=TbIIHhvZxHB4N8Egwo8mLi/via1cqS6pVVLqEa9OutDc3DTb5aKOhyZhr7pfzQ/MbL3bwr5w4uuNBFCXEYUOoDaAgWjKLpiRwVWjOwlq3zfHdsDeQ0qZjBfcn7imbvae8ReIN2XvqyU11H3CJcqp0FpECRAKJTj8z6LQ5OQ36qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323812; c=relaxed/simple;
	bh=QnXDZ5b/3hDTcHEgMiTJIX7eOp4DZps/MTOJPu83meg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwvSeeOOU8vhzfwFooL50JqutpKFtG3Hlqz89h18YHxlDcqkJCQGOS910wqqgiW6nxaDgSLelx0wbIPhDqs+VwbjOzVwUGyQ5m6OvWvlMf9NXcv7K9iVi1g+tQqmGchigzCXY+m/CbTfjrvC0yp7y5gaz5YEhW1wA/kt6bGKh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=covBc9fN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="covBc9fN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323811; x=1802859811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnXDZ5b/3hDTcHEgMiTJIX7eOp4DZps/MTOJPu83meg=;
  b=covBc9fNOlhiPMVOylyWFyJMCDOtfLLqQGFcT0LWpiK973hK8zKW5fzZ
   nQLgKMMT0vNqIO4kPWDnzaLf9YURLpVGqbFBalsK8EjGOs4k8isGE2paA
   bFliB5pSeArPY/sAnoDYogBFIyspqhcsbsIRnpRXbyfKEG90uoeEsgTBq
   GbzfHA+cqyTQjHyArlN6qs3VNKCT7gtjzQeJMQGFyt6CMxCwOg0N1wwM9
   hnDWO/WvNJMG0qpX2s5Fm8ItSJl6uQIklp1N9KUDmj3pxO7M32GRqXbPP
   dihytrtU1caJ9YPegV1CmiQdV4c+GD4/P/lWIwO2gcwZURSsGZWLbDNvq
   g==;
X-CSE-ConnectionGUID: /oOumK4SRNWwC3eGDx5L8g==
X-CSE-MsgGUID: ujEOmQQUTJytnknleasDmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099194"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099194"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:28 -0800
X-CSE-ConnectionGUID: 7ctxf3WIQl6Hai87vWXNmg==
X-CSE-MsgGUID: ugbVO7vTS2mzbyDgyd2hyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851658"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6EA42A4; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 7/7] iio: light: gp2ap020a00f: Join some lines of code to be a single line
Date: Tue, 17 Feb 2026 11:15:17 +0100
Message-ID: <20260217102318.1354103-8-andriy.shevchenko@linux.intel.com>
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

In some cases the wrapped lines are harder to follow. Join them despite
being longer than 80 characters in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 39 +++++++++++---------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 4b7afb62ebf0..c9eac0496ae2 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -175,10 +175,8 @@
 #define GP2AP020A00F_CHAN_TIMESTAMP		3
 
 #define GP2AP020A00F_DATA_READY_TIMEOUT		msecs_to_jiffies(1000)
-#define GP2AP020A00F_DATA_REG(chan)		(GP2AP020A00F_D0_L_REG + \
-							(chan) * 2)
-#define GP2AP020A00F_THRESH_REG(th_val_id)	(GP2AP020A00F_TL_L_REG + \
-							(th_val_id) * 2)
+#define GP2AP020A00F_DATA_REG(chan)		(GP2AP020A00F_D0_L_REG + (chan) * 2)
+#define GP2AP020A00F_THRESH_REG(th_val_id)	(GP2AP020A00F_TL_L_REG + (th_val_id) * 2)
 #define GP2AP020A00F_THRESH_VAL_ID(reg_addr)	((reg_addr - 4) / 2)
 
 #define GP2AP020A00F_SUBTRACT_MODE	0
@@ -390,20 +388,17 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 		}
 
 		err = regmap_update_bits(data->regmap, GP2AP020A00F_ALS_REG,
-			GP2AP020A00F_PRST_MASK, opmode_regs_settings[op]
-								.als_reg);
+			GP2AP020A00F_PRST_MASK, opmode_regs_settings[op].als_reg);
 		if (err < 0)
 			return err;
 
 		err = regmap_update_bits(data->regmap, GP2AP020A00F_PS_REG,
-			GP2AP020A00F_INTTYPE_MASK, opmode_regs_settings[op]
-								.ps_reg);
+			GP2AP020A00F_INTTYPE_MASK, opmode_regs_settings[op].ps_reg);
 		if (err < 0)
 			return err;
 
 		err = regmap_update_bits(data->regmap, GP2AP020A00F_LED_REG,
-			GP2AP020A00F_PIN_MASK, opmode_regs_settings[op]
-								.led_reg);
+			GP2AP020A00F_PIN_MASK, opmode_regs_settings[op].led_reg);
 		if (err < 0)
 			return err;
 	}
@@ -861,8 +856,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 	int thresh_val_id, ret;
 
 	/* Read interrupt flags */
-	ret = regmap_read(priv->regmap, GP2AP020A00F_OP_REG,
-							&op_reg_val);
+	ret = regmap_read(priv->regmap, GP2AP020A00F_OP_REG, &op_reg_val);
 	if (ret < 0)
 		goto done;
 
@@ -874,8 +868,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 
 	/* Clear interrupt flags (if not in INTTYPE_PULSE mode) */
 	if (priv->cur_opmode != GP2AP020A00F_OPMODE_PROX_DETECT) {
-		ret = regmap_write(priv->regmap, GP2AP020A00F_OP_REG,
-								op_reg_val);
+		ret = regmap_write(priv->regmap, GP2AP020A00F_OP_REG, op_reg_val);
 		if (ret < 0)
 			goto done;
 	}
@@ -972,8 +965,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
-		pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer, pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -1024,26 +1016,22 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 
 	switch (thresh_reg_l) {
 	case GP2AP020A00F_TH_L_REG:
-		event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV,
-							&data->flags);
+		event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags);
 		break;
 	case GP2AP020A00F_TL_L_REG:
-		event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV,
-							&data->flags);
+		event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags);
 		break;
 	case GP2AP020A00F_PH_L_REG:
 		if (val == 0)
 			return -EINVAL;
 
-		event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV,
-							&data->flags);
+		event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags);
 		break;
 	case GP2AP020A00F_PL_L_REG:
 		if (val == 0)
 			return -EINVAL;
 
-		event_en = test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV,
-							&data->flags);
+		event_en = test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags);
 		break;
 	}
 
@@ -1528,8 +1516,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	int err;
 
-	err = gp2ap020a00f_set_operation_mode(data,
-					GP2AP020A00F_OPMODE_SHUTDOWN);
+	err = gp2ap020a00f_set_operation_mode(data, GP2AP020A00F_OPMODE_SHUTDOWN);
 	if (err < 0)
 		dev_err(dev, "Failed to power off the device.\n");
 
-- 
2.50.1

