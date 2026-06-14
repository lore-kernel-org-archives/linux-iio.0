Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B153A6F0F
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443152; cv=none; b=uhsy1gxEf2G9lUiRXrPbWEazxB47DWvMAI0mPrqQSQPnutAE0KCcJt7T09e/SFP/i7I6Ec8NOj+OBHiH3FPKplVOfZfjcAcm3+yC9Pup/oNnCXAr226RS/+z1ZDICuV5BXXG0DKBuTkqVpHyO3F1p0MpqLL5u+5N8m2qjHeR6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443152; c=relaxed/simple;
	bh=95sy0VX59VRwSK2QiJBxoBVckVG7ZEaGUPRGIQ5lLbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzctk1D8oUTaCqUcZbGtO7fwx2Rz8GqasYheFs7DcA5g71kmhS/Uuia0QR/mDfdi+/8BdCxtn3mKlgMggLFJSgLVT6HGIxlpCdvdklrA7OQfVY+8hp76DNpYvDmevKqWI57uNpX0LzgEaAAzKSPxNKmsEgZOemnH4JZ4GACbxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Si6bnW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Si6bnW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so16184095e9.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443149; x=1782047949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcMMHq8QVbJO4BaMHes6uIfe774ysaH55ers9LsNGrw=;
        b=V9Si6bnW2Jdk+v67uuhLp+GSifXkPn5uqZLbpVkr9ukjrOQgcslDg5qmT3+5sYnGo9
         XCGkI07z84dFYJAIXPwQBNhHXkH/NCDqHjWTjLNkD3GXfBdbyHls9D64BbVkFjTFeS2m
         QiQsesb3EKKcrmOUOtdLfLhFLCbxa+5E4YEr/s8JNWTzQ7SFp6iUed7w0JhuNFPAb26y
         Y7mR2NpfgiRLoCtA4P/GdOLJcujnq2Fwkd83OMP5YtklnhBtQpdbEu3Faff2IE/IW5b/
         CG64EuW8aHd/vWrp8vXgX4rrDwXqv6dg4PB9/WXfZrU3/0bK5Y4i69dD9vo5xxy0D8pI
         nUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443149; x=1782047949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qcMMHq8QVbJO4BaMHes6uIfe774ysaH55ers9LsNGrw=;
        b=nHAZOHLIL0QK/XrolJqhEeq9QO5q00E7aM2tHxoIr7KUyWeWIuVLkD+yfqhiTIyR9f
         2FRPeGfsLAE6K1PSTDww4c6J9FpnmPkiubfv6MCeIkxKXaErceetg0P16ZTk06TgMXKl
         47x1GHMeTx83lZG/kzmH6bMHY5z/MdNr0JcqEDiIstC++q12TSyh53y4QNWidH0XX2FM
         hPBoYbr5gizdSpryodwC+3st3DcKYemqqQtyPqGWBJpbCestjaJ1pJ2AdlSKe8KZrAB8
         euLIz87n6PiOedHWVwM+znDTJwGp0Ri6U3N5sPh7iqFAhYDwn6DFqHqNeeVtHIcIyxCW
         hKcg==
X-Gm-Message-State: AOJu0YyOa8Zd3wpxxbqnwhEUDra3xmQG5FO4ouAR+HchVvkLsfVaBMGa
	lBVXfiIwDFXEcnvSdLBF0N+ibwjqOkjrRS8xdlxIs8OhU2pO+G9x7+Bh
