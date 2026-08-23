Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F23B638
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787460737; cv=none; b=X2R4eZLITYzT7Zk6sW963dCurhYZVxa5abCDsRf23IkxA3qT89epwJ5R39LHf4AFmXGeUNTWXbZvVio50t/wRBWsLnZCO/a55965+TJwTJI54twA0x49PCVnicgdeB0qUIFqICxaXfKIQT2t/JxiRbnZverznoLG9PxFhHArvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787460737; c=relaxed/simple;
	bh=CRoIahk0zUJFCd/Gr3T4No9Q6gsYfuKWWIpbMSivG44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSRAq0zrq2izJP0lXwa/Qvtba7vd1EMWruNHG7pg6KCL9sKabXnUtD+rK9Cr2ff/+u6xx0Olq4ipiyXceeaUscc/RW9FuSLHlzGsUE02zlUFUbOsUvd+q4WrmboemMJjANReOCAVfknJSo68g9YVEVn6DDGxKjrPrV8qLbjRi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqfy6nqu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqfy6nqu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so3417422a12.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 21:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787460734; x=1788065534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I0Bzy6U0wqPie5F2fLgX6BpcIVEHFkLwygimH93TRcA=;
        b=Gqfy6nquqrKu4qBHE+Twy+f5JsusKVpN6+jwkPRg2lVFVD/SsFG9jbMKu9VPK4CoYl
         wdC+xO8SXS7qiXSwSDzMAJMRh3ghIXPgNBJLpvZn27maFpm3LxWZyMHavHNDxYX+Sc0k
         Bmxn0gckGoyi+tmhxSRSY4V89wt9oXs8tcOI2UEZEVRZ6ERPntP5M00uYPaWkjwE8Xgk
         vCmUPY7ybIvwcRgUKAULAstHVC5nWRlVLPqmHX8IBJvwTYZ13bV96JdtnjU29xS4Vz4G
         FKVgEsPaIj21hx9gMSuiikqkGWEtwaJYfzCPzuXc2QC613SjY5YJoofRVX2QPuWOi0OD
         lTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787460734; x=1788065534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0Bzy6U0wqPie5F2fLgX6BpcIVEHFkLwygimH93TRcA=;
        b=Qi5VQNTGDvCe4VfIiugJQMAiz4bNFeLoZ/9BIqubD3UjQQpLOEXTCuDeHa8Wuu2TOn
         f8og3ArDh7y9neaofyQaDoyyji09s5MYTdQ+3n7Qa0KEEbVihPxPcCJ94BOg6Znf/6Ku
         I/hQGIQCJU1lQZ+75mrsIfjGsa2poDbGgrQXoKZIoKI3O3em/goqxPLPMNWR4MkWGJRs
         Fn6buWFkEcObZbh2nZVr5SyxwhrYMv3D3BCaQqr3NgHNT+fXtyn77D6bUrn/mUWw6hpT
         a7DusoGLBITRlmSZc/3lXCz29hrFS41qo/ytBjmj0vjtbP5+h28YDv9O9tFf8ZFKX+26
         zxiw==
X-Forwarded-Encrypted: i=1; AHgh+RrBYD1VMoCwrHIuoAaQC8GW8SShE5SoKJKAFYFDrFYlkCbm2JDtOqsJ+W3yulDztGjuA1Nz+T4olm4=@vger.kernel.org
X-Gm-Message-State: AFuF++lWusEiIb9IIzWPCMTAzrkn7tSNA57wxxSV+2SbagIhV1+Ew4yZ
	d5x86Rm9lMl1ob2G2eaU65i1DDvu0Gz4RR5dnxxlDoOs9G9UVsOohV34
X-Gm-Gg: AR+sD13jXLTtklpDGgwIyYxgfRUga5OVNjozqxH1JSHWa+OLt0uoIu6sMvpP6r08gcy
	m+1eJ4LSSEltzWN0G4y+lljMkperLZznE3N9/MYeiQBK3Do27sexqvNZ/ZfzwRkVMofQ3VBPSpV
	J87nSTcYVS1+fSDRmALDbLM3bya3bQfij1MJYek1lVyo9WptbKgaxg/c1WXd5mhwLZrPaTNPeyF
	anCCHxyRDm0yPExgQyvUkfcgvOhu8H5Enfcy4sc5XRbjdfbUoRzUcj0Im0Um/euve/UpkNtSCbf
	DoILwo5gqJM2GmTC5V+EALI8AIJLDrHNjCeNBsblWNBtPotZuLxA60WhptXqhGIqNqfcrSA0Eac
	rmQsBmTUH5+Z/hbXzGrPdrBxl5vzG/PH7J/LN8eA0W09lTHHHtllOBrNYVwmLU/WKPKpNxWzoqM
	S4jO9OG/zMy0noXYeQNMvtBcArQSrDF0jsO7LOShoG9gUoyurrdTf0pwHYDilOSo7yIeMRnK5MN
	pA=
X-Received: by 2002:a17:907:1c1f:b0:c20:31d1:a899 with SMTP id a640c23a62f3a-c246a4ad97emr2015393366b.4.1787460733587;
        Sat, 22 Aug 2026 21:52:13 -0700 (PDT)
Received: from localhost.localdomain ([196.235.129.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962a3c13sm652368866b.26.2026.08.22.21.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 21:52:12 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: adc: ad4030: fix invalid oversampling_ratio validation
Date: Sun, 23 Aug 2026 05:52:05 +0100
Message-ID: <20260823045205.25554-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
validating avg_val, and the subsequent range check only rejects
negative values or values above the maximum supported OSR. It does
not reject avg_val == 0, nor values that are not exact powers of 2.

- avg_val == 0 passes the check (0 is not < 0 and not > max), so
  ilog2(0) is called with an undefined/garbage result.

- Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
  silently get rounded down by ilog2() to the nearest lower power of
  2, so userspace can write a value to the oversampling_ratio sysfs
  attribute that does not match what actually gets programmed into
  hardware, without any error being reported.

Only powers of 2 in [1, 65536] are valid OSR values, as listed in
ad4030_average_modes[]. Validate avg_val fully before computing its
log2, using is_power_of_2() and requiring avg_val > 0.

This issue was identified with assistance from Claude AI and manually
verified against the code.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v1:
   - Added note stating the issue was identified with assistance from
   Claude AI and verified manually.
   - Removed initialization of avg_log2 at declaration.

 drivers/iio/adc/ad4030.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9c5f19321e3b..20911cc55873 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -746,14 +746,16 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
+	unsigned int avg_log2;
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
 	int freq_hz;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx] || !is_power_of_2(avg_val))
 		return -EINVAL;
 
+	avg_log2 = ilog2(avg_val);
+
 	if (st->offload_trigger) {
 		/*
 		 * The sample averaging and sampling frequency configurations
-- 
2.43.0

