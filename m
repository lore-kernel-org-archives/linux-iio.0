Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC446D543
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789927533; cv=none; b=JZXkcr1WKO4DPVCV/g3eo58lgqKrSshcw2OxLz59c5MRaTRAEAPieJY+R1qPswMauwTRPCSsvd2a1lmeKc4Qo6FXlmY/PI8i1ZomnXcXIuFBrVyQklApDdRJJp8AV6i8P8KECB+4coVCo07HGT+H+V5M5aZqitIeVhBlFQh6WBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789927533; c=relaxed/simple;
	bh=pjgBUps3bhRyY6u6ycXVMzX0Fos9VuZiAf5efJGxEsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bro+DDLhpk3Bv9uz23wCVAgjJ3Qv3xmzgqJ8jqyO43WMXqiSxPezbyJjny/7k8GglfcgxDo0nvf39vfh9ymHLm3fdpewymN8xmwGeVWTw7O4wHFFpH3yomKonpeszzjMR0ovOiqyZH5DFtmrWER1VdDoiyTrlfshPi6nPmOvabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEUEhQKZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEUEhQKZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so11121495e9.1
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789927529; x=1790532329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eKvqLxq/FDnVLXWqL74StVCqkT72bEtQBBRhBThWEs=;
        b=OEUEhQKZKDkV1L/B+R+7tZsGgjYjLAZowSLRUM3FR4ktYBsQKn1WJ7yGPWDX2X1DYI
         nuQP22ynoC8zmU4p7qGeHts5oWvQkdFZLAvhMlzxUpkR5dODrCK8GctmlzGRnE+6pH/d
         FbP7y8tJXk4c5x1qBXW8se1pFBFfu3wn5YdJ9H2HER4kOhEQig6uGnZMKBqlxmTqhvBI
         qa4CncvlLK4W88PgavH5qX+F68O/JlGMjYWoD1Qi2vkLtYMpB/92WQ65qoDdKehUH8Bb
         2MUafT4oy98sQTxTud+eR78+6/SYeqKekJeXEzMt+YsnH4l/zZigxL8rOPzNFvkTBVAe
         mrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789927529; x=1790532329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eKvqLxq/FDnVLXWqL74StVCqkT72bEtQBBRhBThWEs=;
        b=tYPmGrA07ZCAWFReVpqsVDNoPfN05+sWmku6SFYI7B9B5+qJj6y1HFSbefxGKg12Ol
         FFZT1br2iDU4aceIHU1YD2uc5Ea1YV2FeqcnKBn+bsYOp3PaTGH8+Yip7DW/VFDjv0qS
         +RE1gIKoyRf/HpIZkIQPLgPbr9TVFnvnq3M3KOO2eNz4d0qcWraqB4EtcpTJ9tphwLa5
         hrBeku4CqrOG2LkjlaEbdDWS38x7w1ejaSfP3kkugs13AWjF/ocbIwz0YBZeea6sWB95
         hgmIwkXCTo+CzExcCCfLmcEFUyBW2kJAEojmvuVYN4lHCVk2iQyDMWlsScXGSiRH7V9Y
         eGRg==
X-Gm-Message-State: AFuF++lee1A6VozCG+yapWsNkHvzEV6j8SIi8YONCdiFi28yHXg0GmvZ
	/Ux5AdUy/+wBozgKSC2I5rQvc+5I2S9PY8Vt3qUeQDcrr1V5U1E8wYXhKk6rfQ==
X-Gm-Gg: AYBFou1zITl2GjHfSAkmK03dLGbbOtECXIV19VLslGLfEea9aHs/DDEI9z+WSuZvVqx
	HRzvggwuMF/w4fnIhm9QuEveJwviuQw/lFY4CpILteuFU5PKmWNPtFJiufOO3UkMmKbamGRjg8D
	M76stl6aAw6ZzBgwNEz0mBYh6hqaP20+Cb7Ckjl/Do5vtvtmgo9RpWRKnBpfWhHTgpbjHbJGdeB
	xymCAg/fVU3N2FCfh1K3Mm5n329gfBeAhgpYtgKnitwigs6ip3uVMx+ITpSET0H2m0tSrbGd54U
	HaCyo1/IHbokJ5vKXZldNli6+G3QxS/+fUuT0353m4a+hwvp93Zp4plPKo9Z4+b4oErGYlUt81E
	QDuC3nG4GxONoVrPHwVGo9dNP6qe9JHvP5Ua56W5pJL+Vid1/bZg6nInCSn/+nO33V2dT4sStvo
	v5SmLLKFStPVz4cpF1+EC0Hd2TBK6Z38ANIkB4qjBD/U5E1TNwttGWl4YlmPNyLR4+lewtEZYh7
	YmRghXxMc0JWRx41cPf96x5ENdV8jzY7Sow1344LKqSKf6eERfyDv8JxRFoB3mxj5Rqqu4NSYug
	sUfYb3v0Wh4P+MECuK0aOfd7FdULQ6nWECKuSKL2JtaX3OclTOg64SLXyZo9J3/Tds6yNXoCOK1
	+T+mReRifIAjVlM0FEatFMD2qWpD0yElKoiOcZp64cT2bUg==
