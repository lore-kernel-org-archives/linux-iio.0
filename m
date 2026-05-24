Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83938E8DE;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617842; cv=none; b=icBzpRptDpqleX2B1QyzXqZptuF4iHzRZjduVaBvz/TGwIjRlgrki/4rHQYOriD5Gcjr5Ky56EkA2QXuUB8tZ+SVUlVXeG/OA0724IDFZIHkbNkDMRyUB0D5iDQzlGMJOlKx6VL7X070RY2zgGNgSlr2hKhdUGlBOmeM9Cj2rTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617842; c=relaxed/simple;
	bh=AZb9blexs61HATW2ulQywn9RxFmT8qM4NyZJdh9xWzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnzaSaegeu9utQme3oUbBili885mCpvSnp/F7QlwmMYJnmxiwLDREm1nGzJfmKj48GV1YCEVxjDa9IIV1ez4drsuKOqjuj0qZnbz9QsDgXFd2xwu/bZRHivccUMjUa+t+l1d7SQZU9L8/8YkhR9rLrECbSLCPxUZmSOeOPQhspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni8p9l3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni8p9l3b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3576FC4AF09;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779617842;
	bh=AZb9blexs61HATW2ulQywn9RxFmT8qM4NyZJdh9xWzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ni8p9l3boDIMgcKUBi4LevzjwKarGdDDZrwA65D+lKia/Lqv1jr2krLs01gq+dicA
	 qLKzP+ePY/lgPrJ9BsV6tbODoBxcq6UFn7IIC9fXSIkR7zjbUuFJM+ELHbSL+G8gFN
	 Xu7BKjzJAlpMbE70veo44QjK77cg2afQlIHiZayWhiRfFDS0G3BYf7MbZ3pXdrBW9S
	 Sp6ZgSnl/1f9RXE8yZjnRWT/rJJshbU7fodnVkg33Fp7aTBNXIwfgL6Oupt/WXk08b
	 XCdhNq/QpT9yhQyShBQzV49DELV7Os8mSUjUT82mASuxvLjB6n8tuthQKhyWXGEzgI
	 Iqymvjk/58ICA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40BCD5BC7;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:17:04 +0100
Subject: [PATCH v7 4/8] iio: dac: ad5686: add of_match table to the spi
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ad5686-fixes-v7-4-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
In-Reply-To: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779617840; l=1909;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=tT2oXF3KEnm40SzWw4b18AppwQPhbQfqQ1qlvf4GwSc=;
 b=isQiW5+E8zpJAb5azfDSnckbDk0XkTW+Xs20QwKtVzyCvt2Hx2Sr5Y+QrxrIfoKWui0bWorxg
 sm+091AQKjoDZkPuYd5GyiPP6ehUfQfSjrWIR0KkC72vXErrG9mBpSR
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
index 3a2eafedce92..7eddffe86c00 100644
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


