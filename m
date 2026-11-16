Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793857;
	b=oGED9vDkb2BzuGlg2RIM2iNycfdV5cCzatEOnzf3CF0RlXnf5Cv6Syu+eBASMqPJk0SL
	 nvzZaVkVUIXfQ23TYhDY+j8hQV40DGlTXcAVuCE2i/oSeFcGGPgEzOBGI8ml6rVEkFN+D
	 A9D6i6zprQuvLQUmuK2tJsLjVzHV0jgkYf5YCG9FuszuodURcqhq2f9moCSzBICe7zNqb
	 7BjyiYTx8/niVQogj5fvInbuh5bgDGgsmfrjDpkf7qQVJ4EqvJexuqUORgt8dIk6fhXF+
	 gQa9mUBZ4593LqzMO8u1buDAfnIUIry8amhaVWokUoO9kI6ZEy6AGcMmNIAQDPfvO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q6rimdFgbdRKSDBloeBN+8QLfNBMY5vJUZ9I/FLJUTQ=;
	b=fZD+3+tNzlUeF73lBDc8Iqz7eGlY84Z383usBam3zsF/pyVinep2+pQpiZEPXAyyEL6l
	 kQL//mxzeyu6Y8zmBW+ut09LYwuWSmapLPNc73KEUO0vcAasYQtnMru+umlYDyjmmnvA3
	 piTf9UFdGTt0QjAINfk3wY3YwA157o/i0ULkYQ/8U0Lq7KUINc4sxnOY5o+dMCri5fFvv
	 1Cu6t9pk4nH8d8YiSL/cPNAm4q13r7UJIO7LVuQpdumLwEAWxHODEc17ziJCUe5kuxa0N
	 CagVNhVV099yoM4YMPBZj7mjorCGWebyRk6ANWHIQ/H2Uw4p48vqt4hd9L+PeWF8c8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzVfn2YY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD260A6F50;
	Mon, 16 Nov 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzVfn2YY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A1D1F0182F;
	Mon, 16 Nov 2026 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793856;
	bh=q6rimdFgbdRKSDBloeBN+8QLfNBMY5vJUZ9I/FLJUTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzVfn2YYTmlaEvMKa/pYWuYWIDSpSxWxs0cXyXbKCUZi4mP05RkmCAsoMFPGvuIpJ
	 xjfcAVc803JlcubeymWxKruPQKlzecL/En8oMshVMP14TRpZBPflw0aMcSLd5oZjec
	 et7VHOu8l5OTbIDAMq5H/LVXmDxPDaRkY3/7odusKEXYyxpnWEBcsPw0FM1ZCKwOou
	 e+da9da+kWsOYK1pghpoPon6TwTi9w1cmbk4kMovywh8O5Tzw68cNVBn1okXQQx8cE
	 18ApcNBy/3E/DUZ+os5KMZPzojWoBob/UBmDRmmJNL+/+JUTAtgIbR9pTmvTVxNIl/
	 NqQ3n7kwqtN+Q==
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
Subject: [PATCH 33/35] iio: adc: ti-tsc2046: use default_trigger
Date: Mon, 16 Nov 2026 01:48:21 +0000
Message-ID: <20261116014823.3132576-34-jic23@kernel.org>
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
the trigger is set up. This particular driver has ordering that means
this leak doesn't occure. So this just removes a fragile ordering
constraint and enabled further rework on top.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ti-tsc2046.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 125f6d7e2d84..7bdeff734506 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -805,8 +805,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	/* set default trigger */
-	indio_dev->trig = iio_trigger_get(priv->trig);
+	indio_dev->default_trigger = priv->trig;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.56.1

