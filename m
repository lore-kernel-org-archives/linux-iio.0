Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB53AC0EF;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981563; cv=none; b=PZa5fYNvANdRAhGTgFnTocqhFpKnFHXyX+J2qyt3kJaehd9BrMzCwWCpPqkulWuTFlMGKJBWRhrdDD0WP6HGV3Rw9RKfdaCFV4fTql/YNwlPOiW41uz1hc4alkkd5W18NKyyTkVgdePVhxPuJvoWX2F8fedXfHppK1P5K5pZdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981563; c=relaxed/simple;
	bh=jxemnGlxdQDKX+SQrBXX2o9wKXyK41fprOUR1S3+MiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIzYJPfzuXznRv9C9hMIfCFXqMHwSP9MSV85Ha4FOjJJAOBUaw0O8AMdeX5t6BBNLb+W6q+fPij8IlfS7Fb0ubYgtjjrZ5eWrP6O64UbicYQTrMP2x+WIZeybHRd/sK9TFtDwGnsCWIHX/dzdKsUc8UWMv3ZmGHZsxO8I6Z6/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbud6Iwa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbud6Iwa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3969C2BCFD;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=jxemnGlxdQDKX+SQrBXX2o9wKXyK41fprOUR1S3+MiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cbud6Iwa4wFEHfHitabiUEI3zL/66wSqQTyMYmL0vFUnqH5Mo/Db9gJ8m2ZqrBQPv
	 PqVI2SIFLfuPX1uFrQR5zgNWXAeqIWmCUtctga1QCNs4QqDiYLwVaAinCOZNXCoDVg
	 lVLmKW2tezc2bMgNt1POCNlfmvkEtGtbXw9nnyZJBXosouTVBoWNL3BekJDt6FMcEp
	 sMvT5o+Zd7XwHRB+SeAX+TUitxxOh0r5m7G2oHaESlXL+nyzrQBHrYaaiT65YtMS+6
	 OEK7QEJxAlXQaABq4dyFLyC9ftkwOl6Wu5UNQq97ah/kknANFFOZIQfpk2nJoLU6sL
	 BfYGMWZhYXwJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AFEFF885A;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:14 +0200
Subject: [PATCH v5 18/18] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-18-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=2953;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=7tIHbpJzTq6eyf+S362H0gx+618ZgmkBgJqjoS1nCrQ=;
 b=cAge5PY5Rx6PwGz4MQm/l6nZOrDeK8tTEFIq487hceR75CoDITWN6UblUEeYcQkbZcLGiJ1Iw
 0fdFkgs9wP2DtbSitudVfiW99wB8TAUjuo1q7eTIZ3YDZafbBV5dNjZ
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
index 1c96df3e1ad95d268470609c61be8ee4a709675d..ea024390b36d4a13185ec605de9d808655cab261 100644
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
 
@@ -840,7 +833,7 @@ static const struct iio_chan_spec ak8975_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+static const unsigned long ak8975_scan_masks[] = { GENMASK(2, 0), 0 };
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,

-- 
2.47.3


