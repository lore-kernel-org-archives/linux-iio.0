Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105F43DA4F;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=Ay4dboX7a05ygSjzTy7Vyj0X7SfSpyGolngrjRRA+gIkjMRF+gN5TAOfw6pFlcFd7zaCVHDd9QR9QvCrgUyGJYjzf37rcMi/TBgX7spZnYXM5C0FjLoWSdigllrKTXAbOIXcmUnRWbYr9Wu+90benfoWTLrot+k9w+Ll68E7WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=b6fb23sK+0a50rFQTjadTzLojC/l9EDl4In5i+uOzAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaKFxpVjme+MebUe6ZzF0cJQz8AF4m+ymZP+xnuQ1YnGWNby7BoOIVk0Wa91sMCzUA+pxLrn1l2q5PsCBCqLI/RT28ecTUnOQc0+wF0O1YkSAk1gMI/EjrOsXYt98gu0Chiz6HWO4OCd3OjlVMTIjT61lsS1kweb1kNzSvZk6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ2KtJIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ2KtJIp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D33FC2BCB9;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=b6fb23sK+0a50rFQTjadTzLojC/l9EDl4In5i+uOzAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EQ2KtJIpw/VCMtWZJ4tlqGFl6RoPEBrS8lbiqdSy0eLPeKoF+R5r3p/HyZDRN9I2i
	 bMgilThA7sjtY6df2zoYiKezhVofKLXHF6pNBEzaU1VKOJOoPfvBpW5LRhqbb3YoZc
	 UddkHiGCeU8lvB4oxCcy84eD15f7RtVGYDo4ntEAucRzxFp7+jHxLMZ1r4z0351HVL
	 fMHahrO92H2JNXJWZJj6bPUSodwiJXvbD0z69FaEhz7Pu53i6oj9lKGSG1ETn4iVsR
	 yHR2RB8Iu8N9GzCERdhxs6pHEDTfQIZ9ILavKo/wmys/YogKhWig8ZetArlaVxq0B7
	 PJYgEOCYFhbIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5222FFF8873;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 28 Apr 2026 15:18:34 +0200
Subject: [PATCH v2 2/5] iio: light: si1133: remove unused macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-si1133-checkup-v2-2-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
In-Reply-To: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=1486;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=sAJi4jzXAC1/xkjwpgVBUUVE/UZJLoyjyYEoIQrqUtw=;
 b=hPVVeDLOV8wrvYmDq+tIMEfeaEYl3ptAXJXt/LGS8G4hR7bHtDT6SgrepOeucxG+w8S5nHxEV
 KiaO7yM1vORCirhyPsnG4yM1RPbaSDeHj8v3VzvuhG7O541lVtSoj/t
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove unused macros to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 52e4269dc35014b87b7c46a120e64723be716768..ada8da122b76c9a0a55751baa6522a145f0fc7e8 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -22,8 +22,6 @@
 #define SI1133_REG_PART_ID		0x00
 #define SI1133_REG_REV_ID		0x01
 #define SI1133_REG_MFR_ID		0x02
-#define SI1133_REG_INFO0		0x03
-#define SI1133_REG_INFO1		0x04
 
 #define SI1133_PART_ID			0x33
 
@@ -40,7 +38,6 @@
 #define SI1133_CMD_RESET_CTR		0x00
 #define SI1133_CMD_RESET_SW		0x01
 #define SI1133_CMD_FORCE		0x11
-#define SI1133_CMD_START_AUTONOMOUS	0x13
 #define SI1133_CMD_PARAM_SET		0x80
 #define SI1133_CMD_PARAM_QUERY		0x40
 #define SI1133_CMD_PARAM_MASK		0x3F
@@ -86,13 +83,9 @@
 #define SI1133_CMD_MINSLEEP_US_LOW	5000
 #define SI1133_CMD_MINSLEEP_US_HIGH	7500
 #define SI1133_CMD_TIMEOUT_MS		25
-#define SI1133_CMD_LUX_TIMEOUT_MS	5000
-#define SI1133_CMD_TIMEOUT_US		(SI1133_CMD_TIMEOUT_MS * 1000)
 
 #define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
 
-#define SI1133_MEASUREMENT_FREQUENCY 1250
-
 #define SI1133_X_ORDER_MASK            0x0070
 #define SI1133_Y_ORDER_MASK            0x0007
 #define si1133_get_x_order(m)          (((m) & SI1133_X_ORDER_MASK) >> 4)

-- 
2.47.3


