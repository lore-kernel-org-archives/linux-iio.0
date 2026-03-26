Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAE38F949
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548358; cv=none; b=n2xtuTXw5YZ8hfkJBB5WxvMubYMtaslFvcBjqc7A/KSWj6W7AStzGUG35MgiJ/EEHYCtmyBUICD7IRU1QQdXnzDPHCmaAJo+yekV97IddBn7eTrMhSeok+bCCFsJqMAymJof4RLkLGRYbYa1Xg74jW8gZyWjg6yPgNBD2W6WyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548358; c=relaxed/simple;
	bh=j+iI369SjpVWhlsdQU+v6N3vNKirQiExI/riw5Iy4EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTX2Om5bwFrm/jovZzjssFXDv3hUKXGi1exaivn3oJ9f00elol3Fj4ietG/nxgUrzEea8Q9z8UUNfRRy7DCoI9VzAN6GjucL6XlolwvqIUnqzqMfaHRVtORVR9dE8ffeh022B74qYL5PORZGdwf8+tg5wr6XBhJx7pTuuXN7rSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBGGQmgk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBGGQmgk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b04d051664so11083695ad.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548353; x=1775153153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+NbF9xYAnxp5OLp62dEzPkll0wuCfxXcdLFawqds/s=;
        b=hBGGQmgk9Yow2uW5c69AT5vjQlD6dg+e9alY6xlfDGMNLQku0tQgKeOp5t/uimBOPO
         rFC7Ax3i4CjtfYzRRLfksAXG75fmO8MOtCs6rjFW4pZcI+ucKairsWPkcRtaYHMsDtDc
         uDB7RCaMQFjNEgtasetg9DfuQs0vOUjMS2vfYBEV9rjm5UQe0wPbUz+s78BOBd3TUnWg
         vR6VZUK6TYspTQ6b2Q4uftF9QxH/kezIqhjq4mVBUo2c2qlFOquaOag6n9TA7i0THbDd
         Y+Xgkdc+dgNmA2bLZqkJ7eY2hsvt4k6om+YsgemVofAlQ342a5p0Esv0UiisDY1788SG
         9i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548353; x=1775153153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+NbF9xYAnxp5OLp62dEzPkll0wuCfxXcdLFawqds/s=;
        b=Hcj7WbUF+5o6x0HTSCdGacz2RYgUAaX7hKNHsZepwerva7Rw210xizNCGuPau24Rs7
         JSYBBD4zqGe2wVWMuTPetzcQAHoZvpISA2zZgLH84PW8kPYt0eF69LGVkS5oEEWBMc26
         KYcLHjMFt/Zc+JvZcGQWUQRTm9vxql1YtRDTLRkFpAT8ndWhxjK9lvULpBR8OF6pXJBr
         VH+201mwX5fm6ipnm6fHkecB8Qrw8+GD8at5Vo93J/O/J+SVsCbUl6UInVrWiUs3BkZ1
         MpVG/mw/61Ftzkv7ynv3oX2UGCXofIUfV+s9qISIJlpnnuFTdvxHqiSDLMFRyYy+bWlz
         V5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVKPFNSvl40LvLYFGIs+c/4j8Uvy1d4zJlY83Mjd9asMMeI7FP43hpBvzQ0ENd8mAXnFt7wgQiuAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wX5z+0+tkjP0THsz7nR7KAiTjnDF0xIj5ulBqb6i0Hw+OHxJ
	JeAyjpaY5oVj/K5DuTB3oyHGrBGfAkkDAWXJVbXh/SPk5oXEnHvQqVCU
X-Gm-Gg: ATEYQzxwJF0PsfJVbC5cwZbWCJVa0BP7C+3MxesHL4jzcTUgD/V7sGbsXjyYTXnUR9D
	0NnpPF5raPqC30/WwhlQ5yKDJizfljiiKN1+I8tGhyR8DPp2iFWfWwOsO0TR39/J8bwQTbYqBx3
	/fyM2163R2j4KIQKPSsAzNfnplmWwOzeQgVlLJgTt4LvHMnsBimWqy26SFLcc0kEWK+0X8nozbg
	UHg7TbYFCrVGnSpcCW/k1IOjtrVM6tOANmjESpZZNmudEr9zbMrNBlrnHl40VNRyGiQSwF3xI3I
	lmNqDr/yoyPA0dstCej/b9TO3HR0S+TsUOLREiGnHcqL1jBbtYkL5OqZKKg4i5H2ZvplGqCm/Bj
	ucPutHeiOOqDI4M4kDaaXRA+6CjE2r4M9NmdcT5p7jKQ/2TOdr3qcqELwwL5mUscwWOSyKURMuK
	Izu9tBtHrfjk9pyTTKrcmokC2Z16yvqDqnEcozHmku3sirPaLIBo7V0gTBbppmeH9ZjQpgaiZmp
	aw=
X-Received: by 2002:a17:902:d4d2:b0:2b0:cb96:9840 with SMTP id d9443c01a7336-2b0cb96b415mr4751265ad.40.1774548353182;
        Thu, 26 Mar 2026 11:05:53 -0700 (PDT)
Received: from debian.ari ([47.30.237.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a17c5sm43823545ad.26.2026.03.26.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:05:52 -0700 (PDT)
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
Subject: [PATCH v6 3/4] iio: adc: ad799x: cache regulator voltages during probe
Date: Thu, 26 Mar 2026 23:35:28 +0530
Message-Id: <20260326180529.19154-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260326180529.19154-1-architanant5@gmail.com>
References: <20260326180529.19154-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the reference voltage for this ADC is not expected to
change at runtime, determine the active reference voltage (either VREF
or VCC) during probe() and cache it in a single variable in the state
structure.

This improves the performance of ad799x_read_raw() and removes the
dependency on the regulator pointers during fast-path reads.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 7504bcf627da..3cf7850357ab 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -135,6 +136,9 @@ struct ad799x_state {
 	u16				config;
 
 	unsigned int			transfer_size;
+
+	int				vref_uV;
+
 	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
@@ -302,14 +306,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
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
+		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -828,9 +825,20 @@ static int ad799x_probe(struct i2c_client *client)
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				goto error_disable_vref;
+			st->vref_uV = ret;
 		}
 	}
 
+	if (!st->vref) {
+		ret = regulator_get_voltage(st->reg);
+		if (ret < 0)
+			goto error_disable_reg;
+		st->vref_uV = ret;
+	}
+
 	st->client = client;
 
 	indio_dev->name = id->name;
-- 
2.39.5

