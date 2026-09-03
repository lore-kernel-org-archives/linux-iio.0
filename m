Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147D49480B
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438467; cv=none; b=hOeV1EGJgvrcbQ/NzlFHvfR27T8hpyAvVdw2ZZafxmTH0pX2DCqVLJELyGsR52jSsp14HI897HweaSWVgv13lDgMEAxggpyCu5KTNkdfgxGxyWALE89uzYYtBz6Yh+mPw/kOVhit7N88Mf4vmu5W92MC+aeSryJ0qRdtWS/GeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438467; c=relaxed/simple;
	bh=3YE1yer+0NRbMtvurGpjSkBGtnurRnJc863L+qyXIco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reYLnd9SSGbXR97CjRA5xY3NOs6Yk+Z7Or/IXooB/vKTRrh3IwId7Jys9byOSJnNjsUiZv3nS/ikiZK3W/4GFycBKrJ60JKqHrB3gLobuV+Q7lmSbWCeLD+O4gKQSAo5Jr194tOvcJC7AkEHudmjIsCjnb6FfhBwcTSBMKdFs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjQ0id2E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjQ0id2E"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso17273545e9.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788438463; x=1789043263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O7Bscj5M4bebt0mHty0y1jQwalSa0CrSkjx1JIVvKm0=;
        b=TjQ0id2EFiHwqw3KsmWvGYPbWFtrvsAORrADOQo6lCrIX9ZrvOWAUKhLvZc1tvV+8G
         ble3RROwfqrnDMa3uKFdpnF/8aloJX8FnFLFrnX0b7PIHzAH0A0xRoigH5YAg32xIzEd
         w8PkVbdwZpiiuAFzKfrFFzXeXHsBASQdCLm2VpiqJL8si3LZ8kZ4EyJV+nuSM2OCK49g
         f0OPeBxvimTfGv9P9wNhn3+yPHIxHux7iivSRAlF0UQ0NKKlx29IqSIKpJRkh7M6XomZ
         /YvOGCnYx11uUC/oWeRIHGmuYYpiBA/uXW2fiJ/7VWtEdADm5iu0hRfK658Yg/6U90HG
         yVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438463; x=1789043263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7Bscj5M4bebt0mHty0y1jQwalSa0CrSkjx1JIVvKm0=;
        b=Wx6Pkw+obGg7M3U7uqC7XtmByRNu1zAQH4JL6URPGj/2SkVSKzCvQLQD/4HCD26v0f
         goDZPsePFs61Bof680JPRDvkHr42IAg3RIB6MNNCGl/cGgmaZb+SDJNsblqPqbQLRmom
         v6Qs1VZzuGlX/PV3ILw1z90IlfjIjRUn7E34FvLtr2aP8FdnO1qMBfPdP91AnP+zqcgO
         SxUNQSvHMAmfL+9VJU70iQ0KL4fCFIIrOF6+Oxqv3xpIN2cafQulM2aHwsPwVjE3CM1j
         RyNTj2+ntElXI0jWQ2WGJKfSygKHCLQ/9Z0Q39+ROKEVTi3EIC1xPjnropwDnC2iYSMT
         sFHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZf5nED5uU1YN7+suu/Zwxkey8krRuta5HsaKN1Ixn/u5QzyUPBzoxPqnM+VrLzmCDzpbRXiw0Jbg=@vger.kernel.org
X-Gm-Message-State: AFuF++kceOOkP72ulV3hTqETrD5DDfZPedrQULEHPVLqztKIQE32rqPt
	iYyesAHokL3jSQwMQOwkNj/9KUOoHG0jv0RSF/g7j2kdXlmlkglzNCIr
X-Gm-Gg: AYBFou0nKyVuJ+Mkr1CwyUwNwrae1GMKZzFDKX5wCBgUFZung1u88PAbn1PAvbswOWZ
	H6e4OCuEzpdNgxMCUt6DXDqaVX5SNducwKn5uf93cS0nPOmjnh2M+r9k6oti6lpi11PKvf/1+8p
	VLaweFVmv+ZYi4a4cSn3EvzOuVNZTpKZdNiWcWJsHFQx2SMUofsfC4X6lN3EXqYXk3TWTUdm+lq
	VJCk4ntQEqSAtaiFC71NC2sLiBpxfWvxTU31DXvKLOZcbw38/oBsMs2mpTWQaaBzwu1yNvWe+TI
	wOilNADsklZ20U+4NRZzB/OD/+y23W+lauQpL37plBGpvli9Ch8MRuQsaArihQSgtXBvnEGB6/E
	qKGpfWyZWS+RbEmd9ZoHpBDbyPC2oPPaMgc3e/SZ7J1DzPqFjnKMn4RxjalK/kq6XS53DV097IF
	WpkVhP0j/7MTb4e3OqgwxKobI2R6J2xumc4WsbiN9XRtYIJK4uqW0cSdd+Vgc7FyT+cqVj2XtEh
	NfxrmM2cVrInmWx
X-Received: by 2002:a05:600c:c16d:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-49ce55cb47cmr256137575e9.0.1788438462117;
        Thu, 03 Sep 2026 05:27:42 -0700 (PDT)
Received: from localhost.localdomain ([196.235.147.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm67277055e9.6.2026.09.03.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:27:41 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: imu: adis16400: Check return value of spi_setup()
Date: Thu,  3 Sep 2026 13:27:33 +0100
Message-ID: <20260903122733.67109-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In adis16400_initial_setup(), the return value of spi_setup() was ignored.
If SPI configuration fails, the driver would proceed with the
initialization anyway, leading to undefined behavior or silent failures
during device setup.

Check the return value of spi_setup() and return the error code immediately
if it fails.

Fixes: cd888a17f95f ("staging:iio:adis16400: Use adis library")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/imu/adis16400.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 4842346f9f0c..f51878066b2f 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -420,7 +420,10 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 	else
 		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
 	st->adis.spi->mode = SPI_MODE_3;
-	spi_setup(st->adis.spi);
+
+	ret = spi_setup(st->adis.spi);
+	if (ret)
+		return ret;
 
 	ret = __adis_initial_startup(&st->adis);
 	if (ret)
-- 
2.43.0

