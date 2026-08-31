Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06583D3D07;
	Mon, 31 Aug 2026 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178640; cv=none; b=BSNeZFyPn7MvcRRPTHtSxdIiETt4Unyz3tk5ZTgCamFt+RkPe/TPcXJufdtjIjfKhTZhzHz74Y3CEU5lBEhVO7Nbgx1sJVBTXNfA368CM68X5IP5ODvFSTyx2hLyc32z2J6tsW+FPv/PelXFY2cXQawVk3RSM+H+GOlhqM/0hwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178640; c=relaxed/simple;
	bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LelGqp9Ztg1jXVWAyiCqUFkM/C8Xf23E7J4at6aahV3Q+K9nenbkWaxsDK2DWqDmtz2k1sGJZS1mGzVILltahlB6fxLIGBfJekxXcJ/fC077klc/tEmQBnwVOX5E036INxdkksS8VuBzCiv3s7RDO2+If/bdW8AnGSSkPeCK/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fa2uKZV1; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fa2uKZV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178635; x=1788437835;
	bh=XJ9dsEYOltvcV8dNsiIVCzLj7uR8oL/YLG98qkFwY0A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fa2uKZV1VhrZvLVOtOwi/So99G3BJONP5R2rRg/0yt652T90fhNyBuGFFSVz/XIk7
	 GsHz2PaN1LAYB2BcixcTScK5PF6pQlztUT70QMSIdujoTuOUgIHdeV4rsdImc3Hx5O
	 5vorvnUFt6U+3OVxOe+SIIqMaxjf81/ho+Nayu/HDRnrq+wvtd+OxgPDLbjws/uiln
	 06iISNdJ3JYpdRUt+pvC/ousFBlNcx1abQ0A9dunZKeDIUlWerbPiwXRYQIu30w2yX
	 gptfVC+LZa0YLeI8sZAdc/2C6TrDc2nraSzZhAHF6E7WJydCTHBkX+TAL7cxpEzgPe
	 vLg9CInwWMrJA==
X-Pm-Submission-Id: 4hYSfd6B0Tz2SdHX
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:05 +0200
Subject: [PATCH v7 2/8] iio: accel: mma8452: Optimize struct mma8452_data
 member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-2-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=982;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
 b=4ZxL69DzkI2RHkWpBcD/Ot2C3VWyIpdquNCkx2UCMWGAkFDbn6WsbGShqxxzCRg9RAe72KVZY
 VrR64z9xdjSC6QOHKtd7yjlDzstZFyYdDGWLFzYZtrDOGAlAPpUOejs
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

