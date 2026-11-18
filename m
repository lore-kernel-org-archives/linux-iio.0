Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009581;
	b=c3EeYZg78C+APCN03UmMTtIed3XeSM4rgfk1YZzCS2MvxozB7g2TAMLNsAPy+F/QkvQy
	 MvDO6Q3jKPfz+qCXOrvbMa8Bq4TMCs/9U2wkLvwi3faQUwzaKgWb7X2TqPCiWHjCLohyb
	 LV8EJ9ideuWlxD6eWNCRCrePwmxd/3MWxshiZb1ubnaBXLidLbF3iivJWJ140faPk1gX5
	 /gofeaniXU1X7838rRWKGgSMAlYziniihP/xnycWucP73Ny8Bn7tSMj6VYX/Q/KshGvzR
	 lU01QjbOF2Sy7UCX1dO0Xnu11BnC1xrIL68yr97rGbM9AhR51ohmh8hYBSWbQAmtU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009581;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=qnA86+AejLsPocv0BU0oru43/e+eqL5Csebwx1QALf0=;
	b=TlCbSB+g7EwKo0dWdKEjLUVfQIWTTZjV/l9oAS8x52573+LuPAU7XSIPiL3ZzkfAJ/vS
	 7w2qjXkPeiATN8Alb4+8AtpjXOKwN3xXp1w7MQ9CYGSNxARKyRs4KY38nPUYL+/4aYPGG
	 sdpu3H5C8UuYImHa2VyOVF6SlZkUGRai9rpNS61b5vUxMupOPQVJZ1xvE4Ebu6Bh4bUA4
	 mKkBgGax3DUOmGBOwsK43O/QICcLdYC/cRZtHuSfFotbZj4NDu70/smkeZDPnErAnvx2x
	 0YzHANU6g9TXYeei+9opQ0bi+KLD9zuBipcAoPH7pOdvjCWx7Zn+gjK8K+qnV75ItZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfWmbYkq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BAD606A330;
	Wed, 18 Nov 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfWmbYkq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C821F000C6;
	Wed, 18 Nov 2026 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009581;
	bh=qnA86+AejLsPocv0BU0oru43/e+eqL5Csebwx1QALf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HfWmbYkqmfZeAjjqnyGpiwAcftoXNaVmPbzrdlD/NoLZHkkehs0tL3HWrwNtBqZdU
	 wyUOqiC/dWh5gB0aE+5twy3Gv0MDLA+6OuTtoCO0t8NjI+CRsxO2/FcagYd+EZT7wA
	 wNLK93YFkYXRmWiYyEnMBhtteperv5ykp0rG0kMs11S+jYPl3pXMCs8Oxkkb+XENsn
	 vkmrkZD2i+FKl9XMCf0fIfYUdzifkjetJVZFAAAsApVX4RJbFIas9NqRfGXZf28Wfz
	 aVFFWlyY4l2lzbWv8rhBwJ5J1aT8ggdeBrQAo3mWlnUnQwpvYnA7somCdU5hc5BSm+
	 HCUddYHR61YhQ==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:46:10 +0100
Subject: [PATCH v3 3/5] iio: light: gp2ap020a00f: Enable the VCC supply
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
Message-Id: <20261118-gp2ap030-v3-3-c8df93460110@kernel.org>
References: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
In-Reply-To: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.16.0

Enable the VCC supply before accessing the device. Use the managed
helper so it is disabled on probe failure and removal. Let the regulator
framework provide a dummy regulator for an unspecified supply, and
propagate errors, including deferred probe.

Reviewed-by: Joshua Crofts <crofts@kernel.org>
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

