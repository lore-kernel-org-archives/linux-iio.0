Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5E277029
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614291; cv=none; b=PPZiyZAW14AMMwc9P9f9/7OG52lzFo7C82FvRqnMKFVyG4rcvhR5M/hW4FkMh7pKexnTl8gqbWQK6ty5j9KC0XJc7X3sCqFqRierqZH5+kvyE6+Hz2sKt7ph5EdIAAmyNDRu3rZ6Q5d6YuXbhcPgXzlee45VINKm4O4nJlTenbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614291; c=relaxed/simple;
	bh=IY4Tb05zIpSJbPYx7yaQqKIDo/3qLKitKdlPvPxU3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iX0sLrXQ+0Q5vSXphHPZaAAi8LCi4prr7jV9S0Gg1ySKZBzP5uDgUmWrMz2uG3zf7bRn4JyBamKmuZb+A5OtQ2BwqCW1bnruL8UePCbnR/WSpxU3sBHHJ6l6SUTaf3lbgPobcmzAmKyHV/4kYNE1pTOAxPLzu6o2Lb02kjbuVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srpq0Mpn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srpq0Mpn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46aa216a5edso1364682b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776614288; x=1777219088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jur9/mGgXw7k0n94gBTBUaysjrdjZmBm5Vjpg1Eid/A=;
        b=Srpq0MpnqA3AqyNQSfsPRy46fHu9qt06qurBS2oSuUjLPU045hGbMxL2U5ixg6FYfN
         d7VdZ1xVTDya66s9MpMZya45fJ7vYcc2+TEMe4se3BGNcWXqlATMPiGnJAe+1PS7RO1W
         o4jQtCfBsK3NEJ6SttE2rRE5qQa0NxNh9Orch63I9OD7WP8bM/37YZJCaYKl6ftcXO36
         rWdLZYdCb4KjfRDjfwtuBsfZSLkj7AikvcqE6vKoafXw90p/1hPtlVxdew6RleahY12H
         sxMHwwuGFD+PoYV++LCQ9iF9qfodt/p7X/ZIGlBo3FdHXkt2/bmEfL5jNX8LYlWN+8gS
         kopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776614288; x=1777219088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jur9/mGgXw7k0n94gBTBUaysjrdjZmBm5Vjpg1Eid/A=;
        b=UlCW90hLcQO4/CGbdkb6DEbj3U3FUf8QD837gYvgZG6qC5/fJf2CTpmOvmO/+HC7ib
         i1hkA3sAd3AV5nxd4v+TanD4jQQ97igi7bddKZr0xnqYkTKosZi50lkN0tOSq15muVHC
         +CJnTKdktbOdly9p5nOnXxdYkBkHVRnAXHuuRyLo+45sghgue8TuHx09hQkQp4HBTkG6
         ycUaUmRQsfFWXChcY4ow3fFqDsE8D5IXVpgQOEe3X9YbWtxJnYwo/X86KI1Fy/8BngUn
         VG+VfxZ8a8QUqQc2+yV3ckrJaFXARcv77IUupor3f7vl7VCxLuN2P8rDb2q8rJIx3Ac0
         Q/lA==
X-Forwarded-Encrypted: i=1; AFNElJ/RVJ9thgIlUz9ANThQdAKQMETi+SCL+frsEnOXsFuYz5GQxsrX92it+dL33HbFERuIkS1RLDNtjiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEByWyVvGWQGmXz6fnXWv7lR07SAqb0+ewdFrBQiuUyMedlCK5
	acy6DTjvEDFuvvgounY1Iz1dMM9hdaFyy/QMlw1STmQ/Tc2zEhLSsu88
X-Gm-Gg: AeBDiesgm8ESwyQILQPTpB3xH9rAAFyGIx0vM1/sQqJvf5qZOs7poPgPFy9wP1bYjWo
	xpQb2ya62hOj2/8V0zpYY5shwGiX9CPyVGHAoDlzhcI0omRpiUBX+JeXXl5/yPkRG0I49zoDtWK
	qkJbKFOoyYoQY1MXdM3Qp3O+ABAi5Fbh80LYvdfVGyF/7u/96k0MMGRsJi9VwQ34HHeGjf/GyfC
	21Sl0E4+gGmsAgcfBDF3CxE8ISqtFnCtRSTU2rswzNb82bXpEkra4YrmwRLo7FR3LGRiN8hYwUp
	2vR4iagbU53c1IXdwhrDWhzxsFJFSfyfr7PVkUbma2umlWvreH4KOue1796NrRXiEv8YG29ry7f
	/SMTtpiIO9IaeBKSSGu/VnxqdMeNaE240mCbGfkr5JPeHLEnZA1aOADVlJhc+zpMnCI28zn24Ju
	5OcrjHluoDpaYOEuiDjT1Mx4uwj9KhA1bdxVBBYAFjr5HDVyfM9/WXPUrM7HF0timZDbOf
X-Received: by 2002:a05:6808:1442:b0:46a:cf7e:4b5e with SMTP id 5614622812f47-4799ca7fbcemr4813598b6e.43.1776614288602;
        Sun, 19 Apr 2026 08:58:08 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9304b7f6sm6805312fac.1.2026.04.19.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:58:08 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: proximity: srf08: replace sprintf with sysfs_emit
Date: Sun, 19 Apr 2026 10:58:06 -0500
Message-ID: <20260419155806.208741-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf function calls with sysfs_emit and
sysfs_emit_at. This removes unsafe functions and makes the driver more
stable and modern, by ensuring that boundary checks take place.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Fixed indenting of sysfs_emit call in function srf08_show_range_mm.
 - Optimized return sequence in function srf08_show_sensitivity by
   directly returning instead of modifying a variable and then
   returning.

 drivers/iio/proximity/srf08.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..604e89f89fe3 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -226,7 +226,7 @@ static int srf08_read_raw(struct iio_dev *indio_dev,
 static ssize_t srf08_show_range_mm_available(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "[0.043 0.043 11.008]\n");
+	return sysfs_emit(buf, "[0.043 0.043 11.008]\n");
 }
 
 static IIO_DEVICE_ATTR(sensor_max_range_available, S_IRUGO,
@@ -238,8 +238,8 @@ static ssize_t srf08_show_range_mm(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
-						data->range_mm % 1000);
+	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
+				data->range_mm % 1000);
 }
 
 /*
@@ -316,10 +316,10 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
 
 	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
 		if (data->chip_info->sensitivity_avail[i])
-			len += sprintf(buf + len, "%d ",
+			len += sysfs_emit_at(buf, len, "%d ",
 				data->chip_info->sensitivity_avail[i]);
 
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -332,11 +332,8 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct srf08_data *data = iio_priv(indio_dev);
-	int len;
 
-	len = sprintf(buf, "%d\n", data->sensitivity);
-
-	return len;
+	return sysfs_emit(buf, "%d\n", data->sensitivity);
 }
 
 static ssize_t srf08_write_sensitivity(struct srf08_data *data,
-- 
2.53.0

