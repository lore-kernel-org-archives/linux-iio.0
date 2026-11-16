Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793761;
	b=AmAstBVWrqnayShNOJBE8gvd7+wXWD40I+M4bfodYcCA15J8yJoDJKtRyt3Q3aUBTFV9
	 dsyG3htG3ZPSljhF8wsZE2Lh41mZ5S9/l1klO7u/eqv24NRry7ySbqiGKWKu0lks/oplI
	 btn+rEPIpcyEHhOj0GgYBc3j9SdZP95ZIQ14VXIe5TR/ulIRory6loCpobK9YoG6X1tga
	 K0r36uwpgciWsiUPH0XaeZtQsYFH5VpU5XH2y/cgq5grCNwECBRZzaj0VoWADBhqJatqA
	 mTFeN4llOdy2AhL/nJmo6Vs1Q5in4cygXfdriosuRSzsbPgoQyM/0ID+E1/uG6NTxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jgHjHOMHrYKkHa3noMARo2Ijk5usFxTcPVZN7K1IjFo=;
	b=DCyWf98/uya2aycp2cEvju6rck6ffaMIEqNXtXr1f9EexLQdYCWe/aSLYPXsvxEe2pMl
	 strSRhxjZSFvwHl1xb9AyhLzzMHlFVAkuSBIMjIX9lQAkovUueMx+w60kRlvL5dRRiIXt
	 0QXGDWI0vwG648vomWJ5HwqcIYRWmZGBiw2g65Q1NBZ63WJ1BbsFmxkoqnAkRp3qdABzZ
	 NQbRVr/D+FpzFDTKgGEDVJv97YAgIsluAzW/KagIcjXxanirqCilTuwJP3xN26zUm+Skt
	 jgDNUOrloZVIYYbA8Fmmo8hLLjDY69gC6EG+v3oy75y4zTkMYicWOWqJszkXShDTPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyGT3Q5r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D99606A331;
	Mon, 16 Nov 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyGT3Q5r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674A51F000C9;
	Mon, 16 Nov 2026 01:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793761;
	bh=jgHjHOMHrYKkHa3noMARo2Ijk5usFxTcPVZN7K1IjFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyGT3Q5rYNn3nHJcu7mx1Pt/WohB18WGzt1L+UDkUnC8gAadj9GWjX+AMVQ5836um
	 bQysZt0Ik85jcua356RLpPt5yJCDO7D704ueeJjdV6TwmUMbuhpAZRcyUVpM99x0LZ
	 /zCONVv6FjSRDKv7+ZagKxFyuqODWC86ylWMRJOINY7/eWARIomzutDetT5WypFowQ
	 zM+4PVIbJtQ8EoGf9+elK6zLhr6QCvj+JHpwRFcCar9MoYDRb40Qe5oj2UXR8U9Dyp
	 NyhkOYgLLg4zoYORv9PL4PG9eo7rtWNF0pzczzQgz2LgZDCQPIRVl59uuYTEcZYIul
	 B5EbDDv00kFMg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 05/35] iio: adc: ad4170-4: use default_trigger
Date: Mon, 16 Nov 2026 01:47:53 +0000
Message-ID: <20261116014823.3132576-6-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Set indio_dev->default_trigger rather than taking a reference to the
trigger in probe(). The IIO core now takes the reference during
iio_device_register(), so it is not leaked if probe() fails after
the trigger is set up before the buffer is registered (which sets
the conditions for automatic release of the reference).

Fixes: 9c1d4f4aef0a ("iio: adc: ad4170-4: Add support for buffered data capture")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---

This one is technically a fix for the leak. However I only plan to fix
it as part of the the larger set and not to push for a backport.
---
 drivers/iio/adc/ad4170-4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index f7757b3a931c..a04ab03f3938 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -2830,7 +2830,7 @@ static int ad4170_trigger_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register trigger\n");
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return 0;
 }
-- 
2.56.1

