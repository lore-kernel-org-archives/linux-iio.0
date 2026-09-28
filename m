Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4E4E3EF6
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617934; cv=none; b=AX4sslT81IvWcyowflGxQIgbBeI3NskBqsUCukOy9DK77Z26RmoXGhPKHRHSnY4FZPcZ3EDzWFdokod5pSszTKReZGgdgkGl81D40WPJRc5Pgi/HrGm9KV3pREj9xTEvemQ+bGJOy22UKxNpe4MR0U3gyNUd0WEKidpGL57SlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617934; c=relaxed/simple;
	bh=aX7D9fe6wgqI+yh1tRxKCLwwJ3l80BYRwaXfGv/OprE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8LSR6yONKkKQmncCKH/hi6a0qpw2ieaEC1WfRjr6Qd8pt5WCtS1gcEanOxfI7sD2dJNp7kJWJ8czNlqx2J2djQbbyH1Oel1EcpiUq9ZUaC4bRuWcpv0Fh2Sbe8Vx/rRgYt2yxkm2dV2VTr0ayTyK8+3Aoef5F2Enx2sQI/WKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUZLsK3p; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUZLsK3p"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6d7e06de06eso858877eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617931; x=1791222731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSUc6iIFEktt4xs/8drR7GEw7uAyN5LVYmIaYzfxAoc=;
        b=PUZLsK3pV3Y0qml4ftKHUv5bc5ploACHOynkvT7fa+QVlTX8NTqElZYi/qfvnQPWrO
         6Vy7T98qYwTAk7ergQvGGR6+c0HedKF4l3WscJ4gAB0vxvlBV59XQ1bJFKAM+sBlBO/v
         r+FTG1OiazcL0tFqTCRg0OV8+w+t3ZA5Gep09vrMZ/EV8CO1rXSz7oZQmz9Rmb7iBZjc
         qVkjocb2ZmJzT830rw2O7ug4csXu3JjR66e0Gy/5ZA1nUJvbYa5L6jOa5fcO7EJriKN4
         Rtg3R4fT72lWGfDo+9VphAi40/ZTrd8t41x6+MD0FuXv1rQZ7zT6TykarMlq+NHFPNnO
         USWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617931; x=1791222731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSUc6iIFEktt4xs/8drR7GEw7uAyN5LVYmIaYzfxAoc=;
        b=HM5xcicYubxq54I8Vi5i7BeJOnQ0e5QGaZVOpZlUdcrNmzXl007zQWirr3sZYUPKVZ
         2mkS4BR/fGFrkt0TEV2zdOaLvMcSm7clcyspms/6kFqEPckTFpzZ7FU7X7YPx1slBEMw
         Pd9OxTKyMfz2Sa+w14Dr/e1d+CICs0s2Ow3VxvnzUdH3e8gUz0W/QmktML0m0/AxI1L1
         HAIY4scr3iJbbfxWhdUNGJUCa+Vwi32pb3A5zJBWXj7Zd7PpmUjiMztRRxZA8tT/OR4v
         XUF9ltww8kPp6M75lzGW7JhK0uX4lNfaLcaQCZKbe1MFsGK+ylVFIe4eVGx5aHfjoeyR
         mmeA==
X-Forwarded-Encrypted: i=1; AKwUvBz9S8gRkLdfxPzhHivv2BYCh6mCn3wi3rsnbMeYZYs5bsWd88mM3zJbZnHaDhwm+C+kQrgAA2SBKHc=@vger.kernel.org
X-Gm-Message-State: AFuF++ldWn++9R3ZEGuXqlZiU/RAqQew3caDX0VeeUGnjEV2carla+m5
	4RUrOIoSrYNu7JfUFLOQPXiVHNnuYvSChCMIEdSRvRoNH7ThnkPhkMF+
