Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50935F605;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=Lp1GCHeTNxuSbr4GrXVgkhc4qzwXlkZiHhIufe+CpbxGMSLD+H5X5Ci56DTXYJkam0v3frc4P2CreVNtWuZ6Fmb4C4XJM3o+IAtJXjMH3hFHjrmcsHw1SFtHpbGkBYrbcYqtpmlyr7gHYP6BMyRVK7jv9xb65BChXczfNMbELjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=E2Cs9WNPHooVbreDTbVYPhFi7CYJLKCIehDwlmW/qVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siFAOLhji516Bc9s859QG4qS8jODKZo5AlkU7P0myiBARoPxyous90jPHLtY9M5lXXgCyfrDz+uQ/l+3VUgNv4WvHWxUl+0OIDbV+7V/MGN2l/+vj6s6AT2Q7JALT/N0HmDZVyjxsQzoTMo47l7EXr5EglXGr9BzBZmN9sRns4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEQO8P/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEQO8P/R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECB0AC4AF09;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=E2Cs9WNPHooVbreDTbVYPhFi7CYJLKCIehDwlmW/qVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qEQO8P/Ryu2oD7oC6dFMaRPz1xgwtEdnj7UGOF2N2GGVrqG1ixgS0lp9oIAt2HD72
	 SN/iLnJVKHIceRVM7PeOec+I93UEKvKMyEPYWiXG4beIOpYskrz9ZzVefRA9N+sulu
	 IRJlPqrjzqL/6Uaa6l/51e8jcr1xoy/V323twuEb+UHe9H0yHb9vTL8yGeDBYGxU7m
	 315NUahdfumy+aVqVXIyRsnfFjAknQwX5sCMMPxT44pZ82ZJEb/wt+N0AoOmlAA612
	 3giNaOdKhoBD6CTVXqx7zUC0yN9HZPiKSrAEYZQNUmljvYeyWhf3WMDscbQu7218hY
	 8H5PET6zOBwBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC92CCFA13;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:50 +0200
Subject: [PATCH v3 2/8] iio: light: si1133: prefer complex macros enclosed
 in parenthesis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-2-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=2245;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=C5i/c58hyZEyHBbZkt7Seo1G34DfU10pUdqQTYkoeCA=;
 b=EufXNHGRlax2ZHJHlv8WL4aa4BV5hlrrwB6Enq6d85WsOFkeSk6LZh8l3tszAHGdaWqEtTvlD
 YNKbPCIsB2gCWiwHvK5gPicEmn5jRctgd58d6yL2gZ3Vj2lsYTlI+5e
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
index 73b0ce21e017cd4ab6c6b280229f417763866502..136436c0379aa732a2c93d40b08734ae4fc2a45f 100644
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


