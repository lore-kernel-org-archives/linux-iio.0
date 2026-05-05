Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF13DDDA3;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=Xrz5wKacy33qQgK+9DH6v6/LLvpkw/bEkAugFijImNM8IUqMd8LQ1RJ1duHg48KL1U9DyzKSRJze3n2J/UGejN9rlRXn9iH/8NHNAtDcZkrBItnbL8DdlvT2RmlWPlep9JjX7ZJezekeYpeu+oJF6UUQ8AaBnAgNV8GLwcw37/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=a1HtXrmHWmwg6iqEF4PwgsHX2yIgthT2lPb8Qd9AHjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oECba+4qqV1t4QbDMKQ24EdMiolgxax+gyMYL2YcTWIcZc0akBhMF1vS7NIcsjKyufP0aBr/ivfbQ+WnlxOks8GVhEH/ernyNYwG9vl8BD8hxkVOx/dYzVAd/sfj/iVmr2ikmUF3HWwCFp2Wx7zGV0vOlsMLuCE50bwuI+vADes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtlZeZAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtlZeZAv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 847E3C2BCFB;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=a1HtXrmHWmwg6iqEF4PwgsHX2yIgthT2lPb8Qd9AHjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HtlZeZAv4dmBrRm0DoUaZL0aapxPoiy8ZPyEEotHn+/n+ob71l8SHieqpC8J8OLvT
	 rWpEdJZvgCSSao9NMNW1KvnNMuKYsj6VD6fknPO+bbiL53EPUMcbq3hdTTW0+BwkCd
	 x8BzM1VkXSnZz7x6f0qG1G+KDMfQe7LuiVMGv8NF1dWkp5aV9m0oqTjMeFbwDQR6Y8
	 UAkWHFHCjzxc9ebYYoZ9+dNID677nHmjpguofVQhtV5Zfy45TexVkfNKw72DMD+G6c
	 v7OGOb9iKR+cZSL1d6lSRnPUVxIVjLYnjXC1SEC3WxpG5cEwXRbfm60kfuzb813Naq
	 0WJxC2kR5zEzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF45CD3430;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:29 +0200
Subject: [PATCH v5 4/8] iio: light: si1133: prefer complex macros enclosed
 in parenthesis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-4-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=2311;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=6QJNBw8jW5Iua3EfpJQ1pjs23dcqQGKaFu93Wls4YTs=;
 b=Kq9L9prMT4yVXUV8dzD4/AJzkoLYjUdCslkzUaJ2NjUae5NB5ZOCg7RQOUKU907+d0h2LHiyj
 IPt7rSTxzmAA4mEtWusTxkgNfMr2j4noKDRhtAVjdyz7RdOGhieYDUC
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Enclose complex macros in parenthesis per checkpatch.pl error to
improve code style.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


