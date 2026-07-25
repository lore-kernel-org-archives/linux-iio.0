Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840A30C156
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784956260; cv=none; b=gi48MlXIveS0j+RdRGhy/GyccjFFYCkcchURWzz+OVgbK+xhml6LOpi1vEq8A48e03R0cxW86FNs8+wM5JGFe6qk2aYZHmY7edYz3fVpggJa7tYqtTphI8CFv3NNosLWhMFGnplt2Ipie+aMg/S5Sa5C1UwDaipgzQMdCbx8P0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784956260; c=relaxed/simple;
	bh=JeHX5wCK+eWh2x0vBH8Tjole6M5Zvb/8/2HLBL9CW3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNt/Jlbko/y6vCfFJKFo5raFm+Rt0Nd2kEtjtJ0245/d3kEOpL1yceb+hQ3v0A/XZhZIRrXLwla9Puu88kv87H4hosRXS8CNehwsvwYZZ7kVqLVAnj86YhIzvMxVKyycOw/HYUjio+O2963cJLCVrbQNAB9jEmpqxeq6FirhIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmvguw+u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmvguw+u"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1496146b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784956258; x=1785561058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYNr122iGMgO/EI6gg3d5n1DYFQvFWkuT6oNTUvaAfU=;
        b=kmvguw+uK1aFYCb/duCY9/KxDHWwbZ9XTv2fAsA0lldRnU3defio8wJChlXfsQdqr4
         9gSHgUxFmllZ2hLn3KAE7FMz2UkqBo74bFIuxFAsYSfx4ofCcXm6vM9ok33wb95vuNyE
         m+rNdqJD5d71s9nKmj1mQbkhysJGy5I6VgHTkS2D5BZz9Zn9Ufl3N505XFsA8vUMo4KI
         uCQPSdjBi0+enqVp1D3Bj/37tnukj5Zkou5Csul/3U9CzI/lOylPYjuHX9Yys9Sc3hoM
         0YWrFgzCNnzLRviffJ/uFM1FuodIEDTk50CdLJI2KSHhF7+hiWRiziDXLCMHvNyes7A1
         HL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784956258; x=1785561058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYNr122iGMgO/EI6gg3d5n1DYFQvFWkuT6oNTUvaAfU=;
        b=QrhohV61HAFPgChvrhY/giJAn8GAX964YSPGm/EB5IL48ylm/q12aZv8Wakaj1A+EG
         0Wl23ACU4K7cv9UtQkYdZmnSrrM8nCTwSoHAfGuA1/OKZ7vXwGe+0HyycQWmvb/X8Kfq
         yN6Kqag4x2N81ZgU9bg+/LHNevJ+134XCjp/TBhThZikPgFChFHx4RBSKQGw0MAUvWkJ
         OP6hscvC8PYcbPv6yIzl8qxspmfdIQ8irubf223sRFxj8DdQFqlNecwGbZiPI41yLFJZ
         LZRCUZbyBwVji9WkCTmf9XQGs60BapH/gmYfhf5s8g9lNNLf43aIV7EYz/3qSe1VkuTw
         BnKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKjV6liFlUCYHYDWp8mf3BLyxbu6QehGekYGJFJ/R/bdsrlUKkRAf4PoH+4qA484zJDaZIr+iF/Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcSVP6MJmzd1YIm4PGxWm38raX/T0D6aKC49oOvipzVIRGUXF
	ItZDMCgqfZ8hLDiLg9cMLdGTkUudtN6PV/fZkAhz1YISyetZ04VvCSii
X-Gm-Gg: AR+sD10n62W98Sjppdib57SRBTZnGd0psisoqOQo3LKawWa/x1E3SqdCr5186XCYJC/
	1fn1rS68LvYSYtxUTHT7uKIL8iQQoq7sIYjzJ0u3Jy/N/vCWyZanyKIhO8ukcw4zFRZt4D9iDYF
	kEDnlUuuW3SkbAdxRaWo10U5Gu9G0DVlUsUfo5nd6lvfYhJLRZ1D++4b/z6T/4IPjaKslTTsjRu
	aoiXZi4uS45GQNobxig0MImudOZ8stqVL/EXPRb0/il2bQfevt/V0lJSiIRCm8sx8Cu1h1J/9t3
	rYvuO3A5FbyENAhwbt26nb/Jubfw9lVoC6fHmJbXKSWH0LFwd9DGTiMmHYoohXCm6+ShLRxWpPO
	83MYXTEtNQ3Fy2aOjW8K+A3h9CrtOXBHZNLYK+f2gtDXYxwC8nYus5ALHnmli0DpZZcUfz3DDht
	PYWSbsms2Mq99RP3oEbGGK3uor3lvR7mkPdiOkYOln+h7VcqpLh1Bh9/jy9E8Gr0A=
X-Received: by 2002:a05:6a21:6b8c:b0:3c3:8315:80b6 with SMTP id adf61e73a8af0-3c67267e948mr3145679637.32.1784956258481;
        Fri, 24 Jul 2026 22:10:58 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([36.255.90.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm9263154eec.2.2026.07.24.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 22:10:57 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] iio: light: apds9306: fix PM reference leak in apds9306_read_data()
Date: Sat, 25 Jul 2026 05:10:48 +0000
Message-Id: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Add a goto label before pm_runtime_put_autosuspend() and use it on
all error paths after a successful pm_runtime_resume_and_get().

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/light/apds9306.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..014db7a1787e 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -475,19 +475,21 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	ret = regmap_field_read(rf->int_src, &int_src);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
-	if (intg_time < 0)
-		return intg_time;
+	if (intg_time < 0) {
+		ret = intg_time;
+		goto out_pm_put;
+	}
 
 	/* Whichever is greater - integration time period or sampling period. */
 	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
@@ -510,7 +512,7 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 						  APDS9306_ALS_INT_STAT_MASK)),
 				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	/* If we reach here before the interrupt handler we push an event */
 	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
@@ -530,14 +532,15 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
 	if (ret) {
 		dev_err_ratelimited(dev, "read data failed\n");
-		return ret;
+		goto out_pm_put;
 	}
 
 	*val = get_unaligned_le24(&buff);
 
+out_pm_put:
 	pm_runtime_put_autosuspend(data->dev);
 
-	return 0;
+	return ret;
 }
 
 static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
-- 
2.34.1

