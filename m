Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E23C5DC1
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129863; cv=none; b=lmZ0L+y9MDBz9tDpuuNGDkcMuRCXJbm5Khp8axnjYWAEIS1beojCvEYjpedu3pdWT6trXdpVwEWsIR+rirEA1WyintFi/QAOE3fjMygJ2c0bS+ZQrx6l5wZ6dhuV33hvlka5yBVjviGSj7D0wmsmKGAKI4o/+JmPO1JaRSj4hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129863; c=relaxed/simple;
	bh=Qb+m3vyNjoLuBkv98+cG5kWyQGgKbZn8DiGZT4ttv/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmW6zNyHnm8en3FqUMsMPlMtFSJ2xNSNvdRZ0Jegvu6blRgTtGIiW0zzlqtqRCSgCHwEJejU+i26bDijMSs4xY0Qey0ldLxjMDWCvva7Rm+cNDRTUHpkWtwj1YaIFlHbFHReV+HhodUQaQKYglvN6zxN+CGwIlAzztCUzWXib4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mechasystems.com; spf=fail smtp.mailfrom=mechasystems.com; dkim=pass (2048-bit key) header.d=mechasystems-com.20230601.gappssmtp.com header.i=@mechasystems-com.20230601.gappssmtp.com header.b=denL4CXg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechasystems-com.20230601.gappssmtp.com header.i=@mechasystems-com.20230601.gappssmtp.com header.b="denL4CXg"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c736261ee8dso263647a12.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Apr 2026 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechasystems-com.20230601.gappssmtp.com; s=20230601; t=1775129857; x=1775734657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sS8BWqiAgjFtFWPZdqlWG6FpRpWc5TRma3EPhoLUPrc=;
        b=denL4CXgD9iiyH+jXrhmjcqdSNCAApJGhDpG2fbdOvFdQxjFmePCVeWwilpCX4JGlX
         Q0MELz0sfRuxn9Q84zrWBXd4vOIMUpeA6/umbVRnK7nHH3eAVPFVZ4sbxGhDbtQLfxLb
         IXbdVQ1/rl6cLje5oUdZGiSyGkRXvO+qJjC9x6WHrcLDrI4W1Y5MGxINEs6MTsB+dEyY
         HHGBKkw/lvNR9BYFCYBqBKY4xS38/diYn03tVTCeeV2qCfgpG91mXkTfG00MWG8vWmrh
         a3JzJVShi2+iYp/IgNKzxRLaeUmAQOvv9VwcooE9JQQGh20fGxLTodG1hkgicMUbw7lD
         yzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129857; x=1775734657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS8BWqiAgjFtFWPZdqlWG6FpRpWc5TRma3EPhoLUPrc=;
        b=bJabDSHItYSs7rk7y6INe1RXlrYIBN0fFbd1qLcWEaPl/au6LfqoeBrjrGNF9e78fz
         3tlLtYn+SuVg8Nm8Xu1J2oyTdgg3W4QOPQ/E5AFaNx8U9aTh58h1B0vdud/3ZLhV0Mn9
         lFpmD7jc8bMHyWPHu+XOS+mIyFgNitL0tFVn/XqDMQFY8Nvq39s36IQhrMgwcbigS7p3
         oUxL4Jtv9ODYEaXHG23Pl35fdm4r1Xt/CGDoV0tnwOzkGHIaGDemlf+Sbfr1H2Q0LVem
         WfHxsmj0t4YTelAZQ9TQSKZybjTu2SzZ91Ki65psXAus3EY+xMlA6hr3b3/tKF5tE2tN
         6AVg==
X-Forwarded-Encrypted: i=1; AJvYcCVaYEuaqMh2V4nrZPNoBZERJyU8scazq4p2Zcb+BGpKdIjeybMyQUZKgMK0aHXeXXVQ4pDlPpEqvyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZwOzb59KFJ8ePvEJgR+g+HeGnaM7z+rBJGkbYHyMur4zvhLv
	zWrSlLVyugoGOH4GiSofhtwGoKqVSkZE6fIwM+NI6ue6KmkuEblFpiFXd7eaPJ5qtqc=
X-Gm-Gg: ATEYQzxwNGBPIQZJi3i/i+w67K2nHYtg1YTnw6AYXgHnuGG3w/CtMRkkI27Hq8jJLLV
	cIwO8ymCA/nNyHqvt4CDTOM5xjmZ/uxJqf7Jy181Q8ve2tXiH02lccGFGIUjxesveUhRih4Sczh
	HyuhAeRM+WPuZc5icZh6j6h25EvfgE8GbMCDMI6lwaqEGsxmAIJFz5UbJLS6U8eU7XUOFQnf7Cn
	LQVmwsTDeTJedU+0B8HmO/ifD9dH27agmfllSMY4l7qe8PY/Qvzfu6KHgPRdExXa3XfFs2ljcX7
	3muvudDCIwW4Xs8b963enj8RDJAqWp+KvqYaSVkeJBc5bmuGAzbPKU3c2E5OYQ+AEgNIpYNkvsV
	RP5+sPntFSgAHTOv5GjHYhdqMD9754GbvFLGRI0Of6SxeNIkTaT6oHZTKABwZszs3IFwwOqWZrz
	f07/+wyZl2jlcV6DrX5Fk2XGaVFLzUxDouNEk=
X-Received: by 2002:a05:6a20:3c89:b0:39b:f026:6f7c with SMTP id adf61e73a8af0-39ef7718de9mr8049727637.49.1775129857336;
        Thu, 02 Apr 2026 04:37:37 -0700 (PDT)
Received: from advait-work.. ([2409:40c2:104a:e006:73e0:8cc0:c3e4:586f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a6b1esm2380598a12.32.2026.04.02.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:37:36 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: jic23@kernel.org
Cc: Advait Dhamorikar <advaitd@mechasystems.com>,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL
Date: Thu,  2 Apr 2026 17:06:51 +0530
Message-ID: <20260402113653.212043-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree binding for st,lis2mdl does not support
st,drdy-int-pin property. However, when no platform data is provided
and the property is absent, the driver falls back to default_magn_pdata
which hardcodes drdy_int_pin = 2. This causes 
`st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
sensor settings have no INT2 DRDY mask defined.

Fix this by checking the sensor's INT2 DRDY mask availability at
probe time and selecting the appropriate default pin. Sensors that
do not support INT2 DRDY will default to INT1, while all others
retain the existing default of INT2.

Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..64d7edd7b3e1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -506,6 +506,11 @@ static const struct st_sensors_platform_data default_magn_pdata = {
 	.drdy_int_pin = 2,
 };
 
+/* LIS2MDL only supports DRDY on INT1 */
+static const struct st_sensors_platform_data alt_magn_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -628,8 +633,12 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	if (!pdata) {
+		if (!mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-- 
2.43.0

