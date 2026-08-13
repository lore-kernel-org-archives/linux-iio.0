Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DA48C3F2
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635131; cv=none; b=JmgSLG4A4lh351Qz2T1tUQ30pdXA0tc/yFG2p5G/COeOs+JnJ9eZq3z4l16dzUxbMQyiBdNZXeC4eeYOfw+fc6fQ0B+TufTyn1dKJrYbZQUPHHuT759ZghXyigyZ7tEN//XOlqY30rhtC8CmkRYWkWTEYw2vL0YKDYAMaBCoW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635131; c=relaxed/simple;
	bh=sfBAezaRbgRTasTkRdf7Yl4IPx6PAR6DvqI2G38FvDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIWVuDyUl4wq21MXnV0QJ7T8A/3hXLmc+9sLatZsFC0ffL2dfRTkRzcN7Mk0iwQbgF9g1aUQKC7STCG3E0BMo+0i3xsUIfsgS6YBmq1/I4fF/H0cnzTVzXw2RMD2p+SNmWPkPAbKisGIyLtFiaUySULVHIgCqJRjaOijAAHRf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPo/RxGr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPo/RxGr"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1251076a91.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635129; x=1787239929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2qdJ72LpMBcvPrJb15/0HrRL2gmcJhiINfNwI4WIvY=;
        b=LPo/RxGreTuVBvodu6e5CRs62zGeuSd4AXYxN6atXQyh9vFIKOdKjKx9QM7QNzaof9
         PmKchn8EbSxTfBZGVnOSxLVkhuG+HGatOBySRk9EDM9UPUNOzhOeIGjK20PE8SPT/i5F
         mfwROpeQQMVA23GL21SDsIh56fHP/TxSYrl7z59leJUCdlca7kU15tWMirEjIPtMBmFw
         n+O43djMaKyYrJJZ188ffZWpl0RDtWm5Mj9V+ex+pMxFuc4yQyXdBpN61xd81nF9a/WC
         TXLOqJOwVZVnBF65deEiZbppGKp25nzKINTpowFeR5hzyX2+uFZqBFwLMNM6FfzfGncA
         poaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635129; x=1787239929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2qdJ72LpMBcvPrJb15/0HrRL2gmcJhiINfNwI4WIvY=;
        b=m6pj3PSJ6c1jpV2RJy+xDqpZW6uEnrdglm4RK67TbRwZV+zDtREWB3nKXyVrkC36Ei
         yBuaa036khQ7IggOx/qQggeCSjuIixjBB90dgESujEk2ZIRHPjuy6EwHFlhzgqCqq/N/
         rKOSBS0xxTbcVRGiz+Jc3CEv4saReGU6cxE6h/08k8R4INEfhUo9hvi9FFntGtij1zR2
         FqlNy+knFbOvIjEp7ufO+3RJQI3Ia/htTdadllklnH+uMpgKTK3ch5FwYb+Rq78vWUnT
         V1Llrqp2KxH8XnHMzAtjavw1myQPoitYY/Ocs5IQsPrZ1HifQsuXTM9RrE/qvG+P1dPQ
         FflA==
X-Forwarded-Encrypted: i=1; AHgh+RqIKKFgnkoeBRaHWMfc1XLrfK/+hnvXrBFinz+VSt/9YYdXuIJ/lfkcfcIKcaX6f5FgVsB6V2beq9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUQqkxg3gibXsde7o2jIrnA36KxPXkgnCPJAtwC91iGS1UVUE
	11jGNbM3Wf+NX4WJbTSYyYazdM1dfzRuS/OSVw/49sfim4iDBBjaxPS4