X-Received: by 2002:a05:600c:4714:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fc4f72886mr130088595e9.2.1789927529563;
        Sun, 20 Sep 2026 11:05:29 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm164648055e9.5.2026.09.20.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:05:29 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 20 Sep 2026 20:05:27 +0200
Subject: [PATCH v9 5/5] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260920-ak8975-cleanup-v9-5-1b0f00ec19ef@gmail.com>
References: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
In-Reply-To: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789927524; l=3014;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=6ZMjVC6e/KIqTzgrm9DqPo2hpOPArGBVsN2S5dq6DFc=;
 b=51owwuPaLGk6u9mi2rhRJdyER1xoSr7TMn5CxXZCPw9yln+SCfYQCb9OH6/h3Bz8JTL/jEM24
 RFPNwofyTeqDJWrQCF8I5sETkrcXmhra1aVT+W1+IAfiI1xbwaBKYaV
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Make use of BIT() and GENMASK() where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ac556644b02d..05cdd285c5f4 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -44,8 +44,7 @@
 #define AK8975_REG_INFO			0x01
 
 #define AK8975_REG_ST1			0x02
-#define AK8975_REG_ST1_DRDY_SHIFT	0
-#define AK8975_REG_ST1_DRDY_MASK	(1 << AK8975_REG_ST1_DRDY_SHIFT)
+#define AK8975_REG_ST1_DRDY_MASK	BIT(0)
 
 #define AK8975_REG_HXL			0x03
 #define AK8975_REG_HXH			0x04
@@ -54,15 +53,12 @@
 #define AK8975_REG_HZL			0x07
 #define AK8975_REG_HZH			0x08
 #define AK8975_REG_ST2			0x09
-#define AK8975_REG_ST2_DERR_SHIFT	2
-#define AK8975_REG_ST2_DERR_MASK	(1 << AK8975_REG_ST2_DERR_SHIFT)
+#define AK8975_REG_ST2_DERR_MASK	BIT(2)
 
-#define AK8975_REG_ST2_HOFL_SHIFT	3
-#define AK8975_REG_ST2_HOFL_MASK	(1 << AK8975_REG_ST2_HOFL_SHIFT)
+#define AK8975_REG_ST2_HOFL_MASK	BIT(3)
 
 #define AK8975_REG_CNTL			0x0A
-#define AK8975_REG_CNTL_MODE_SHIFT	0
-#define AK8975_REG_CNTL_MODE_MASK	(0xF << AK8975_REG_CNTL_MODE_SHIFT)
+#define AK8975_REG_CNTL_MODE_MASK	GENMASK(3, 0)
 #define AK8975_REG_CNTL_MODE_POWER_DOWN	0x00
 #define AK8975_REG_CNTL_MODE_ONCE	0x01
 #define AK8975_REG_CNTL_MODE_SELF_TEST	0x08
@@ -94,8 +90,7 @@
 
 #define AK09912_REG_ST1			0x10
 
-#define AK09912_REG_ST1_DRDY_SHIFT	0
-#define AK09912_REG_ST1_DRDY_MASK	(1 << AK09912_REG_ST1_DRDY_SHIFT)
+#define AK09912_REG_ST1_DRDY_MASK	BIT(0)
 
 #define AK09912_REG_HXL			0x11
 #define AK09912_REG_HXH			0x12
@@ -106,8 +101,7 @@
 #define AK09912_REG_TMPS		0x17
 
 #define AK09912_REG_ST2			0x18
-#define AK09912_REG_ST2_HOFL_SHIFT	3
-#define AK09912_REG_ST2_HOFL_MASK	(1 << AK09912_REG_ST2_HOFL_SHIFT)
+#define AK09912_REG_ST2_HOFL_MASK	BIT(3)
 
 #define AK09912_REG_CNTL1		0x30
 
@@ -116,8 +110,7 @@
 #define AK09912_REG_CNTL_MODE_ONCE	0x01
 #define AK09912_REG_CNTL_MODE_SELF_TEST	0x10
 #define AK09912_REG_CNTL_MODE_FUSE_ROM	0x1F
-#define AK09912_REG_CNTL2_MODE_SHIFT	0
-#define AK09912_REG_CNTL2_MODE_MASK	(0x1F << AK09912_REG_CNTL2_MODE_SHIFT)
+#define AK09912_REG_CNTL2_MODE_MASK	GENMASK(4, 0)
 
 #define AK09912_REG_CNTL3		0x32
 
@@ -864,7 +857,10 @@ static const struct iio_chan_spec ak8975_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(AK8975_CHAN_TS),
 };
 
-static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+static const unsigned long ak8975_scan_masks[] = {
+	BIT(AK8975_CHAN_X) | BIT(AK8975_CHAN_Y) | BIT(AK8975_CHAN_Z),
+	0
+};
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,

-- 
2.55.0

