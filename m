Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F12C326C;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=nlJh53cOk8c9b5uCPdl38o4Q4SEYFOMA16Y9XQ1Cu3Bz4051+xEVPOF2a1dXxpVH3sLDQjFjB/uFEzPULLehI72RE2Rqeiwic5xS1xFII2UkZC3p+5kBIDy736Vc7i1RbiW0A8JtLxZQHJ2ZDRo9gIBqza5VZOTgnudJg9geSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=fGMqRAXYgyJdDBq2SYVWRgzcZFN2wRoLV+QRZsxYyag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wz8Xft+28ukXlzGSN3ogOqnsaZFcDSqY8nh/eeWfLmCt9A/rmRfuh5vbHqKhl+D1iFc6NGl8cC/cR4nEKCz49duKDUWb6IshF/YyvX8tK0xDp2YoEdb/K9HXiP3L7+t7NjsnvsvisEMgcHZ0JCKovtkBDpI8R6+uTlKVrumnKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ/C7UTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ/C7UTv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C8CC2BCF7;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=fGMqRAXYgyJdDBq2SYVWRgzcZFN2wRoLV+QRZsxYyag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WZ/C7UTvO3WiK5takOMuNiEdklYtXTd4+P3WTuH0fAl4/ZtEmPuKA28GgWQVZclAE
	 h9fasI7CxMCDw/qbLWuILKx4nko1xWbYYaTP/eSXkH7QA7zPP8p7Q0RGG1G9ufzxBB
	 ZAieoudIZM/gQgbwEzAOwaPZX6eaaU1VEItMxUT6TyNmncNLu3l2xsq0RqtDBGML/N
	 4/IwjLx1obyjoaHtnySwhudAbyHXxI2WO5i6uM4VpBYJu8Zy9KHI1OPPOYRr/mKwGt
	 V/DLnwATmbS9myR6WzI9mKvlGWeBXWJrKCwW6F9r3nknDnoPALnMUUa0iTFwa5k5/B
	 musvttT5S6s1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B3CD13DE;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:24 +0200
Subject: [PATCH v4 4/8] iio: light: si1133: prefer complex macros enclosed
 in parenthesis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-4-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=2245;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=OzZMU15zTcx9sEaqcKvYydwvAmEqmo6kqt5pLe1FX08=;
 b=J4c8vlAtjvydqXUFQbrRV46xKf82utdbK1AS8pJjwAfg4jCPSqT/Jz7qZjWktLdEAJk6FehCb
 xzQujZkShqWD4OxMvnu8S3qbVBC6Ve/Uqo6l1q1HeKmNm0R2zSSI5Gf
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Enclose complex macros in parenthesis per checkpatch.pl error to
improve code style.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index ed9b3e0a12d66d749f09f570de1ccdda2174b6ba..9abc0a7e2ecf0d2fb1bd3af88eb675e9f1be4665 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -50,23 +50,23 @@
 #define SI1133_MAX_CMD_CTR		0xF
 
 #define SI1133_PARAM_REG_CHAN_LIST	0x01
-#define SI1133_PARAM_REG_ADCCONFIG(x)	((x) * 4) + 2
-#define SI1133_PARAM_REG_ADCSENS(x)	((x) * 4) + 3
-#define SI1133_PARAM_REG_ADCPOST(x)	((x) * 4) + 4
+#define SI1133_PARAM_REG_ADCCONFIG(x)	(((x) * 4) + 2)
+#define SI1133_PARAM_REG_ADCSENS(x)	(((x) * 4) + 3)
+#define SI1133_PARAM_REG_ADCPOST(x)	(((x) * 4) + 4)
 
 #define SI1133_ADCMUX_MASK 0x1F
 
-#define SI1133_ADCCONFIG_DECIM_RATE(x)	(x) << 5
+#define SI1133_ADCCONFIG_DECIM_RATE(x)	((x) << 5)
 
 #define SI1133_ADCSENS_SCALE_MASK 0x70
 #define SI1133_ADCSENS_SCALE_SHIFT 4
 #define SI1133_ADCSENS_HSIG_MASK BIT(7)
 #define SI1133_ADCSENS_HSIG_SHIFT 7
 #define SI1133_ADCSENS_HW_GAIN_MASK 0xF
-#define SI1133_ADCSENS_NB_MEAS(x)	fls(x) << SI1133_ADCSENS_SCALE_SHIFT
+#define SI1133_ADCSENS_NB_MEAS(x)	(fls(x) << SI1133_ADCSENS_SCALE_SHIFT)
 
 #define SI1133_ADCPOST_24BIT_EN BIT(6)
-#define SI1133_ADCPOST_POSTSHIFT_BITQTY(x) (x & GENMASK(2, 0)) << 3
+#define SI1133_ADCPOST_POSTSHIFT_BITQTY(x) (((x) & GENMASK(2, 0)) << 3)
 
 #define SI1133_PARAM_ADCMUX_SMALL_IR	0x0
 #define SI1133_PARAM_ADCMUX_MED_IR	0x1
@@ -87,11 +87,11 @@
 #define SI1133_CMD_MINSLEEP_US_HIGH	7500
 #define SI1133_CMD_TIMEOUT_MS		25
 
-#define SI1133_REG_HOSTOUT(x)		(x) + 0x13
+#define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
 
 #define SI1133_X_ORDER_MASK            0x0070
 #define SI1133_Y_ORDER_MASK            0x0007
-#define si1133_get_x_order(m)          ((m) & SI1133_X_ORDER_MASK) >> 4
+#define si1133_get_x_order(m)          (((m) & SI1133_X_ORDER_MASK) >> 4)
 #define si1133_get_y_order(m)          ((m) & SI1133_Y_ORDER_MASK)
 
 #define SI1133_LUX_ADC_MASK		0xE

-- 
2.47.3


