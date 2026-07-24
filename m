Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A217411FA1;
	Fri, 24 Jul 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894594; cv=none; b=AQnKTaXYejw5qcFyFG2mxqupHllpmw2wkAzoZR1v+jVhROj+o0z3XAEa/2bt5tDWwnOmgqQbQlS4K9K0qjJJeeoHuloAhn1s17KB8OU1wdVbkdmctzzipnRyhYe1g1ORbNHrd7giugQ0QdgFfT1c5EYJ4MSJyOC6J2YlRV8B/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894594; c=relaxed/simple;
	bh=W3tR44szyXvcfQX8J1s0kBMXIVVD4pdqptVgOWszjIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARXL15+0tVGNprZOhmohvYNb6GW5pIa3xFJ8MaRcGh/Ogmt9nMZmkoaOrRqqkWxw6ufUvdOlh5u0zwRq/F+af093F/S2hlr1qEHlxaKgZ4tz1yBbsE6qPT7OnBN7gSiksu+K+w0XIM0Zj26ZL/+nHAhxTjVgTuL7vLDaoQVm/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCG7NQZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCG7NQZc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3D56C2BCC7;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784894593;
	bh=W3tR44szyXvcfQX8J1s0kBMXIVVD4pdqptVgOWszjIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eCG7NQZcDyX4iOafSgX5+OTF+LTSEEalSAvNPxe02ZbV079N8gf/XY94Z8Pwlyo55
	 kgQY8i9iwQVRPK6TzZNRZ1Ezv8Bt8kijNyrEU2Xo6KW0V3U30lxM94JuNY+PLoJTFw
	 IQQZAJ6YXYwUQZ+TaXiPYORyTlKRwlvE7Cys2YzTPkNIXF8ABr+nKRpYhxSvW9Ycmh
	 1g5L0U4EXynGx1YaZWoHnkx/va8rgZxxyK45ZZ704mYADZTnZidzwbSotHrSFK9uHJ
	 7da1DG3w0Jszpi6V80gPu8U+ir6LutSqxZPC51T9Z+oIUwPDQh8+tqU7rveARry18O
	 WMYEXI4lMzD+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1686C531F9;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 24 Jul 2026 13:03:12 +0100
Subject: [PATCH v2 2/6] iio: dac: ad5696: add AD5673R/AD5677R entries to
 of_match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ad5686-extend-dev-support-v2-2-cfc2b30ce988@analog.com>
References: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
In-Reply-To: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784894592; l=1114;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=5Oxnj8pPzQue9O/xIA3Xd8dZvO/9iV+KIKkDlYyJfAE=;
 b=kBLV+Hb03n6ywm6cD88gfwkisa6vtI2zjXZ/T8bO5UQ8q3NMVbf6HT1guJm0HRgrfdXj4L954
 D8hmwZLAvGSA/n4GA6apDKuz6CKNlRPxmUWgXxUCnWxduVCo5lSktyn
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Populate of_match table with AD5673R/AD5677R entries, already supported by
the driver and available in the id_table.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5696-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 31439567f00f..4ddf2e151d47 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -104,7 +104,9 @@ static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5337r", .data = &ad5337r_chip_info },
 	{ .compatible = "adi,ad5338r", .data = &ad5338r_chip_info },
 	{ .compatible = "adi,ad5671r", .data = &ad5672r_chip_info },
+	{ .compatible = "adi,ad5673r", .data = &ad5674r_chip_info },
 	{ .compatible = "adi,ad5675r", .data = &ad5676r_chip_info },
+	{ .compatible = "adi,ad5677r", .data = &ad5679r_chip_info },
 	{ .compatible = "adi,ad5691r", .data = &ad5681r_chip_info },
 	{ .compatible = "adi,ad5692r", .data = &ad5682r_chip_info },
 	{ .compatible = "adi,ad5693",  .data = &ad5683_chip_info },

-- 
2.43.0


