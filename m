Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36433D0935;
	Mon, 27 Apr 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298929; cv=none; b=m8cURlhZav3qYLlamx5fv3ByZQG0TOSvBL+0SzGAZKGLL5FLwqPPO655laWXJwUFyITcunsUXXlMN+qWHOehwQoNth8lKnQFmek2HXpS6KXnyp8tZ6T4s38xUCWMpUFK8CO3zXGuH8UHws6Mg6nMM6Jda6C3ppGEgfm+z9LEhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298929; c=relaxed/simple;
	bh=53jHOZogzOomx48zzPan2dKKqfyca8jC8YnH5yaygWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ujbky5VMt+KVTTfOSC1Jrb8vNrABL+iHNN/AkrrEv8sxXdy20jZkDDvnm6yIOJnMmEGCgq1MeOMmQu5Grl3YoSZ3RYS4+urvAp5ltQ3UfzgyL9Wx+Rkhu1H90wS2fn846CBrDfpYzBPiwVkfVHNRVrnFfGpHRbt5oOsimxPl1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeUp5VIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeUp5VIj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D696C19425;
	Mon, 27 Apr 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777298929;
	bh=53jHOZogzOomx48zzPan2dKKqfyca8jC8YnH5yaygWY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eeUp5VIjOK4au+6xO7jw4XqFBhA3p3D7XlMj3QuGu5DmGFxcPLXL72HQ4Hcraq3UB
	 +4BizXtJI6K5xz1oKVDBLHlo72M7BHA8Rm9k/QzJdnTE56JmgZVyl1qXjTodDS/whh
	 ln34/9bQWILoLmSqRc3AKiN5c7PJAJmHiMkwJS/33GRsHWSDBUwqFNgmJiF/BnK71T
	 v2wDzGOQ1dPJ2Md8CP+CiqncYhPWSSMU6qqQpwGHMJDPzKi0kcMDIv0LSMCwJ4X5Y9
	 fqy+9mwhZUfG2f021CkLEkZKpbdRGinLwXU0qLIRpgYuZJrCe8ASWlNGW4KJxz+j61
	 1Ju47KnIv0Hag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1EFF8868;
	Mon, 27 Apr 2026 14:08:49 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 27 Apr 2026 16:08:37 +0200
Subject: [PATCH] iio: light: si1133: prefer complex macros enclosed in
 parenthesis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAORt72kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3eJMQ0NjY93kjNTk7NIC3cSk5GRTIwuDxJQ0YyWgpoKi1LTMCrC
 B0bG1tQATOWW3YAAAAA==
X-Change-ID: 20260427-si1133-checkup-abcc5280adf3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777298928; l=2621;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=wIWv9xd0kv0lLT4IzZ2t9fQldOy+dcvM2jBcRgN36JA=;
 b=CRKp1imw0QWgDNFL+Rv97yGjVL0O1YApGKSR5Qq4otOfSbGzhQDPhWQNNTYzktahYqcXx5/4w
 5nWIeuNCFJkA7abpdSh6x3fTNIskS+b/xEYwbz66W9glDmbAsS9Dd+u
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
 drivers/iio/light/si1133.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 44fa152dbd24c26c97cc778cbe641d92ecd56afa..52e4269dc35014b87b7c46a120e64723be716768 100644
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
@@ -87,15 +87,15 @@
 #define SI1133_CMD_MINSLEEP_US_HIGH	7500
 #define SI1133_CMD_TIMEOUT_MS		25
 #define SI1133_CMD_LUX_TIMEOUT_MS	5000
-#define SI1133_CMD_TIMEOUT_US		SI1133_CMD_TIMEOUT_MS * 1000
+#define SI1133_CMD_TIMEOUT_US		(SI1133_CMD_TIMEOUT_MS * 1000)
 
-#define SI1133_REG_HOSTOUT(x)		(x) + 0x13
+#define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
 
 #define SI1133_MEASUREMENT_FREQUENCY 1250
 
 #define SI1133_X_ORDER_MASK            0x0070
 #define SI1133_Y_ORDER_MASK            0x0007
-#define si1133_get_x_order(m)          ((m) & SI1133_X_ORDER_MASK) >> 4
+#define si1133_get_x_order(m)          (((m) & SI1133_X_ORDER_MASK) >> 4)
 #define si1133_get_y_order(m)          ((m) & SI1133_Y_ORDER_MASK)
 
 #define SI1133_LUX_ADC_MASK		0xE

---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260427-si1133-checkup-abcc5280adf3

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


