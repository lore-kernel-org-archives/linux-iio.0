Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE6485947
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206434; cv=none; b=q2mlNftaafm2GanSyFkU+SEh1KLEJWiXmT5cClOyo99waiUeI3BXmmdiK/ttB7zH0RZ9419I9NBJ3HTU8oY48EUsT19gYfNRQcwoILaSSLFCd7aieSKF8/QOYuCaUjILH1vkwniFPcnk62/UonKTE7iKcfASe6GptqHNqE60vDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206434; c=relaxed/simple;
	bh=Wke9HpYj8rajyjDe/WQXo5QKw7B9i4Wf8sIf6ePyJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0mZzqP9tvS1VlWvseCJG5scqupOznk47JCmILl2axeYCeR79eK1Af5VPkQjaKmsOokhtbgRYap2+Qo1jaA8capPzv35aUAHBCeDwcx2fusKyvmLevBlr53QhyW8KBMKyhuF29b6sbjNOpkh3wqN1MZlG97rnd587ptUswueCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCzyd0gG; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCzyd0gG"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so848570f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206418; x=1791811218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxfXgU6J2Pe/OFfdHlqW2Qga6zf9kDBoyeMvz/c9QrU=;
        b=UCzyd0gGPYyZqf/DS/GyUvw4+uSbAldaDpDd50v/obcEsuOvmsqcKY4856nreHJfkf
         wyXFp1xDkhiSzCyXxfjI00Azh5pl1SPnHR0DliRbgjfHGcwnmMoXLY8TYW5LvvL09sCs
         RAaIkSwZTYjoDVUcr8LJqzrp+EOHmRCwpoNtaNnBnErQ1oomGe3ZBnPTgAxIBCfZ4GGe
         IooY2uP7hm0/pvhEWNWC6ZzImvplkMAyQsnQlkKVG+rYvwIcvbdtHNSlf8nKzvyqIcPj
         S2fjk41wx6R/t6e7sE4UjlltNi8ZrdCbEfJMzI1GhcopaNjkqH1vEnf5wrKctf0dVvRN
         2rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206418; x=1791811218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxfXgU6J2Pe/OFfdHlqW2Qga6zf9kDBoyeMvz/c9QrU=;
        b=bKDfa54G9R/sbE158NSnvHGYTrcxbRUl7lBUDsIp52dZFYdU2ERp75w3nhbArBrHv5
         kH6vHs7XQU4kpm/gVbE48+fsQOgvy9Izwcg4FVHo0w4XTcEnRTM3kcPEO3tpAFgOUxNW
         UREEd4+K1wiMGk2yc6wlL/B7T0GCdrDoaDqNvb8FymAMzEdi58ZsQZTHpZduZtzhC19e
         84DGttDPVoLMNilZe35lehx1RfRWmnVLhi4h9X9JzeOF6dmpmeAFybR6mU6eN1ihyRQ5
         cvrWFXlPY7Q8/3KOYcmKP0Yt2CDaO+tbYtdtzKbwQZJ92/4Ypb0FBioquKC9N+m11C5C
         ftmg==
X-Gm-Message-State: AFq9FYL4lZYzGUPNdjkvleak9bFuw9VHJPpSGuybmpjPj8WLmP3LHFxI
	8zGMZiSE5Epnoc3zxgTA5BeoJQf/+fBYoVk3TrfYjYXwamCChMu2s57h
X-Gm-Gg: AYBFou1f1wxsODaQeMMejTJ0uzMUrlHOYOPV/tI/tE7h3kKQ6Gn19hvdwQ9ZT73Kxq/
	v8bJrT/Yymb55HS6UocttkLEdCUAZlgob+FT/my2jv1nEkbFVke19AsISIRxMK2GauAGZlFlAnJ
	FrTTavnUc8o0FGGSBT6I6ZP5MT5ymB7uGbRYm2kPFeJBSHJZ2yLm2qVAYi6lo4RxVWv3/VAtV1k
	IEX9TFZ0Qxq29138nmdwea8tflJXdyBjgEwqtCktJO9RYiG306sZ3gpqvwIRsVXTxquLy2e2p66
	kogRZMLhRzK2XBV+3mlINi+9QGoTM8IYT3VuT9oF8yKfti6Sp+xwbkv/MUrHTd1yQj4UjexXvz3
	OfIue+TrwhZPYGMVAv4md/esxemEIs6iMsEHZLtH29WqSMzuyAbnhRD6H6M5g00IrijwWhN4IQn
	IGFyDJNYZgyQkr2oCQyllCgqk3XKALtYcLz7TI8gUxh6Fm702CucPdGpQGbdxxALIbnc4TsR6kb
	1cg1ZHvsDcPuQ==
X-Received: by 2002:a05:6000:290a:b0:48c:490a:3370 with SMTP id ffacd0b85a97d-48c490a4c95mr12518365f8f.8.1791206418219;
        Mon, 05 Oct 2026 06:20:18 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62290381sm3660017f8f.25.2026.10.05.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:20:16 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: joshua.crofts1@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: temperature: tsys02d: Fix state desynchronization on resolution write error
Date: Mon,  5 Oct 2026 14:20:02 +0100
Message-ID: <20261005132004.255462-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tsys02d_write_raw(), dev_data->res_index is updated before checking
the return value of ms_sensors_write_resolution(). If the hardware I2C
write operation fails, dev_data->res_index remains updated with the
new index despite the physical sensor remaining in its previous state.

This leads to a state desynchronization where subsequent reads via
tsys02d_read_raw() return an incorrect sampling frequency.

Fix this by handling the error path first, updating dev_data->res_index
only on success, and using guard(mutex) to clean up locking.

This was found through manual code review.

Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
v2 -> v3:
 - Include <linux/cleanup.h>.
 - Enclose case block in scope brackets.
 - Add missing return 0 on success path to prevent falling through to
   default case.

v1 -> v2:
 - Use error-first pattern (if (ret) return ret) instead of if (!ret).
 - Use guard(mutex) for clean locking and simplified return path.
 - Add note stating the issue was found through manual code review.
 - Add proper blank lines.

 drivers/iio/temperature/tsys02d.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 2c67faebd90c..3dd33eb3c310 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -12,6 +12,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -71,19 +72,24 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
 	int i, ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_SAMP_FREQ: {
 		i = ARRAY_SIZE(tsys02d_samp_freq);
 		while (i-- > 0)
 			if (val == tsys02d_samp_freq[i])
 				break;
 		if (i < 0)
 			return -EINVAL;
-		mutex_lock(&dev_data->lock);
-		dev_data->res_index = i;
+
+		guard(mutex)(&dev_data->lock);
+
 		ret = ms_sensors_write_resolution(dev_data, i);
-		mutex_unlock(&dev_data->lock);
+		if (ret)
+			return ret;
 
-		return ret;
+		dev_data->res_index = i;
+
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0

