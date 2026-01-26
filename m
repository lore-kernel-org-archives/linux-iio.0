Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3633BBC6;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436113; cv=none; b=ghTrx5UfhU8V4d/9m5Mib9Rt2O9g4fsyOoWuQ6+IrJTUktoVhSoqim70Ho13P9kJBNOUY/KGMwZbLwQ/n5CIivXjjBSzqe4yVFNNzIvpSJWQ8GXLRHbiEFObk311WCfZV6twVrBNu3jAHwvnaLXosJBz+ezQwrPJsADk+DzdP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436113; c=relaxed/simple;
	bh=nTkWrIvUUzvgq/OPnvUxlYx4rVHLhmAGhazBXvRvIR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBqp/jrfGz4nl29xFQChrN7q2t7FjT1zpD2vHwdebbKUwE7he2KRdaFNsTlyfZH0CTmuVn1255kb1msqsgm38RwW8xCPmEaKL5qMmfz81lcblr9hYxk1JvLp4bn3h2KJVjmStcnzfO5dBqoyznsYS8qffsGlR9XpffMl/3Uh4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6vasYAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6vasYAz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9902C2BCB2;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436113;
	bh=nTkWrIvUUzvgq/OPnvUxlYx4rVHLhmAGhazBXvRvIR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X6vasYAzT8NAwmlHOMEYYbpRzBVpMtGOaC8jtB9aptlRpExSsetoWJS5l1qnR9sgA
	 9kpwhhAkQV14Qf7jjM4P2LWRg/fIS/voZrQbGoNdmdw1nH3hmEX0rqsonofOmz5HmK
	 JQYFgCq0tmyB3lEzGx+aVHaPFFilP5WfPNYRmmL9rfxvCemk72VoPUiHhlK8BWQvgR
	 ZyVT/sdgm+3O8hc/uviO1mR85b5k1FquLHzjjI+wlpxLK4yy0yLtQaExiL0Whn8kQA
	 Ri//prfGiQFOFFeXmONOoH55JLcZ7iUrZOqq6fYoswLwmtOuICYP7EobAjbt8F+g/x
	 7EmvMomJO9NEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A74D13C1E;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Jan 2026 13:51:06 +0000
Subject: [PATCH v2 5/6] iio: amplifiers: ad8366: consume enable gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-iio-ad8366-update-v2-5-c9a4d31aeb01@analog.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769436111; l=1405;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=hjO3AF8SajGaQsSNLm/TNA2Z1sFEVvdZwYSoYv5HFf0=;
 b=j0iEMbB69a495oPjVHQreEuRT6rLV60FdpY1TMMc9fs/WRw6oCZPCUz+Q+4AkqDn5FdECcaxD
 Z2bZqDHFNV4DudgdsrwluMu8FCMsOWQ2L5f22sR+Cl+pfU6YpaXdL6K
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Some parts may consume enable GPIO to enable serial mode
(HMC1119's and HMC792A P/S pin) or powerup the device
(e.g. ADA4961's PWUP pin).

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 134188db2e15..9ad6a628376c 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -41,6 +41,7 @@ struct ad8366_state {
 	struct spi_device	*spi;
 	struct mutex            lock; /* protect sensor state */
 	struct gpio_desc	*reset_gpio;
+	struct gpio_desc	*enable_gpio;
 	unsigned char		ch[2];
 	const struct ad8366_info *info;
 	/*
@@ -230,6 +231,11 @@ static int ad8366_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
 				     "Failed to get reset GPIO\n");
 
+	st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
+				     "Failed to get enable GPIO\n");
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.43.0


