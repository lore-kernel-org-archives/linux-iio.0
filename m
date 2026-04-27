Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7030DED0;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=Z9Doeuh6BkhUCmIW9kFAwWmLrsReyl91CYsQvwhnhYfCpQeaTkzVQ0qET1fLU9G/C+/ZLsmy2hcwYhQVXUEPmzu8nlmjfw7OFVLEVF1AAgQjv/iVh1unjro0/rbFOyfEUMFe/j+vNH7ut67tWSTBNcYNYugkQWx2vC4JpFOGdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=zRqZGudlCy/r9rTbDAr1hiuQyH3vkLVcQSg7ikAa438=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnOVEInLN6Fg6+3m1+I+MBoBwPAhNZVIFQZYVfAY1SJSjgNcHWSuIK8EtZ/DSd1dLeYHIC14HpEaFvCuA7jomMMm7jvcotmzi5g+ZsxvuGjrsXuphqJ2/rjLLVsAgzKspli0g+D2FHg0hCu6BLuGSdwNJEgppVobKFlymNeDvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp8dFxKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp8dFxKH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69F93C2BCB8;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=zRqZGudlCy/r9rTbDAr1hiuQyH3vkLVcQSg7ikAa438=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pp8dFxKHBT7W5W6QPIrr3+Y+DfbKg121UipEI46y0J47G/XxtuT2gH1j1PMOBT1/X
	 ZBJZxJIKK4Cnp/2gtogweQk3djTBO/7I/cLPTaLYGKVswwp7eil+LL0MFdDJYTctnn
	 Y3aaNnR/SLbZm5udUmdtnJ4U0yDvMxi9+54GjXDDAk0BUvlKyBTEiqbC7qOHdC1ZDe
	 PR9RvIxPDFQ/YnbH85Y1DeyRIMuGIG6kN5XcHfjKXxgOdwn4EeFr29S+v1disAQAgA
	 H6J7QcRZHzNmy5GpsOT2I1k67rASlcvSAbqo0iq+0sxDWF/HV4PXA9W4iqYeJYTXs7
	 wSbYaUU6vQrgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425DFF8868;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:15 +0100
Subject: [PATCH v2 08/11] iio: dac: ad5686: add of_match table to the spi
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-8-188e05199368@analog.com>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=1849;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LohyswX/WbRmKSz4Qx5zIV8Oktgz71bUWV/iKlpzTJk=;
 b=l0IDiXlVjGpoZlV+TZpBhzBxtO2XtlhJJ+NalLFHpr35fQ+FlP5tRCYD7lqkayLZsMGrudWKp
 5/zV3zLPCDRCEM/1eKg8l7Xky3HW8PKAn0wjtT0SeXnt7hoGQHBwyAX
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
index 73e6c998add0..8fef0e6d33ff 100644
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


