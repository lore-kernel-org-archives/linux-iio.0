Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793836;
	b=0Btf9H2lT3bWgUfxRwA+6a2o7j0d5ZL6FyY/S0Q3VAPy8c6j+3OU2LOszrF8dkVyMWjx
	 rnzrVRGqi8xV6VeFBHFOmZFH1FRyuzD2Av4hcJEjmFjyMBiUknyp9uWhGt6WDFBKLis4R
	 tYFurTF46x4TnAQwVNTUIOEhSRlOPIsEK94m0yf/MSKvoMQI0R52a/jGFKTBCU5+fDqs2
	 tV7CJE/ryM/C9o+fvLf26xlogwVFlnMYd3GgGEuK+qop1o54AlKDHv5lvb99/cBxY1B/9
	 BC0Ii1mGVc7fRG7EKQ3rnyfAoqx2dWzIOcj/CAR9OUbcnNjG+L9G7ZS58K9t/ygmoyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x667OETHLQ5eiU24XMRh9m/YaJP0mqPvPFdZV2j+y+g=;
	b=Q1+Mo4Xe2xAWWNp5cf8iLaA5ZYt0nwuyP2lYgI0m+4SPDx5wjVlOsfTpeDS2MSBpN4yd
	 6Vz3mBYT4cfgyx5+Pt5xN68igOtdz9kd1aKXxO8BPsfS79a2AQ7LACQhrvMK8R7IAIawL
	 DMawUC+zBd1E+6Pm0exyc2UE6Pszwt2DyyV6CXgPpg/8mHhOCUrA52kieGcUgV/m3HHji
	 U1jI2BCPfyZjJrJZBRwlp8s9mEBTEQo7i5Uv/NYWqzLYUxdBUPJ/RH4QBBYwGmU97H6yD
	 YJbpvoFxQ0nhPM+Q8ejAlpICic5S19ynfCrwoG3GP165eOpwQzuv7Z2m+hDAtT4A5qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3w+FVDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C580606A331;
	Mon, 16 Nov 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3w+FVDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6E91F000CA;
	Mon, 16 Nov 2026 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793835;
	bh=x667OETHLQ5eiU24XMRh9m/YaJP0mqPvPFdZV2j+y+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3w+FVDn73DaIjMWAkAkWjlUmmnx5oiDNs3YSSk0iB79hwKvxDfbzn82cmtPOyyai
	 GP/5FG3YmCm5okQ8TLj4Rj7rb6fmOwrBaUG4QJXH5HRZ/KVECiBNpuP0LGUEgL2AQn
	 cYL7yP9udvzd50YZEoNEn+y0sZO3dt5TZripR9iY8Pwf0lXoO35gzNzQQFB0Z+QaJl
	 KzVjXIU4/7gohtlsQrPO2hWnwl5oIAf2bRLQkSnItcSX5wjr4dTAGsRvrOqSAVaWTE
	 ogBgr8KAt2q/xC8dpR0yQMNr7bAZL1kuuS1XsI537Eer22XfAlF2guIgudVf46qVrn
	 BJg3o1+YbGKZg==
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
Subject: [PATCH 17/35] iio: chemical: scd30: use default_trigger
Date: Mon, 16 Nov 2026 01:48:05 +0000
Message-ID: <20261116014823.3132576-18-jic23@kernel.org>
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
the trigger is set up.  As well as closing that leak, this makes
the ordering a lot less fragile going forwards.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index ca824436f60e..2710a3cf97a6 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -675,7 +675,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(trig);
+	indio_dev->default_trigger = trig;
 
 	/*
 	 * Interrupt is enabled just before taking a fresh measurement
-- 
2.56.1

