Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BC3446D3
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818046; cv=none; b=MKq4Pifhy5v1EVn1LBZ48amtPLjK7DefHhpv2C3yRhnE5BmF1LpsGN0RIW0ks/XjF+FHbxSjUQ0EXWz34DgxauBKXnhYjp15CdXdNKjdnu9MwkkUaB4+sfbUpwjzUrYAXWE3mPKmah621Qq+ENWfqQMviAMkaCfR5zmJ4jMOC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818046; c=relaxed/simple;
	bh=WhKpuE8b1REpDWRKAoZ9pUtxDhIb3YCRe8/Hvvpd8PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgy/ZgOgDjqKuqtimAPTZS/m+IlbgJog3g/GqJ6vcsX94+CbQs7/XJuTxhfQz8Bqm4ZD68Vr3lDqFGtvX6p4cTo4KLcdWx99e+pp/daXkQ2brOc7v8bSfLyi4fNxJDBk2TvOE7qNQ6X2CkvBTZR+Ea6maV0W7UzFuY/tY/Gyg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzcR8MeY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzcR8MeY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fc4425b6bso33270727b3.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818044; x=1772422844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inztnc/jQ9anU8XWvdZwdVw0U+roWoisz8AsRkpiLjg=;
        b=CzcR8MeY4cpsGvoWfFjmMKtQ/5B4ZI8q+Df8lo9301UoFJo3oVdRS8fq49XOuGDzXy
         fiaOFC5vXLh2yg5LwnWo5HjQmNzPm94wkP7t5IeSoT/32aqNHfcCusRIBaWNDxHMOgYd
         /dxwAZ69xDAx/T59gawUSrWTXLLOwPQTGX1d6DnxQo9Mk4vp9f1Ej6tJBg2FtRfjKCSl
         LHD3vRYukTNumRxaiOx4/xCYSdhzl8e6c7sS0EnOxNQgS6Jz4V5EKrZiam1h23bJ7w2h
         wA048pYSfPJ7POfF3AHlScHJoPGW3rVmhKOkVTyY04Hgo36E7597Y5vpL2UZDiabkiqE
         +rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818044; x=1772422844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Inztnc/jQ9anU8XWvdZwdVw0U+roWoisz8AsRkpiLjg=;
        b=G+mXmXIBPv/zriR/+1jAi1iIUT2tImRE0bRrz/PfB/JjGQ0wjs9dZsW623k3RDkCLM
         IDKH6wmeABf3y7cVD2vwkWrae4mUk0XDD+7dEj/XvjVxGive6inYEsxzRTzHv5z9P7ZG
         dHkyf5RubgXGSporbbCSrXJiJ4+gT43mj0xJgXQ9elYBfEVjPcNXh2s84zA0prq0w+xU
         JxUX3g9rfqlRaEatcJW0OHFMnCudZmhGZTvDM83iBLSqzuOo+zIU3wVNPGp3Ia21mnB9
         95BIPs5lA29itGLAeeoyTTuiNCm5YNC8moGCn+phgJ59dgaHZcKfHaxJzi1ZiUG48ohH
         7pIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNMJPUtX7GimAeBFS27nTnYgX3a/HfJb1rx4HGxjIRbw1LlNoGaZQqD7IbbYhoZ7IKP5tFbyc7pnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx08nFu7IQf4rrIpQzGaAQUgw5Zv65l156okEf/mKSJA7ZbwBJ
	vQK1DjkiXf14ZTsMEZCabSdZc/IPqDooTKjnSS7/8pQqHu/3GP63dgoga0apIjWH16c=
X-Gm-Gg: ATEYQzw3cwOyKKeJEMA2nKVX2yKPsLvkpHKJQ/95Q6lKz1AlDtcFQK9YXQYj+LYTc9S
	Y7fMXYeDIAVKZQ1dGydYTwOtW5ZekxMNRB8iaR1yhGp88xU/UbtwEmTTemEtiRlHcKV7YS8y6CS
	y6L/ALjx68X1hnNOrWMR2UAqnnUGG/JlvFWu5LJkRbk5alSSA5PTrDeQy4iVth0NG8GSEjqX2WA
	TLnhNFPc/TszFhIOYBgZjBc5iNX/dNiiZyz0I8JjvD/Mvxe6+eVLuukZAndm8w/cRfinxQEDVtj
	dpP50RlLVigIGmgS+xdZ5Ujl/lWklLzJH1dPi+MwTV+Cs+xM5VRJKvlDpUGdeBvYS1YLfK3ajQU
	24tC9nkt9cTDchM33S7kbo7KrYxLSKffUEo2CVPvK4oHu7HmCQ3accE927zO7YbKupE+UKM3KsR
	SsaHTVymkCb13msAw63K3wpy6xToVRzniauCUUDe7MJeCm/Eo0PGupuyN+8oy8WlpV8RirOcRXR
	mjrqnTLOI+5c1K5VfcXf4Et
X-Received: by 2002:a05:690c:9990:b0:797:afeb:de93 with SMTP id 00721157ae682-79828ef1198mr65599197b3.12.1771818043672;
        Sun, 22 Feb 2026 19:40:43 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:43 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 04/10] iio: light: gp2ap020a00f: Return directly from the switch cases
Date: Sun, 22 Feb 2026 21:40:14 -0600
Message-ID: <20260223034020.27625-5-ethantidmore06@gmail.com>
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

