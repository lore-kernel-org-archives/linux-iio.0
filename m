Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5330BBB0
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389477; cv=none; b=rISs4+NtmxYXVD+Ob+CxIe/jx3soapLC20yEsyr6c2ahZ3IJHrojXFc3p9mYl6ZUSD329FBbWcGLLWWbQbHUaRNvGGZRqYGgcT7vkBJtb89yiJyIa1MwKy56+Yheq1nYaTGtvyCHP/eLrKh9lKhBr3gWRM47DhvZEJ9mtNkRmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389477; c=relaxed/simple;
	bh=tavTc3XfhtYb3eP3dhZujArpuFQBikYBD/4KjS7zNUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYPIFdWOtD1a9yIiSMDd5wCjIjIQTTMWlQq05r0T7O/1SEXNAppAtgOlPAL7SkSRJr5Ourt5rN3oKHPVU6GUkMPNGpLYY7qbDuuAW/TRLYdbshcKdWFtMxdCmHWCbU5Qex2/jE0rwXFmsZBuDJjRRxPJsANEqwcnIAssN7Eax0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9mE/YFr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9mE/YFr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7963b25e0ffso42369367b3.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389475; x=1771994275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGAhusucpz3XIU5gfM/bxCa/fDIiPoUBjtUt95RLBgs=;
        b=H9mE/YFrd++f8eCwADqnh2vS92o5JQsRIILntMgV2k73+f7j8BbQ8mB4z9qf9sVt8e
         MJFoMj9fAHnE/zmq98jOgHBpA4ICY2tsbmC/6ab5ueHKYzoDTKVe6ukmyHaaxdrWt17/
         Kskgf7o5RlJ/v/r2uO9Ok8xJokTyHb9cuCUKjRj/T2YvftlOMHQwZXklvutIKiNBaOVt
         XmdPjRDi+WTpkoF3bMZd0+eSHbmjEWwV5iUef/hoWac32fqSdvD1d8a988EPYhGdYDD3
         Tkis8HBu19go4InhwMNJcOmqNf7FYwEtYYxvWX0xfCDrDThn+rfm+3cFF/fJRxAuL1fR
         RsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389475; x=1771994275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGAhusucpz3XIU5gfM/bxCa/fDIiPoUBjtUt95RLBgs=;
        b=uw9V4nlnJ8iCdqAm+ENF+aFF3TZnJxfFINfXIgbGSoXUed6AWO9NDJVO4LyFHwb/HP
         VYs5g7rWe9gFUnHln5QlAPHKYB7XDdjM+L8jClokvGhRsTCN0h6U0PUHjb1wbuYeb7nu
         Im9D2frvgXFLxSUOcmkSt3G+S4Vo4mwF0X3sQGLEePOEBuqhF1dFmMQU4OIrVzxBgUDO
         OnNmuFgTQ4zVhUzJWCvNbI2T2uDoCMGCykdVjfUIWU3MhqxGf04UQzaN7FBcp0se/ymg
         m2xYyx3WKLzgBhrUUmCW5sB2HtiA6FHlEUrIu3ix2yQVjvshrhq4gXndLn9yqudaZDUH
         cOwA==
X-Forwarded-Encrypted: i=1; AJvYcCVqIoJpFJ/gobVwS1FjrC0kWTHcOsejtrYAaKEYZyW2xIsLRtiD3h52DUcR8n9zDm/FrH0RpzKZU6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5uQDSIbCeuIvKrI5txhstkrENBAQtKRfwYDlDhtLuz96kUB2
	phIdMUzmINRqfm8+W9LIr3Li5tezIRXZ/wRpRNAHa6oklnr0GGDy60cx
X-Gm-Gg: AZuq6aJl4X2DL5aasBIC5/y9QZopwGyfIJlZguh9Ty6VQsrhfBLQ757+cU7jwtcZtvR
	qamKTkDefkINkzKIec975NHfSnY06KjAqids9C8Y31c5FJc844idB4UsxPXuca2Vi/QUdnvyZtz
	g6mNC4O2wNlpWWDPaGwZxiixp+p0HW5a50kLQb5C7g1ls37CjOER+S1/epnN3l9GOiyXBnbq5iz
	9QZLPRcRf8UEzfTSK7fk7uCC7UBHQpWQqMwLYjm2QwQMGQs6eKEospC+29GAR5B4933hbYv65z2
	YL++S+TVVoJQxv7oTBPj0IjR3OYUHWo5wkUGQxXDXANx0ySCAN4FBc5N20P5iKQ4DhDXiZg1Fo4
	/UOawqP8K4yiHlU3zrCnQa1goYCRcv/hZV0h1dcWFmk5G3Ht0QFxRZ3fRhNcqT3J7sTfkob1xTd
	Dyhm8uUueqRnghKhrXok3JIA4+4wWSMS+9U3Xumxwee94s3x38VMWfTCoXAWVS5ggb1C+PM9iJx
	S2N5Y+Hooa2aQrZw1U2xyJy6TwpxU4wlDyXsZPPMYc=
X-Received: by 2002:a05:690c:4d84:b0:796:5a14:87c3 with SMTP id 00721157ae682-7979e89a46amr145000827b3.40.1771389475050;
        Tue, 17 Feb 2026 20:37:55 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:54 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 9/9] iio: light: gp2ap020a00f: Join some lines of code to be a single line
Date: Tue, 17 Feb 2026 22:37:28 -0600
Message-ID: <20260218043728.609659-10-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In some cases the wrapped lines are harder to follow. Join them despite
being longer than 80 characters in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 39 +++++++++++---------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 1867dacc0af6..e901a8c33609 100644
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
 
@@ -1023,26 +1015,22 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 
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
 
@@ -1526,8 +1514,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	int err;
 
-	err = gp2ap020a00f_set_operation_mode(data,
-					GP2AP020A00F_OPMODE_SHUTDOWN);
+	err = gp2ap020a00f_set_operation_mode(data, GP2AP020A00F_OPMODE_SHUTDOWN);
 	if (err < 0)
 		dev_err(dev, "Failed to power off the device.\n");
 
-- 
2.53.0

