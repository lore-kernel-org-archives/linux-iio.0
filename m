Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793848;
	b=CljmbKYGpIan5l0ByfOoo56kFBOK4sT1Oya/RFTjYmRqjzp4InzMKWIeQx3HKgDtqILz
	 zhQ0SHIjREB+ap5RKNsWPFI8FtK6SvfVcWTQuEQ4xI+rBKyk03LgpX5hc/ed9orc0bVvj
	 /j+NuATas3xnmvOr/n3Xja9+rHRDbO5pugQBmBXNbiMJzdkIcsI1CE8BeXxOOIsqVY2PP
	 4Bip6pQ9rZlvuOHl3q6T1XLSHwXuIhMqQGjwYAyzxZdiE0vSVk34seBMm+ZYdAdZd6dTk
	 c8j0aiURueVG+MRfHlNUe9VdJojKQwkGnL7n3CGGc37A0Hk5xzdb1DOhzG+59SnG5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nZ6NMqTef0qGROEviLfYHdCWVArz8lChGLub16DzNzw=;
	b=xw5mLDuoILOBrotLJxlF4BQH2kcvMOCXM5b1S0XcnYBzcxQOnq24Gb3zBo3nqcvUdv6o
	 Bxga+0AqjlF4XnGNGK1CyA6Z2+8Ci50IwlHJ+BckxT8kv1zbw3Hzt2KpVQdGXzUvCBZ5J
	 xncXK2+p2AyTPlMpe4qo4rB5OG7QF3wqESt2ZU9aT9YAVhtZzVw3nSKGAsIZk6JRuDxVR
	 N1/wBR/yGRpykRHVlQy+tdkHeuOwh8KD/qn0C7kFHhoM3ZeFsjl+ENFSU9uW2pK9WQfO0
	 K98N/SPVquOYAhhix1Yh3CbI1ND2FPub/eF0BROlQQY9TWdjzIWYWfrL/BEaBnpT6Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsmURwN5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24646606A33E;
	Mon, 16 Nov 2026 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsmURwN5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A2C1F000CF;
	Mon, 16 Nov 2026 01:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793848;
	bh=nZ6NMqTef0qGROEviLfYHdCWVArz8lChGLub16DzNzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsmURwN52Xp76zxQUUnmtgV+syaLlSt5VBQMZ4Ts+lkFuX3QgW9mnx1Dvy1if0MPk
	 yRshjBc4u5FnYWoj1/Uu1gEoqlormws+0bRzmb4PSelr1912OISUzIWnaBv4WoI/+2
	 TzHL5SlVaQpXjY9lBMe2fBZ2rNXjPCDsfMO3HlBMNjFiDKCzE8Igh/6xgvjzC2qu8i
	 u1UK898BsFIU93XwuBC0bx/IlARWUkdTw7JH/izzJP8qAsYkiVtTSLLjy+TZmXSR4t
	 WKuslVXeAUpM+cAWFzh7sFv9IO5XtQrxV5/Y9uK9ScRZLyUpBNAsF+JDCuO5XSHCoP
	 Yf/lIHrRNtbOg==
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
Subject: [PATCH 21/35] iio: chemical: ccs811: use default_trigger
Date: Mon, 16 Nov 2026 01:48:09 +0000
Message-ID: <20261116014823.3132576-22-jic23@kernel.org>
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
the trigger is set up. As well as closing the leak, this should make
the ordering a lot less fragile.

Fixes: f1f065d7ac30 ("iio: chemical: ccs811: Add support for data ready trigger")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/chemical/ccs811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index d126ee12ffe5..ad3266444aad 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -502,7 +502,7 @@ static int ccs811_probe(struct i2c_client *client)
 		if (ret)
 			goto err_poweroff;
 
-		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+		indio_dev->default_trigger = data->drdy_trig;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-- 
2.56.1

