Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B513B5AE
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818043; cv=none; b=b3Ccy7rIgaqVNtJvfTCWp9C9LxvT0PqibQh6eJVLldD7YleyRmJ5xTgrK/K+WHYIgEPqZ94e3ApNzGlbWNDlGRmG5TnXxbr+d93AlPrxCnmHSgbb9fxJ4WIgcIgYtV6SROzN5sPvj9to81WXWxRCFnW2HMWUe+CjlCMTOyy3AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818043; c=relaxed/simple;
	bh=MHTAdA0p3yx096g9IicyqQnRBWRyNknXQhvTuGz80UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZV2jcRS7uxLRiPfusOkcebRdQpTJlI1DFaN8sSpZd4qtT0TC7f4TmgzifyeRMGba1jfKsZc5X/87Pqpdhge1wtDEXxXkmPKiQEKfevT7c2ilVSAXWhD+KtB9fvgzPsd+4KcfIQXzopZ6mhlgCmjxEXbtn9r9Mo5WiNQMis0KhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFd7Upvl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFd7Upvl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7964f1405a0so38132557b3.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818041; x=1772422841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkUJsJ1p8D5fQxyBrpC9/cW9Unihi8QuVXvCcGPqhEk=;
        b=IFd7UpvlyUHKjivxiMrCBIX6IhI0Hb0NN1h61dpTvCdMF84n7qhdJ9qud98I7nh+dQ
         O/pepywlFa0h00wwcWgCUWnydX6daFetRSZgIoOeWmIOHciw5ru7N5H77McxbLR+l2w8
         0ZXHzKQ1kK5EzILzAIieT9sd/+Mg+nAcI8TlwdIUlW0eVjrCZb/p4dYAfn4T4sZ/4M8w
         UoNowWi4hpMa/Z7CCWcKK9cINT3OZWCqG/pq48oRjoX+6+rcLHkuN9Wlny2+fSMBT2Pj
         T6tfQM1trEX/e7mIm9NHj5RfEkolyczZTMIm8olduhYKE2tl3htSKBPdXjMRkdImmCNA
         e28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818041; x=1772422841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QkUJsJ1p8D5fQxyBrpC9/cW9Unihi8QuVXvCcGPqhEk=;
        b=TdDTKdTMtxr1vlYytnnFJAcVrjrC0nWQabQP2oAihmZfzxQA0LKTx2nRYKtj529EZu
         iyiJqp3Mx7fziW60FBgcuSQS/6kMptL/Sxsx+Ls4Faw+x2XAFXSr4sUZz51NQel6IFEn
         w0z/JqJMXP0FOOSNjsadnq3uHd8SkE6ZJ/C6XlbQzYlfJcP8PBU3lpQIHeyskP1+078f
         tsEDQSV+iBjcxxy9c23CO+AR9WSMjxjPIbTTpt2VVCciRrzM4qFMvRMa8IhmAMVuWjNl
         wdFJWlNaWOTXf/gmXzqq8lnMi5WAy01hSUyvwA+7z4xSfovgf2n3EEzGeS7A2G5RYAjk
         LnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6WBH0YpwtFU3m2zHQtJVf7OnNRLctTP3Qw9Toa68M8/QTR5IXz+RkYMEFxLTONaKLkKQcd34XtRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEQVqBij9OYfv9762EhSpUGu0qRqu3vrS0UymgQHzD4H1vH8j
	brZN9FVlTkuel6QtgE/bIT9MM6sZjz7itF9y++8725/O42xLQ8s7pgWl
X-Gm-Gg: ATEYQzxITcQmRpuU31GCwMY2LFQ+/4BBX/7L07q55P6JndI8SunhKYWx1YnqrZ4wLqX
	Qdxdf314MwIcnQrUYKlB8mB8VaNMUAkgsW3a5YQf1lLHf5Jug3nlzBlgllka5bF09pBoCtG9VKY
	fuIPt4aalbkgVz3eQF4ee3+M9hOSMrgiMYAxMqmqDCgYDQtwYobg1R6bjEO8eP8AJL8iNgt2B72
	eGyUGs5CLnygtYKFfWAXv7JVMpt/ASTKTRvqFaHITWDX7MBZC+GUcjZHVJ8aJp6I7FO/CP3dIc4
	tivvK4QYVVMg4+oWLJPPoLkVlRFf7YGm66UoStLjhHV0s9qjqRSL5Eo0+veiQVprQWC4omWO4S7
	MbhFzdtw+TDZ8Q+VrgvmQXOpzNRJ+LiUuZRjXTKzR0oouOi9hafVnzvkl/s8Vea6FBDAFvrGoEn
	D3d9Dxsb61rNOXWLqAOmn6cZv6SyZdHdekOtrBtleUVcuI2k/3ZGSToyEkQF9cODSMhNXt+Zq6N
	WG+r/iIqVEnVRjK47/fVgZe
X-Received: by 2002:a05:690c:ed6:b0:794:d80f:d035 with SMTP id 00721157ae682-798290489e0mr60364847b3.49.1771818041119;
        Sun, 22 Feb 2026 19:40:41 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:40 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 02/10] iio: light: gp2ap020a00f: correct return type to int
Date: Sun, 22 Feb 2026 21:40:12 -0600
Message-ID: <20260223034020.27625-3-ethantidmore06@gmail.com>
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

The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in its
error path. Yet, the function has return type of u8. Added error
checking for gp2ap020a00f_get_thresh_reg() return value.

Detected by Smatch:
drivers/iio/light/gp2ap020a00f.c:1013 gp2ap020a00f_get_thresh_reg() warn:
signedness bug returning '(-22)'

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- No change.
v4:
- Added Reviewed-by: tag from Andy Shevchenko.
v3:
- Remove Fixes: tag.
- Added Smatch warning.
v2:
- Fixed gp2ap020a00f_get_thresh_reg() parameter alignment.
- Removed unneeded whitespace between assignment and check.

 drivers/iio/light/gp2ap020a00f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 7cee15db3a1a..6fe4486101b8 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -993,8 +993,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
-					     enum iio_event_direction event_dir)
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+				       enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1024,11 +1024,14 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
 		return -EINVAL;
@@ -1070,11 +1073,13 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
 		return -EINVAL;
 
-- 
2.53.0

