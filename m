Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889F32ED20;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752537; cv=none; b=RTszbbpwxmA0vgBZZrFIqW7yhX7Pm/TGP0fm3X5CU3t7pu4Ihu4rUc5t5cqFn/x3mNuDuhxSd/0kYUu8tK7rQvBecuWbsEccWHJApuGGQ3jFMJmq3v/z4Fo0XDu+g4zQOoy/78KcQnyUnQqoSwHiTXhWWHyJpKaaO9cUc4eIeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752537; c=relaxed/simple;
	bh=plu/6l880qGIQgdniL/wvPRi4bACVp25bpy4r1Bt1sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRXi8PWI/X3AQWD+hay0lHkYCZZ9BOblbEjnvmt1CJJPyhbwK9UFTrAaeOt1SMxchnhOokrqASDuLqyVdHdH+8xhbOLA67/z4iKXZOUYa77JYh7GZBhB3C9+GSsjDWB9p8qziRLTEhjSa+mXstsBSC9gbPk4V2fV2K6nAb+Wmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYHjQnQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYHjQnQE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09D3C2BCB4;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=plu/6l880qGIQgdniL/wvPRi4bACVp25bpy4r1Bt1sA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EYHjQnQEi1zBvwt6LEkP7atxc9JDryypFx8EyTLYFcJblPOhvHqxKt/5mod6LRvU2
	 vzSVjAiL24lu0P/jWDqfWv293oMnZ5hIMyfR/SCsEqvVQqPSx7C56XNrpvOPwnG7mc
	 I+liUZQbN6txHRGT5A5S5ab2MEQoSBcT0/QmhFBFTCotfHOoG1b41qGIjBnsP07f29
	 k/26dMGClAvX/+vVg20nYCN2Y587vNnmzfxPxdFOmh29gE0GpURj8gpMMzfHXzoLxS
	 cxQXfwLOvonbGm9PB3kHGI/4G3iFp/+AHPunZM1MPA1ywfQISJM71OKa3UjO4VNr9q
	 WyoJN/UmS2CeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863BEB2706;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:05 +0000
Subject: [PATCH v4 05/11] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
In-Reply-To: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=1203;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=N6wBoaEJ3rmqydikLPLchURyMnpaauU46yNuxPpxMDc=;
 b=DDbvkrLSZsTZmjyq6O/UnXAl2NDHW/6mwqxWsoQ/yhH+wwDAr3xNaWAaazh6gGWyRgrlgPi1j
 tFzsKZtxU3JBeB5JbVlzKHWpMrwVDsE2ylSCtdlbZcdmNzMB8x8L7jl
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Adopt proper mutex lifecycle with devm_mutex_init(), replacing
mutex_init(). Also, Include linux/mutex.h header.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 3456a31cb1ee..f0053a09cbb6 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -251,6 +252,10 @@ static int ad8366_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
@@ -259,7 +264,6 @@ static int ad8366_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	mutex_init(&st->lock);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 

-- 
2.43.0


