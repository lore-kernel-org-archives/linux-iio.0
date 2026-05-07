Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADB40627F;
	Thu,  7 May 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164570; cv=none; b=OPS2jJ9PiXEYakLpPghJZADGAyX9y85J0XtyUFMaezUCD4XHLbJAa0C7HLMCZZZuHEwOwKHsu2Iegu7bMDMMbTo56lqXE1WP17siP6VoXxWXRNOV3u7in3RsIrlK+aXA85MqYXnr64CdoZHRTVNHxeGSMFUoieZHd0pv1l2t3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164570; c=relaxed/simple;
	bh=Unp1dH41/zoQZrljdPrJE9WyZVlWutvMQmiybWJnPfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tre1VKJgLu7r0dJ3Cw2CdzGALtlO8kKCpQdHSR0lIei0yKKZhJ/C6ZAJu9oJie+ld96ujhUK2so/cgsXsD2STGsj4lFvJxLB0JBNuz5EVcmw12ILU6u+a93Va2oAsyJJt9/m6J6Uk7IbmaBgkgxoD1RQ5Dzk0K4dsV8TJ5ENJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5c25uBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5c25uBr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD58C2BCB2;
	Thu,  7 May 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164570;
	bh=Unp1dH41/zoQZrljdPrJE9WyZVlWutvMQmiybWJnPfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X5c25uBrMw453ICHHIBA6X87JQ5mCOhbZA+m3eVxhZs3ZSVyDHUTe5AlnCZmxnMyy
	 3757pl7bv4+maKaFLyzNdpFDOG1z9soqlAog4Vei3ZBFD43y8iSkB1Z8Wqt/YJHoQY
	 KwjYVmETSthpr1+MsRUO3680WRR4XCo7aGdAfCX5YD7+n+mNdqXOdytrBXsiHXf9BM
	 FkOxhczCI1Gt+41RqZuJ1w7zZua170KTbW3v/m3LijT9S8nloD2QGTJcDs8VRsCYoO
	 HrU0LVQKQyAuBWCGk/uYz+lbrRuDg0FyCNZr2wm0ZHaG2A9OimByXAkuaY4SDrxGNk
	 YOTycK7Nd+b0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02427CD343F;
	Thu,  7 May 2026 14:36:10 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 07 May 2026 16:35:57 +0200
Subject: [PATCH 8/8] iio: magnetometer: ak8975: make use of the macros from
 bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-8-37827ca68fb3@gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=3026;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=uSqUkNKA96dxORbdKRT87CB6VtK79Lmf39ap3WDBEeU=;
 b=qD/2bhyCsROnAtQrqwOMwyy58y58ehGB9jrvSyCqxQJFaUn9qL/7hCq16zSM7x/keSTvk6ozU
 YGMgB2t93TEDn41b7elkUpHH9QHFMv/g1Zl4pOT8xlMJhQTkX+GWFyF
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
 drivers/iio/magnetometer/ak8975.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d11f025e146d098508f35ef31c1ccad544612535..d8d9f706f96bae3be19e8db17b9473e6e0eef4fc 100644
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
 
@@ -848,7 +841,10 @@ static const struct iio_chan_spec ak8975_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
 };
 
-static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+static const unsigned long ak8975_scan_masks[] = {
+	BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),
+	0
+};
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,

-- 
2.47.3


