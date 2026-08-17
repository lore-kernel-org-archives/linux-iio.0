Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70946AA92;
	Mon, 17 Aug 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987246; cv=none; b=q0pMtjlCiJoe9nMcVTfPX3K0MW7yYSnvbSLiy1rJe7cgO8iHkCZzdIl8C7owJQLW5Gs+4r5rR0zisBkcCdUOpchFkgrbM7imfMh6n7dC5265/O92jUgj+veg99ye2y97z4hkR2V9sPldjXG7m2D1lMl3rbBz022D8myar/BB6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987246; c=relaxed/simple;
	bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQHifhSrL59glmvU5sfCSuJukHR2dWVmZdnYFZfAasP99mPIhyy9JD/8Lmt+bXhfD6IOW9lMEfglxiSwTeaEyPWKl/rMT5kkFrImuW8tN3IWyyQO7zRmtyps4N5n3d7Zb1RP65+9eOc9NGc4+JpLWwAFMG121JHCHFvc70yYUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BFoQwpLf; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BFoQwpLf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786987242; x=1787246442;
	bh=XJ9dsEYOltvcV8dNsiIVCzLj7uR8oL/YLG98qkFwY0A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BFoQwpLfxIqnFlfrIhO+sgn1aAVJhCQCmTqI6ubDKs0wf49RRD2EvyxMKkWWA9nmr
	 TtRToJI9bJtuoma15KaAv++RCEalZbrOA+0mecbqj+74sqyJN2IIepG3s+YqLBaO0m
	 Ozc3dWH0XMqebFosPHO+bFlyXhIiOoIGa0DVyf0vWi2S+b+hqQI8wWpOj2Q5sgXiIx
	 xAr7iSQg4j3qqqPvULOwBll9zkYgi3QTaibVsoytMNi4FdgL/FRekieqIzoiJ8kXsc
	 lsOycU0sCKzeCwVKEvMk8rtF7+7jZgzYxdGPpXO8qVBU+htvSZmlOMX7iadKffgThn
	 6TOhiMjepC7YQ==
X-Pm-Submission-Id: 4hP03D4DvYz2Scd3
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:20:24 +0200
Subject: [PATCH v5 2/6] iio: accel: mma8452: Optimize struct mma8452_data
 member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mma8452-open-drain-v5-2-e34e872d7d57@geanix.com>
References: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
In-Reply-To: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786987234; l=982;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tzfxlXisttEhbwqNjklxdIHoQtWVVaaErftAi88NK6M=;
 b=u1EW4dFESXTsJEwZojlLWMj3nD3QcypxX7Qfd/c8tRV2WVlycm6uPke2Un1KEechNN8WT37p7
 5oMC9KH0C1BCtGZRkVdtOu5yMGJ2zKPzRq79eNDTdIVfwTOkQmWcsb8
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