Return directly from the switch cases which makes code easier to follow.
In some cases convert pieces to the standard pattern which also unifies
it with the accepted kernel practices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- Split patch up as requested by Andy Shevchenko.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 60 +++++++++++++-------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 8558c4c3ef7a..6b283b52698f 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -494,27 +494,24 @@ static int gp2ap020a00f_alter_opmode(struct gp2ap020a00f_data *data,
 static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 					enum gp2ap020a00f_cmd cmd)
 {
-	int err = 0;
+	int err;
 
 	switch (cmd) {
 	case GP2AP020A00F_CMD_READ_RAW_CLEAR:
 		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
 			return -EBUSY;
-		err = gp2ap020a00f_set_operation_mode(data,
+		return gp2ap020a00f_set_operation_mode(data,
 					GP2AP020A00F_OPMODE_READ_RAW_CLEAR);
-		break;
 	case GP2AP020A00F_CMD_READ_RAW_IR:
 		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
 			return -EBUSY;
-		err = gp2ap020a00f_set_operation_mode(data,
+		return gp2ap020a00f_set_operation_mode(data,
 					GP2AP020A00F_OPMODE_READ_RAW_IR);
-		break;
 	case GP2AP020A00F_CMD_READ_RAW_PROXIMITY:
 		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
 			return -EBUSY;
-		err = gp2ap020a00f_set_operation_mode(data,
+		return gp2ap020a00f_set_operation_mode(data,
 					GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY);
-		break;
 	case GP2AP020A00F_CMD_TRIGGER_CLEAR_EN:
 		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
 			return -EBUSY;
@@ -522,16 +519,17 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 			err = gp2ap020a00f_alter_opmode(data,
 						GP2AP020A00F_OPMODE_ALS,
 						GP2AP020A00F_ADD_MODE);
+		else
+			err = 0;
 		set_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
-		break;
+		return err;
 	case GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS:
 		clear_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
 		if (gp2ap020a00f_als_enabled(data))
 			break;
-		err = gp2ap020a00f_alter_opmode(data,
+		return gp2ap020a00f_alter_opmode(data,
 						GP2AP020A00F_OPMODE_ALS,
 						GP2AP020A00F_SUBTRACT_MODE);
-		break;
 	case GP2AP020A00F_CMD_TRIGGER_IR_EN:
 		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
 			return -EBUSY;
@@ -539,16 +537,17 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 			err = gp2ap020a00f_alter_opmode(data,
 						GP2AP020A00F_OPMODE_ALS,
 						GP2AP020A00F_ADD_MODE);
+		else
+			err = 0;
 		set_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
-		break;
+		return err;
 	case GP2AP020A00F_CMD_TRIGGER_IR_DIS:
 		clear_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
 		if (gp2ap020a00f_als_enabled(data))
 			break;
-		err = gp2ap020a00f_alter_opmode(data,
+		return gp2ap020a00f_alter_opmode(data,
 						GP2AP020A00F_OPMODE_ALS,
 						GP2AP020A00F_SUBTRACT_MODE);
-		break;
 	case GP2AP020A00F_CMD_TRIGGER_PROX_EN:
 		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
 			return -EBUSY;
@@ -556,13 +555,12 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 						GP2AP020A00F_OPMODE_PS,
 						GP2AP020A00F_ADD_MODE);
 		set_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
-		break;
+		return err;
 	case GP2AP020A00F_CMD_TRIGGER_PROX_DIS:
 		clear_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
-		err = gp2ap020a00f_alter_opmode(data,
+		return gp2ap020a00f_alter_opmode(data,
 						GP2AP020A00F_OPMODE_PS,
 						GP2AP020A00F_SUBTRACT_MODE);
-		break;
 	case GP2AP020A00F_CMD_ALS_HIGH_EV_EN:
 		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags))
 			return 0;
@@ -576,9 +574,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 				return err;
 		}
 		set_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags);
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TH, true);
-		break;
 	case GP2AP020A00F_CMD_ALS_HIGH_EV_DIS:
 		if (!test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags))
 			return 0;
@@ -590,9 +587,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 			if (err < 0)
 				return err;
 		}
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TH, false);
-		break;
 	case GP2AP020A00F_CMD_ALS_LOW_EV_EN:
 		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags))
 			return 0;
@@ -606,9 +602,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 				return err;
 		}
 		set_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags);
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TL, true);
-		break;
 	case GP2AP020A00F_CMD_ALS_LOW_EV_DIS:
 		if (!test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags))
 			return 0;
@@ -620,9 +615,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 			if (err < 0)
 				return err;
 		}
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TL, false);
-		break;
 	case GP2AP020A00F_CMD_PROX_HIGH_EV_EN:
 		if (test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags))
 			return 0;
@@ -636,9 +630,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 				return err;
 		}
 		set_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags);
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_PH, true);
-		break;
 	case GP2AP020A00F_CMD_PROX_HIGH_EV_DIS:
 		if (!test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags))
 			return 0;
@@ -647,9 +640,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 					GP2AP020A00F_OPMODE_SHUTDOWN);
 		if (err < 0)
 			return err;
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_PH, false);
-		break;
 	case GP2AP020A00F_CMD_PROX_LOW_EV_EN:
 		if (test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags))
 			return 0;
@@ -663,9 +655,8 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 				return err;
 		}
 		set_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags);
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_PL, true);
-		break;
 	case GP2AP020A00F_CMD_PROX_LOW_EV_DIS:
 		if (!test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags))
 			return 0;
@@ -674,12 +665,11 @@ static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
 					GP2AP020A00F_OPMODE_SHUTDOWN);
 		if (err < 0)
 			return err;
-		err =  gp2ap020a00f_write_event_threshold(data,
+		return gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_PL, false);
-		break;
 	}
 
-	return err;
+	return 0;
 }
 
 static int wait_conversion_complete_irq(struct gp2ap020a00f_data *data)
@@ -1007,10 +997,8 @@ static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
 		else
 			return GP2AP020A00F_TL_L_REG;
 	default:
-		break;
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
-- 
2.53.0

