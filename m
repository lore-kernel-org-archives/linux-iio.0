Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26760357CEA
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307929; cv=none; b=odpQyqd+huw43Ne634BqibzSGpRpBPtCg12fwvVaPyO9WMD9n3lBLIixKrttwLVE/H6THoYJoRYqlccXdPKK4xgUW656zUWCAX0xPeYjlrTkQEz2YZ9B25B9BeWJ9FhBcMSo2o0/xUN4NOSigBZuneCelxje4SCWKS5laDyn1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307929; c=relaxed/simple;
	bh=gPhH4u7kFmeg8EHT11wFoZiSLcRlZ7le7pXzWEpGGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/jAo/XsfAuBy9oMm6tmXbmqhwALlipDMntwvKq5UhiRDUmwjzQAdL/ycponbyc2+uYDUlGHmMgVTT91QKzOlWvmY7sGbtg3pZvC/h1in7kkRnHcielezfAnS4gxYVy72++WejOl/6goCiMbuJkVOZamCayg7Iy2mMug3/yLLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y15U8pZ0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y15U8pZ0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so5383955e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307918; x=1787912718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyIuAekOpVPDTOROhunhzyK0Yq3w+Qc14AFzLwRnzrE=;
        b=Y15U8pZ0GuPE7RdZiKMbS9/7LyVYhr+S3npWht5VFFl6bD+u1Ef3YGqZMp33R76Kfp
         6briDVENEIpPeJnHVCIjyCJpD5xF24aoytgFRDu3EETAWKUT44udJQ2S/JePyGCp2gZj
         VUFdTLWXl+KB3mPOMqQzqJuLhQSeuP5/So10tId1YXQO9ZJ0yz4aeQA3+xeWaiVm3yT3
         RWNCrwNL6YuLILRer5k8b6HcpnVajVmW6euhUA/8GH3CxJ3BCKThqBwogJqWD+OWNtsm
         zg2xM1hvmi1cwiXEn+e+o3IJQGe1WlTgEhlOdKhcuNpc1/CDqTSUyHXtuLYUwfLWYdXu
         Ogww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307918; x=1787912718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyIuAekOpVPDTOROhunhzyK0Yq3w+Qc14AFzLwRnzrE=;
        b=lkCTi6OaEYPhEPgNIfqsiPnNwM9fycy5xNgxJSPF65aGQws33SQXo+003mPWB6TQYh
         iScfY2YWtT2+vsV5HBV8Yf9bNkEairkPo9y5xMcsnb41Kuy13gT/OkfbcXFPWt0Wuj7L
         JEZ2oKAXeUIJ7fX43TbhtNSFIBJdOmNwSOMzD5ATN40ebFSRHtCDOgyL3ISl2WSM7H2v
         R5/g2ADHlDlqBWwo1gzVPWimDUNRr1p77bxMVz6PcpTbo+1MIWY6AszEOBs8zj18F0WT
         XToy4lmCXXXYiRkE3ufOz+Eq7qDukeAW3a0vscnLFQJIYVKjQirXJcDlFrAXUeDATRB2
         Yw8A==
X-Forwarded-Encrypted: i=1; AHgh+RoEi1ySkz/5swtXfF7RbzGmUbS8uW6YBzdhJTjfhUHO8po/13gtKWIiTTUY7gpWrImkTfdH02+HOWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsN0/paxw6AOEUccdb9fShQkSVcv94Un259O0pjoG7+a/MkQhv
	WlWO+eHPoP6iv9mB5atbhrvmyTqkUagRYcSbhHZkqdNXImfJvkSo6qeO
X-Gm-Gg: AR+sD10iJ3A8BN521fPS7FtNsS4PigQKiZ6/wNBhUGMeMAm49I2zu059rCztvYDTVvA
	AQvgKBbddqAadpUbqsjRn5pa81D61ZgzbFdUUC3tahU8A//kV6in0T3LGJqZH1qcwwPvf+o8m67
	E+4NhiL689/GKU/MZwFEaRuqV/Y+f/gXy0nbaMt4BBKhpi68uYZFlioCoD4YGjdaefmIszpgUgq
	aLmBB7stUWy6HyaGqAppJbxncZ2Boh5teXYc4puBjsCuykb/4Yp3d5XggP7eTOldoWTFgNZ+SvE
	s70kgcUYatuDWBDA/28LN7/KNoya6DTqMAfNF/l+Q1DUR0H5+ROQGnSmQp1ybp2NZa2z8gdQ0af
	OA/+WBYvVSvrihLWz4UactPOUGdqKVWr88giK4YqXcp8GMMu1okhqyuQ5IrzH21wlDMWsxb7DiS
	j8wn41tYQsJjB0uEHU2J5Po24O+hI31nZpIZdLTIwkuPQybHdrnm0Lm/87Gf+swFODSxGVsL7m+
	F/XcKfIhtRmzw==
X-Received: by 2002:a05:600c:c494:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499b82f4d3bmr68893055e9.3.1787307918131;
        Fri, 21 Aug 2026 03:25:18 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:17 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 6/6] iio: dac: ad5504: support scale via output-range-microvolt property
Date: Fri, 21 Aug 2026 06:24:48 -0400
Message-ID: <20260821102452.37407-7-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range is set by the R_SEL pin, not the VCC supply.
Add support for 'output-range-microvolt' to set vref_mv directly from
firmware. Use device_property_present() to distinguish absent from
malformed property rather than relying on the ambiguous -EINVAL from
device_property_read_u32_array(). Fall back to the vcc regulator
voltage for old DTs that predate this property.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 489d2e03e9f6..19ece5a2af58 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -300,6 +300,7 @@ static int ad5504_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
+	u32 range[2];
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -315,12 +316,30 @@ static int ad5504_probe(struct spi_device *spi)
 	if (is_acpi_device_node(dev_fwnode(dev))) {
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Failed to get vcc regulator\n");
-
-		st->vref_mv = ret / 1000;
+		if (device_property_present(dev, "output-range-microvolt")) {
+			ret = device_property_read_u32_array(dev, "output-range-microvolt",
+							     range, ARRAY_SIZE(range));
+			if (ret)
+				return dev_err_probe(dev, ret,
+							"Error parsing output-range-microvolt\n");
+
+			if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
+				return dev_err_probe(dev, -EINVAL,
+					"Invalid output-range-microvolt\n");
+
+			st->vref_mv = range[1] / (MICRO / MILLI);
+
+			ret = devm_regulator_get_enable(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
+		} else {
+			/* Backward compat: old DTs without output-range-microvolt */
+			ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to get vcc regulator\n");
+
+			st->vref_mv = ret / (MICRO / MILLI);
+		}
 	}
 
 	st->spi = spi;
-- 
2.55.0

