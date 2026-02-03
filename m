Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3C3346BB;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=P8+LnQxm2BZHM2/wOEjzx+ZpcqgWPiFllDzX2SrNLNL+9DKhMHIZrTXBDKu+f4zKfv1AHZsbH4RxoRuZSqBtEBRmnce3qhTN7Om1WC2FlHDyYhwfT+DZllp95g5Ez1IPe6INCDyOX/jfN4V4NaJy1l5900J8EF+hTXre3gySEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=o2vrpBmE8UUrNQuSszq90H8TSetzuxSfZT1ZPkryBDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcvg+Fb0H0qv6hI5xcEvCcRnMlKJoSR+7mi0NX54cJL4/Hp0Dbr60pyxAlFdzZ+uIeu1IEbK6H3R6LHJVyBKwxuCFoKASduOltUl2klG95+g3C2uA1H3ZPXAzdutD4Dh0wch7Hfoe90ZfxghHVsi+vGUVtqpkpmITHPPtbRcQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2/TUqhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2/TUqhn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 555E7C2BC9E;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=o2vrpBmE8UUrNQuSszq90H8TSetzuxSfZT1ZPkryBDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b2/TUqhnpQHC0D8ucSkXwMOxeMWFEi/dZbBIbn7l4ew+uV79HhKfiCp66Ys4j9qjh
	 fFNUr4BrKgBF6T/filJVM85/SiDn6B8iZoQYhDuIjULtn0tQPXYZzI1mpcOL5XEK6N
	 9go1B0+GtUK2vkNEzgxzoyM1vEGiuovRkzmnJQNI72Kcc3nYTYg7/sQv71J/K52SFz
	 WxJdaoY1UkaBfW1dG42r4Kx+GESBnBCNl00IgOsTscYNuMeVs0R14lwmJDEVBtQLeN
	 C91y2sYGJbspKrd936NEWG/SCAf8Z+TVrUuVa6IILdfhCavYg9dZlcWHuHv2+fw2C3
	 I4gkdv/VQm/pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46662E6E816;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:09 +0000
Subject: [PATCH v3 3/9] iio: amplifiers: ad8366: use devm_mutex_init() and
 drop mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-3-5d5636b5181a@analog.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
In-Reply-To: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=966;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=i1uZPY/+9TFsjqSIU1LFXWflhkq05R0JInppwz60DI0=;
 b=XEQOgfJvTdu75yedpZWp7uhgPEHCuQp7kFnG45x0KqJp1Rz9hi0+ZlbTLkwVALJ1fsMzVuyj/
 08Z8XVNkGD3BYcjYh9P6ksLh/l8uN4/F1PJDkKgTdLU9VY5I3BOv4xW
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Adopt proper mutex lifecycle with devm_mutex_init(),
replacing mutex_init().

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d06ac786501c..f0d44f2769ca 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -255,6 +255,10 @@ static int ad8366_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
@@ -263,7 +267,6 @@ static int ad8366_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	mutex_init(&st->lock);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 

-- 
2.43.0


