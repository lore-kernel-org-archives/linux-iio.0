Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28B411A17;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=UzFeAK1cN1uahdmpEzDYQClJVU6hs7HWef11UQNY09ImSaRGd7YmqkafkvFijRJxlGbwt7dNf9UPFproPvwRN1/JtrV6GuhAaNKT/9QMHCyNieKj4leTkMETfZSI+r/W1J0jvzKrM2c5/TrJGWbQ5vTjApiR951TRI23i8Qxjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=SVZ18yU3md3cTg26RphV25AGCiaWCiD2tA1ZYtiekj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cV08EL6MA5W9VEcRAs2j+5bVUu3fdpFYmqDOQVwg/hgbxURO35YdfVTI2damKAJz7USRutA1iiSzT3oncz5xcvDKcSWzp2CSSivHvXYXtL4biZYiTAnJ47Ay7BVpJungEerQtOpj+tt0Z6pJVhDgilZqA9GPPPh4cAQutiDG1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiShvjgB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiShvjgB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8680BC2BD01;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=SVZ18yU3md3cTg26RphV25AGCiaWCiD2tA1ZYtiekj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FiShvjgBWdGChqmGYcLMitVIx/4Fj1Z7TziB1TJ6l1e8DjG7i7+wY4lawWekOHI+w
	 xMfGHDha0956LrQWWg9FApvedaQfndBjdY1g3QC56C2lJU5dxxW86/E8JLCI4Ydaw+
	 9GfezfJnUQFUG7bL7o6pLWBmPLnCYLL1Hax3YMAS9cMgz9V1k6Jwmk+u1w3Av9SGCv
	 skFK4VItgphIog9kecWHaakWXxKOjb7kLt8fhVDBjYpRrv4FZ66ggEEMDlhFXiJzwK
	 c+3q1UX8IhBT1MIviPqGHq1F9zLw8mr3yY6vyKWhk+oNkqEYUoIoCWoByXi3yO7sJ2
	 iZJJ3fV8umIvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DCCA6012;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Fri, 09 Oct 2026 11:43:36 +0300
Subject: [PATCH 3/6] iio: adc: ltc2497: add LTC2493 internal temperature
 channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-submission-ltc2493-support-v1-v1-3-3dad1d4b152a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=1711;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=y50zBMCty6O/0VAscXJTxsJbowdiUfKJKU+8SF6Q/K4=;
 b=Qu4VdPdTeDXtWEz5X8Ec+PtTkdSgzZc07RvD7MScvZJ/UXGCSIPY+BjIbWwf7aLz95G7EPXsm
 jwpB8UdzqLzCkhfjGdiewq6VPES3sGsMVQtnt8PrtEurJhIMACIYosG
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 includes the same internal PTAT temperature sensor as the
LTC2499, selected via the IM bit in the second config byte.

Tested on live LTC2493 hardware connected through an IIO network backend:
in_temp_raw, in_temp_scale, and in_temp_offset are readable; the reported
temperature is plausible; and voltage/temperature interleaving produces no
sticky-PTAT.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 2 +-
 drivers/iio/adc/ltc2497.c      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 96b365efd1e9..87eade46beb5 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -396,7 +396,7 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 			indio_dev->channels = ltc2497core_channel;
 		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
 	}
-	/* Only the ltc2499 has a temperature channel; it is the last entry. */
+	/* Temperature is the last channel entry; trim it for parts without the sensor. */
 	if (!ddata->chip_info->has_temp)
 		indio_dev->num_channels--;
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index ea9dff3c0d73..12c8a2fecc07 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -174,6 +174,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2493] = {
 		.resolution = 24,
 		.name = "ltc2493",
+		.has_temp = true,
 		.four_channel = true,
 	},
 	[TYPE_LTC2497] = {

-- 
2.43.0


