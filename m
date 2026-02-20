Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539B2FFDCB;
	Fri, 20 Feb 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605988; cv=none; b=ex2KXCNq3MzYr55R5EAW1eXT1xddtqDc1lDYgEzRoqxM1vLKUuSs4BlLdNGc8VzSoYTfsHPGzDVr0fuKAmyCPnE2+qYbM1lt3LCkahNbQmQSdZ1MXIdtCdjEUy60G18aSnE5L0Y37pZjIBTfALe4p8uEle31nDk9pUFmACmbe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605988; c=relaxed/simple;
	bh=9+odTQuGjwuDd7d4LuL+kXPrT4LFEcQA9hbZMWMqEQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSXDTVtrQLG9Aq7xoY8kJKY/+ErORkxgmbbj0S60dU+QwS7BUAtdcB20zzvnBNmV5jyZy2uikP+bZzujXi6Lo6tNiqf7BkoeCoS7DkRq2hSnhOete1Gg5s60Fx2NdvVjIxYAYNPOzz5FSslvtqzR4JWg31URJhonq1KRQKyjcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIpbCNtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIpbCNtI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35EBBC19424;
	Fri, 20 Feb 2026 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771605988;
	bh=9+odTQuGjwuDd7d4LuL+kXPrT4LFEcQA9hbZMWMqEQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aIpbCNtIR+mBNkxAjJXarKV3uR7DxGYLtw8RrrZxU9rWL6NjywSVRhiL5qflx1g/U
	 jJrVbx/eQ19XSUebR66V/lrYXpMcv72nS7f4s4e1WRxZa7JGf3UmLCLVTHL9/sLJUG
	 Tw3rOBzqlXpsfhgzEJHsk0MSZ25aDLec8MBCX1ez1Qts3gbD1vHgtTGcRhizyZ8B/2
	 c0NuFUsYvkHo6pj93ij/KtcokGE9R5y8sTGw/dTKVBs2snLzuDUwbwjKwu5tXXhq6S
	 Eh7uTY7HlcxppfJfRo+g3taRqFzWAGgXvgV2hWCt7kOU5NNjZukIFsCKROQqB/LlFG
	 OLTMMxjRfiHsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E288C5AD44;
	Fri, 20 Feb 2026 16:46:28 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Feb 2026 16:46:12 +0000
Subject: [PATCH RFC 8/8] iio: frequency: ad9910: add channel labels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-ad9910-iio-driver-v1-8-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
In-Reply-To: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771605986; l=1464;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=XVRMytzjE0Xjg264u9puMX+fiQxZ2hkudN/VqdIWRLk=;
 b=5SaIsbhoNyh6zvARQPcFhGGl1gTCcLezdZHcHhu0tnqnvxY6Rl6ozdCQ2urKHFjRFx6uWdemu
 mCfxMLVBs8tAgqn63Km3Kna/REqHbpQRL+6EuIKW9WGWJAg+1J8Irlq
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add human-readable labels for all AD9910 IIO channels via the read_label
callback: single_tone, parallel_port, digital_ramp_generator, ram_control,
and output_shift_keying.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index b1540b157a0e..e983614805b4 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -1814,10 +1814,26 @@ static const struct attribute_group ad9910_attrs_group = {
 	.bin_attrs = ad9910_bin_attrs,
 };
 
+static const char * const ad9910_channel_str[] = {
+	[AD9910_CHANNEL_SINGLE_TONE] = "single_tone",
+	[AD9910_CHANNEL_PARALLEL_PORT] = "parallel_port",
+	[AD9910_CHANNEL_DRG] = "digital_ramp_generator",
+	[AD9910_CHANNEL_RAM] = "ram_control",
+	[AD9910_CHANNEL_OSK] = "output_shift_keying",
+};
+
+static int ad9910_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     char *label)
+{
+	return sprintf(label, "%s\n", ad9910_channel_str[chan->channel]);
+}
+
 static const struct iio_info ad9910_info = {
 	.read_raw = ad9910_read_raw,
 	.write_raw = ad9910_write_raw,
 	.write_raw_get_fmt = ad9910_write_raw_get_fmt,
+	.read_label = ad9910_read_label,
 	.attrs = &ad9910_attrs_group,
 	.debugfs_reg_access = &ad9910_reg_access,
 };

-- 
2.43.0


