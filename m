Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4001414402;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=ONquHWARVq8IH9BdcSxpr+E4HehoIIce0cgGIGu0rQys/+nwKKSrR6EO078J7+VD65RJ/SOnwquPgUVO4KyQLvhPqIsedYqeAYRSYfKgnLZ1uGHctyIHMvQ+jDP3jPNM7Rb7wa+Ohr7P8sN0yWBp0O4xNfMoWdJbOKS6sKJR2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=iFQ97RDqK1F25vOKqeZ58JYB8nKs9+J01VyGzJvbaEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiQe1a+wCz3x972ACpzpPDSt3yB/GO69WPxhbojP0slPvkeyIkgubOnT+xW+Agmy8KPlqPJ77+6m0+HGFVNSbmFJDzARlftxqEWNSdripZ2KmPzYW3wYq1wOtiMXMBIcupQNj04VlanKl/UJZy11/djJhKaTLPjzPdli/NVnawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khHCj1Pw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khHCj1Pw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 944C6C2BD00;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=iFQ97RDqK1F25vOKqeZ58JYB8nKs9+J01VyGzJvbaEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=khHCj1PwN2wT6zuTvdUo3kiKhSaU+I21fmSzMPxLQzpRX7ahrBHDCFQGToThqi5QA
	 RlyIRz2Gey7snVTHUoiB3XH5/Hy8qAjB8OSQBTpRHOq+KYjsTsNWRoO7S3jDK/d/Vl
	 pBOMVYeuapo5PC4kbdEoxZG98jAnq9t8p+1y4gvL3KeaM4AOe5Hl3l5EWFjaZChAtE
	 Wd0nQzlocnv9PeDhcW2GualAm2REM0U1OmrDfItGcThZIecMayIBVWzQEffg7yA4jB
	 g0+ejrfiPYwJ3qn8nfoeUuhROsqbu9gA5cYalJyq1C2PY/qnQBbbb9+HQG3GN+JnCq
	 TPEHi6AfQfkMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7992ACA601C;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Fri, 09 Oct 2026 11:43:37 +0300
Subject: [PATCH 4/6] iio: adc: ltc2497: add 2x speed mode support for the
 LTC2493
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-submission-ltc2493-support-v1-v1-4-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=2263;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=FtjA/zFiFEBKxBtPjAK1vPhQfWF3e5tfKdK/i7o0yJw=;
 b=phN5jGvDKmOPIhTENlBto918SuB2PDmV50jIjy04iWATeU8iyUUXA9jsm1HKrV8kxHodn0bcV
 SvS01G/8CMKAVuejLLR2XjmzdXaS45u8ir/1Es91+IWflN4dsZtY0Bc
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 supports the same SPD 2x conversion-speed mode as the
LTC2499, using the same config word and conversion times.  Expose it
through sampling_frequency and sampling_frequency_available on the
voltage channels.  The temperature channel ignores the mode and carries
no sampling_frequency.

Tested on live LTC2493 hardware connected through an IIO network
backend: 1x/2x switching works, voltage reads succeed at both rates, and
the temperature channel carries no sampling_frequency attribute.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 6 +++++-
 drivers/iio/adc/ltc2497.c      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 87eade46beb5..816312bf0e90 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -362,6 +362,7 @@ static const struct iio_chan_spec _name[] = {                           \
 }
 
 LTC2493_DEFINE_CHANNELS(ltc2493_channel, 0);
+LTC2493_DEFINE_CHANNELS(ltc2493_channel_samp_freq, BIT(IIO_CHAN_INFO_SAMP_FREQ));
 
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
@@ -387,7 +388,10 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (ddata->chip_info->four_channel) {
-		indio_dev->channels = ltc2493_channel;
+		if (ddata->chip_info->has_speed_mode)
+			indio_dev->channels = ltc2493_channel_samp_freq;
+		else
+			indio_dev->channels = ltc2493_channel;
 		indio_dev->num_channels = ARRAY_SIZE(ltc2493_channel);
 	} else {
 		if (ddata->chip_info->has_speed_mode)
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 12c8a2fecc07..a655b04e2454 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -175,6 +175,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 		.resolution = 24,
 		.name = "ltc2493",
 		.has_temp = true,
+		.has_speed_mode = true,
 		.four_channel = true,
 	},
 	[TYPE_LTC2497] = {

-- 
2.43.0


