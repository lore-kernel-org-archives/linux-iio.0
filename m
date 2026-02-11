Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637713B7AE
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770770920; cv=none; b=INu8nx5XUzWx90oCze+d/mj+jr69uZYhjwxF7w1WCqrer7D8j8VAZG+6+5K8Ou2bTZYmz9ubE09d7t0TTzJLKtIFNozq0Vrv08tRGx2qoGceuWFeRiBbOhPZM4r/01f4fpBFVnwaRSUKKULz1Q1QVmOFjVdNKYAHGH5u+yIXmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770770920; c=relaxed/simple;
	bh=hQHDuAeVIShrqRfwzEWpPeww2JVwqe01MpL3Pgiu9CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cilyke6XrQM8LmM9J/PuXsAeFRFPWszHzErtL76JJLNAA3M/rvArq1CO4KYywr7K0m2HJHY2wKawqzhmGMwkerGuffjTpo7llt8A0yCDrpFo2EcPyRXXsOcFJ315Rfb/D8LkoQzIVnXgEnjo2dLKmh6vO0Qfja1cKAl+09X2FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiU+b/4t; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiU+b/4t"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7963af509f0so16194007b3.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770770918; x=1771375718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kc1awYXd/il/iM2fPxtQGgTUyWwIhmO+WdWac4gmq0=;
        b=QiU+b/4txx145fyeesU0vBqNuoDfPJMT7cmWP0/BEHp9viM+VIYhdtkrk/Q464sKj9
         H8AbH7SX6JRAZJf0btfSj4BhbGR3n9UgVNDXhooqS5kkT8IXNE+oLqjvd/rM7EyJhcM8
         kTBrazA92pPfX57XLWQx3tZKTpcwPCNVxgzvqoRH8GnrO5UB0LS45ktbeeulHWsA56jL
         O0Pf6O0Bc0pRSTGl6fG+D2z7iZKJwg0Q4UO8ySOekBRgcZ6nYUCuhSYCJXHwB/pkyAXo
         /0vruQUgfc+c5iFnoN8hHGdqYNj+/7DPK/22VKKvxsjhBz20c6Q9NNscbWdXj7RAyFbs
         0qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770770918; x=1771375718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kc1awYXd/il/iM2fPxtQGgTUyWwIhmO+WdWac4gmq0=;
        b=gcCoBhaoHcCHO6fsxlS+UI13pJNB4S4+2x8DykgaPk2jzN6mhcQbo8XTJWtq+SK8Ee
         YnSFW81ZKyq3mQvhg2A5Sj6NtBBWdNqhzab29nT0OV3rT0Qmhavai4YCpPSSKQr+fE9j
         Il0RoU8xWvwlZM+wEHIAGQ78fzpNnko0SBhtryNKEHvgKanry/tUtGx660WWT/3O7hBj
         gASWxGSN/0PAVCA+EOxjCJ+TsHGpMyJBV5qJ6NMzyFLENF0sRYprxn3T5+Xqyk+VQ6Bg
         1wo+mA1hijEQfkPc0QnsELAODCW+S8WNzyaM07lr1l654UEwubgwyj1EXIDPQfnBqwxt
         FxLw==
X-Forwarded-Encrypted: i=1; AJvYcCUV8rOFrcV/nn2oTqMc1OkG6bg2/D8FcpxcYPFQOsNJPKf1axFjhaCZ5EUmxfFDfIW5vVbxFXQNmHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ague3VLfgDg2vlu07rpSwguG68/2fjUKx1FCUiPE/EoKmgRa
	6sROnIP+KiU8gMUZ389W9jiwE/Akmqnli3BtJ8ldAZiMARsGA10+z2jcllR2v60lkIs=
X-Gm-Gg: AZuq6aKQN0LZmHYwhXvydj9XOA2ACneckH/ucphZ3xV25jxKBiop1Sa6YbSqH8NF4SN
	GRiNgHkIXlz8pK0Jmos4QIb8NJauNvgBuJH13OIMd+/zdzPnVcGrk/sDjOy/XTxJOGNPUf4wEdZ
	TslNgBUCyhhTsg+JxER4JhBfVG9A/AsHBzzOR1tfdS+VJyadcNkohDID6v5bq2Xon2nQTj11Lys
	CtVErbThdtDDe3THy5z77nZE3h6HQEhTI9YfAO2J13mHHljw4heLI5Xpy43qsg1L2exROO3lpKw
	/rJr7b96m88yxX9no011sCp3OCTKC/d2toN4za4hFufqaD2wkGEz/BSFkUnRCPGpT8ODY2zPTGk
	pEc6yOi9hhXXUUJiD66kZ1qjp9Jtafl/CJ7ybQMFKSxsDjnzeHts3E42ej8XPFlW6fLg9BHLK7L
	StaohWIfcq295xC2TKO3f5DQugih1iKxJLizNZa2tGEqW60xIcp3yCdTiCmuotACI3uFjPtxWrS
	mVqa/pblZh6HwQhp95iHBQr
X-Received: by 2002:a05:690c:288:b0:794:e634:edea with SMTP id 00721157ae682-7952aa37b20mr162380167b3.14.1770770917963;
        Tue, 10 Feb 2026 16:48:37 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::9944])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254dc8sm2296417b3.38.2026.02.10.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 16:48:37 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] iio: light: gp2ap020a00f: Correct return type to int
Date: Tue, 10 Feb 2026 18:48:19 -0600
Message-ID: <20260211004819.854169-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function gp2ap020a00f_get_thresh_reg() can return type -EINVAL in
its error path. Yet, the function has return type of u8. Added error
checking for gp2ap020a00f_get_thresh_reg() return's value.

Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/light/gp2ap020a00f.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..492d1a029f77 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -992,7 +992,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
 					     enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
@@ -1023,12 +1023,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
@@ -1080,13 +1086,18 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
+
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
 		err = -EINVAL;
 		goto error_unlock;
-- 
2.53.0

