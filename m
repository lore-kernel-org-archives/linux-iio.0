Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BC49363C
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629636; cv=none; b=aEFBq7hOYL1FrZll9P4fcJMKmv1QM2oxLWRtt9sAxKsVY3/uVHIBW7s9NEY2oRmuWhwZWxhwrwG2GvVHX6kt5G7Ki3zlcHOVeVHTTFtwrg/SOQGbQvn36AxndD2xPzUcIg4RhwRYTZn+8dipz+t3tMKHluizzCtWZ6UVPAwsuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629636; c=relaxed/simple;
	bh=hU+IxLlZZOcgwJxZMzz1xAayi/JKKfOUSMnkoxiKwyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIQziTDeYtYNExziRISE0Qt09BEpqyl/miym4dl7mZtR8V5/HMomKFJDYHt3zK0i27+zxfIoqBVKrdx40KHGA/Ke/yDCJHJ1qAAu3c/NEwjrlcD4goaMKN6jOozJNGjWqGchE5PDVJ/u2+Fz2iGfkv+36whPq6nv8I6nTNullrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp7k7aFF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp7k7aFF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93a40a9a01aso28511085a.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629633; x=1791234433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfUcyDo8bj/+3e29tf/qBMWppSLDCnumnXvFC6mLqnM=;
        b=Kp7k7aFFzkgiUjtA0VFVP4VFwvepTvhEE0jvEN6wDff7Ebw0ZXmQ4jIcOHBCuJsX7r
         r2LeFeFA48zsSjMkUMSZE2yAVDdbbUxkzjX0NNZD8bVe0TPW9P6yBUzDrcEW8JgLinp8
         7VGSr15McUtNWmeGsmboAr7j3SCRTb19pNyKbw/iGna1jWb9dEtWM3tIOEI0FpkDE14J
         CTZx+COSwxRBdflkUykiunG27MY2vxNV+nETy4g341XqnynQfZOxSm4uSFvn7wqk3VdM
         tK8vqGTn4YQ/p7YtAppA7FLkJnLTE21QoHMrtK3N5B1chQsjIBoV5xFYg1W/gOf6KwiU
         r5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629633; x=1791234433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfUcyDo8bj/+3e29tf/qBMWppSLDCnumnXvFC6mLqnM=;
        b=Q+EcLekEmINliz7SGnF/67A8KcvVXubuCT0+NhSzntEjcuaL15YWFiGXWvHd/DcxXQ
         QjKce140YkRv6sp5h0DluKTH1MdbH7niRKK+PXG7qc4M73b7WMSe3kdbw2Zfrrdw2nWn
         wWOhY/PZqX1DLNXegdbPsdogvhcREkch/KIkZBS89vp5uVvNu0wR9Od5F7vrdtB/RBzY
         BpLUSdNXwCrLLuT9ategGlYC/JM56NbENlDhWp7g4Z4dzMDZgpqxA9Ljcq1IDxMIcj5n
         dX/tQ61fJ2omoxRkPX2JEDY/CfheOFVKQx+nRaxjLRP0a4m18qY7J0389+thf3SvrPJf
         F8TA==
X-Forwarded-Encrypted: i=1; AKwUvBx5baTi1V/jdIQwHQrqoXeoATawj8f0R4l5pJUkRZaPNgKq+oa8XBAQmKte6f2h1bPaf3OIWnLIKz8=@vger.kernel.org
X-Gm-Message-State: AFuF++l1vKTZ5p7ETPtAvg9dBgJyOxo26aC0kbstXmLowU4eCN4xQV4O
	kbXfWy7ulc+TWw8YKfmsGSGxRjkCBfZalef68QzEzp2ypBLHbgYB19EG
X-Gm-Gg: AYBFou35UOI734najL6F+iNdHS8quXOpImF+4Z7vu24fK/I4suLw8HB9y34q4Zl8sFV
	/ivD3AGRLwFD+Pd1TWTdxbUIsuCGGs7S9m/ts09gFYCKI7uYgyafSGuI1pCZiJe0G2Gb6zdEIxB
	sBhCyGL2H3KjRoXORW0XxZ+H4y3I8bUJ2J3TNwJGwfxOr0MFz56z5DFj4gcXBhiLw0h5RvKNxlv
	6tGp85iQyA4UYQwQQYFtC9AMkrQK3PpEDHltInVBcUxpH8SwVoKg/IIiBS8csJkj4CQhlCfgUe4
	wsZ6VgmnraoUFsPCRYL69r1i9XT+NtY6Qs5oZh+ctXthAQ22s3IfOFvT9HEdFQDKh1E7g1Gghji
	kAL7vg73Rki/kPjiXQvxqCcB5AxCOF8qbx7ON6QXZLH4JNX1Q3zmnIW8770hCfdXyY9kjtCUBCl
	HGf+Ud3IbWakBbjYAm2xQZ7AmyCtZHLpf+VC9izSrL84JMAX9KABqO4TTFRJB4/8pTfzuakt5nz
	t1bckT6Lt19X7SSpdS8Y7PVQcBEzfy8C+ZMDHtZynIeQjYoP+lTMyAF5SgB1HkTCVu9y+MRWe67
	VBUq5fA=
X-Received: by 2002:a05:620a:6f02:b0:93c:7861:675 with SMTP id af79cd13be357-93c8bcd071amr126916185a.1.1790629633106;
        Mon, 28 Sep 2026 14:07:13 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c814342f9sm241348885a.29.2026.09.28.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:07:12 -0700 (PDT)
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
Subject: [PATCH v5 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C
Date: Mon, 28 Sep 2026 16:06:48 -0500
Message-ID: <20260928210648.17166-3-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928210648.17166-1-jwuerz@gmail.com>
References: <20260928210648.17166-1-jwuerz@gmail.com>
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

The device has two I2C resources for the same address; the I2C core
uses the first one.

The vendor-specific SLA0/SLG0 matrix methods in the DSDT are not parsed,
because SLA0 is not usable as a mount matrix as it is. Its X and Y signs
are right, but it also negates Z. It follows the Windows sensor
convention, which reports Z = -1g with the screen facing up, while
iio-sensor-proxy uses the same X and Y signs but expects Z = +1g in that
posture. Applied as a mount matrix, SLA0 gives correct screen rotation,
but iio-sensor-proxy reports the tilt inverted. The actual mounting is a
plain 180 degree rotation about Z (-1 0 0; 0 -1 0; 0 0 1), with which
orientation and tilt are both right. As for SMOCF00, the matrix is
therefore provided by the systemd hwdb instead.

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
[Jared Wuerzburger: rewrote the changelog with test results and the
 mount matrix rationale, converted the entry to C99 initializers,
 dropped the mount matrix patch]
Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---

Notes:
    Jonathan, the full DSDT excerpt is in the cover letter; a Link: to the
    series (or b4 shazam -M) would keep it reachable from the commit.

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

