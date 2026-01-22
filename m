Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772233915B4
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099031; cv=none; b=FoaK8KwqaYohi3ZSFgQnSiyhCrCqS28uaMkAaU0vu70bywH0cjOjAeKSJag1ASpxRDOCBVsBLVS7l0OeRqv8FUwcwyJejF8iNTqMicHPcqwoiSgHsPjYpdMN50Y85PfDbSqTk5nE1S39MyjLwx5a17N8dWDhD+Iq1iLo2ZG2cRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099031; c=relaxed/simple;
	bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPXB8U8nUAQEnpphlOf1kv8CeRD8l93MQtaU1GkyPPzYox94ZgBPDKm6o9Tso06k4fJfcl+8eNtHaFNQEdzN9QT6dA3IZ9uRSWE/vf7Qq5bhqzdHlfEB+fuO30n5/g2BCX9wBh4oJUXFiQV1CLec/pN1hiHTx/+BBwhOheUMP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EAH0f3ho; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EAH0f3ho"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so13483305e9.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099019; x=1769703819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=EAH0f3hoCmJ3qLW3HZyX21bK6V8dBE25jcvMv0ocLcyMDUvYkzlXEv3cYUlSfykMiL
         jSoUOmOriq4gcbpcx0EFS7PsHW9OxmuN9KKmmewayO3t9mYy5P5r5UvIbrukbGcn6LAj
         mjS7IVa/psdFqFFbZ7lN3q5zTBqHU8yqj51BckV5uCsz7+fEwPCRFaFanqoQtwqljqPN
         VYGQX6Qjzik78h/UuX5SMFBCeWSkVUOB5l+LlbtTozYh8BWi99qQGDGahWddf399Zn2n
         zbnIsEM4vFhZT3oUvM3GWy9uUgD3IAPs5xJQD59J5mudW2EG0ad0mY7xJ034Gw8s7cPX
         U8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099019; x=1769703819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=CsSwjbrpIVCddlqeHNImY2dTTe0FnbkQzfJFu/vApG2vO+11z2mFZfkAsOORynN/1u
         ULob4Ngr/SrJZfDioVi6v9mNlr7Ys6Um18BfHi5pEkgIRChQQtRvFvAV1smt39Dgiv5D
         ub1ufMBNbCWDss4AedYEH+or9MeW9baeuC+9C25KI4+z0tcez41pSnDMUZuIWlzuqezZ
         ple7F3cyJDBDvG65uhci/2xSIEhdbgYGIB0HJwRz7mpJsw1lllqA15x4uvYqfsLkJpsS
         7b3XoUY3p8LEz5dZ+r+ib0/IB5LNvuPICP3X1dhAEc+WsgBn3IcXyuYS6rnI19yNFSgb
         zfxA==
X-Forwarded-Encrypted: i=1; AJvYcCVYoqlCH3twqq4x05IzE4ByqIUHKt9YhAm5NtsCFQ0GCQ+OjYFFgjPUI7RMz53ZnofgyYO8SL3yQro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZpPUVUnwicPF6Om6ARRE6MPqBg83jCz/rDxaz6oNdt4b3vZP
	wB1KatrYQkkCU3hlczsEU6FJUXk33A/um81RRrpVL5M5BQYokMmUHEKedBxEH0y+wZQ=
X-Gm-Gg: AZuq6aJGo0eY1NnEK1YbG85hWZo4qrLV9/mR1+hucclymJ35uuyL0CdphNJ9EWpErwA
	AKBq+IjlLVLhd7rgwOE2eOTdqh7mI7ZMfGaHV/KlFPuHn4GeAqf035earIabw/Dl481HxGHHjOm
	cUdvN4AAlYrqRydBpUmVFD/DUHDni4AcyUQsi9C+yIoqYbWBHgF8GdVYTt0qe9Py416bWozQtpE
	4TpWuntTg74x+TQ3lhEBfapxPL66nx713MLhrjOyHFeaPEmhgm+Xl29JOS5OdeztFGK5+KHoYP7
	E2o5xjvCKh59cwWZDgyHgdtF+BZW0BDyxkP39VP8LoBdaUaSgiSeZoWExG1hFdLYTiTQIcxuUMM
	AKfVU5r19JLZfAU2bPHCtJrNF/QQs62q3eGLXdfdTiCzajTKO5CxoscH8PCV6zjBkHWyE
X-Received: by 2002:a05:600c:19ca:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-4804c9db040mr2784365e9.33.1769099019276;
        Thu, 22 Jan 2026 08:23:39 -0800 (PST)
Received: from localhost ([151.57.192.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596291e0asm17268482f8f.15.2026.01.22.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:23:39 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only
Date: Thu, 22 Jan 2026 17:23:33 +0100
Message-Id: <20260122162335.2020006-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260122162335.2020006-1-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=flavra@baylibre.com; h=from:subject; bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpck7o8/bTUHWtdx2A2C6OfJtUtmuStD+mgbvOu BhcilH85FCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXJO6AAKCRDt8TtzzpQ2 X9FaC/9hVNScf0X4967gBKmXzMyIjnUD3tvR3u7sGNDAD1UEmydk9fQ/0mLaPjN9Q9PflDEq8Z7 ujhXCfRMcFbnR5RJ/0VcJ8BMdjK8GYG4iEAPauj6RhCUuLN8nJn9ORtTZzGnYm2p4H4sx0eIVEG 4u+a8vKFf7TOeMq0Do12SdNpr+nHTR1kgLNvsBhn1I3f7PiKJoFUpcG+zRFrceIWmUZJnCZ/tHo S7J+qT3/TFBzsOR32Fnx2dMobLAXfUI/SxemaRJXc+UeduWq6UaGKH3Yn3DLWhrM8DHVTS1Z2gU TeWfLKQD8xVper+z7cKKmZ6q6OQ4eCSVb2lBZ1UgeUNqVjngQTEukMwCJJjnCKJOuvrQo+NEOiq x/vgGtshNZ0kpI5TkL64E8syxQG6H3o2AyIHcZ/WUmE+FcziLsIi8wDYK6oHuQfgqTTactcaUC8 Hqqs2w1u8ios7gvgrBpaaIwWcZz+ECX1B6P8s/91G2RLn01wxpaDqWpg2iTmhQOP2sVsM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

The motivation for being able to set a buffer frequency different from the
sensor sampling frequency is to support use cases that need accurate event
detection (which requires a high sampling frequency) while retrieving
sensor data at low frequency. Since all the supported event types are
generated from acceleration data only, do not create the buffer sampling
frequency attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1ee2fc5f5f1f..5b28a3ffcc3d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = i == ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.39.5

