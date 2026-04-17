Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB53AA18B;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413870; cv=none; b=feei1ybOLUzp4dplu9HbpDF82mdQRawxRFDUbbCN9b3DFgVcO+UvUdsVmY/5ZRLkFKr6pPWoquLnGoDQmggm0XBj0opB00Q5Dl/nB7tRDXfveZvb387gLDzmcsSnf7o824Es4pcwCjqv8RbXqOJh9TnnCWdul9bCaVp5wHdpfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413870; c=relaxed/simple;
	bh=WJDDvTNSHOuzICNpTczoY/QXlZKf1N2HhF4Q7EjYEWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yb+aS3yVK0yzbW+qVqroUfLtN/h9hyutdTgRLM6Ro83LXHADHZQLr11yaFoKLwFouBvR4x5kw2O4EgI6MDFpMRPqzdOOhASY4ynXQKHp2rZsDoi/Ka9eWr0FcowULYXLZ4PiB+6JZfe0IoShj35HSylj9Step6RMEMCQ1wa4RuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeUDFqd/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeUDFqd/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B273AC2BCB9;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776413869;
	bh=WJDDvTNSHOuzICNpTczoY/QXlZKf1N2HhF4Q7EjYEWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NeUDFqd/8m0YvtvUVnIYD/xR/QK0wHTFL1JZmdGxB3Smey8e8nFDWk08VRKRMtucG
	 9hlY6G/tWCL/5KrIbRJn4ay6vomhcxXVfIwtUv6GpAyphypYQeEcP0nymbzor3omth
	 iRtCoOnvJr8nDNGoOcgpdqC7/MhwTv67JBcP6W4Aur7PKDjSqlkTYLVlSVlUv2atBp
	 EF0BkrSDwWhTfmCe5FrBWzv8AggQDr8U4Q1mEEv67gr91e2g+eaXleoka1mX/2ri81
	 E5daacEjAntlrB9RiJIUyG6WYzhTsVyHUHIS/OMR9gclreFf8AqH0Bume/ofcvC8EB
	 FBWtSgWhJ8u4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A909EF8D75C;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 17 Apr 2026 09:17:36 +0100
Subject: [PATCH RFC v3 7/9] iio: frequency: ad9910: add channel labels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-ad9910-iio-driver-v3-7-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
In-Reply-To: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776413867; l=1840;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=135hAwfMg9NdwoUEbgF/+pVbdNhBQedFCd2GfQfQhok=;
 b=ffoTOLAldI/iBynNJz+WCRFiVAIPZE3m+nGQhF4LB47Z+WodWtNUZ22K36r6+XVz5dOtevjEZ
 Irol4U+Ok1lACTyktCbRctBociZVQFMeB4Orl41USyuI/w+OoFid2Vo
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add human-readable labels for all AD9910 IIO channels via the read_label
callback.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index e43df6265fd4..50d97ce937c7 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -1816,10 +1816,36 @@ static const struct fw_upload_ops ad9910_ram_fwu_ops = {
 	.cancel = ad9910_ram_fwu_cancel
 };
 
+static const char * const ad9910_channel_str[] = {
+	[AD9910_CHAN_IDX_PHY] = "phy",
+	[AD9910_CHAN_IDX_PROFILE_0] = "profile[0]",
+	[AD9910_CHAN_IDX_PROFILE_1] = "profile[1]",
+	[AD9910_CHAN_IDX_PROFILE_2] = "profile[2]",
+	[AD9910_CHAN_IDX_PROFILE_3] = "profile[3]",
+	[AD9910_CHAN_IDX_PROFILE_4] = "profile[4]",
+	[AD9910_CHAN_IDX_PROFILE_5] = "profile[5]",
+	[AD9910_CHAN_IDX_PROFILE_6] = "profile[6]",
+	[AD9910_CHAN_IDX_PROFILE_7] = "profile[7]",
+	[AD9910_CHAN_IDX_PARALLEL_PORT] = "parallel_port",
+	[AD9910_CHAN_IDX_DRG] = "digital_ramp_generator",
+	[AD9910_CHAN_IDX_DRG_RAMP_UP] = "digital_ramp_up",
+	[AD9910_CHAN_IDX_DRG_RAMP_DOWN] = "digital_ramp_down",
+	[AD9910_CHAN_IDX_RAM] = "ram_control",
+	[AD9910_CHAN_IDX_OSK] = "output_shift_keying",
+};
+
+static int ad9910_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     char *label)
+{
+	return sysfs_emit(label, "%s\n", ad9910_channel_str[chan->address]);
+}
+
 static const struct iio_info ad9910_info = {
 	.read_raw = ad9910_read_raw,
 	.write_raw = ad9910_write_raw,
 	.write_raw_get_fmt = ad9910_write_raw_get_fmt,
+	.read_label = ad9910_read_label,
 	.debugfs_reg_access = &ad9910_debugfs_reg_access,
 };
 

-- 
2.43.0


