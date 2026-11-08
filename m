Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174251;
	b=OuHTh61cQVjM/8HtNdyk/+zHPTFPcilveAOttqF1conLdncS7HjjvIJz2Kn6TUx+fDWB
	 LpQzurNkpgJZswijT0Ntt7nD1PuzFNWiveqsZupcUSlhNuI1Gwzw6LPagEoyXl3dBEeqr
	 Li6sV89Cd3xLkBtMx7Ru3G+h8CrKhFDhginFoO6Tvrpr0FClJC2v3i0og+mPj1n6Nv7BB
	 2FzSc4KruWaXf5r73A+Fy1ZecyfFtQmJnymeK++9J3+FSRfSiaaHR9zY7mUTX8poOUmvV
	 oMb15Nz7qJHAip8FSL9VjYHk5PV0NBki0SbI8GHsCFVP8G/Cp1cG0epj12eYIlkjwDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174251;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+7EnpzfX2KOa1mZjmJcNbYW23Bh0va0lawY7GL4Fhcg=;
	b=bDiK7LO23WKSCftVxv25Dc3pJAkeZh8+34CS/Hmfwh76H4g7NeUDe1eVZQb4GodcbxK4
	 XaHhfuOBlyHgXVc3dt88Jjf+yDNb7E1Bo/Ts/M4D/4szzVnToreGEp5B0hxYMaHg9RWmT
	 emVl23jyMoO9m9+Br57k/WB9LGtMmIs/Ro8vztD6IO05mofco6sZUqkGH6dIQkRk8zeIQ
	 Wg2ra6Boe+9ye00WrnuvMJjTdq/oOfWtX8UFBEcofoL3wo3nMVE28qeAaaF0PstpnkN2Z
	 rGQ+djdvvBgbc++D7IVW0b5s8vQJ/kxwausfD+m/6t1bnPh3JvhvuVhX7OIeUxGhQjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz4Apue0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC4606A325;
	Sun,  8 Nov 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz4Apue0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26641F008AB;
	Sun,  8 Nov 2026 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174251;
	bh=+7EnpzfX2KOa1mZjmJcNbYW23Bh0va0lawY7GL4Fhcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kz4Apue0LS20AZbZylzGxyl9zconERifjTHbN5wyaaYYRVjahsqvi39qCNuHpBEk1
	 4PpB/+cesc2eJqpgCRFkZa02g5BNfq5j5uzfDMx+kyblgFRk4+WLlcG8ESwTQ+irSb
	 GHO74cAjkaSzI4C3DJkGJYufDFC6ZSI4Wc52X7RE47HUwc3g5ndB96F6oR8q4Nl57Y
	 7d/dxYmR78xJZ8zOurDbru/XeHiiBl74NkGK2WOGHVDVFccTjaB5yF5L5G0oZUrk0Y
	 M6FoKDRSadoIWGduhIAh/65Go3OQA8N4r288WQhywmLt2dFRWAnyFWPoxB/p4Iwn4L
	 cRc+GYvIIdi0A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 22:44:01 +0100
Subject: [PATCH v2 3/5] iio: light: gp2ap020a00f: Enable the VCC supply
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
Message-Id: <20261108-gp2ap030-v2-3-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Enable the VCC supply before accessing the device. Use the managed
helper so it is disabled on probe failure and removal. Let the regulator
framework provide a dummy regulator for an unspecified supply, and
propagate errors, including deferred probe.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/light/gp2ap020a00f.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b435dc5e8706..dc07d137f084 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1414,6 +1414,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 
+	err = devm_regulator_get_enable(dev, "vcc");
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable VCC supply\n");
+
 	data->vled_reg = devm_regulator_get(dev, "vled");
 	if (IS_ERR(data->vled_reg))
 		return PTR_ERR(data->vled_reg);

-- 
2.56.0

