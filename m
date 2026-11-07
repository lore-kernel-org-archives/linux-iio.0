Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094305;
	b=tGuUJNHu5VZi8iUN1azxGAlmABx51TMSQkblDbNGqbZmgK2vbAPLT0C59V5kco1Bvh3q
	 NlN1dR79O8iOml0lw8KSUFhZM4nexFGJbLc+pLDFzi3ZKKiqHal8ng01BVgFNy1vpUdcO
	 ZcxLJSGijH58l5Y67mxy/TbaAGqERRbmlTZz8besxijiSP1XDAbWyaeO8SBM8HO523y8G
	 fAWSexD/ZalwtubGunrZDDjj1AzNUTocbbDPx0wVncoJLCLwaib0rxLLZwtrz0TTY3ARn
	 AqiJZMsTwFPW/ccozSJODhaYr0ppy2C8m8erHwWs7445WWrgYjCjwlq11A3s4W4Dh7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094305;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=qn6+f9/Nw8yS3cO039h0iN1zCg9ZCL8A82qAce6YsHY=;
	b=bcvAm2cE6Dg5YXvjMQxqDxCTh0MXIwNX2g1dz+TD5je0joRuQmUCxDiS5I7XGUWiOIbR
	 x6tqvRdPtivEkXJPRF+w0Ys7+BUhFO4y+VTmW3Cw3pbN6sUAlSgpdvaal5t9t62k+tn5i
	 nwjGTUjz1nnOCK/fJq9S4gS4jHHnAmhpHXD9Qt2IBqJl01KtpsyIIB887gyN5u4utdPti
	 HXtFiMcDzqgEJN8KO391Z/bR0ATCd7a3ht1fYBS4FwTi6cewK3KqVAm4HtxGXy+bIW8N7
	 oA7ht3nnbwJ4etyMm9Cx9hh4QruCX/KqtfaQw9KraZo+sXPF28IIDOLagBpHkt78dDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLuAW1IF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BB606A32E;
	Sat,  7 Nov 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLuAW1IF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CAF1F008A2;
	Sat,  7 Nov 2026 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094304;
	bh=qn6+f9/Nw8yS3cO039h0iN1zCg9ZCL8A82qAce6YsHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TLuAW1IFg2jen5vcwanGawE9oYcLgnuzeFM2XTkqp0CtqyM9BBN6ZOxM2SIteOA1n
	 yghxYdLtTFEQBpRMycTcgk6cjoJqEnSAEJiqBjrEWqQEeTaF53WiTfkn7kA41pSfRO
	 8V9DmmhElAz9TZgX0raK2T9+RSoT9fw0FC3zfFiz1YGan5IBU7ujSZY0evKCOjDa9L
	 2iwScO1WJSxP91S/N0Cjg+SP3Q8kF9thpm3VcagT6YsLydt+rJ1JNIXrYNf8BAHbhz
	 eo75wucaN/kixJ6OfozSaw7+ryS/Xa3m34FC5i6TeDmO0sIg4gNsycJ8KiJhSDwlna
	 To1tfXaU6wKwg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 00:31:35 +0100
Subject: [PATCH 3/4] iio: light: gp2ap020a00f: Enable the core and I/O
 supplies
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gp2ap030-v1-3-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
In-Reply-To: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Enable the optional vdd and vio supplies before accessing the device.
Use managed helpers so both supplies are disabled on probe failure and
removal. Continue probing when an optional supply is absent, while
propagating other errors, including deferred probe.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/light/gp2ap020a00f.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b435dc5e8706..62c4beb20cce 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1414,6 +1414,14 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 
+	err = devm_regulator_get_enable_optional(dev, "vdd");
+	if (err && err != -ENODEV)
+		return dev_err_probe(dev, err, "Failed to enable core supply\n");
+
+	err = devm_regulator_get_enable_optional(dev, "vio");
+	if (err && err != -ENODEV)
+		return dev_err_probe(dev, err, "Failed to enable I/O supply\n");
+
 	data->vled_reg = devm_regulator_get(dev, "vled");
 	if (IS_ERR(data->vled_reg))
 		return PTR_ERR(data->vled_reg);

-- 
2.56.0

