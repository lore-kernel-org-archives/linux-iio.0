Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793830;
	b=XzwdyUBTvToJ0qWY1dSDsRTDKptpVUtWHrXl9tFfe3JrXax1bf/PzT6b+FSTx/YNSzoP
	 4oStPmhzORxVvAxHroorgw9cTv1hPGWy8L1xmunIGAqE4UVh6B/QzAXCngPAsqP+ldo12
	 qUEW9xYtDHzAZUyQijiBBCvzg5Hv9IjwUZBloxLJe2gmHURaUSUnCMSoG1tx0jZfbfLgn
	 7OjoXDz5RKYC0gOMsLsOVrq/5hT1zPBEihdAbd5I9P3s8jtlaSTps2YChNqYHcDfxv70E
	 2f2RVj9ZMdlLEiOzUKZoMDtIcwD66QMLTEwQa/4ZkKj+FmT35Jc5a/NqAHuzFDQnxDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IbBgTnZWi71j0RHkbBN9yvtHl5SKp3Gp9O9PBrzzwHQ=;
	b=CRnU04KO+9m1Rb8SEQvyycTtA/DmoolyAy9OKIgy7ywZe8+1zNSHmQ/is7voXFgPDJlr
	 GbFIBQ6lj6RheQCpPOgLTEEjeKfo4pWjq7KGVZNGOlvbSIr2FHmf/SxYr+BCDYT+s62HQ
	 H3ZY9M2s6cGfHBmxvGZi4Sa0hSl3v42L6Igl+V61i4qqU+6J12e+gzCQRqeffnXUuSFeh
	 7ZguanJRgWMJkMH+DIn0OQ719rYZ+OCynwvt/o3mYmeTLdCRCh2GXZThjSdK5SlI+6ZPv
	 MO2xXWrKS6wZNsMjuXplYP9fOmY8fweU9cRicnE1WkwQvVrvEhmcaAXFjamT4Z9qICg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4YclfdR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A99606A31C;
	Mon, 16 Nov 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4YclfdR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22D11F000C4;
	Mon, 16 Nov 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793829;
	bh=IbBgTnZWi71j0RHkbBN9yvtHl5SKp3Gp9O9PBrzzwHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4YclfdRMthCECEDxrSOmWPFziW6UVRE6R3jdsrb1tvPXv+XKmDbu9oeZP9RKlozY
	 YJfnXBDYxsxQyVgIPzIFYicGAnRqPNLYykEwB1lNiBqsWnCFR4k9SMGMpz4mNxFbqt
	 2xoJNEc6FQNUCqs8Kjkq/sdllgT8MNaBj3dxKk72ZFJdjUkpxEManZbPEUzXnWkko8
	 tUZ/lJ+nSoXlQ4JejO0kIOEGxsMgqs7UUz3MxQh/a6p7wWzKUOBUD2P+QTd+KHpNz7
	 hIQaq57ZW8fZah5bxguahTf9/tQ87WU7lG4Nz5ZE3h1iZ6OcW/BLOGXhV6XJbKeN3q
	 cp6FhxQeV7wWg==
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
Subject: [PATCH 16/35] iio: light: acpi-als: use default_trigger
Date: Mon, 16 Nov 2026 01:48:04 +0000
Message-ID: <20261116014823.3132576-17-jic23@kernel.org>
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
the trigger is set up. This also makes the ordering a lot less fragile
going forwards.

Fixes: 24b84444eb6f ("iio: acpi_als: Add trigger support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/acpi-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 9faaffb94b8f..b4434fdb561f 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -214,7 +214,7 @@ static int acpi_als_probe(struct platform_device *pdev)
 	 * Set hardware trigger by default to let events flow when
 	 * BIOS support notification.
 	 */
-	indio_dev->trig = iio_trigger_get(als->trig);
+	indio_dev->default_trigger = als->trig;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-- 
2.56.1

