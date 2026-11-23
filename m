Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440348;
	b=bWmXVqZgOswgviQr+ub/K0c7xSp5Wp0EWAoUZG9+79G6Y5xdgk4HK+tB0jqXaDVJXhnU
	 sR2vzdsV4Qj3nxTnq8kzMvSx8nysC7DDve0eBdrXDIKHkjj+8vDaA5TueAEB/q9dfK2NU
	 mzWhMxIpLTzSmQz40vrrgHKWHkV/6Yfsbbpofy6Zt+wiXVCERPoX+VcXdvw0xsf1FKFv8
	 WbswAkemfNf2xZ6fN+B6vTna7LWab5BLoOp1iPYuycxYheMDYKqLR1+mjI6BP2w48Eu1g
	 yZJoro0NshykwPD+ftApYkHXQZBhrJ3Uyp1rjcsfRLr73oWvUdkQwvOK2ZSpFeWVF8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440348;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iaQa3pwKeYgyE2VR0uPIpJCMq77PFHTi19WKazaWpyM=;
	b=r/XJ1mY3+g6I/xiKnCSJ4diqdnDBi5z7zyuNnsClY3JLW7ClLQ2bthGUFUn24tj2Fspw
	 33mdm4AIQTfB+a4vUTO2Zv0e0ji6Nj5CWmI8oqPeDyV2menlV3auH2u5YS/pmHA7d82Rp
	 NLYyfSGLA97pjOt6SOdv+ngSGxzM4Ff2XsWfgNsNPzE7iLX2ctG5NftTIanJu6ux4Gf4u
	 r8PfI/ZqQmz8Z9uN+Zh0JtP+VDuGCGz7j/cKqHLaUCxr5PQvqshMJeNDRaJTEeARHg6FU
	 xftsdj81reL3PGTZpc96ua4oJjxEsFrAuURnvvHxBWmlS+o7RrdZG+aphQI4SxLa1DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKfCfl3X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B160A2623;
	Mon, 23 Nov 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKfCfl3X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440348;
	b=mjGv6XBSwnJWCpYGFRSM/eCtxBaNBINSGk2bqMHub2GEnZgHsVkWXM7P3eKiDMbY8DZ+
	 13QbYhU4MLRC/vq3zaMVBoWQZJbmY2sJwqkVQIzTSaIKKN3QkCSz22uOLsPnd2F4oXgVf
	 iINmxoIvqN4KaXMHzUc7Q+ayg07dxpCF8JqIaUPzk3l8zjCwLjlzoYAPgX18WDVWPVlIQ
	 FmS7Wh7wUiNbjESZKqiZKqd7WEn7t5ViLQGrBmd8zCRgMtC1PXW6cs1k3+z4mK+iykLfw
	 tecrwUQggLT6fghVc2ZExyFJX4jnE7+I6vKwekT/ktfGrogLwh/hjL4feKTOQfTQT1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440348;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iaQa3pwKeYgyE2VR0uPIpJCMq77PFHTi19WKazaWpyM=;
	b=TpY5KKsCN9waAnQfuGH+CAo4jCnYz51ozmoUBMAk67xZBUTFJAjsnWjvp2c/l30m1P4+
	 4nhbt6ukdq6y9hOSsCtsS7Z7obV3KHS/g3ASw1PB1ipimjvMedSPdWDNOayzYynF5sBzx
	 hk3OflJdpS2RiqLY4Dq3eOOjdt2lPlEmqmcwwTA764DFc9eXU1IcSJ3XHrUK26qAJ8+U/
	 KITKfUylNizu/J7VOL3SgCv+mN4xzSouaM29yvIcaSsL8HVvkE98lGKw/fvsMcJEO8Z6l
	 W1Y9ojCuo6RQsuIlR6pXExYjTXtt2nKVKEF1tAgSqKKWXmJQEPhkpRxlguEebtbGPcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4224C1F0093E;
	Mon, 23 Nov 2026 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440348;
	bh=iaQa3pwKeYgyE2VR0uPIpJCMq77PFHTi19WKazaWpyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PKfCfl3X52bII90lC+ZMzSzGkSgc08Gs+qFg3TMKS+WJ8uBLRN1LqkvR18xhsQM1h
	 9pBCap2O0syWefmkIJsy9Txj0IqKLb1cSt6htZ6Vh28+iKWF4mSvoxzNEmyz9FBzsz
	 vLig0tMkcUsFnpsyH6A/gp7q3Atlk3nipC2ux+tlxZeljWT/7GgGZUSCRLRKQf3o9C
	 a4zEf00cW8mWNpjw7m1dj0OhDwRGikOK20f+98b+r4wEESc17wk/QJSDU0PkSTmj0H
	 Yn8/MNPNRZH8Sjrv/ktMyjN3rAKuC1/Xsnvg0linelBfXrhtSj5Sur6/nrQ5GZQSSc
	 lY8WH06ci0D9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB3584C4A1;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:29 +0200
Subject: [PATCH 5/7] iio: imu: adis: Drop the FIFO handling from the data
 ready trigger
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-adis-fifo-v1-5-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=1449;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=pD142zB7Wg0nJ7TAd0BHg7Du2nyR0gjUnfAC77rMuLo=;
 b=IceP6S+oYJoHgGh+eGQ1OguL2IPkrHb64sDsGvZvM9LE5MInLfTXvv+pFIcOjxbbCPpVVvbkZ
 h8iLDGubOPUD447P4rbwF267neCJe6OK6BDCTblmlXK6FGSvTlrJxxm
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

No device with a FIFO uses the data ready trigger any more, they all use
devm_adis_setup_kfifo_buffer(). Remove the threaded oneshot interrupt
request meant for them from devm_adis_probe_trigger(), which now only
serves the data ready devices.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis_trigger.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index ea8661bff901..14d29ea60273 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -84,19 +84,11 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (adis->data->has_fifo)
-		ret = devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq,
-						NULL,
-						&iio_trigger_generic_data_rdy_poll,
-						adis->irq_flag | IRQF_ONESHOT,
-						indio_dev->name,
-						adis->trig);
-	else
-		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
-				       &iio_trigger_generic_data_rdy_poll,
-				       adis->irq_flag | IRQF_NO_THREAD,
-				       indio_dev->name,
-				       adis->trig);
+	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       adis->irq_flag | IRQF_NO_THREAD,
+			       indio_dev->name,
+			       adis->trig);
 	if (ret)
 		return ret;
 

-- 
2.43.0


