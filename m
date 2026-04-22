Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AD33D4E2;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=ANQlugPvlNvg5Q6I66io8sR4aWT/BTKQWswIoSCYezAvH9SdczROWAo2FMPsJ4hXGefp8QEeW6D14yl1QG4F2pvhIZkOSJKYq+kXP+YYOlfWt68QhdfStGpDyMj5rktftDMxVmQwKLJZ93m5yUNve7uPBxAwJhTylfloqXb5eVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=K+xFdI3qumlz2bfGS97Hrd7C3kyFTVbwY0YIscqxoxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUg8CrMg/cfpTInw0iLye8kBtTGXg1TMCpI3d0wzkgU6coqZtEu47f4g4RLEGp/ntA5JB/30WAXv9U/fL+neAvhqsj6tAlBXi238V+w4s3sxFeOcmmTINcnP+fzXdTcw1Q2TOoUUqpJ6E40m8IUi1VOxhYwObOLSrVmO7K4r17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjhUJK/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjhUJK/+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81293C4AF11;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=K+xFdI3qumlz2bfGS97Hrd7C3kyFTVbwY0YIscqxoxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RjhUJK/+sveXbGxjLKrSndX4MqsHeBteXGR42YDhdtTMYLbbmm0IZzZ/B4V+cXuoO
	 fw6JX0O3EhMXdlZpg8fmhUq1W+ZL0PY76EXd6K0zW1b1RjdVS0di5ppKZcDccTa1/e
	 J5IiCCvsRNj+4WTKgywALBwVDo5oPKGUg7vLbiT/kZl+cufmO36HsQ/4GbizuzmwWf
	 sCRifK+Mi0gzmkr3keAADsIf4qCUOTcMprbllqul1XK3c/KA4CcDd8WdHr3kbRfIN5
	 4T4YjUJlZkhQMEoSnCn8gVz0p5gJdZvlRNzOjwAO2NJ6T/4uwLicJTv2JnY4251hHf
	 LfEKTmw9G+z1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F7F9EDF5;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:44 +0100
Subject: [PATCH 10/22] iio: dac: ad5686: add of_match table to the spi
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-10-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1849;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=C7y+tv8tl9vSOd2HafCCTEPh7cdjuxKwc/v91PQUx9E=;
 b=WY9x4RgC1GHSTS1QD9/Q94sNL6zKsziziM763el98x+DfBvcFe4tmyKCLisSjkDIxK4C0CE7f
 UFWhFLHkHdxCMUuvCbOkbiY2GZCQSHCfY1qW6qpYQ0RtOBDl8Jk3GUg
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add of_match table for the SPI device variants to be consistent with the
AD5696 I2C driver.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 7a7a19a01b56..6c9b70880da9 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -118,9 +118,30 @@ static const struct spi_device_id ad5686_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
 
+static const struct of_device_id ad5686_of_match[] = {
+	{ .compatible = "adi,ad5310r", .data = &ad5310r_chip_info },
+	{ .compatible = "adi,ad5672r", .data = &ad5672r_chip_info },
+	{ .compatible = "adi,ad5674r", .data = &ad5674r_chip_info },
+	{ .compatible = "adi,ad5676",  .data = &ad5676_chip_info },
+	{ .compatible = "adi,ad5676r", .data = &ad5676r_chip_info },
+	{ .compatible = "adi,ad5679r", .data = &ad5679r_chip_info },
+	{ .compatible = "adi,ad5681r", .data = &ad5681r_chip_info },
+	{ .compatible = "adi,ad5682r", .data = &ad5682r_chip_info },
+	{ .compatible = "adi,ad5683",  .data = &ad5683_chip_info },
+	{ .compatible = "adi,ad5683r", .data = &ad5683r_chip_info },
+	{ .compatible = "adi,ad5684",  .data = &ad5684_chip_info },
+	{ .compatible = "adi,ad5684r", .data = &ad5684r_chip_info },
+	{ .compatible = "adi,ad5685r", .data = &ad5685r_chip_info },
+	{ .compatible = "adi,ad5686",  .data = &ad5686_chip_info },
+	{ .compatible = "adi,ad5686r", .data = &ad5686r_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5686_of_match);
+
 static struct spi_driver ad5686_spi_driver = {
 	.driver = {
 		.name = "ad5686",
+		.of_match_table = ad5686_of_match,
 	},
 	.probe = ad5686_spi_probe,
 	.id_table = ad5686_spi_id,

-- 
2.43.0


