Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71503CA4AB
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546803; cv=none; b=BJ1TGA2vQlOcBHKrlo+6qVPpmaXm8akIjdV1WMp+798Vx+XcoUmeLFYaKAu2AzvaQ0VVSLv6KsvVb7N9kcq8Sj+CUsyW+yQab7jokqLNN+WY3ENQHT4Doh4VZMnaskPjJkLbq54RnXpwUeT7Pqq3I+ajUlM/cTnFHoAnELxCbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546803; c=relaxed/simple;
	bh=i8R5ShupKRQcM1sWDGwuW+M5JCa5wGqjk5dVrSzAeG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lefu80Rx1hBAr46j4yHX22GoRW/IzJvOiHXFz942JL3yc/OndiTopwf+F61dLQeeTyj9v90HeI6aMbYZKnO7WLTRXwsmnqPB0whVc0ww2MlEjywBWuIWQtRh8yyscjWW6xRxW1LflfLDAQ7vheVftNEpz6xEs6d6KZ482CjylHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLVMKap+; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLVMKap+"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-9143d127a26so21435936d6.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546797; x=1791151597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=318KVPravmuZL7vvBUPt/vYrDCtgz2UR58hdtie4Kas=;
        b=eLVMKap+GxB2CeobEAAwSWctSZ9ro+DIU7OTNQQTQtnU8rbBKui1JkIZIUPY6iXm11
         3N2LpLoHr0xG3Nwg1yoxczey3UARgvdzBBeTZaOft3cc05Yw5xX52OSUaxdIFvYrxw1h
         venV3vK4AMaidxOhhZL2diNANyF2ALJqNaAMtJYhXUmXkpGsF+wG1A8+sS/t6uMv94jH
         1MtqRZAy2lG9wV363Ftfy2nH6QZ0J8lkCHgo35hjLnJxEvGNeelKqPWFWy6UISEF76vt
         V3JSlhCZOQNa/ukeIsXDnoc9/TPzT3dc6l12N4QyLv9wq0VjiTXnsykC6OLjzH8jDbcf
         LlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546797; x=1791151597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=318KVPravmuZL7vvBUPt/vYrDCtgz2UR58hdtie4Kas=;
        b=Yn+XC7xel9mpUCyGiQGdzfb4c+KS+i3Fi9Bad5qO1uLDsWg7YiAAARlnvK8zSTIQXX
         4Er8TbEa90ZW3isOjF/O93vT/A0Nva2/Kek5HlDJAe6/a4mntN9+9ePdJLjaIh8Xn4cv
         7xhDxi6Aw1YjejqusO7oTvjAaJYQ2VXg9bKiJI8i2hBBSoEhCawwC8bzdyDUNew33wvd
         H9JQT0ESLyaGW7j+76SKZrGa4t00Zg3MR+v5OcICGbE7NNIouXXQillmI+0uOWUU/1KC
         jtC/Jho3cfJ4aK7/7VZOsl2uLgTroEZ9KCjICwPaKp+8FY2MaoHHeomx5cRzzKwQB4HC
         /dmg==
X-Forwarded-Encrypted: i=1; AKwUvBydU92ZOal+6KsWL1B9hmBZkk6PbkM9Fl0ixLVaDp0NTXjTpHuWGeNn1J6bynPXnpc68V2NxyAFCFA=@vger.kernel.org
X-Gm-Message-State: AFuF++kPye0lNT28OyO55WgSK4WMLKAZhaC3niav2WiniuoPIHX7QkDQ
	zvj2x9r7xU68bqOnOBLB7gMnQGtJBJjKmKaIMgQIF0fglQDZRBpzi1Wh
X-Gm-Gg: AYBFou17mhktgQFjfBof+JazQFj5nAqJBO53wYLtPS95yRDA8aL6j8AycOvcqOvn8da
	FCNAXcTIDJPREzvl8xrcNE3QasyuxtPcLPF9z0KmAAbtjbqWLeTA3TRLczv90qO80Bi5IDjVTQH
	xxckD48zZgZdJzbRn3LSFe7+utUYl61GGqfZnF3GrT9hHonVb0PpG5NazUGOYGLCdo5wutNfsXM
	R6OzrxNg/+k5Nnmv808I9rDp2u/PTmgnxT7nZCdRKKz85C7yoIzTTr+uIsVFP63hw3Lv29d6b6y
	a14ZrmmE5HXPCFolnCOEsX0z6g7WYL9tosEin0Apk7yzOr2zqiarwrajsbZI8PrYSJagRcLGSvw
	IrkJccL2sxFQ+oFIpsEXWOQmRvmOY0rPGdqCy66yp4vPJCItTXgRM7/1iHLqlPUYOIAuXNx1jbc
	7U+mGipMEUUB/cG/cnrepMkBGhTXe/T3a1QEORW+WeUy1p89NOTAIq9hkn+9RA5AHUQCELg8p1C
	dyEoeWATVOCPpp3wgjKx4NsU8iPVef9sQDIp2RoJizRR5fQabeA+YYr6tCs/yWCk6Q2+R2tlPY3
	mQCd0Qpx
X-Received: by 2002:a05:620a:6602:b0:939:3a81:326 with SMTP id af79cd13be357-93c47498e61mr1491329385a.37.1790546797026;
        Sun, 27 Sep 2026 15:06:37 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c44972febsm708092385a.39.2026.09.27.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:06:36 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Jared Wuerzburger <jwuerz@gmail.com>
Subject: [PATCH v3 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C
Date: Sun, 27 Sep 2026 17:05:59 -0500
Message-ID: <20260927220559.24169-3-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927220559.24169-1-jwuerz@gmail.com>
References: <20260927220559.24169-1-jwuerz@gmail.com>
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

Relevant part of the DSDT, identical on both models (full excerpt in
the cover letter):

  Scope (_SB.I2CD) { Device (STS) {
    Name (_HID, EisaId ("SMOCF05"))
    Name (_CID, EisaId ("SMOCF05"))
    _CRS: I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLA0"
          I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLG0"
          GpioInt (Edge, ActiveHigh, ..., "\\_SB.GPIO") { 9 }  "SLA0"
    Method (SLA0): "-1 0 0", "0 -1 0", "0 0 -1"
    Method (SLG0): "1 0 0", "0 1 0", "0 0 1"
  } }

Both I2C resources describe the same address, and the driver uses the
first one. The vendor-specific SLA0/SLG0 mount matrices are not parsed
here; the accelerometer orientation is handled in userspace through
the systemd hwdb, as for SMOCF00.

Tested on:
 - V3 SE (Ryzen 7 7735U, BIOS 1.03) with this change.
 - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7, with this change and
   the stock firmware tables. The driver binds to i2c-SMOCF05:00, the
   WHO_AM_I check passes (0x6a), and both lsm6ds3tr-c_accel and
   lsm6ds3tr-c_gyro are registered. Screen auto-rotation works with
   iio-sensor-proxy (checked with the device renamed to SMO8B30 via a
   DSDT override, i.e. the same ST_LSM6DS3TRC_ID driver data).

Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/2
Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
[Jared Wuerzburger: rewrote the changelog with the DSDT excerpt and test
 results, dropped the mount matrix patch from the series]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index fbf4e4ecc..5def1d01b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -145,6 +145,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 	{ "SMO8B30", ST_LSM6DS3TRC_ID },
 	{ "SMOCF00", ST_LSM6DSO_ID },
+	{ "SMOCF05", ST_LSM6DS3TRC_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.55.0

