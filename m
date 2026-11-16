Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793852;
	b=x+h7bDGkhwdI4Jl67rwk6fJPGW64dSyd4MgJHQQKA3QPjkj3poSke0se6mjBH+UN1T26
	 o4aqeHpVXbWcRXIxYteF8Mh/9U8gUUHCmELQzxBqoRnWLWOZZen5A4hM79sH/MWiyAfxY
	 nWui+4ROAHQiVw9jVL1tkVMIlleNyai3j3Ao0Zm3e0RFOHkv/165OMZzuu5VJKatuwbbH
	 XvbELlgDX2jQnOokRBgiRebj2QnQIKFQQLP/i5FMaSbAd8Sr75FAoKFxL5UbDpWS46Ppp
	 P3KrmYcX7Z2koeS6jcQL5L/XXLLt7kLd6pCXbalpqLBNQfNyzCmLeKRseAtUirLk+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mEycx27KMabktO1vMmgYUWiUXRqo519HiiST0bovNzQ=;
	b=rk4SYUKuGLT+9r4LeyDvkuGAq29FMjWqx+f0YTq80z/JVlK4DlzW64gACCm9R6VDLtoJ
	 FH/DpHQPj/krJRGff7ouW7PtgoDzE4HnGRs/mKYGEXwYkeBYCRttvI3HGWbvp7AwklJmL
	 icevBQNKEGpI2qzVwIJct2LrHl/RHQnQ4uJyhrWkTaffQoxAS4c08dNhVYqk/gc5Xm0fh
	 0MYFpzM/YrgNJF5rioqv30tGLnElGd2H0Pn5tMF4N11TQj9M92HIzy6PsavUnX0eTyco4
	 pipB1iHn3z+7q2/5jGV/yHLvq9L4EJt2sdTa2KO7LYjwrqnfFQFYUQZxATLwjUiekzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fg1B9wOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE960A2607;
	Mon, 16 Nov 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fg1B9wOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB551F000C6;
	Mon, 16 Nov 2026 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793852;
	bh=mEycx27KMabktO1vMmgYUWiUXRqo519HiiST0bovNzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fg1B9wOwwUN24ugXLVMJ434tU0WdboVNaGU0xT6hnMZwFj6A3NR8lqWbtL69Xbucx
	 T8yEncJC7A6sqPPWNjxa3inmGYB3JpRjnwAArAxQ8A9aV2TkoPqGp9zSeKMgwsmSEr
	 cUUR0UsMB9xARA5yKahwxFOhdHphviOjnNSBqBbpwDqv7BKIVpDrlm+PcZ+8dQ2mNX
	 h6jrToYwOyaZJgd3rrUQxMYKaz5eznstciFXyztkgDaf8vUw/ljtgDoh4LWZuPHokz
	 oD+jOmiQ7Gq4iPLvdwHFSYwxsqzVInnro1RhSoknRJeKwJhUNF1810L3AxtTt9twcl
	 IPo+ztJ9ef9Rg==
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
Subject: [PATCH 27/35] iio: gyro: itg3200: use default_trigger
Date: Mon, 16 Nov 2026 01:48:15 +0000
Message-ID: <20261116014823.3132576-28-jic23@kernel.org>
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
the trigger is set up. Whilst there is no leak in here today, the
change will make the ordering a lot less fragile.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 426d04d496b4..1b0f1c99da31 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -132,8 +132,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_irq;
 
-	/* select default trigger */
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return 0;
 
-- 
2.56.1

