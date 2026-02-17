Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984B3233F4;
	Tue, 17 Feb 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323810; cv=none; b=uuJbh20SVnQEIHDSDmnfnBIIrGCB5Abhc7n+22bvcq4+8UnELMS46Kch/uNXR6k4qzQ6TPVeWCdCD4fjisBp0n72iSvGtk0RBQNtm1E3WOaklrA+qlg+p7/xdTOzEXqtTcxP4Vv72qIgCd/s804S73wBPpnO+97U12Se5BEizbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323810; c=relaxed/simple;
	bh=z5+gHOsy3k74vfj74pPBY43I/aqOzMIVt4gUtOwP+7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1r8pJfmJ4SMPQyfE/lnaPsFb6j2Dx5mTdTBzmoB6f8+1KloVthuMOi0jOfSy/cQvpA/X/v8KbyzcvD4wSL8iImY+RgLPHtBADpwgZmO9KybUZJrqt0PuqHnAgDPH5AylPry4HdXbym7SMl3J48ZcwOFxGea9METnThepkLhKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIHNFnJQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIHNFnJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323809; x=1802859809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5+gHOsy3k74vfj74pPBY43I/aqOzMIVt4gUtOwP+7I=;
  b=NIHNFnJQ3mMSHulNoTZNa8zr48TvbazGdP8EYac0HE0g1xWIcDcom7qk
   v6DHHTuzL/Y5YGXlRnY6dipQEifBD+Q6Sn1gJ9voaSqG2CYe1d47R5LbT
   bjpWnNQ69LH6/nX7vOhTc2UPVLYQEzqZDwli8HH4Psn17GUAWeeXtyNC3
   4bkR0GyhHS9BYNt6DefrEabk1LZM4zbDpoCaBqYrLhbUgU4Rj8VzjZaVC
   APMmfNGu9WY2meRw3vpQf6KmvzdD55I8A5KoztFVwoAN9Yk29Xk5lrI1R
   RI+9Y1SI7ZMuqEtZh2pfqs/r1xHa7CqPeg8+XkARG39xyyYUWC7ZT2ym3
   Q==;
X-CSE-ConnectionGUID: kb6POmrhSkiR8HjIpJpSFg==
X-CSE-MsgGUID: sUt5CTPrTRKa34x4zZRPxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099181"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:26 -0800
X-CSE-ConnectionGUID: QxKartTkQ0WcWmSkf/UEQQ==
X-CSE-MsgGUID: oecdtysoRmWPbOsJJ84R3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851652"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5E40A9D; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 3/7] iio: light: gp2ap020a00f: Return directly from the switch cases
Date: Tue, 17 Feb 2026 11:15:13 +0100
Message-ID: <20260217102318.1354103-4-andriy.shevchenko@linux.intel.com>
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

Return directly from the switch cases which makes code easier to follow.
In some cases convert pieces to the standard pattern which also unifies
it with the accepted kernel practices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 98 +++++++++++++-------------------
 1 file changed, 38 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 64945690cfaf..6c0788720af4 100644
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
+	default:
+		return 0;
 	}
-
-	return err;
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
@@ -1184,33 +1172,23 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
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
@@ -1368,7 +1346,7 @@ static const struct iio_info gp2ap020a00f_info = {
 static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err = 0;
+	int i, err;
 
 	guard(mutex)(&data->lock);
 
@@ -1402,15 +1380,15 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 
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
 
@@ -1429,12 +1407,12 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
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
2.50.1

