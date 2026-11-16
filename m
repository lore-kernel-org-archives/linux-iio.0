Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793753;
	b=vHgwh29VXAs99qRWxHj++dXKCkPFlupW915M5Rdx3WvpWctHTw66AAuCWvG60+8v7/C1
	 4X5wDA3zrr3RLorrRoepwRpVePfb8nOmP8YeJCtXbzJqSJGia3GdMn9U9wydcqlgPDf+6
	 ti36hYHujimre4xinIQ/qttB5eYlr1VfxUgnEaAjYDbkugm/3xPm3XUmFuevYck/3qgbv
	 kf5evmY6iggT4RtA2pt+klO/xIl3A2Wz4X4STXJhE6LDwM3coZ8UFTI4/7bi5JwNl9KjS
	 reiuV+pysTO0XvT2aYmgDHnZjryUnSKH8i+W8Lcbq2NMniqg/9DykYzvuzTT6b8b2fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uRMIIewxVeu+ht7LO7h/BFu7l52guGdF1d2s1R6V9yk=;
	b=Uu77QdvNDJc8wSGQDte2nPrEM+lQy34kynO5SPWQx3QCJbob4AKcqx50zFkcpT4+qQg5
	 tB8cmTCQG4IHZqlsNKOn0f7UQ+eBG+TzwpsTnK2NU/xigfoFVI3zO+PL6lK2t2MW15ihL
	 XjICRLB96P/8a0oR0wcGznvNlykWbcnZEfoSodmIi+q7pHsXTG1E+UJItjqFml6lCRZ/z
	 pSeKNCfd9/+jt5khPbCdI1lawsBvsvMj/AuT2DU5Eq2kBHhWoei2X8yO7jXgSw9C9SeYl
	 RbOvr/mfFIumwaDwFpioDjQB37vxlc0TXM8duVQpC/+E6Jkjeyg6ZDgriW5og9eMp+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZosUqJy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4106606A321;
	Mon, 16 Nov 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZosUqJy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439C81F000CA;
	Mon, 16 Nov 2026 01:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793753;
	bh=uRMIIewxVeu+ht7LO7h/BFu7l52guGdF1d2s1R6V9yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZosUqJy9hByTWKMCTgYWdv/TJ0lEs9E5ChrcXD2W0CCAnrD4RUCngZpUVfcQ+YW0u
	 23r69QjPrbmZM8ozIT+XQAUwzidhq8E7onQ0VTNZfWskCbWvmsXtWcz00hixwljzev
	 cTmUKH9RVHF4GJuy/BYMs0CleZQsKqPiPfyUfqlXY+7ffsQRzDVtbEMpD3PtAo4uhE
	 y7rcDIcuVLrcyKR7bLe4DTxFbLQvLi02ravbu6ASnkmjvH5rqaJyZONAUuytC3i2Eh
	 yqPJ4HSitBaRZVi40EDXmfU9m20yvAN6YMPEXAEV4UWcCFl7DfPGWxh9zf5ZbxZ9FC
	 JabSd7smua9TQ==
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
Subject: [PATCH 04/35] iio: adc: ad4130: use default_trigger
Date: Mon, 16 Nov 2026 01:47:52 +0000
Message-ID: <20261116014823.3132576-5-jic23@kernel.org>
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
the trigger is set up. This makes for less fragile and unintuitive
ordering rules in probe.

Fixes: ec98c3b50157 ("iio: adc: ad4130: add new supported parts")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---
The fixes tag might seem unlikely but that patch also introduced
the default trigger.
---
 drivers/iio/adc/ad4130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 9763a811caa3..a8fc21eb829b 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1666,7 +1666,7 @@ static int ad4130_triggered_buffer_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
 					       &iio_pollfunc_store_time,
-- 
2.56.1

