Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17272FFF97
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389473; cv=none; b=ZLL/u3/H2ekefTAW57os/yULQHMjnKg9DoWFm0aB7fH/3DLio2a9pP3dJysypXPvLdzz62N5K/nPb7BLNaNM5j6SAUQnLVcVRJ+Y+z/WXqa5maguLIcZR+3ae+z/lftm2qi1QBWNjpRer0GTjMVz0bs3HMG93ZNpZiEXV0ExXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389473; c=relaxed/simple;
	bh=r1xsUjm742lN5OcNZYcSGZWAnGyO898ssLDUm4GqBiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UctAkTyEr7cQSIbB3M54fa2l6YBWYaAPfNBoHTmhswchOv7tyB25dJhpsUVY2WagkSn0/7obrMpm3X0yLHIZzV1KQiMWpvJnbvZpwyW8VqIqRBZPfYfuf0RNVFdoKyJ9ZIpe4J/w8Ivc1wk/+dsx2jTvdi7sxn5C4oavVFlum3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTkTX8cF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTkTX8cF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-797a52d8c34so43289167b3.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389471; x=1771994271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPEJTZQlZV/DMKRq+dAsxYEtRl3v2k/3xpS3no/6kB0=;
        b=kTkTX8cFWNjOQJK/wYtnCEroTXXWVuWYSKZcgHIy2WIw5cbmHYXy9CGhn7J1xF2xb7
         XFXQFqUGe8ivWwJvWL6YmvsZWb7CA4gRY29/xajNhn5fF/t3FiqpUhegYjQggUnNSilo
         XzdzDetPWfli4jUKplQ9mh2BSRF4HPrbb4o+ChWa0MOki7rV7OXhILdNR2rrqw/DsZAd
         I3ujgX0A28MXD/NSz63RIoUCDnvf5ZT2bdvD3fjICdHJbPTICEy4ucjVfPLsGS3TaYBG
         n3fulTX6HngHRJl4Es6CqN2QbD77Ugn+co3JZMe/fskiXQFi7FlTBrW4wKZA2Bjp/6k1
         IemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389471; x=1771994271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPEJTZQlZV/DMKRq+dAsxYEtRl3v2k/3xpS3no/6kB0=;
        b=M6IAU/wHiMxp34roQqCTwZDAEA8ipI2deDbKIyGlEDEJaRHbWfVW1YOeFewND4bdLs
         Jq4MAjb4oaiUEeQzGT8Ab4BRYsohdhDAZtNsPRjzHy5+OR1bem2txZ0tIsV5YdENS1Pm
         9htipmO3QXeJIbwgIv1qVFfltXng7Uf/Y2hwIAT3cWkbRKSeE72J6YD6gBeT9AqdBvdR
         DJdIh2QvB/8CmztSvFjbd+NJJQlOy+RhEaI59eM6g5EVoI7l415NOu0LVVlNTBoxApAc
         M5BZPAZnbzuoXR8k2iJ0MhzoE8y8pn+r4Z39m3dkhQkdmm/ZlfvouprH3GeQnZUvNiot
         89Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVzdWYubb6qzKBpkoOP0ohKcBKkzHYSsu5+dHsBOE7iFxdFItSGIL/xGvD0gHOMeSf6uVTnOPXYIHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7Pz1IkLu69vX502hXb+gEsBJ+88W7qnF+OuMPZmjcfwM9hP1
	Oxe61UyyAgfAO3oXZyu536tMADTiAZ5j4eJAW255Fi315k2fBQQ7tGdo
X-Gm-Gg: AZuq6aK7CTwF9HXXcJiVUpYFEW+8UFkYUmiqDPKVdS4gUvT3RIFezuyVYC4DKexwYdO
	bPA5SVhOkhuX5Pf+1Sc6SZiwfenQIWDD+VJvpomsdura+K3j0jvE4etOSvQWIt3TNdflGYG8OHr
	BMyPSfAMDNveVP1x7n/VB8JZ7RCT6rJwHxwfSs9xH0HAVHwiVL5cvj1rIp1h9j4JAGa8irmAqyA
	Y2DlzIeVLOFeALVhxrU5gWTNmy7HyQWsgJ+BJNObWcfeuH/2BKhMJzUDNNN7ATG4Z4zCbpJY46q
	P8ZR7NdOHtQAR4R7dIMb0jlicKcRH6ue6bTCCFT6oRbSLtoh19qXPlAWcRZn7U7rf4SZAAV2aJO
	NMjF72D7kzr1O7px2s8M6lgqt8e4YrkfgOJkPcy1Gk7w1VgMa6GdUJOmAnceLjQvU26/mKa3hF+
	9NTE39M5OVi8Ioo8+qNwMPTkRgUXoDqMudHq/2jLRbLvdTnx+6I5QZjXNyXHoH+enWp/M7egW6J
	MhVmgt3+HjSI39JaC30e1LYHpK/ILw5hOj+9lWiwV4=
X-Received: by 2002:a05:690c:4c01:b0:794:78d0:9b57 with SMTP id 00721157ae682-797f71ca8eamr5810567b3.16.1771389471041;
        Tue, 17 Feb 2026 20:37:51 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:50 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 5/9] iio: light: gp2ap020a00f: Return directly from the switch cases
Date: Tue, 17 Feb 2026 22:37:24 -0600
Message-ID: <20260218043728.609659-6-ethantidmore06@gmail.com>
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

Return directly from the switch cases which makes code easier to follow.
In some cases convert pieces to the standard pattern which also unifies
it with the accepted kernel practices.

By doing this, it appears to have fixed a preexisting bug, the variable
err in  gp2ap020a00f_buffer_predisable() is only checked once for errors
after the for loop is finished. This could allow errors to be swallowed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 96 ++++++++++++--------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 4afdd22499f3..f9ff8bbbe5ec 100644
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
@@ -1182,33 +1170,23 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 					   enum iio_event_direction dir)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int event_en = 0;
 
 	guard(mutex)(&data->lock);
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
 		if (dir == IIO_EV_DIR_RISING)
-			event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV,
-								&data->flags);
+			return test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV, &data->flags);
 		else
-			event_en = test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV,
-								&data->flags);
-		break;
+			return test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EV, &data->flags);
 	case IIO_LIGHT:
 		if (dir == IIO_EV_DIR_RISING)
-			event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV,
-								&data->flags);
+			return test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags);
 		else
-			event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV,
-								&data->flags);
-		break;
+			return test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags);
 	default:
-		event_en = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	return event_en;
 }
 
 static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
@@ -1366,7 +1344,7 @@ static const struct iio_info gp2ap020a00f_info = {
 static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err = 0;
+	int i, err;
 
 	guard(mutex)(&data->lock);
 
@@ -1400,15 +1378,15 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data->buffer)
-		err = -ENOMEM;
+		return -ENOMEM;
 
-	return err;
+	return 0;
 }
 
 static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err = 0;
+	int i, err;
 
 	guard(mutex)(&data->lock);
 
@@ -1427,12 +1405,12 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
 			break;
 		}
+		if (err)
+			return err;
 	}
 
-	if (err == 0)
-		kfree(data->buffer);
-
-	return err;
+	kfree(data->buffer);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
-- 
2.53.0

