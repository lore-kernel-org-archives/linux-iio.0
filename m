Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D4395247
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994559; cv=none; b=T2hDzETJXvVICGKAfXtYff5lm0+dJ2/pj9C4Nr7Wl7/VgZD4J/6HjskXNb8G4LXDVLTyinwsDRhN0r6bpE/HbrtlFVfYBjUMx/ibAqM+IG0sH8kdkZhGN1O3Zeq/BESf1VwayvNOBZobo/x2nVcN+kmYa/C+RCvOJyqqgJN4QIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994559; c=relaxed/simple;
	bh=x5Is6TuJfxAgrtFz4XT+C5a3nBwqtfBUhZaPk0bie0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTIABdZZZS3XIHWl5ZEczqP61LZtt20XyZ7QxVZ7nWdccwPG90sNoJsiXV+RzBv9q7T8hoLegBhzC46nQJn67EPIyKG5pl/bV5Yixnq9p5pEHk5Ykeyta2dXOgmGP5ONasSA1GmiGTJobKpL61qSqnPpAJSL4JK6XCDtf034uOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBg0nUTa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBg0nUTa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso5151778a91.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994557; x=1773599357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5REngnkmAV3py6hSuWlfdMiQRrfGu2JrLts1i1aI7wE=;
        b=SBg0nUTa4HB4f7srpxNPlEnoxeEzwNulgV0F4XUC91XY/Cc8jOVG7u42GEnHFu1Fhl
         MNwxuicQqyd0O5BW0qJ0EZMl0a53hv7Kl/CQq1vH6BuUaHUDkEY6ROnsg0tvKHEyUJX+
         5K4q3AlXCuFesLJLW2eZTBXvZwrUDBvplzHp9GZndTkcyKKje9bSrZgEqmhu1KToK216
         F+0F7sQqB/us6Wo7MwMd9jbGOoO2N2DW5e3Ecr6HrwcGVMGUYUHMKbXi8KLLoOl6NHZB
         XkgnK67lo553GKSv+BnXBJkkJKW/qhmIPS9qddUzqcBCOQIya+yckU9lexVzwrw9raUH
         FuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994557; x=1773599357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5REngnkmAV3py6hSuWlfdMiQRrfGu2JrLts1i1aI7wE=;
        b=tPBwoxFe4rGGmY8DlP6tPo4KUj/Yrf/wR27aslJ64bmx3LBaqS9lg2LhfXAe8YM556
         I0xbz18ZqaHzk32Z43vvB0DJrnt4v7JjFhJ17uf0FNSrLrEY3snxfbfA8wxncWVRbwtL
         PXpOvj14D0lgv5aI3enQgJcXXUvkI0Po00KYajs0/O1RmLzEOSnvPQYTQG/jlaNM8Ey7
         l3d/Iu9c7v75dss6B0/TFpkUcdxrVD3H6+FUpr8y/5U40lp3Fpm+ClW9uWMzCUs73+xr
         a4OP00Ncj024wtHxkI2OgN0f9KM53XgYsksrsQQh/KHV4IrA/ELe/fD4e6dGaEwQtwHl
         B9yA==
X-Forwarded-Encrypted: i=1; AJvYcCV9X+G0lgZ6a0nY/yrfN9JD/BcoCVjOtMwht/PA9RSjPGUR06oxllvQrw9+SQimxFEBbkQEGPnkYmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc55N3pNrIx3l1iCyaRdm5GAgrwVNoWfgJlXx78E6PedSJzd69
	qOZtWd0F4LsQMec1qMx3Snm340ynRTsk8el8aAn9TjUjRbV/PaUf5WZJ
X-Gm-Gg: ATEYQzzTrvRtdaKq1vd4aNw89L3gp/ASn23sVTVG9pXe1IOWW5KpP1Ve47jWHc/UtzO
	3iAk/VxED1xK1DTj8ua+kzHNtpjekYUV0MoKoSP+sQOd/KVuxUqqXCZyE2hM35+BmhqGAPvRRFs
	s+c8ioyxkZBTsZkGI6v6xgSyW0HExLtFW9U72s2Y14RMpa5oVdpRiIRr1Sh8LZzpKSVi6dntcQT
	M6VcnHwT74H7kH+lZykUGM8kOY1kLQmDRweHOnFQxNG/PhYpDvTmfT+o+akdeDiWygRKCEeug4v
	BLTv0jTNLqnrZ256JrWVVpRv+z75EGsGzQ9PZQtqVEIPspgZuDPcZ+3AthjjE+CTtGAZq4E5ptm
	LUZo/Nk76lWldTc3OxPW/5eC03Be6tcgELZvKRYx8ywJ+ij02JAHFrlJ2+dB3aeSb/bQKa7Z5Xi
	W4/UxVT13kSHngeyM+iPn5/CikfY6egmRGpEHqmR+Ll84SsPTvl2M=
X-Received: by 2002:a17:902:f54e:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2ae824fcc81mr93036945ad.39.1772994557514;
        Sun, 08 Mar 2026 11:29:17 -0700 (PDT)
Received: from debian.ari ([152.58.179.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm89006965ad.42.2026.03.08.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:29:17 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 2/4] iio: adc: ad799x: cache regulator voltage during probe
Date: Sun,  8 Mar 2026 23:58:09 +0530
Message-Id: <20260308182811.33471-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260308182811.33471-1-architanant5@gmail.com>
References: <20260308182811.33471-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the regulator voltage via regulator_get_voltage() can be a slow
operation. Since the reference voltage for this ADC is not expected to
change at runtime, it is inefficient to query the regulator API every
time userspace reads the IIO_CHAN_INFO_SCALE attribute.

Determine the active reference voltage (either VREF or VCC) during
probe() and cache it in a single variable in the state structure.
This improves the performance of ad799x_read_raw(), removes the
dependency on the regulator pointers during fast-path reads, and
allows the removal of a redundant negative-value check.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index c1a7fa37706f..28f1901698a6 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -135,6 +135,9 @@ struct ad799x_state {
 	u16				config;
 
 	unsigned int			transfer_size;
+
+	int				vref_uV;
+
 	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
@@ -302,14 +305,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->vref)
-			ret = regulator_get_voltage(st->vref);
-		else
-			ret = regulator_get_voltage(st->reg);
-
-		if (ret < 0)
-			return ret;
-		*val = ret / 1000;
+		*val = st->vref_uV / 1000;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -809,6 +805,10 @@ static int ad799x_probe(struct i2c_client *client)
 	ret = regulator_enable(st->reg);
 	if (ret)
 		return ret;
+	ret = regulator_get_voltage(st->reg);
+	if (ret < 0)
+		goto error_disable_reg;
+	st->vref_uV = ret;
 
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
@@ -827,6 +827,11 @@ static int ad799x_probe(struct i2c_client *client)
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
+
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				goto error_disable_vref;
+			st->vref_uV = ret;
 		}
 	}
 
-- 
2.39.5