X-Gm-Gg: Acq92OEtsmX2k0brb3ykEb6U9XNS+l6kU7KR4yDGqXc6i0jTMxBXt39Md6RF0+ip9cX
	eZJTXa3wFLtgUNzBuhan8CGhJAXRK1fQMi//KTcWlJwBI3FA02sX3XBGIBb5IIcJwWqbnUGtHX2
	0C1plVMupCtx2PJgbm+BIxtKeTQavhYt+71IUPtq5cZgFsOS7PQ31ElId+ZbhzpigtgylCPX4/G
	9XNDvzy4LTyn94t3gMx9N/8FKH7KdTxL4eZpPufxokKkCiNlWnvugP2LT17wMVqDTAFSk79m9Zr
	6G09ybQMz0Mvgwe/G1dIjeutZNgCWDCAjyTL9N6roVv8NNo2Wu3SoALMPpVXZxF76Xk1wbvy/tE
	BEQk/Fn0rnhQLOod+76jqcPXtDZmAgRB/voDlgl6P+FX2Q7t9JOTvrBGCzwqpV9jaTmGM6bcWlD
	igNN4LOFtUeyAVw1vDhzB8CqrgIT2NFmjMbUhzI8/wc6MSMgCbGCdUvPKdwtHlLLIbG0ZIVHC5u
	TxxfelHHzOaU1ErBKJ4KU34l0mPHd0paFvkrC8UJak2X6jiQGHt/5AaozMdx+fJMJHYY1qE+2xM
	jgJaXRsurHfSVOn2TF3QDELdAncc+NeSbhK35GhT
X-Received: by 2002:a05:600c:4fc2:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-492200851cdmr85654855e9.2.1781443148726;
        Sun, 14 Jun 2026 06:19:08 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:08 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:06 +0200
Subject: [PATCH v6 4/8] iio: light: opt3001: ensure correct parenthesis
 alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-4-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=6481;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=95sy0VX59VRwSK2QiJBxoBVckVG7ZEaGUPRGIQ5lLbk=;
 b=a6YHvQ/t/dFijZ6E0OhfjCfurBkhkvdMgbFEnkfxW7HmjrSCWN7D8ibXpMJFndYsuoTTsxWTZ
 l7JBSuv4qHRAloMHIQfGVA1LqI41TTFiK31XIS7uD8++Jj/9gVythH1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Ensure correct parenthesis alignment per checkpatch.pl report.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index c1062ace184c..7aee251386e9 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -223,8 +223,8 @@ static const struct opt3001_scale opt3002_scales[] = {
 	},
 };
 
-static int opt3001_find_scale(const struct opt3001 *opt, int val,
-		int val2, u8 *exponent)
+static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
+			      u8 *exponent)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
@@ -242,8 +242,8 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
 	return -EINVAL;
 }
 
-static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
-		u16 mantissa, int *val, int *val2)
+static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent, u16 mantissa,
+			       int *val, int *val2)
 {
 	int ret;
 	int whole = opt->chip_info->factor_whole;
@@ -364,8 +364,8 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (opt->use_irq) {
 		/* Wait for the IRQ to indicate the conversion is complete */
 		ret = wait_event_timeout(opt->result_ready_queue,
-				opt->result_ready,
-				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+					 opt->result_ready,
+					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
 		if (ret == 0)
 			return -ETIMEDOUT;
 	} else {
@@ -474,8 +474,8 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 }
 
 static int opt3001_read_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int *val, int *val2,
-		long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -506,8 +506,8 @@ static int opt3001_read_raw(struct iio_dev *iio,
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int val, int val2,
-		long mask)
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -532,9 +532,11 @@ static int opt3001_write_raw(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int *val, int *val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret = IIO_VAL_INT_PLUS_MICRO;
@@ -544,11 +546,11 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
-				opt->high_thresh_mantissa, val, val2);
+				   opt->high_thresh_mantissa, val, val2);
 		break;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
-				opt->low_thresh_mantissa, val, val2);
+				   opt->low_thresh_mantissa, val, val2);
 		break;
 	default:
 		ret = -EINVAL;
@@ -560,9 +562,11 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int val, int val2)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -626,8 +630,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
 {
 	struct opt3001 *opt = iio_priv(iio);
 
@@ -635,8 +640,10 @@ static int opt3001_read_event_config(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, bool state)
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -800,16 +807,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 			OPT3001_CONFIGURATION_M_CONTINUOUS) {
 		if (ret & OPT3001_CONFIGURATION_FH)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       iio_get_time_ns(iio));
 		if (ret & OPT3001_CONFIGURATION_FL)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       iio_get_time_ns(iio));
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
 		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
 		if (ret < 0) {
@@ -872,8 +879,8 @@ static int opt3001_probe(struct i2c_client *client)
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				"opt3001", iio);
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   "opt3001", iio);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "failed to request IRQ #%d\n",

-- 
2.54.0

