Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491B3D1CB1;
	Mon, 18 May 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090642; cv=none; b=D9i4t4t2NQSIdQaMU8+JZHpxvKpCEh/vZi8DWpOD2EAla8IQqVDGJEizLWdqI6U3CMe2zv29F4pAcvE1hnIey2e3xtGzMFTxWKjdMm2ybsCEd8szZjtFOVn8YtYI+dHnuZcYDykW8ue9QAJJ7eQ1VbbZ8UqhJe6aKddkFBgdH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090642; c=relaxed/simple;
	bh=zyLcdeqv/avz5A8qPCnkpPBKHA9DDyEAq0acfzNciec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWCj4itXSSJs/pL3R8Pv/euk4+j9UqxhcO585Jx1dLa8nOF2jhrpVmKZ4OAgRhy71XVLKSLsEWDo80GtLDtkjm3ujPCS1tpOguCHnLO+BkmpWxCbjUAY/Dw8FkAYowr76Wv19tZa+m596YNyUpSo5Rbbj3Mo0MB9N31Fonv6v6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyih6Pph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyih6Pph"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 737C4C2BCFC;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=zyLcdeqv/avz5A8qPCnkpPBKHA9DDyEAq0acfzNciec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wyih6PphyD5YVClou7WM50Wdr8vgEmhfzpTxp/1YcdrNcO2gEcHh2niwNr+YSzq5Z
	 T5aaPRn+vsmadOC5fFBtBQqy39fs4XsL/CPHINueFYPHkVCs92hI4py+dl/lQfytbR
	 P5t9nZrUMmTmDsmL+0/HMZ3rpc2bjt4tASYOI1A5Ph6+H1i0IkbbyGwF5mwKlHNAU9
	 CGIgk4yccyeINT4oXiwgZI9y5IQJFxWuiMexQlvZG60/AJ92Cvz5l3Tow7NQT+rTNc
	 NapnUf7HRltLSH9HvdMQ3v/k68nkJaTqU67r7/z3oZ/hkNPB5aoVcfzOI7XKWPTFxz
	 0WJxiEt59PoRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E55CD4F48;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 18 May 2026 09:50:29 +0200
Subject: [PATCH v8 5/5] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-5-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090641; l=3070;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=BtLMic4EKbvo/TXyU+z5jFmNKa9TTxTHDNruILvxV+I=;
 b=0UloWUoGbdrlQwxATeNTnYybF/7f7C+qzSQkpdMzqszHagHBl+kuJKGpmnHXDtAG3Iy+n1zWT
 e6452MKzYmaCg3dK+fRbFDcCYrXLGtBWzVBPh1DJjAqzrO6PwZxdcKs
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

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
index a140d352bad663a138295dc0c44084a9a18a4c24..366d56a3f0355f9db3711e17e1215b1210f0c9b5 100644
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
 
@@ -858,7 +851,10 @@ static const struct iio_chan_spec ak8975_channels[] = {
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


