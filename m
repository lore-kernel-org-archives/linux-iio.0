Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DE346FC4
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818052; cv=none; b=Ydnscf7LZfMUe7pEUr785Cu5lFf62luB1iG3ZwBAC/WziGLXAkLYFqjeSu8F6R3FnEKiTXjfjiz1hqqbW5OVhx5KGM3/eM0An25LmLqlj75CL7hfSm85FQmP+dqt1X+/PLa2kO/ZVUfpw1DW7gsEYHRKaK0shhqrShYMSeyOjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818052; c=relaxed/simple;
	bh=JpgjQT0LjeiOJzmjtLe3sLwto3eScrmQ5EGl4TkpJGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLbNGlbmkm8+G3UqnCQlf+OWGrbu7ldpcjscjo0+N/CiFl80bMk4snzxUA9QyR4vKCnqumhmmCQSLQPJUfRjEkiGcd4q3+52AK+f+UtB/b0gS7YCSaAGeq6TK1oNbRnPdBS6h3hk0KMbRTnuvXQrTsy4TLfqHMiv9UY/mrXgFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3eh76Xb; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3eh76Xb"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79639c2d2b5so31044507b3.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818050; x=1772422850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AODKCMIgB1Rg+62Tm7VBERUXirbCJ30DxdcOZIoJtvI=;
        b=Y3eh76XbvYOfTLxggvnVoAH91XmeHvlo/mNTu5t9PTI8zORZZfTBQD58mUiyysyYnz
         Hn7f+T21TUuu07y4mFHtUMv+8VdkbdOQdj9tjVBZS3urlPvizQUATMwAbHmFsBabWUYs
         s5y+HB68HO++PyYijjtZhGvq8SnUsnjmqVshWyN/Bpkt84SKBUFKdf/btHmztLXXX34s
         4rw4ZMzpqFXRLdZQq5rvgVNgrxEOfKNO90vm6CArQSTS9nY+LXPYLuGeDrgapektDBan
         eZZUD8567kpm9AybxITnFHJb2F0fSvEWf/fTMM+5hKPL3AxKtN6RNOT0sG9PBbApGKz9
         xYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818050; x=1772422850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AODKCMIgB1Rg+62Tm7VBERUXirbCJ30DxdcOZIoJtvI=;
        b=t14H96MSEbXOwU5Dkvg8ZF9+iiCw4KWC5HW1cWai8cKslQfueD0Cr5L5mWxJfkEDhj
         zM9uoUOy9iuY6DNTrf4Ssp4N2Y1ksYHsuXGdcjCohZF/L9g7P4aulMP5zdGWCr9a50qs
         tWTf8u6632YuAvjdN2IBJi7Y6FFp/R83IGTkHe5kw3ZhX9CC6jE0Kw/iyr7C5Tl3+NR8
         DkFHUJK2FhjR6NlZf6hO8jSW/sdxB07x0+l56/VrIKVs9yoOE3U6z6Yjq9EqBpgtwHTf
         0bA1pY0YIBqkN8i1fQSIQfjLL70KfZyl1rR1eKkDRELdtc19/IBikHZhn3r9sx+V/AYX
         LGUw==
X-Forwarded-Encrypted: i=1; AJvYcCVi2Wc9ijSuaA5d1n5cr4IHgmBRVpNxbuMmT6JhmegkUpm93Lboiux8k+UJMZrQ6txitsd0mwETl5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcABb6+LQBjY4OeeVEHdof+ZqyVuQXZ7nbpyCnndAmtfd8IzE4
	C/Dln7kR03TUBOQRaFrdy56ghAjDjx0RnkgT8rG+d/6qQhrxISJRLwrC
X-Gm-Gg: ATEYQzz4yVG2uZHcbm4fF1IeieRV+kyoOsKecGr7+nSJY4dEZXdWDdPzUGXqnqSYCHt
	uwHz1DKSIxNgMQlWBF9HXE6pOnm+L1Q/JRJaRlez1lRfFghCyuxymP6YlIcaKlJR88XxRzKgqxH
	51pLj3LR11naFwhxpHv5Vt2GSb4+GU2wPUnF+gQnXlfbM3Ku1yRAILLDkx1NGEwX3i0UXvJGb6c
	6Ool/HTTkn5Nc/RQ+ElvGId7UhI4rVn6AVRsy+vPHlOhUzKF4/hiANeBnImH955jaxgyFEULZX+
	LzDAEYudiHoWHzBkv4kgafjf3jh7NdSJ47TyqvEb2bZdkkgpWR5c20IMa9B4HXbX3mmzgMyfSUS
	TB4xL/iFt8OWo1SYM9D8jVxeSD2BhgRpK+B7PnzR88Qw0Akd81IAhCxgWsD/VVgh8kp8wjaUabh
	Lw22W5k5fsc9AK02mD1u3qtElsFRqv8zSaV0UnOSW83/drPEeMU3gzyNPb3ruTzjOJZZ6mwsOZZ
	9DV6TALI+wcKxWN6Fa0kZAudfvITm6aOL8=
X-Received: by 2002:a05:690c:6ac6:b0:794:b8c0:5a98 with SMTP id 00721157ae682-798291a1469mr64770897b3.58.1771818049721;
        Sun, 22 Feb 2026 19:40:49 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:49 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 10/10] iio: light: gp2ap020a00f: Join some lines of code to be a single line
Date: Sun, 22 Feb 2026 21:40:20 -0600
Message-ID: <20260223034020.27625-11-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
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
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 39 +++++++++++---------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 0571803155ae..9d4a310f92b7 100644
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
 
@@ -1520,8 +1508,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	int err;
 
-	err = gp2ap020a00f_set_operation_mode(data,
-					GP2AP020A00F_OPMODE_SHUTDOWN);
+	err = gp2ap020a00f_set_operation_mode(data, GP2AP020A00F_OPMODE_SHUTDOWN);
 	if (err < 0)
 		dev_err(dev, "Failed to power off the device.\n");
 
-- 
2.53.0

