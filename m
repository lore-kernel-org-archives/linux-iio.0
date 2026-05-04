Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2A38C426;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=U3qH3We2IWZ5RqLshjn+GPJSzCXrNFcweXDHRVDaa4v2eaVPvGcOHm0e+oR5b6cik2XPfV2QxYV/djQg3vfaAPkCk0enTJij+5xdkRCn0VsOC2ObJ1AiFWvzzjaozfHJ3Va8C/GKt0SJW0UyfUXGbU1/zzBm5UaHTN0OJugVvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=zmJEtSB0T2YuJW2BxSdMSZv6WW8eov8Luau/IiqB+Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnCOf4/2hQ5STYG1Jrp14+FbMIKmTaElEcMA20NkC0VZRWtgsjdpEJIrHSB7i5lYIbbHue9agXoqRpaWh2WSfLUXfnKZmp3ib0f0gohZ5wBpF0019MRS/A45kw7FD16k50GVEiD9wXUsdemR6/kn1gClHF7N3EvVaFDzUzrihi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbiigpuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbiigpuO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9992CC2BCF4;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=zmJEtSB0T2YuJW2BxSdMSZv6WW8eov8Luau/IiqB+Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bbiigpuO2fywxKXc5QsPaTkqoM97jRcUDARcWPde6IDHE//sIS2ERr+BtpU75TeTn
	 Hye55DmE+Hw1RfUv8lvcd0WjFNqIEONqBAa+5XYiAeEz5AiDzrLjdBqDBqGLA9muRD
	 qt91KBwf11xJOY3H8/w5Jux76Tj6Loy2T7D1aaSPFHIHmcTC/CLRqwpYiwlxTQnX+y
	 uRX0wPrA3TZ7duIcFEsZ4OUfuPmVc1jd1x6TRtfzjIV0pGr4hKSfsTKA6yzfFXW2zI
	 kYCUpscRNhmip1FSarPOVceKOiaWOLctNRg0rOtBb2XelJUGR1eULMmg0GSEbRfg8r
	 EkSG+Msid4hXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93452FF885A;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:29 +0200
Subject: [PATCH v4 17/17] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-17-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=2953;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=FYcHPKDQ0L5hi3cZ5Q/MrcN4lIp6bx9WNHjfUJ4/iTo=;
 b=B9pEHPtR7Oq4u6jiOpVmmQUkPGQGZH5Iyyt8P9il0YfrHr7LUfZ1O0BKSxGvEhYIEJJ7TPLAA
 37X1uuvWQ6bDz05jTMwO3abVfmhfF9fLBkyxQ2sJEmMu4N417UHnlz0
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Make use of BIT() and GENMASK() where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index eeaf7cd5e36dc0e09f4bc588edceeb66501b8bef..ab400c107a2154b791d969f1df16f96ef139c5b2 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -45,8 +45,7 @@
 #define AK8975_REG_INFO			0x01
 
 #define AK8975_REG_ST1			0x02
-#define AK8975_REG_ST1_DRDY_SHIFT	0
-#define AK8975_REG_ST1_DRDY_MASK	(1 << AK8975_REG_ST1_DRDY_SHIFT)
+#define AK8975_REG_ST1_DRDY_MASK	BIT(0)
 
 #define AK8975_REG_HXL			0x03
 #define AK8975_REG_HXH			0x04
@@ -55,15 +54,12 @@
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
@@ -95,8 +91,7 @@
 
 #define AK09912_REG_ST1			0x10
 
-#define AK09912_REG_ST1_DRDY_SHIFT	0
-#define AK09912_REG_ST1_DRDY_MASK	(1 << AK09912_REG_ST1_DRDY_SHIFT)
+#define AK09912_REG_ST1_DRDY_MASK	BIT(0)
 
 #define AK09912_REG_HXL			0x11
 #define AK09912_REG_HXH			0x12
@@ -107,8 +102,7 @@
 #define AK09912_REG_TMPS		0x17
 
 #define AK09912_REG_ST2			0x18
-#define AK09912_REG_ST2_HOFL_SHIFT	3
-#define AK09912_REG_ST2_HOFL_MASK	(1 << AK09912_REG_ST2_HOFL_SHIFT)
+#define AK09912_REG_ST2_HOFL_MASK	BIT(3)
 
 #define AK09912_REG_CNTL1		0x30
 
@@ -117,8 +111,7 @@
 #define AK09912_REG_CNTL_MODE_ONCE	0x01
 #define AK09912_REG_CNTL_MODE_SELF_TEST	0x10
 #define AK09912_REG_CNTL_MODE_FUSE_ROM	0x1F
-#define AK09912_REG_CNTL2_MODE_SHIFT	0
-#define AK09912_REG_CNTL2_MODE_MASK	(0x1F << AK09912_REG_CNTL2_MODE_SHIFT)
+#define AK09912_REG_CNTL2_MODE_MASK	GENMASK(4, 0)
 
 #define AK09912_REG_CNTL3		0x32
 
@@ -836,7 +829,7 @@ static const struct iio_chan_spec ak8975_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+static const unsigned long ak8975_scan_masks[] = { GENMASK(2, 0), 0 };
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,

-- 
2.47.3