X-Gm-Gg: AYBFou0VuXSiy2cTgH0PLR7Kpjxk+HbgtSL9r7TzW5EijLiFld6slbg8j/U0WFt8DTc
	5wa9VhMekALVckDMdcAGo4mQZetM1o3xGa3fR5Tlej+8KEEP4ZoSdv5PUJN7qtEsLZcXLc3GIw4
	OJVF/k+vpDvMCt+lhKzFxyPgqSFQqwVtxX348JKP39bjxXrVPo4szj6EPVAYyp9uJGdbcfsB2Sx
	t2aeFW7krzTAsUW0Zwl1wJD4+H9jNK3NjaIzMfbRZ6nFT8o+AZZ5/BiybjFR4iMFkebQlpunacj
	exbeiwXGUSlOgTltCmO8rfmxAPGJ7rA4YTz6zfzAj0kzjS/ZAXaNjQjE66AWgH3ALAQdIwvb56s
	g/R1QrGLuwszZqC58BO2VNbv9jbIzlkg8YXCkr6RerWLSxudgGYiBCHPFpbDrdRXMzB4k/PJVq8
	uFHV/Fhsu2H7zuVSjHR4g1shv6/atXLc3YGDqu2JrGRfyala+ND83bHe0WuYXq7dUvPvQ1kilB4
	+nDzI++Kum+21mAabusGQ==
X-Received: by 2002:a4a:e913:0:b0:6d8:9568:840a with SMTP id 006d021491bc7-6d89568880bmr3942870eaf.46.1790617930923;
        Mon, 28 Sep 2026 10:52:10 -0700 (PDT)
Received: from cachyos-SlimIce.lan ([2607:fb90:9a26:9349::e71])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8822199cbsm5971644eaf.5.2026.09.28.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:52:10 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C
Date: Mon, 28 Sep 2026 12:50:49 -0500
Message-ID: <20260928175049.86941-3-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928175049.86941-1-jwuerz@gmail.com>
References: <20260928175049.86941-1-jwuerz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Dionne-Riel <samuel@dionne-riel.com>

The Minisforum V3 and V3 SE tablets declare their ST LSM6DS3TR-C IMU in
the DSDT with the hardware ID SMOCF05 instead of SMO8B30, so the driver
never binds and the accelerometer and gyroscope are missing. The
Windows driver (version 1.0.4.3) binds the LSM6DS3TR-C to both IDs.

Relevant part of the DSDT, identical on both models:

  Scope (_SB.I2CD) { Device (STS) {
    Name (_HID, EisaId ("SMOCF05"))
    Name (_CID, EisaId ("SMOCF05"))
    _CRS: I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLA0"
          I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLG0"
          GpioInt (Edge, ActiveHigh, ..., "\\_SB.GPIO") { 9 }  "SLA0"
    Method (SLA0): "-1 0 0", "0 -1 0", "0 0 -1"
    Method (SLG0): "1 0 0", "0 1 0", "0 0 1"
  } }

Both I2C resources describe the same address; the I2C core uses the
first one.

The vendor-specific SLA0/SLG0 methods are not parsed, because SLA0 is
not usable as a mount matrix as it is. Its X and Y signs are right, but
it also negates Z. It follows the Windows sensor convention, which
reports Z = -1g with the screen facing up, while iio-sensor-proxy uses
the same X and Y signs but expects Z = +1g in that posture. Applied as
a mount matrix, SLA0 gives correct screen rotation, but iio-sensor-proxy
reports the tilt inverted. The actual mounting is a plain 180 degree
rotation about Z (-1 0 0; 0 -1 0; 0 0 1), with which orientation and
tilt are both right. As for SMOCF00, the matrix is therefore provided
by the systemd hwdb instead.

Tested on:
 - V3 SE (Ryzen 7 7735U, BIOS 1.03) with this change.
 - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7, with this change and
   the stock firmware tables. The driver binds to i2c-SMOCF05:00, the
   WHO_AM_I check passes (0x6a), and both lsm6ds3tr-c_accel and
   lsm6ds3tr-c_gyro are registered. Screen auto-rotation and tilt work
   with iio-sensor-proxy and the matrix above (checked with the device
   renamed to SMO8B30 via a DSDT override, i.e. the same
   ST_LSM6DS3TRC_ID driver data).

Closes: https://github.com/mudkipme/awesome-minisforum-v3/issues/2
Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
[Jared Wuerzburger: rewrote the changelog with the DSDT excerpt, test
 results and mount matrix rationale, converted the entry to C99
 initializers, dropped the mount matrix patch]
Assisted-by: LLM
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---

Notes:
    Jonathan, when applying, could you add a Link: to this series? The
    cover letter has the full DSDT excerpt, too long for the changelog.

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index c4097ce2bf..11e5ec3798 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -145,6 +145,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 	{ .id = "SMO8B30", .driver_data = ST_LSM6DS3TRC_ID },
 	{ .id = "SMOCF00", .driver_data = ST_LSM6DSO_ID },
+	{ .id = "SMOCF05", .driver_data = ST_LSM6DS3TRC_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.55.0

