Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1741E6CB;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204076; cv=none; b=qTysP1g3w2ry7wO4bf2RWGjP0B/cgGhUVgS0r/KI8LGhLFAOqqtjue2H7C4pF1QnJ0ca6F4WnLLjJD9G36ooe3ZGcZJMBYvGU1UHQYxRoJR8qVVbvFMy3Q7hQKoN/l/DkubqByjBACHfPe5SMBwgBfDlSwURS1UObZfirVoDrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204076; c=relaxed/simple;
	bh=O7Zf7muyltV+fxEMustl2nDV2Z0DoJbnq+Mz2OI8upE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRMpvwfA8pUNLCi+ujV0F84J9C3mmYY0/2Sfgy/5YKSJXMQ4cDVEIrqrDSFff0IEF2Xlzy/LtZCMx9OTaoahBNy3QWBLToaJY2x+STaq1yVI+ILpsLup0bdH98pJCvzljYLnUPA/rmmGw/SwnAdHj2cSnzSXsSQ0iplO2QeuHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfYmuXkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfYmuXkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20E42C2BCC7;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=O7Zf7muyltV+fxEMustl2nDV2Z0DoJbnq+Mz2OI8upE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AfYmuXkZvWFv4rkP7WisttAGL3ZIaTHICitwS/nSZInIcW0uXbuU8bEZ501Df10Kw
	 OaJJV81us7q1I62ONOQP2lrYTJCFcJLIS0VZFLIpLPvBhSVBqbJbg+9TiSkQcZCehv
	 RnUmaqpXpwKTCIrZ8DO2ot58/o1n4lAKK4gzG1lLBwkEtIJXKMv77El6pPe9aqafVW
	 MtFx8K842VsVCJt5SmIpwyWJqYpYAIUMa8oteCSxH2quWn8oyfyD75qlHV7+Cg+Jun
	 e2PTcVO121J7vz0aENS/m9A4EvE5D7zcKt4X6k5J5wbWP/Xmxu8ry4PZ7xEzcrpBYI
	 EEDKob9a46a4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E5C44514;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 16 Jul 2026 13:14:17 +0100
Subject: [PATCH v8 1/8] iio: dac: ad5696: properly check i2c_transfer()
 return value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-ad5686-new-features-v8-1-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=1345;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=zz4hraoKydFSu7wueaAjuCXnID835nhFEfDyJb8Sb44=;
 b=mf+Fpuq1Pv6bh1V4wapfF+uIPBfBRB/SMEqk/ViOdzmyvHgNeyNmCD2fiaWwoAlfrx6USFd7g
 HoJFYbL1gpTATpXifl8lMehrE76sKNBUqtK69XouehkFwatfS/HrgJH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Verify that the expected number of i2c messages were transferred when
ad5686_i2c_read() is called. This issue exists since the support for I2C
devices was first introduced.

Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260705114746.1485F1F000E9@smtp.kernel.org/
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5696-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 279309329b64..551b200bfe14 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -7,6 +7,7 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
+#include <linux/array_size.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -39,9 +40,11 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 				      AD5686_ADDR(addr) |
 				      0x00);
 
-	ret = i2c_transfer(i2c->adapter, msg, 2);
+	ret = i2c_transfer(i2c->adapter, msg, ARRAY_SIZE(msg));
 	if (ret < 0)
 		return ret;
+	if (ret != ARRAY_SIZE(msg))
+		return -EIO;
 
 	return be16_to_cpu(st->data[0].d16);
 }

-- 
2.43.0


