Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7D3FBEDF;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=UIH/e3lX7X9E4FscKAPpXV6iCyYxxB6lfMYFkIcNWUe7WGABeK8EyD/qJZdsHMIgISQuAG6EAdO9vGBlkzsvEed0zqf5BbhckxuMg2ximkMfnJDO8udMHbhvUzNo2Z1Sx6VAZcyHeXF6YS3JYTabd8cTpxuwB9voHRzVpCOtxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=5OQ30KArxmdJ4d84VYLW3NcLCUWs3NbxBmlSWwWqBIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0nApICHIJTSYG3nRpqF6Djpb3rH2OgJaIlyIe0DiDoYudhb1bMNaaTmq71DENgkQABDqZXkOupPWTisUmoBFVutuJeTfDbE9xgJM9GngOKQQuZYkAi38Nk13TmA9HqADB4TnrDB33kRKrEu9mEQjG+etCs5rOalZULgBH1P3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3fL1g21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3fL1g21"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 283B5C2BCB8;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=5OQ30KArxmdJ4d84VYLW3NcLCUWs3NbxBmlSWwWqBIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i3fL1g21AGHB2OnY1/IOz+vZCfJ7vVQ+UIXUoDQJ1kDAFducX7lKrC2gD8vt/RGT1
	 gCowmuyC6utVbwrvO4ol87Pj9RaC/rHXZvid+TbZZfhnq/+YxDLjpNJF1W9CgFrOEh
	 nOoLZyayH6XvcBH5rCm3W5SWCgYz1RkU3XM77OnL1srCFCTEAd8rKcEH4qwrE4w7mK
	 zl0SmCYwSlwlTU0OS8tYTwUBdlWVyLydoIa59N2aCv7pzE0TkwuOnCzUwSt9reZvu9
	 RDd2zxdTgRvpbBjV5x23S33LDeQT4TjI196onq4qWyeRXiB/7hF0vOhWG6qiOlNqKe
	 hOKAmZ2L2gLDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F905CCFA13;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:39 +0100
Subject: [PATCH v4 09/13] iio: dac: ad5686: add of_match table to the spi
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-9-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=1909;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=wFk8LhEhsvyl3awicLq5nznLuet66NPWLXqtRqBdDRo=;
 b=Uy1DSFQruTXgTBzSVnGSQhz9L1j8GGk318zwa0z2EY1yCRgk0nvkS6dSR3klKv035+utIAPVZ
 jofZDvaHFZZBYLVaP1O/dITQBKI+3caZYpSIWuHaiin/2SuB9zAjC/c
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add of_match table for the SPI device variants to be consistent with the
AD5696 I2C driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 5cf60a6e19d1..9493511d9e7f 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -119,9 +119,30 @@ static const struct spi_device_id ad5686_spi_id[] = {
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


