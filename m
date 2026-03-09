Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0D3D9056
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070481; cv=none; b=mlGYWJl/pDkdzRbwwyVfeMehTxstQ0QWVT0+Q+XBFTDyKR1iMygNYsnJmSjNXyhddMiGvFUdaJx7I0y5UbhwNnwAdyrHjAl4Y4s5M71Dr3h2V1HIEt7jcZ57sr3xgPZ4o5EFuZcnylhVr1RNEP/8b4zW/u0hMSH3ULPjy1k05P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070481; c=relaxed/simple;
	bh=PPcH7gq7zegC4ms1+4zc5u6TowItE1iBiFKCzoS1KW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AutHIHevSv+af8mfDExdEYMUd6DYRGFfojd/8MPJAlgNO74uOy20R9MrvT3Ln+S/uWG4qRzw5L7TdlIUQS9nNb4nlg7krMTzavGs0x47CP6EqzqRycF/8AkjS8kpiU/L7UBrL5chYUNR53vyY3kuJ4kl5H36iTgL2jqP3RS3peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1kRqLm7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1kRqLm7"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4029383a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070480; x=1773675280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bK0WqhpBZ+pZa4H+CeTkJHxMvrxbA/FN+llhWOAZnc=;
        b=M1kRqLm7teVpYG/kikqcDYUxWvQen/S9zDHJxB8sWZrBQ+zZq90UNc9+A4aWxp1wRO
         XizjPczFJP1VwjxgsTvgVv/c8jSXb1gEUqnioZ90WLfGYpIiTCaFojF0uEuAi0ZuyeSE
         srPlvaz8m/GqzkYAd1Pyh4rxyM0fYNydk26K+X8GpUONxgsUMpVSJmZfcRTtPF1MvkyT
         0LPs61mKfMOmlIDBaOI7G5RHb9jOrCeB38bJjywaHyeWEerQmf2iIWoRbVw3+X0VKGIP
         /6+tQVd9MZC4FaeOKGu9wMJnPxYWN4Ss8qrmeGpr/J+cdXf1kMwEtVeVO8BiVa1y1YE6
         ef+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070480; x=1773675280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bK0WqhpBZ+pZa4H+CeTkJHxMvrxbA/FN+llhWOAZnc=;
        b=CGXW0wg04c8qFB2OaEQSVgTLNLb0epq0pcRGJK9wKnQ2yzP5Hgp9S+ftT7ptkn7WH2
         BHFEzq39QHyrwMixoLPKB020tK083P8Vyshs61eS9pKEZ9Zymg0N9GdRRVZusraCITlD
         VLkapAhZSc5EL0EzVYDbbK8G9mixFU07m3GHc1Svo1m7hR/0wQGH3ieHXcAOXbhwg/Y3
         c6JxkWTC5WFa8Wu4w76VYlXQDgh62DiWtiYUk0D/r3Km/pxpNJLk3JUy/x34fhTCVHzD
         PqNE3ruhIsFVrYQpRAMLDJDqJ4rXkOAFTYaQSyWfbAYs8pfipGm5v8FPM7Br/IU+6iE3
         5wtA==
X-Gm-Message-State: AOJu0YzY84SJ7LAFV1k/ySc79TYizo9+vcIrBbws9js3eVGJ201Na/a3
	mGhLW8fh0mn65k4hDDVsHeS18rQXHh5FkW7HuXWmZ492deV1p07Xuprx
X-Gm-Gg: ATEYQzz2pzz5T/3ApkFRbQU7bt6+91Mo+AMy6wmBf5MBiKsVj1YIf3VJWA6oj3jk5Jj
	flvjenE8x4Emzz+mWhyYpt0wYDhOUsAGM4xxVlRjFqlz/rNLRabcRtjZeA2h+lRgVy4HbIEy19w
	E4Omkp8PNQ29h0oHx/L6ZvLvd0LdPQJYqU0rVazq6+2zjshDa9s+1vYAixoSbOHB4p3vkeDs82x
	dzZ2mq6s7mOhg3vzc0sQmtkE4X9UkW4xkkuJCkGtkQqJZi3c6l2Xr0jLIlekEtwQ333CigPOKKs
	4lr+V5Mb32N/VxUJDm/fHJi48UsZ6Eh/f+XMhe8Jt3X350597v1wGen0iofiJ0zUDQmIsS/uiRh
	8ZQLu5qEtCN8Awifh5y1j7RhqUdgI1qjpyPTVi2w1AKiUplWz9ZNNOimAi2b7EzClvicHsD1uiC
	ju+zFXzT9UXF4WYv+/UUQdpX9wujT17NYMJz+UxfKZVwoJ+UzGN2691PoRsY2KFp7dfGfUWlJ3y
	WEzmPG/HwZYwCyYpbSYClAJhX4=
X-Received: by 2002:a05:6300:408a:b0:366:14af:9bd1 with SMTP id adf61e73a8af0-398590ff382mr10268050637.71.1773070479847;
        Mon, 09 Mar 2026 08:34:39 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9316563a12.16.2026.03.09.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:34:39 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 1/4] iio: accel: bmc150: convert to guard(mutex)
Date: Mon,  9 Mar 2026 21:04:05 +0530
Message-ID: <20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
bmc150_accel_buffer_predisable() and
bmc150_accel_buffer_postenable(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v2: Cleaned mutex_unlock and goto in bmc150_accel_buffer_postenable(),
Dropped Header alignment change.
---
 drivers/iio/accel/bmc150-accel-core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..bd9791c9fcf7 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -1485,15 +1486,15 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->watermark)
-		goto out;
+		return ret;
 
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
 					 true);
 	if (ret)
-		goto out;
+		return ret;
 
 	data->fifo_mode = BMC150_ACCEL_FIFO_MODE_FIFO;
 
@@ -1504,9 +1505,6 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 					   false);
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return ret;
 }
 
@@ -1517,19 +1515,16 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->fifo_mode)
-		goto out;
+		return 0;
 
 	bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK, false);
 	__bmc150_accel_fifo_flush(indio_dev, BMC150_ACCEL_FIFO_LENGTH, false);
 	data->fifo_mode = 0;
 	bmc150_accel_fifo_set_mode(data);
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return 0;
 }
 
-- 
2.53.0

