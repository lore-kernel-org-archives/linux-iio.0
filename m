Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C6411FA0;
	Fri, 24 Jul 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894594; cv=none; b=mY6iPDbv6xN9h8kmh34/zTqjJghRidwgStkVaomH/qGAnn1TvJiDkQNGvq1CLtBApyGd4nbK2x0tnycj2q3cUfxGjP1/takmjcIe9WlVlfrePEb1eaZr95kL+8xRSmNeJwL8w/Rnkyr5nOBgVVDW67rxgWV2kQuTW0QIOuOugjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894594; c=relaxed/simple;
	bh=PautfhJ21skWgcmXc4dS2ZLa2nUW8ouG7TfVnowoPDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hy+FlyKsYsrHOKjnr9oTiyjZTcMzHJ0ymOvTGMUBEKtXmX6LU18i6HRxQIX6AaIAUnIu20VrMeolCiyE/TgA58GQTdX1DvilGdLMQpK8/NRuaPd0R9EqmQhqGUdu3McG7A5H4co6IGA7tC69seO0UoKPs1ois4DHZNq6KzlHy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3zTyf3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3zTyf3J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D038DC2BCF7;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784894593;
	bh=PautfhJ21skWgcmXc4dS2ZLa2nUW8ouG7TfVnowoPDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z3zTyf3JrpGyTGMQwrX1FkUUvdpm6TpQh8FLvktrrQBotId6aBtOW8xnTI2wYMdn0
	 HJfs9mdc2bX1h03ljrxm+qgtblzkag2LguMGQB0pUgr8T764fuCeNuXtqX0/XkGyVt
	 kLb7LMTYaO8TwfHXq68ifochAjQ8+T5j9nvmU/lTF094rH9aUUAQ3EKl/ThvzzYMVd
	 08Wirwk7VqKScA0FIJcCIe5XQkZwngZQxZmzpRlkQp2lqgiQfquvrQqLVqABicZ2q1
	 6ZDy+Z9AX7XYhBvBV/VfT7o+GNB9v8w9X1+TF9e19AR4mZUBhSWkQm0CZ2FY6lx5uk
	 GYhre8/50z3lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2746C53200;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 24 Jul 2026 13:03:13 +0100
Subject: [PATCH v2 3/6] iio: dac: ad5686: refactor device list and file
 header comments
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ad5686-extend-dev-support-v2-3-cfc2b30ce988@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784894592; l=3788;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=o2YHmFSPNHfxwtoVvwK2R8/4/1vdStVyZFyqOCVnCto=;
 b=TfN4fMrTTF+iXIVpK9r0Y8PZN/XKQtGNiNkvoYlEUsbXWqHIod7XwG48s4T59lAp3iIlUZSDP
 VUi0NYXfByYB/Lqt2x/B6rSjWqZzQDjHdMp2bwBERv35pp2LX0JydNG
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Refactor device list in Kconfig, sorting devices by channel count. Also,
remove device description from file headers. One can rely on the ID
table(s) to check for supported devices. AD5337R is ommited as it does
not seem to exist, i.e. its documentation could not be found.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/Kconfig      | 29 ++++++++++++++++++++++-------
 drivers/iio/dac/ad5686-spi.c |  5 +----
 drivers/iio/dac/ad5686.c     |  2 +-
 drivers/iio/dac/ad5696-i2c.c |  4 +---
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index d6d560c09e25..3ae997939ff5 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -251,9 +251,16 @@ config AD5686_SPI
 	depends on SPI
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
-	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
-	  AD5686R Voltage Output Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices Voltage Output
+	  Digital to Analog Converters:
+	  - Single-channel:
+	    AD5310R, AD5681R, AD5682R, AD5683, AD5683R
+	  - Quad-channel:
+	    AD5684, AD5684R, AD5685R, AD5686, AD5686R
+	  - 8-channel:
+	    AD5672R, AD5676, AD5676R
+	  - 16-channel:
+	    AD5674R, AD5679R
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5686.
@@ -263,10 +270,18 @@ config AD5696_I2C
 	depends on I2C
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5311R, AD5337,
-	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
-	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
-	  Analog converters.
+	  Say yes here to build support for Analog Devices Voltage Output
+	  Digital to Analog Converters:
+	  - Single-channel:
+	    AD5311R, AD5691R, AD5692R, AD5693, AD5693R
+	  - Dual-channel:
+	    AD5338R
+	  - Quad-channel:
+	    AD5694, AD5694R, AD5695R, AD5696, AD5696R
+	  - 8-channel:
+	    AD5671R, AD5675R
+	  - 16-channel:
+	    AD5673R, AD5677R
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 227ddb269669..2689d66c7c20 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
- * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
- * AD5684R, AD5685R, AD5686, AD5686R
- * Digital to analog converters driver
+ * SPI driver for AD5686 and similar Digital to Analog Converters
  *
  * Copyright 2018 Analog Devices Inc.
  */
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 873dfb5b9107..e2beba6d54b1 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
+ * Core driver for AD5686 and similar Digital to Analog Converters
  *
  * Copyright 2011 Analog Devices Inc.
  */
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 4ddf2e151d47..4a249f9cdb8f 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
- * AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
- * Digital to analog converters driver
+ * I2C driver for AD5696 and similar Digital to Analog Converters
  *
  * Copyright 2018 Analog Devices Inc.
  */

-- 
2.43.0


