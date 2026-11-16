Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793765;
	b=DUH2WLY8osaRvEQLgb/cAy6FS2jSShPK4z7zWJco90LZOjkcUEYTPSsYdq2l7hZQeZ5d
	 wfVBn+7TTTzSNgXT8OHG6cZP3PNaK9/8Etl40UPLDpleMTC07sAJPAfA3Njg/cYPPj680
	 b5vbQknZok4qdKI3XjO39+15GMh0Egd12CYaZ0OwMJM+1MCh5oGmIKif7UChWLLW6Ey9b
	 J9uOI5ZbIol2olLE+1QeH1deHpl+yL1uxIENcgiWi3/rn9DBASm/fMKzKzAGgAV55fnHf
	 t1DAFGT77GEFh7Oh5BLLVVyS541yEQM7QYfRzxsLwOip7Y8B8QkSBY2lswZKhFmZnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kkNE40hLGqretxaXKtWB4tl4n4tILJzps480VDxvOao=;
	b=1MPoP68slfdtD7V48YKtonX4PyxaseZ32KBPzYn5uAnd0bE7XIq+uaLA0OMGFUb54h5f
	 rAGSSGH49lPLs4BMM1sDY6Sp75Gu6nK+NUtrJQVC4wS/8XNPKRl7pImjSppLgZ49HLhDj
	 vE2E/1K8sLKh2yBwIsUZbaKm1sMm4+wzd/FRpRTyMDrej1ng60xYHgaCLdxISlaCXrjV5
	 JdownXiIi1SeKgUHH4GfQz9wdtshh9KfbON9r7mY3+3f4UDGCSzXjXnRPau01iuy1xk5r
	 Ex2OfXKwsFY9Rb/DKREUTRJBXBi91taP8osIlZ8CPn3OYgvXUCWo25VwJyze3D0daUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kO7jTsRE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C21606A329;
	Mon, 16 Nov 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kO7jTsRE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4AE1F000C4;
	Mon, 16 Nov 2026 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793765;
	bh=kkNE40hLGqretxaXKtWB4tl4n4tILJzps480VDxvOao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kO7jTsREimhxEKsZZA37BqHC/+pdpsVaduMHliPvI+DSSn3flfbMcuN7dAoeqqT5g
	 MJndgZHMg+An8oo114sMZ3AOuGw6tu6ocW8t3j6xt31/+wqXFqGTDeG7wLGSs7y++L
	 M7ZE0SoUhhQcpLDPfO6+OdaFGt8XHJaBsrNWF+P2xQi9u/Y33Sq2BsLXhvR35oreIa
	 uP7bmvIo/5apIKeU7nGVA3m21x9ydb9Cjz4cHTu4XwvLSLqJhnJMfcheaD1J5YqYFr
	 ZrtOUPWUM/tPvXr8BoF4YA9gLdrAexlD5JRZv2P83+p8BHPrX03lZLrifJXUB6gBtL
	 ZSGzY2Ukrhy7A==
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
Subject: [PATCH 06/35] iio: adc: ad7768-1: use default_trigger
Date: Mon, 16 Nov 2026 01:47:54 +0000
Message-ID: <20261116014823.3132576-7-jic23@kernel.org>
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
the trigger is set up.  This avoids fragile ordering requirements
in probe().

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 3972821c295a..75e62b872925 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1505,7 +1505,7 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
 					       &iio_pollfunc_store_time,
-- 
2.56.1

