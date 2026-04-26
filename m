Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD71343D72;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192699; cv=none; b=SmW/EIAU5ZhSTGUft0aGCAxPPleA0JPwpfknjimWkmkBun5RpU6a1G03XUc/getf2vcN9TalpoNt3gufRMqjQdGMHbQ8fdhRN/i/Zo5+RuaEIyGFDboYwGNrN6X3OrGbX25+niphMUSjif3c+f46yfcRvzoNxlsfVUY5+9ulefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192699; c=relaxed/simple;
	bh=zRqZGudlCy/r9rTbDAr1hiuQyH3vkLVcQSg7ikAa438=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+b4B9Z+z45QStmqWsqm9wUgDH6Itd5dN+CwCTjp3xkeulKccTLRU1154shJHj/nyS4cwtiQokC4a0jJhqGA+QBss01WEtniR/Xu38Y3LXrIFE1BVNuJxGGTE/hWUiZwGJU3PVoTDVvdI3vs0oq1niUeip2c6d5s0irJLG+6esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsYIXxK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsYIXxK0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 980B0C2BCC9;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=zRqZGudlCy/r9rTbDAr1hiuQyH3vkLVcQSg7ikAa438=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tsYIXxK0wBIyMz36Bi2r9q90gkqSM/bLD9pK7pED6hUF8oy1U721+cimffeY1wm+I
	 W+rlPEMzMyg+GwxD7kSroMU5meXqOq1Qv99dj4+36QooItcnyqttetXFeyFXRuHRlr
	 XZ3EEhyYzhNNvw0oUzkAJJCnLijEZ6echLCPFng+QRGoQHM5LwhD+Qzy+b2yp43lNn
	 IAmSwzA7Xc0ikTAF9z3izy0e1iuvjnEZhhYXaGatM58bx2/6v1dXU8CGy6mJtPWabb
	 gKz04MAH/Td09Vt8LN8Gqn/rFxYAMPBxvI/uBiTPpPRrKDd51KvIa1YaX8UP5afaBT
	 m2kwpRXeU+big==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF72FF885D;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:05 +0100
Subject: [PATCH 04/10] iio: dac: ad5686: add of_match table to the spi
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-4-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
In-Reply-To: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=1849;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LohyswX/WbRmKSz4Qx5zIV8Oktgz71bUWV/iKlpzTJk=;
 b=7HwBKUdGOdQdhtZQKTASaUcJpnz53KiHbPi2FvHiwwP2umeCEJVd9RA/Sn4AUIz5JnBA1lmFJ
 EXQXP46kYG5AhKxRp8dZeSXFAkmpX1CyuNXlbFhmeiOFjHvKc2OCk/6
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


