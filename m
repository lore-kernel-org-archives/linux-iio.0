Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0873921C1;
	Sun, 24 May 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618940; cv=none; b=jmyGrK1mthiXCgPFq1j1/0vanSaazT9jngKzGridaP3tW950W/Yi9GfFG51/2go59EcHu64IPN1qgLsozJkn4Rq8iGFbWqUw+Av/0vpzgokJiZaVC3AZQHcillddMvxOBDBTav5v2CkC2ja3G0Nv99fzfLyhAY7Q+IOqsfRDFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618940; c=relaxed/simple;
	bh=am5M0FfyA32T0RH1j0AQfBPIoRlOufOv8qOkJi+td/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IjgPfvauoH9yJcBsxsNMJ6jrpXigczkTvWj1YeJSRz1sy3La0ysXZrAedRJC32eb9VOI0M1OtfDVG6e8BqsqJ1Jf5aEY6IYLiH9Tl2nC0A71EpwN76Spyt6a32KPv9RzbkzS1Qe+MCHN0pLUfGImsa4Uw6p4tfj5Z3q/05Q/JtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVJJd003; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVJJd003"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E404BC2BCF4;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779618940;
	bh=am5M0FfyA32T0RH1j0AQfBPIoRlOufOv8qOkJi+td/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tVJJd003jLL4JvU82Ym6vqDEMvomadwMtFPeTQaKM66yYCc8O5vOybj40i9OG4gdo
	 6WjJnlb7lcly0Sw/0SOBtf/IjHFxXoY6XP4dN0VBncQoSvipyrmsdzYyNKK+HyGQBZ
	 +toKWTXhK4oACYkeS+BWtAUCIbHU4YS9Y8L5N2/Kd+dAP4EeHvnnrR61Qpk8HQBOSg
	 vvzc1w2z0ttYeTIGPsNkoNCCUPtVapuOKmc2YNpsyUWrdQE/sqzBO5/bwPtEbR2GYj
	 ga5Xz/6UVjHfq8DFivcgK+KWLjyjSLrMHMd14HEtFxBMqquveWj02Xwfj30JZW6bRz
	 DE60toEV8NA5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB90CD5BC8;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:35:26 +0100
Subject: [PATCH v14 09/12] iio: frequency: adf41513: handle LE
 synchronization feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-adf41513-iio-driver-v14-9-06824d9c15f4@analog.com>
References: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
In-Reply-To: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779618938; l=2690;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=zmkJcNOMxyjybaEg7liQf0jE/fQEjr0YjWYo2BC84cw=;
 b=/tLPJvOS0ZgwxtTxsdWPvRdvIW3s6teqaVsvKpUjyigqCqd1FNFj7Yq0vENTzLgJRmyPWC2/T
 tfiokjnVDJ1Duox/EQl3+wrDnMTgDAenPd2k78eHoixS+4nSqzz3UM6
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

When LE sync is enabled, it must be set after powering up and it must be
disabled when powering down. It is recommended when using the PLL as
a frequency synthesizer, where reference signal will always be present
while the device is being configured.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 6f952ccc675e..43726b2d4879 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -226,6 +226,7 @@ struct adf41513_data {
 	bool phase_detector_polarity;
 
 	bool logic_lvl_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -635,13 +636,28 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 static int adf41513_suspend(struct adf41513_state *st)
 {
 	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_POWER_DOWN_MSK, 1);
+	st->regs[ADF41513_REG12] &= ~ADF41513_REG12_LE_SELECT_MSK;
 	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
 }
 
 static int adf41513_resume(struct adf41513_state *st)
 {
+	int ret;
+
 	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_POWER_DOWN_MSK;
-	return adf41513_sync_config(st, ADF41513_SYNC_ALL);
+	st->regs[ADF41513_REG12] &= ~ADF41513_REG12_LE_SELECT_MSK;
+	ret = adf41513_sync_config(st, ADF41513_SYNC_ALL);
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t adf41513_read_resolution(struct iio_dev *indio_dev,
@@ -914,6 +930,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 				     "invalid lock detect count: %u\n", tmp);
 	st->data.lock_detect_count = tmp;
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -970,7 +988,18 @@ static int adf41513_setup(struct device *dev, struct adf41513_state *st)
 	if (ret)
 		return ret;
 
-	return devm_add_action_or_reset(dev, adf41513_close, st);
+	ret = devm_add_action_or_reset(dev, adf41513_close, st);
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int adf41513_pm_suspend(struct device *dev)

-- 
2.43.0


