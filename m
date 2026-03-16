Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FC3845AE
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651703; cv=none; b=OaiKm8G/YVksnQcJelNNCHiODBjCZjF9Ovfv1UrNhY2/+j+HwmEfqEbx5jCszZMhrBFX+hfnqPsY6ccmJBbtAqA8eo9cMNFIo+XMZgH8xWLhO1qtw6Qo86LpEEybU1K9R3NwyFUCn+tXpSV0dHL4N+C/i/KrkIWEceCNrP6Ep3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651703; c=relaxed/simple;
	bh=V3HWIXCvXXE7FE5FRYklt761wxOahtV1detCwX3P8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1fUN/2NPV+c46oQkyYJIbEenF3H/iYff2bNCeMioc6nWvK3n6r2CTIhs5t7TEV7Kzast5Mklta/XM6U7Tgdvown/vGgoNKBzjxn8bfP/T9GOop0B4VaJnRsRGwGaGkKcl/3fwfqNwGE14pxtqiNO7iybIjj1M/xvIOBuazu4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C218IYR7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C218IYR7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a9296b3926so34084225ad.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651702; x=1774256502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUxp2VUu2W6Pw8Gz02q+Ts23ED2qB8HC59Sr60mpXkQ=;
        b=C218IYR7f/sWYmevDy2SuelvnjYSOpf3HTTiBuJGIOkaIvp7IZmQribbHpi2TCik5O
         v2wTK2AMCg/V87ALAlcqKeLz8bOcjrMI47b0wsoYrLi49kPGpQ1J0zLbdmoTjaa6mMBG
         mFIMCvrMjPtlp7ncX+BGYj6/wCswwlvoraBEoP6QMTK09zGPPdLnsdMYuGvC9bn4539D
         XToJ60Rq6dcbAyDbDWUmIEdDryN8WPq8KZlPo3JR9EvDZ8rdvuEp+ezqdUqrB674gvhE
         l+iJrtlsVPfzH4H6eimaFv0iN8UlAZAw0yztmCHmj7vrEjC2RiUeYEVoGpmrnP4wGSby
         SUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651702; x=1774256502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUxp2VUu2W6Pw8Gz02q+Ts23ED2qB8HC59Sr60mpXkQ=;
        b=mfnMxVsyEYjcv0kmU2BsaiRdSpRqZKEaoNYcDDoRlOgs22vB3+B5IQtGDdcxgBJZCA
         /m8A9Py8W+1A/seNJCwIOB/qdiUkkK8WpQR1TQFLLF8W4Ybk00K7HEDrZj9dhT+RL/Mo
         g19aIcGnBp34P3j73/FhM4W+adA3lAoTyrJyUK9IjtJD8Kl/Mwt2IWHZXo/rxXSS9yB6
         JoX49LXT1bK8KxWPxVzX5DrDo9lVYjmpcnZ0CF4BHUnzMOClxxZaXQPDQkcfk5TeeH21
         zyAD161yUNUomo4aMitl1rOBaWHz6/G2MgG5yVAbw90HgKnSaEm13POX+HLXtTvxRRIF
         aVVg==
X-Forwarded-Encrypted: i=1; AJvYcCWVAbUbF7KcIpmdP5PEz08IkUfdTK1nOnoRIvNkrJ+8khIgZ+N/fNDgNM9NDqaY42xxwG3d7o+9vy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywddDJ55H9n+JJ1bAVp9lDJZNekAmlfllzFb0TpOoqdDnWpXOq
	9owdS0uVdiiGrGzyUXp+ldiBSz0rgRGe8WY42PV6HWrSEO8EpNSpUbDF64lWBA==
X-Gm-Gg: ATEYQzwnaR2Qa0VXoh0n40GcNdZ9E/xQ3jb276gIl3+8Tpe1hUPRWnmSZq/S2KAOYVl
	QBjzMyj95g3EC58D0s5e3426ZML8P6DNyn1XfzR2WcXRilkB2VP1jywvXBnBb8Gi1Us7COM5Onf
	G05vZ+Up5VWhO5bSYm72LAvU/jNHV70bovFPDo269X4u1Fm/Z02EbqJUDx8JDxKJhfPdBqIMx1N
	3JoFMppSG/ICrulIATZAR8k3XBwBUaa9ZksYj1r/beCL/aCGjg1f47vXIjSMMWd2WXuSk3kLTSn
	7TLyScSqEqb/n+snJ/XU51ePEl/IQiM8/qor0fZQTNk1JPhrliIlztbAXK9fSRWTY0+0eQJmhUe
	ZHaYJlEUnP1GU+TbzxL/578XTJ2vFENVa+GwQwSx87BHJ60IZ5Ym5B6rxrcUeq18P0uDs/w4Axu
	0EvU+kKDb0HAhSct2TACuGTEav
X-Received: by 2002:a17:902:db0a:b0:2b0:5770:d485 with SMTP id d9443c01a7336-2b05770d6b7mr28757365ad.11.1773651701848;
        Mon, 16 Mar 2026 02:01:41 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:41 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 11/14] iio: common: fix spelling mistakes in comments
Date: Mon, 16 Mar 2026 14:30:19 +0530
Message-ID: <20260316090023.14691-12-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes in comments.

- exepects -> expects
- fuction -> function
- theoritical -> theoretical
- appopriate -> appropriate
- iio -> IIO

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
index 97526ba87b93..e0b10366ed2b 100644
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
@@ -185,7 +185,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,

	/*
	 * After ODR change the time interval with the previous sample is
-	 * undertermined (depends when the change occures). So we compute the
+	 * undertermined (depends when the change occurs). So we compute the
	 * timestamp from the current interrupt using the new FIFO period, the
	 * total number of samples and the current sample numero.
	 */
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
