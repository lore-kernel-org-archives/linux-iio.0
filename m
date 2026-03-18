Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A913AEF3B
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826200; cv=none; b=rBXfwk3U2hJ1lCXJUFe9vLd+RqO00k0Zhb/stpZjkYZlgQjnnKc9eL+WoXEnZAnBdkc+9sjyNB1ZlniHVTA2vqyiN7GlV+0ZW4WBjfCvZp1vfhG9Gb/XC8Uhoyxvd/4nNm8ZjqEkKO+aLwCuBDyPvo+0WYcXIDQVYBHMHsA+3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826200; c=relaxed/simple;
	bh=pRd86ixJCsIKMhFYIEKfaVMan2Ea5weBwsSCy5N7fHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYHsalR929867Vs4y2P8QgasPdGkeub0ZIk1z4CxQIf/KJE0vir8P0yN7x/8+HY0Yp8GpEcVnLIJGz/y0tOT3+2ogmvwkINhPrjUP0LwR25PPsUZ2S8cuED5bGqRiBnQWuCDzpNlfL3KY0gxTPCBjotvvgnQ6KvFz+o+hXFr49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f73HQSMl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f73HQSMl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso2930874a12.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826195; x=1774430995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FT3FCWE6d/BfnmV6V9NTfwQvybJ7Oe0ujhNN4DmJ54=;
        b=f73HQSMlulRLagBtJc98PwMTa9Wsejt/Q86wDSG/iSq24v6CGFnaaJlXKOudSZwxfw
         XZdC5plIre3Big5KcDYZa31rahN+wVlO+ewOetKIUZX07X9oSTPQoWAV0EKHEY3BAa5J
         fy8YqXtd4lh8tP/cwyfuHVXEu2fWoYOW/vskxJgJd9hPfMtMK0jqL4NySGYle8GfOX91
         l/LS2AiWtMgypPu2jeZB/v+oMrGfPvZ8aueHn3GQ2bGoHJqRrCyFnfK7P/QR90d8Tvfv
         KBqiuqIihwFxF1njy86RVFhI1jXPUQlWRm7hmHBdQN3ESDKCo6M3CdgOeAT//wE5Knoi
         8TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826195; x=1774430995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5FT3FCWE6d/BfnmV6V9NTfwQvybJ7Oe0ujhNN4DmJ54=;
        b=FBYo1NbAsKDffkZGdXcr4Fd3S7cxV5SsvtRHC6web6AdUMJxv2KAYGX0BLdyh+6mja
         EXBa9xfMhyc4kUaI306T7+FVFtNPynS2hKc6qNI/vYafYHu3lIUez0AiF5uP7y12BE1n
         GTm7dq5Triguku55kS2g6kUwlbwdR7PrChptTf1NycF6dvGuz1AbozX5p+8O8oJebXeF
         +/l61/qoKGmph/hdIjUoUzm+05ORZUCg6lOZt28Rbg8oxWVbZCD7+nTLgYA3wJg7ziLz
         tUYkvZUGzPCz0G8DodELzfaGLYSJ6YxCL0D77YsE0jIJzluxbal+wx5LmCC87sf9MAnA
         eSxg==
X-Forwarded-Encrypted: i=1; AJvYcCXD5d5t1yC2fVDxGZEHKCz9kuPigkEXcmvGXrz2nz+qlVsuYlN9uh+03gtS7Fmoa+sMXfztHd37phU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtg5wLVIeWzC/PCDncuUJvKM8UUvML59UHS5JTaO40JBj8/K8V
	h6VyrOjuccsCmSHF3EqDj5vEvwNMFGS2tmlEE0b0YRLtoVj3Q0zCx0Qu
X-Gm-Gg: ATEYQzx05zx9yOrUjX+sUcijX7TOlMCVBcM+2YhLHB8h8pNnXmlXQE/0RrNfT7kJjNH
	8HE/G8qC9n2/0See/4BSX0ZFXspgpqb7+ZbnaMWy/BBj6HLkb4atbK3EUS9BVokdVAYVJ8U12fR
	IW2ZWY5XWghpa6tvRI2ilj3p6LgXBe1mv/24u/nA3SZLzieEVv2mvEO1wPM5HIRtCnZWdY63hUv
	gA6IIrcOX5JNerumaLfQOgYvSd2TL6+e9qyBfTMLn+pBUMvWqfIJLR7dTWFU9kWToDiEBQPQPLQ
	bS0Y8Yol+6VSGZFZfdti64wkBTbNwAFJXxGNigVJYeGJO8stHLw+UF7Eeg4BPlKNiOzXHhMAVOJ
	nMbXt1gvQpj+4xd/LiaWaFr6iJ8WXrgVWt+Rb4qBtT4Q4O1T7z7X4QsB9Lh0SwkWrYNh6XIifJP
	qYlbXwD6gRthUqAdzdQiu65dV8fG+4HYo4OGsOqchOGTah838bzZSUq3/VMNMi+Zza5CBY0kZ5
X-Received: by 2002:a17:902:f708:b0:2ae:4445:f39a with SMTP id d9443c01a7336-2b06e2fbf94mr27636655ad.7.1773826195304;
        Wed, 18 Mar 2026 02:29:55 -0700 (PDT)
Received: from debian.ari ([152.58.182.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e616351sm21168315ad.67.2026.03.18.02.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:29:54 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during probe
Date: Wed, 18 Mar 2026 14:57:14 +0530
Message-Id: <20260318092715.42538-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318092715.42538-1-architanant5@gmail.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the regulator voltage via regulator_get_voltage() can be a slow
operation. Since the reference voltages for this ADC are not expected to
change at runtime, it is inefficient to query the regulator API every
time userspace reads the IIO_CHAN_INFO_SCALE attribute.

Determine the active reference voltage (either VREF or VCC) during
probe() and cache it in the state structure. This improves the
performance of ad799x_read_raw() and removes the dependency on the
regulator pointers during fast-path reads.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 7504bcf627da..ae2ad4bd37cc 100644
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
+		*val = st->vref_uV / MILLI;
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

