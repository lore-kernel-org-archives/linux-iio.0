Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56D3CFF74
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222037; cv=none; b=JpFXKEiZGLn9rT42SQUSsX8HpFSc51+afLx9tY7NB4+xsunF3IUZpAvDPSyXwcKAusJbF38qnvsjz8iOCpOyMIQ6nRWMUDztIc4C3xuWz68W+KpncTBWqUlW7a17fDuhiorm+NZfK+jD+VkOMSyyTVZXW6c27smVsKf4fyBZwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222037; c=relaxed/simple;
	bh=Pt3Eq2CUv3k21M+nm+SI2/g9idalTVgqq9ZNH6Q7dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mckX/l4OYd49R/J1u1H9h1w2dki5Ng85Xv2gqqeUxQGiINGv0t8eXV5NzO9tA5/GU8teQgy2ZhN34xOln+tzUuQu5JwN4zENQQXowaAGk8i1MTqXe8RPZZodD+BKNNC4uKZhbFE5iimmNxGziOvTr0lu83dcdJnJJu00BZnmp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdBk8cHm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdBk8cHm"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so8714100a91.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222035; x=1773826835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSVNkS2a19BIeTMvUYSRkHQV/F6Vq+SNjgvSHd3Fjj8=;
        b=JdBk8cHmIcsYJQ/5J0+shJNbh+2YGdFU7FOmDROuYqK+y7PTMnRpYtzUQHBLJ1YlsS
         JkFxiqaOZbte7l47DOdAGTmt5Sejp+yhvfR+dG5Mc+aMXaVgdBbndXiVmtfTo84Ds5Hd
         AUFwYliSz2WzKd9qRjJ+uPsZ7j2FTdWiZux6adpOEbqqn7tCb+vYhZcuuuMoz4oCVKrz
         v+OJ5s7A0LIS27y57gmp82ej78gqwFTaq2+DVKLuo+socNuRhgHzn4sT26sx95+0Plq7
         N66lz0n0+bBkECNPIiVWj/8EzQrWBTyNopkB3sEAozbMjHxDxZeQBJJW96IApTUHIJwf
         I+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222035; x=1773826835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSVNkS2a19BIeTMvUYSRkHQV/F6Vq+SNjgvSHd3Fjj8=;
        b=sdrs4P/C7riNOFRrijCCLpOgMkkIaEJtfuYDJHUEY1fJwaNSBXZMZ6q/cG2b29AXF6
         j7AlQq7sHsUXopg5RAt/UUHJxOTc4RiyR6MjwkohK419P4SCbO18Uf8fVdc5KqMn5B8O
         YxJflm1+lgCFAYHAGK4UsG5kPH00C4YGaxo1To94RLsJAAQyUottq3Xiw5DMPZzO1dhN
         5aMNP9JmZvKwcal9D9YLYaSZ9EbY7ArbE/BgNaT0oFymSxl6VILpM8KBz0lSSILVFogY
         kDID81bc3H5ha3fh0TBYS6p8xxmqMP/2sx8WFJ1EDqCFZT+lbprsUMDnFN2/hUyvy3YV
         BAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYcukF919Rf0ys9Jd0LNnkBsXlIdS2/mKfimwpt9LuOtoDBxAUTC54ogY2j2VTiPMQL+KNi4EpzQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva6kY6QT/TB7rIUQb91g5tVj0v+3x1P3+HRJ/8r2j3s5ewfJl
	de7qSUcME6UDefF3boN502bEOvTHvGgMWda2iI4JnyT/KXNX72cLruL2
X-Gm-Gg: ATEYQzxZRdDR3FAlIPT3Z8vOUib++UxqRYGH8FZz0n6wbY2WwkrW4BIPqS15hXM1dOn
	e0ntttuFzx62OejNkwln5g1ndw3jXPo4l+ZlXoefVpznwRN4wO07uuhUIZUITMKo2U+aBgj+GxB
	66Y+rm0sN0wD2BgM7114Y9WcAkXF4yjdC+td9Dpu+RW2atChD2XJtZkhRWhpqXNCkXVFYxJBu5X
	mOqNquIFp1f6hndjKGRR1fcQsMxsxvxIxeteLdrRp7hpx4wTa/5sLDv4Bnfc5mcgmYb/Afaw5sV
	lq1owkPjjB+PeNoygw7qFmYR8omvfOBxFvrbx62mzOu7Ow+mEchlnueNAE9bcJ7bawvtF4IgWbl
	ksO+mQAW0j/eYCUegFjAqZWJirfVobpuj/8Zb64KhJEHTXuUEHtBRACFjndH5Ta7EIYPf/jVSPe
	+oi1alhJVsZRZXdskormC/FpIfyKfILhIuq5g=
X-Received: by 2002:a17:90b:3fc4:b0:359:8564:dc0e with SMTP id 98e67ed59e1d1-35a012868dfmr1746197a91.3.1773222035441;
        Wed, 11 Mar 2026 02:40:35 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:40:35 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 6/6] iio: common: fix spelling mistakes in comments
Date: Wed, 11 Mar 2026 15:09:33 +0530
Message-ID: <20260311093933.21333-7-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments

- exepects -> expects
- fuction -> function
- theoritical -> theoretical
- appopriate -> appropriate
- iio -> IIO

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 82cef4a12442..f34e2bbba2d1 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -106,7 +106,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
		switch (st->core.type) {
		case MOTIONSENSE_TYPE_ACCEL:
			/*
-			 * EC returns data in g, iio exepects m/s^2.
+			 * EC returns data in g, IIO expects m/s^2.
			 * Do not use IIO_G_TO_M_S_2 to avoid precision loss.
			 */
			*val = div_s64(val64 * 980665, 10);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index a61428bfdce3..c115a72832b2 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -346,7 +346,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
 EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, "IIO_HID");

 /*
- * This fuction applies the unit exponent to the scale.
+ * This function applies the unit exponent to the scale.
  * For example:
  * 9.806650000 ->exp:2-> val0[980]val1[665000000]
  * 9.000806000 ->exp:2-> val0[900]val1[80600000]
diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 97526ba87b93..4e50c03410d9 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -154,7 +154,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
		valid = inv_update_chip_period(ts, period);
	}

-	/* no previous data, compute theoritical value from interrupt */
+	/* no previous data, compute theoretical value from interrupt */
	if (ts->timestamp == 0) {
		/* elapsed time: sensor period * sensor samples number */
		interval = (int64_t)ts->period * (int64_t)sample_nb;
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 588470863681..1960a2ce82a8 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, "IIO_MEAS_SPEC_SENSORS");
  *
  * Generic ADC conversion & read function for Measurement Specialties
  * devices.
- * The function will issue conversion command, sleep appopriate delay, and
+ * The function will issue conversion command, sleep appropriate delay, and
  * issue command to read ADC.
  *
  * Return: 0 on success, negative errno otherwise.
--
2.53.0
