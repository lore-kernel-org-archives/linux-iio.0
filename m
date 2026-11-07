Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089708;
	b=ClTqW6EG48Vm7xAYV11sgJrb6qPsUw3GW5LraqiFCKuoWWybDAhEiw6RsdiTZ33qqJ7p
	 y81ykYJohZjxVGFFRTBGUT30jgq1/KrNygd6dVrBHN83E4vwfdBDAonI4BSNorTg9eWLF
	 d1iGQqS+Wv9BWubmuT8eu/CSlIKWZu4tyjIhiIl0OrIYvcc7woq7MXihvJt60i6W+Meb9
	 yikQ0jjfDJ+oKa9LydJ23W2peWtzob5FgCVFgSxF8kLRFMVwK/N7n9x61Ywl0AyAy4Rcs
	 d7p52svR+jrkN9UJGywgE+eIl+blh7raAOmRITm5VWShj189cTzWMs1GzO7pVZZwJTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089708;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R41m1RfyOsbYcj9ik/CD2n0LFKU1CRTt97iO/p2LpY0=;
	b=aKiORv/ERsPsypiQvsRabsbucJObJaHy4fys1TdMFZxJEYU4ZdcrAEEFiowMp/QgSErI
	 UDSGUgeHkhtr3Yi4hGPzNuwTnc7TE/mnLmbG6WUiba/0CZkYeSZ4h5j6BZTmEwc+w+nY2
	 nKKB/LqZYIYBIIdzLMQ6tIRunTkWoAYB67zX2CX229hLDkB83J8t4aNkSqDzUsqeWF6g9
	 54Z/dw41F4ZQidqAbwusjAnsRZlOEpdJc5wbWXitW29R1OTpfgDx/RC6pkzRuC7nhja+v
	 4TEEWPpxEee16RWr1++m9y6FRRKuo9/Ftjs+3yq+DvD3X2gFsL9HI8sReN26cUCMhNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hydPMooU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931F606D801;
	Sat,  7 Nov 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hydPMooU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794089707;
	b=c4ztBDjh6vTaN6R/mGxo5L3wZzAxqzrfVAtOft6S6+GXE8zgkAR6vHoIK1EboIq4zsfe
	 IalNURI6WddtitpVPWGsJbQtIB6kfvi+9PJR20Yopac8Tf0UvB5Aw83lwRNCdF4VPoiRD
	 BaRpbW/pTAzQ4yAGIO/SpMp7SMgV0el/QsUz/g2sjVSKoQCOKWJ2kmzWa5LtNcXBGaEZb
	 JLMgFhE5oeqUqznC832XJWMKqAhs+VARE6/7cAJ0kbCsYPZwa8itGVWnlGsbU82SfZzuO
	 DI3CTSuEs4FsslrK0791kY+zjZuYz5yze8T02UECfbGOotd32tD7uZjoT+EJskbH5FQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794089707;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R41m1RfyOsbYcj9ik/CD2n0LFKU1CRTt97iO/p2LpY0=;
	b=EQf8DyKxAOPBToFDaTi/OBeP/IyHtk9Uq978aohpbKkwOpkpIWkMFrt5pjNWPhp/+NxF
	 6fIUS4cY/LF7btCNf2LWYJGHorulWt4at3vr/lht7gXn47I0Q2N674Vh9Trh8QbrIvub8
	 DIz+DcU62i3dnOaQKB1uN0L3awO8TezAKGjAdiJLXT/uyjqUKXMguhopOXIkSsEYYMT7a
	 w5ZGNMgBJ9K4gq16F1cA3NcyLD3totsOdw/75S0IZMh9f+t0VFyqwcuSQbl1NBslZlohH
	 MvwmypGB4hjITsEJTQIyMV5RI5ASX7cV48BUwtIiOxbdJO9XW3DMBdv4uwdgeWxYGfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5D5C81F008A3;
	Sat,  7 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089706;
	bh=R41m1RfyOsbYcj9ik/CD2n0LFKU1CRTt97iO/p2LpY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hydPMooUzbHGRbVEC9TmTbFPXNlRJUThkbDi88sY11Ti3HDVX5TbLGu5CNIQ+GLXJ
	 e+bDlHpyYzRvP75l+/supOekI/xmuZy86ZS1kaDsZRJDyAYHoPgJkR9SDu+wO3V9I4
	 vZoy62NMn10IAGFaIeS7PeeyLl7wwgRd1i3rnui2UXKkRa2pJw/gMpIHDZSCaiE4Vp
	 KGGwxFEflD51QByxTH/cVAu/QXADAyA9I0fG+JFhNzJV53f2IPIvOuK6OYouT5dg+e
	 SwpDiMQUNLISTWem/K0D+kKKNLve0mwVWozm19rEZbXH1ZNrTDQO166x5TTzP9Mayi
	 bmrmByhG3f4JQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA5FB47D3C;
	Sat,  7 Nov 2026 22:15:04 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 08 Nov 2026 00:15:05 +0200
Subject: [PATCH 3/4] iio: light: stk3310: add vdd regulator support
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
Message-Id: <20261108-6768-stk3337-v1-3-0340c99b0e33@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
In-Reply-To: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794089703; l=1105;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=w804U03umdc3nXZE7jsNqEsJ+dWAgFZ1E0X2zGBKj/w=;
 b=XRZgatFrMMs1SZDMdHyCxHz8zpsOzMo/oFHRSR8U7x2jdaU7GBjuhFgfyuZqJEo1f0PnjZH8D
 00KWvfvaEQEB9yg71p999FmADDpQHKYUOza8RMXXB15FMzmHv4huq1Y
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

On some boards, the sensor is powered by shared power rail. If the rail
is powered down, the chip can't function.

Add optional regulator support to ensure the power supply is enabled for
the chip.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/light/stk3310.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e751e7c97bc1..2f4747c06f43 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -745,6 +746,10 @@ static int stk3310_probe(struct i2c_client *client)
 	device_property_read_u32(&client->dev, "proximity-near-level",
 				 &data->ps_near_level);
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
+
 	mutex_init(&data->lock);
 
 	ret = stk3310_regmap_init(data);

-- 
2.56.0


