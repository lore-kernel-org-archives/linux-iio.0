Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C0372ECF;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498780; cv=none; b=U+TksjiOFEQitFZlsXGsRsY3Yq+f3B8dQlzMjQoACE9ZhLJf7qaq/trbSaLhaYrkD+P6B75DXrpAMv9JN3p08Ore8mOTHtzbmhdTaTFpCzNWxMDQ9oOKC3zecRQkfZn+bRVZ08ukGa4S+O/BNG6scHlg84B7H4yjrTzJ/Hk9vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498780; c=relaxed/simple;
	bh=JMPHUtGRLp4XYT3qoYRr7853oC/XlIRIvjLWhcOanPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/rG97hkkX5fiNqHHP1B/X3E38Mg9o2yx6BeUeYMIp8mnFptE2rj7sL3alsf81+WJ+llM+trS2m+W6mQ6s6EnJcOpkUTukKnI9RqwtrUzjkWJqzV0gXJ4VEWA2necwPlyPangtmvjl0QIA1JI4lw2/uNfU0vXyjA4OhuvDGgUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3DkDLPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3DkDLPi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6E7BC2BCB0;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498779;
	bh=JMPHUtGRLp4XYT3qoYRr7853oC/XlIRIvjLWhcOanPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m3DkDLPih3/KujpML9+JMToMg0xOZx2MZsFvbWNnnED+bVdWSntIXNc9X4D74lwq4
	 kv8alp6+OC4eRsf3s+g7EFCDLuFYgWD4HCNK9+BU/frKwa791TldDkGklh7X2gbhNL
	 1VmsqJSv/JxLSvDBd3bN0YJhrLyRd2RQf172yyuYty8QAYiWPOlS6iOGR7IWVOsWZS
	 XFSFenmJlkBusvoBJl5HsSHk9f6XyIGJ4wv19bNLTL+GD/pwcQZB9E7CS32SUf6wsL
	 jE3FZ6IAEhj3UbxhjsJEC/fQpftrJ1nmMJ8e7mSDimfBNKu7zjwqKOOyNt9+ovPbod
	 WbutgMlOKxhpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD5CD37B9;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 13:26:17 +0200
Subject: [PATCH v7 8/8] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-magnetometer-fixes-post-pickup-v7-8-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778498777; l=3070;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=raM4Osn4NOSANS9V3gWU6boxJNZiWShxAROFiRWtIAY=;
 b=TP0D4CypFbMuyzjysRkUKOG9vatbV58hCmoS0rYS/KDF5K6851oG/XMMb2uT5UulpQlwTpKFg
 UXP04o0RjTIDNnmBF/HBrDf9Nx0GSe2GS8rY+9PB23LgdtKxiAfIAiw
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
index d87a98090c991508ac835839286da0371d689cd8..d8fbdc5debc1cc65ea6e86167a79c860d019cc32 100644
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