X-Gm-Gg: AR+sD10CdqdzCH7OtC9jFSOlXf9D0JmUasfHIiYU9IPY0Yb9jxu+qI+fVdcelhbhGMQ
	XseLj8oknWab0ZiUxPEnZjyCZRJ0vZBu6URF95MKQsSODrWkr/Zv5f+Q7Suw6zsJ9fwDm+OlkXd
	UqCRhtYl++u2xaqJQUJEL/qZYZifd8PDzOfRouxap3UnfC7VKwgHQhQ+BlO5FQo++O1TzF9DDdm
	2jGnmyMT4oinjTF9yfRexa3KLCiBb0LL9zJzbomLT/MUqZEcX1P4I9oyUXoeQR9SF5epD0LjD1q
	DcQJkfsdFHLadyVqLHuvGKKXiaA6ePDKVvivSghqZoqAgKuGy3BnN45GIVfqzWp5vF2PS/LCwZe
	8bSY6FnPm0+cURkFHf1vW+m5lGhDOLsxQn79QHy9LVPNhneZGlnOKCsFTi2gs2E7qtX1YTyBJmg
	C8CBIc6drB1tX6GWoSLpEEnUZQrECxqVo0O4PteJJ6/a47ELX9qhHXHSZAHrDtKunaHplmt2yzc
	4NQlYDVZBPODFa0HwvXRYHFr1T1EFxR3b1h6Ch6Xk139VO80f15OdAGvF2QjA==
X-Received: by 2002:a17:90b:50:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-3931f9069femr2991671a91.11.1786635129125;
        Thu, 13 Aug 2026 08:32:09 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082943fsm7960604eec.29.2026.08.13.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:32:08 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH v2 5/5] iio: humidity: hts221: fix division by zero in calibration parsing
Date: Thu, 13 Aug 2026 23:31:29 +0800
Message-ID: <20260813153129.12423-6-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hts221_parse_rh_caldata() and hts221_parse_temp_caldata() divide by
(cal_x1 - cal_x0) without checking that the two calibration points
differ can cause division by zero.

Reject zero divisor with -EINVAL, logging the offending calibration
values. A device with such calibration data cannot produce meaningful
scale or offset values anyway.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index fda38dfc6742..47a10884d812 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -245,6 +245,7 @@ int hts221_set_enable(struct hts221_hw *hw, bool enable)
 
 static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 {
+	struct device *dev = hw->dev;
 	int err, *slope, *b_gen, cal0, cal1;
 	s16 cal_x0, cal_x1, cal_y0, cal_y1;
 	__le16 val;
@@ -275,10 +276,20 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 		return err;
 	cal_x1 = le16_to_cpu(val);
 
+	if (cal_x1 == cal_x0)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid temperature calibration points (x0 %d, x1 %d)\n",
+				     cal_x0, cal_x1);
+
 	slope = &hw->sensors[HTS221_SENSOR_T].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;
 
 	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	if (!*slope)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid temperature calibration slope (y0 %d, y1 %d)\n",
+				     cal_y0, cal_y1);
+
 	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
 		 (cal_x1 - cal_x0);
 	*b_gen *= 8;
@@ -288,6 +299,7 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 
 static int hts221_parse_rh_caldata(struct hts221_hw *hw)
 {
+	struct device *dev = hw->dev;
 	int err, *slope, *b_gen, data;
 	s16 cal_x0, cal_x1, cal_y0, cal_y1;
 	__le16 val;
@@ -314,10 +326,20 @@ static int hts221_parse_rh_caldata(struct hts221_hw *hw)
 		return err;
 	cal_x1 = le16_to_cpu(val);
 
+	if (cal_x1 == cal_x0)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid rh calibration points (x0 %d, x1 %d)\n",
+				     cal_x0, cal_x1);
+
 	slope = &hw->sensors[HTS221_SENSOR_H].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_H].b_gen;
 
 	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	if (!*slope)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid rh calibration slope (y0 %d, y1 %d)\n",
+				     cal_y0, cal_y1);
+
 	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
 		 (cal_x1 - cal_x0);
 	*b_gen *= 8;
-- 
2.47.3

