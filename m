Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97D34C98C
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546489; cv=none; b=ZKCatzdrfej/hMPVTyyJYVrFa2nKZQ6CSIquajFmcSXDjDdGdXij7J65Wco1610APbMpZruMtDkO1PcWdqonokx4zCaV260Sceko+kTF59bCDBBulEhPRv9XeYPGSAvrYjCEVNLw6z48u7EGDGjnWUvdwx71fjwbXkOHS5C2l70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546489; c=relaxed/simple;
	bh=Nj3PdkS9eg1BsdVDKzqGJFpFq7uhiaGo1Ep0coBcvYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLqtLukWFArRL68uqnOQjuAwlh3iGBi62iG5Kh95rF5omTQoGzuPasEL/AF8ucH1OVUxs2Y/vUQy2OOOMZ79+H4ahH40U/MKQ7bWRkslGutl+dUMpNMhgdtYNH01Dr/w1ETZ1VLDVkpDB3uwH2g8q6bcbjhZoZAbBc4QsN2agcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mechasystems.com; spf=fail smtp.mailfrom=mechasystems.com; dkim=pass (2048-bit key) header.d=mechasystems-com.20251104.gappssmtp.com header.i=@mechasystems-com.20251104.gappssmtp.com header.b=01Ap6rT3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechasystems-com.20251104.gappssmtp.com header.i=@mechasystems-com.20251104.gappssmtp.com header.b="01Ap6rT3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b23fcf90b2so46161865ad.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechasystems-com.20251104.gappssmtp.com; s=20251104; t=1775546488; x=1776151288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yY2N78iQFWA7p362ELoyXOxPQGSjqtrv+lYs7m3FdxQ=;
        b=01Ap6rT3UlUmbPeN8VN+JfBLKXr+5/BwwKrYTftzSFTBcJRmIQCpEpOGIUxyXtOZqy
         4omstR9rAqMyiA5zeEixXW+4XxuFXNF1x8835KXjSys1etGqm/BnXesld1qQIrfb0Ykm
         LVKVbDZVxxVcclu/Y8Qo2dSLaoev6zdmZTrCq4w+PheLq7BoSuKxGGHW2jqBDHGkpm7H
         bEGUJPZB58hasFiJBBsTXzhCR8mjMjwIQnUiwi1Z5rZSitRuqTnbajAbSeoRgMwNqpnz
         a5GCfpWj7ryIz4YmrW/jvEBNFDFN2btdEChlV9REesxLkKHE+Ay8FsJbNI95/fXD3795
         JXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775546488; x=1776151288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY2N78iQFWA7p362ELoyXOxPQGSjqtrv+lYs7m3FdxQ=;
        b=iH5F44YG0fzFD3srfJYA9/JGVtpsyMjBElf6arSjeQj36u+KZbBBF5bXyEno4BtQKi
         r+HxsyUyfWe2FhqI1CxlZKPdVwqwYudDv0C66HnWkBwHkm9PGndPkHKkjXtmzuKQCAG6
         6ds0N7eYYns0csaPLtHalX4gGKAfM0T3/x6UjGCMWPmId5DmH+OzbeJTFpUbVswl0AF3
         5SfMnBqfwtMa2QTEbtBF29BelKXV5ds5rjPbOqd0aLjrXSfd7qt9YA+B5obQC+O3i/kU
         DZaNeIVSb8/ajtyuWYtx7UmnGq2EuMJE89Bx50ZUYHH/2w/VJghTpYBt1sxYo9GS7ZYm
         rgaw==
X-Forwarded-Encrypted: i=1; AJvYcCUbiDNy6tcqduCAeMekxRR5lDToxTMYj+UEBfBHefekMaf7YhJ9MvUXnMB9RA4tsIB34So+jHMIEjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ra5exVkemhRW1yaVt0VcZbi+INibed3tU70nsexBQjbloD04
	t1IXV8TdC8UcvN1oB5F1GW3DzNjqwvbyC5v3djuuGP7ib/UbRv5ZMFioZTM4bIQFyac=
X-Gm-Gg: AeBDievCVcHYJh3MXxlm9xIRgbAXAJ7iYxUPT+fG8/0OUsRCRNF4wz2EP151oMQKVZm
	Hmjc/HEvE5LVdoBohNKBujs7P4oYFseFQPXlKYLIOenSukkBDjdF8JKKvRh3jSPYnAa7587umNk
	JOtjD7pJ815VhhpmcOcAceA5zg6JhX/w+fjVIia1uglO1FIc31oGV6LGShqtxFV2subhKScdNQ+
	i90SXgFPfJHtuhHw5B0MbAXw17dC3w1CKAblGzuunI7GGvMp+TCSaFZOPyCKOsWjSUD+S+XFe5p
	TL7XtWjLJceVyeIAetEQ6sUEdUKlU2MrwqONTmrBUdSW1KcqAYxcv1KMuBPEapK+MLkwuZEjjQB
	77OUbJLgIeKH03liiAazsRfmmeT5tKPYZF+JgOh5HSUiXsJW9lrkoMUXu7c3JMFDQ/bX8X5W0Zv
	DXDV2dJM/4LljJ5CYjrVmrvz5TKsm/aiyNhMEl
X-Received: by 2002:a17:902:d2c8:b0:2b2:523f:50d with SMTP id d9443c01a7336-2b281802cacmr166840765ad.29.1775546487680;
        Tue, 07 Apr 2026 00:21:27 -0700 (PDT)
Received: from advait-work.lan ([2001:df0:e1c0:3414:82e3:d51:5a33:fe5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747a7115sm151884005ad.36.2026.04.07.00.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:21:27 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitd@mechasystems.com>
Subject: [PATCH v2] iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL
Date: Tue,  7 Apr 2026 12:50:59 +0530
Message-ID: <20260407072059.222597-1-advaitd@mechasystems.com>
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

Fixes: 38934daf7b5c ("iio: magnetometer: st_magn: Provide default platform data")
Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---

v1->v2:
 - Fix trailing whitespace in commit message
 - Add Fixes tag
 - Use positive conditional for DRDY selection

 drivers/iio/magnetometer/st_magn_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..7644bd04654b 100644
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
+		if (mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-- 
2.43.0

