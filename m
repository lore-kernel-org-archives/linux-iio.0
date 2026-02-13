Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAE2773EE
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012321; cv=none; b=ZsyFCoxiBugr/0vrH9rAYho+z5LQS9irPvN5wtqFBGkvBXlMJrI7NxGaomy5TjktJHu3lMHoPl30DeRl99LQ6b67B+08QVoWL+OSKMgj5oHANOkXBdtu+Zbyk9h/qHOI9We/XilCpeveilaMdnOejlf1VRJ4B808At4lhIUqCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012321; c=relaxed/simple;
	bh=hfSQQopjpYV5I3Yfr/pwBz4wcdwAxFlhpS2vh0kNcsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4dSKHP7kL55/OUNwd4kA/XqBOAulgUm+o+nJujBaxm2qyre+LIwBtu+s53UtmnMnFzzuyw07ub3MSjFm2PDS2PNxRVz4ZGratFu+u2pzPvghRtgNNXqwZ/gyhxs8zl29qqVCo35SIvKty6OIGl6qznXqamN1nfk+3rPqC9XxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDM7mAj2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDM7mAj2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79639c2d2b5so14767947b3.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012318; x=1771617118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+3NM1chn06K9YCbGEYfn+AGcC25PLiw3IfcYFLF7ns=;
        b=JDM7mAj2Gr/NaJbAhOxJUm1OBWYdLIfP16NT/my3O/qAN3Fr7WYD9K6qX+TtUOte6Z
         YlS3dhi2MCKIknyHwbWP+IVKthjTVjAdCLCOeA9em29uEBcVEELCp1IqD4rMHiAZf1u4
         iI3dFguAKBMN0DaanV3DuHqeZkkjvVE/ghoq0EPSMsVPTuLkByXCf6P7Z5KMa+NfhpTF
         /R1FaJv9MY64b69oDoGa7ikKT4Wx8MVmvMFt1GmAevy4i3M+NRZGh6bkmLiiY9Uw8Sp7
         kQ0XvfNlRbU8rnlvk1b/vnm4IKPvBx8bXp2C9El244QH1rlZk+7wO9Rkf+o8sCdXL9Fo
         1L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012318; x=1771617118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+3NM1chn06K9YCbGEYfn+AGcC25PLiw3IfcYFLF7ns=;
        b=FDpmUKXLU0IEV2EFQuGq1YvzIHUEPVNMCKo7v7Va4kqEflnYMvJmBUh+vd7QKObBiO
         rMgOllrxW5Spt4b2hu3jN0f96tTVFpTZ/6zOvl5y0aL3m1hTYxWT+9v108K1D//z2Itv
         Lk3VPyFDpGC9kpkZcIIaygG/hz4VTxYtbFnW5JeuZL9tTcKXkMhsE3NbzGI2XHPuK3S6
         kvN653VF+bUcU+zWeB1K9tMdu2WOio608zpgCWpka2Or/Oms0w7FELyI4Wq7BKNA/pOd
         X1Q9nU2A9Vr9t1QP9R4q4tusgLjdizkYJswVGsdCZxKcQDLJRbNn5lbIOb9t/XfDDodF
         LbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV160WUaJ/T9mWb1eN1EkUCH8LNarCoKLi2E+E9Kd6heCr1gXLsuyAWTJ1JWqWjD6wQIFnvGwsDgVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrii5vulB3wBWGHNtWOTii9A2cpgJM/Hsf10vnf5985BE0tFZt
	hSYpHd650YJTZIl0A8kTNVdsP5sqpA/Nw8sJSQe4d4FMi3+/k0yzMz39
X-Gm-Gg: AZuq6aJrIhE/u64UAPy1yd4RkgeyPCtwYT8I6Q2jFDIzql1UjE3H/tpOHv2ef3rvumr
	lSOcGQ6lEKD2A4vJCOlfIZSFGVMay7C2fnYD0OsYHLl7xWz0sXgSrUpz2CB4n9+DE0PAkfxhdeF
	V4q8ZtMDe9IT33ErmLGTUWhf4+9G0a0o/6h/8YqfeETp1ohimiTtvRyXkHn3KZub/u1zNSWypHd
	EfDZMq4jU2WHSAXahHwXxzmHORMMBuINjAU4c/hXDwGCJhV39aUBW+7Flg1u14pB5rJ1WQ0WwRC
	wFylHat74rtxImGHb5P7x0g7UQVYAMPW5ZaXfnUS7lQ5w42PBjBG7w2Clp/to2NswI3QdRNHErj
	J79rPdY+Y5Xieym6L6n87nDvgY6JFpZCl0BHrPaGrgSG08IkNM6rCrCFYT1Ec9uHWD9UIubi+A4
	9wYAlfdK7ti3/iS1fq3l2eRSKBaYfgCWsi6VYvhtzOXniWkTWxgQtE1B4vuizsZ0DjWTouA6eyc
	pSywZXbbDwXXWLrVDzxngO1m/fI5VoL3GwekU25SHk=
X-Received: by 2002:a05:690c:6c8e:b0:796:4f04:bbe5 with SMTP id 00721157ae682-7979e8cd65amr27744657b3.47.1771012318168;
        Fri, 13 Feb 2026 11:51:58 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c195dccsm74210287b3.21.2026.02.13.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:51:57 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] iio: adc: ad7768-1: Fix ERR_PTR dereference in ad7768_fill_scale_tbl
Date: Fri, 13 Feb 2026 13:51:41 -0600
Message-ID: <20260213195141.22256-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iio_get_current_scan_type() can return aan error pointer,
the return value scan_type is not checked for this and immediately
dereferenced which can cause a kernel panic.

Add check for IS_ERR() and propagate the error back.

Fixes: ff085189cb17 ("iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202602051234.5gArzLyZ-lkp@intel.com/
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..e16dede687d3 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -531,7 +531,7 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static void ad7768_fill_scale_tbl(struct iio_dev *dev)
+static int ad7768_fill_scale_tbl(struct iio_dev *dev)
 {
 	struct ad7768_state *st = iio_priv(dev);
 	const struct iio_scan_type *scan_type;
@@ -541,6 +541,11 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 	u64 tmp2;
 
 	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
+	if (IS_ERR(scan_type)) {
+		dev_err(&st->spi->dev, "Failed to get scan type.\n");
+		return PTR_ERR(scan_type);
+	}
+
 	if (scan_type->sign == 's')
 		val2 = scan_type->realbits - 1;
 	else
@@ -565,6 +570,8 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 		st->scale_tbl[i][0] = tmp0; /* Integer part */
 		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
 	}
+
+	return 0;
 }
 
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
@@ -669,7 +676,9 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
 	}
 
 	/* Update scale table: scale values vary according to the precision */
-	ad7768_fill_scale_tbl(dev);
+	ret = ad7768_fill_scale_tbl(dev);
+	if (ret)
+		return ret;
 
 	ad7768_fill_samp_freq_tbl(st);
 
-- 
2.53.0

