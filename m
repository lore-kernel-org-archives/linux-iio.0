Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A832AAA8
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508029; cv=none; b=DzJHebfPQPUJsywTsWwIJrn0yhrdJGJhCecDFIuoxpMs1uaA4ZQAtNvwARODv7Qg4E2E+hPPUbIhDd8yIdCrGZnhqEW4o2fmqxlXUh/K0VAiQqyraIa/oAOijJ0mh1mY2ItUNAeLjroMO941pReLJg5Jws/3nN0lQ5B7S5rX6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508029; c=relaxed/simple;
	bh=HmPTsqb/9N1Z/ajgv8obZI9UP3kG09bBiRK3FZTbKPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cae3Bsj+Rx7TuVk0+9KIr5bzvh/um0tH05Kuo+B6vsoyOMdzQ70+a/ox89pm9DToTE0LmKojjSAf2fE2z4oVOw4vrfPohcUO9dXSt8sVOXxAHXAkYY/6jnQk33izrB7pvMXI327XGBG930tOnkCJ3AbyiTuR3aGuqH1/ZHKBCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaGEp5yE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaGEp5yE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b90d6fe14so184796a91.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508028; x=1774112828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXBXAYup5bMGRbC7TQhDOWWRHU3wjPm9XP+UjoBzfnM=;
        b=gaGEp5yEA+TBSMUREIndaKUfhOzviMu4ecd9EDZi7NTK3qoqAFhBkr5QfLxRQWYomT
         rJgkzSEhx109TprHgaQgmZSixazGF/XkO0A3dH4+ocr43z9LPONj1AIz5p8GxrtHIRH8
         kbZWMXNeBzJmu1A4+cn8BSANWc8SOEBKf2ehKmsgJdrXZB5DZdc3RORpuMC4cLUvZUad
         d5w9WSfODwHpDbRvZyltn9nUPA7Y/7q3MSVgob8/AS9s/beMnUXLs9lNDN2bgyBOutVr
         gHAnDUx8yIUtlbIfR+KmfPnatcTDpKWufde0T0Xwov7iHAh1CjMkWL12ccMC3QDTREbL
         EHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508028; x=1774112828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXBXAYup5bMGRbC7TQhDOWWRHU3wjPm9XP+UjoBzfnM=;
        b=cYggH2DmiXDSVcuUcOQto23FF9rAWgT23ylMG+XZQgmb8riempTVb7iotSj2jm2A85
         kAUI6CNjYx4uF5wCA2Aw/03a7aj9F11c7bMg3odq+6FpnBxmQYNgWkM+Yb0wG1YIVtpA
         nN+fsrm78QEwG6MhGXdteYov71DWBXSx899y3WwSZx58X/YD1Ve9tFv9sENdMpyIBD5A
         6pC8dUTXM9hPUp0CWGlsxSUuZZnOmO8WGmwT3iY5D/3CzVcnttZR3bJzpAnfHcpivvp0
         a4w1aDQnI6F8F37Ojk3kwsUdXM21NcPc5tpMQo6UWOrMAlAl23+28lSvXDMoCEEb1yYG
         N7Dg==
X-Gm-Message-State: AOJu0YyPa4nzNlcrLg87CplCCEKbTNFgtNb0yeIn4e4Nr5V3xPGi+Wpg
	6SB0SnGUhAhrhSNYEfEbzp6bt0lbEV/eHuOPfg+bxZUGc9OR3aSdjFb4
X-Gm-Gg: ATEYQzxEH7GWCIehr3YZEP6y9/3clL3qIzo8dtBCM/G47CYimPnTZ6LEdIeHUe55KmY
	N9WnW4rgI6mhvyCn3PPym/eNCI0FHf0cJByripAnOsbidDsicLSD+iGsgwQzIVbvG6FFRCHZzdv
	ifNEii8tFBYSVFUgB6ssTOINj+/Q8u8tX0byru1yARN7KdKAnTTb7aeffOswMKmAy+t59Ftd/st
	7votAhAAgshprcEE5OV9E0kp0bQGkHd5x26KBfUos5r3+QM+g0/61/7YUkpPwfM/c0atq0W+c41
	OjqAFh13WtbiM7KRpCsaful3hFwujqFeJHCKG0nOatcY5U7TxOD0hpTrgF61TKdvyogfcEr/lm1
	i+4riQ2XDkqzKWnF5T8Fuf2tQIKjwzcast+056bh/U8D9iX7EHLzcV3Ht4CvQ057ofgYK/kcARk
	9AhJ5k3RHBiwlnEscoDmDGjm9H0MNyZ1GqelLHxP8tyXCXqOWcZe66AFlaWSqWE7Q8WUjiVdV9j
	Aqre1jrJFLH2DvQugQrertnikk=
X-Received: by 2002:a17:90b:3c10:b0:359:92b5:da70 with SMTP id 98e67ed59e1d1-35a21ed3a60mr6694324a91.9.1773508027792;
        Sat, 14 Mar 2026 10:07:07 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:07 -0700 (PDT)
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
Subject: [PATCH v4 2/8] iio: accel: bmc150: convert to guard(mutex)
Date: Sat, 14 Mar 2026 22:36:03 +0530
Message-ID: <20260314170609.26827-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex)
in bmc150_accel_buffer_predisable() and
bmc150_accel_buffer_postenable(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: No changes

v3: stop initialising ret=0 at start, making clear about good path.
moved return ret up into the if (ret) {} block in
bmc150_accel_buffer_postenable().

v2: Cleaned mutex_unlock and goto in
bmc150_accel_buffer_postenable(),
Dropped Header alignment change.
---
 drivers/iio/accel/bmc150-accel-core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 4eb4293a741d..d3214be54819 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1483,20 +1483,20 @@ static int bmc150_accel_buffer_preenable(struct iio_dev *indio_dev)
 static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->watermark)
-		goto out;
+		return 0;
 
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
 					 true);
 	if (ret)
-		goto out;
+		return ret;
 
 	data->fifo_mode = BMC150_ACCEL_FIFO_MODE_FIFO;
 
@@ -1505,12 +1505,10 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 		data->fifo_mode = 0;
 		bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
 					   false);
+		return ret;
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return 0;
 }
 
 static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
@@ -1520,19 +1518,16 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
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

