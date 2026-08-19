Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1913C279D;
	Wed, 19 Aug 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127365; cv=none; b=NevLC6bT3ilDLlu/gzAKQL1pc91/ndEThgZeE51mpTkNAHPnKbwjiDRfdp0LWHHlxvon/iVW54JOjFQKYrtf3oQqseSF4ZD2aQgHEvPBOHyP/erjyD0o7Z+/ba0snO5LeI2wk0SAR8O/H67mAqsZfJtacK9VOVcuenyngD7DfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127365; c=relaxed/simple;
	bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtNLArLw80U0DnHgznuhFVMw2UiKa1Qb5GA46DPM6/oTS0wi2CcAdHlMQU0Zsk7k/c81M9SEJ0fhp8VIXQLTfEbc+I/kkKMEEjqIjyhZHTsKNHdRMARb2/PQEdrunY/vGabCXBQcHhD3YFBlyq3c+y85Q0/ruRep+XE506/mhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=v02DpV0G; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="v02DpV0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127348; x=1787386548;
	bh=XJ9dsEYOltvcV8dNsiIVCzLj7uR8oL/YLG98qkFwY0A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=v02DpV0GqhNg/imemKMn6a5vk7MHa/ZklJbBDimVfISWuzREBFMe22FSbv5fb3pI0
	 lxpctJAlR0lnSPzU+ZJoiEXpURA8jfC4ZI9YsUgfO61rsDMi6/s3DAhQmt73QSw75K
	 10SQPBp77m8c8oSTaf2Brn9L/MGImBuwFenjxVOshBf97Y5SvtkfjB1vlYglfKX2by
	 ax//2bLLajoKvTVWSaGVEberhigHfJ8KbcSPco/h+AJoMPw4cI1U51Z2fsTprDjP++
	 672/ABIvLcRmyOuqGc267ZsQVL5CUUMYB2paHvJZK38UWgLcgmC9eCKGE64b7Ptp02
	 W7oJJGnWKk3sQ==
X-Pm-Submission-Id: 4hPzsb4BJJz1DDs3
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 19 Aug 2026 10:15:29 +0200
Subject: [PATCH RESEND v5 2/6] iio: accel: mma8452: Optimize struct
 mma8452_data member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-mma8452-open-drain-v5-2-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
In-Reply-To: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=982;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
 b=3wdjDbaECj7qwSx5YqQUQ7Wu/8sblcFKkDzK9/pPnaquhxOvI0yNsjZ7aYFJO4pZNQpyoyIqM
 ZA1Yy8v83fcDIsJOb0vkQY8W3nGfEsGk4kNlYpJiGXSYpZBLmr1/CHC
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Reorder struct mma8452_data members to avoid holes.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7d683686dd9d..f645a5c6fd1c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -106,10 +106,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct iio_mount_matrix orientation;
-	u8 ctrl_reg1;
-	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
-	int sleep_val;
 	struct regulator *vdd_reg;
 	struct regulator *vddio_reg;
 
@@ -118,6 +115,10 @@ struct mma8452_data {
 		__be16 channels[3];
 		aligned_s64 ts;
 	} buffer;
+
+	int sleep_val;
+	u8 ctrl_reg1;
+	u8 data_cfg;
 };
 
  /**

-- 
2.55.0

