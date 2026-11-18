Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007867;
	b=2JjkSShJJ31cpUfsQBkgNYthzyeY760QG88wcL8YpKPYTgY+Dxs5X/b7pqdYrweY76By
	 W84IjM8uWmjsHTF/5mgfJ4Fm0bTtDzE55+YYF0lVR7D3TRzRX9rW2hxIJn67G63nQVmgL
	 bLYJpPLZyEK4ZhKNw5Gblfmnsje/77V2J78ITKxCpsADpBkEKt63SfXAI5akZA8n0Cx6Q
	 mmTH+kxYwEkXqP0DgpZ8mTYlWld5ZMyoi2cMX+ViIM665BCE6ZMqlZG0F8V0V8k1PPu1q
	 hQ96zbtv1ueajae8s4wLzB9cj61q0I423+tNSgeW+Odwfu3g150tt6b9hVkyufdkNoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007867;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=QIAYR9hwynRINgiEVz8LNm8bBM644YVKjYGji5p8v8c2hPxdh40S9yQklqqFE5/EQX2K
	 M3ntXHmjd8s4BGmUX0r+zSJ8/l0RvzVeaH8kqq9hdIThSqyfF2SzfkMXNrlSsx/+mTfmu
	 y4Av6waJOd6Od+iW9DVaUsSio0uKAPK1Bq7vj1WP83aeaJA1CDHfvI0ow7h+ajs6CdeaX
	 5dMHVoZnvttji+4ZLXUh51bXZmewd6GYZy6ioLhoXK1OmmHLpVOjYCgqlFF2KhgRnqFB/
	 MfbV9ChxnKWj70R8ipgTUAsODBrPCbFPnXurkKgc702iNsdzLtB1RqudP8Oqbbix3EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeaSVjkh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3A606A33F;
	Wed, 18 Nov 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeaSVjkh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007867;
	b=kE7CbEG1hiPaz6BpFuBN9cOobyGLdeWa8SKq6XiD5gRXi8aj8dhOY5qmfs5OJh7I+epg
	 nVjnAg7JO6Jlw6SVfM2lwHojFk+vBXi64PcMMSeE5k5b/wBSLUzEjhRpmC159H1dwVQN/
	 gCZqI2z08TXRPBwNjAa+g391JnTRJeH5m9EjbVPZJm5PPIEZZmqfJor4oOvAJCXbaa67n
	 puUfnKMZGcIrx/YrNQQqeCm3IAbEak857wyG0iYTRle5oil9QmIRtDyL0sspEQBhBlE6v
	 /fJEtGF4+a0MonikmnM22B6QWfuvvmh9qZxBoBpy4y9HZY6c1/oVHN0JPL7PbIvyIlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007867;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=VLtpT6QI6+jRAEJcK8TNIFusDlpp/krbIVvDAVQQPd5It5qEkz59vIR9zCivVrOSzYe3
	 oVt9YVBd9uUkgzL+Mw704exg/4vvaOKskSdJoo3UODIjxOBywmgImmBVcGLsnuuS2rrmJ
	 FjN5rMbPV8krdoRgEIJIywtDOnOxUH/J/hz1Z1QcDuRBc98LDo0CXuSIM74CQzxvwMD96
	 M7bnHxyrqVe2W4cNBkaLYIBym8VntmgmxEszKa1p4h6jkPCGtmitsvOeDkbbsUhe90qma
	 sv0Zc/b4AKpLx2WV8MqhKj0xAyPCARTMrHHUBT9IYawFO9nvmk2HPPVB7xCYhGbm8Hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DAFF01F000C6;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007867;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NeaSVjkhX1tXxUxo2vDS2oZegPufDZYRW7UVyN64XPg+TQfe8YSGaod47Xmik2LY2
	 OOXqQ4TmYvBexeSwvik/lzcafGhKTqwtaByXFOWl1qo9gEWFEjmabOcAt124G8d+im
	 8RvgZEvdpIJk2L+yHtk2kLDVPP7O8H7ACNb7GIOI8X7Iq44hwdm0yhkBgyxgB/xnuO
	 lzINjwPL4dJojiBNTdXFUV21VG4b2rsr9C7eTex6lXEEHzOYYTkHtqCgcSf5wcOxC5
	 q14jaL5yw0/SqsUF4/a9WMaUP+CxZB+TaU9LRahIbXF2eYdrJxGHkFYY8TyA9amMAU
	 Y4eVqB3FaOXfg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6362F4AD9C;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 18 Nov 2026 15:17:44 +0200
Subject: [PATCH v7 2/7] iio: imu: adis: Add optional self_test callback
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
Message-Id: <20261118-adis16607-v7-2-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
In-Reply-To: <20261118-adis16607-v7-0-707609737691@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=2180;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=tkzZy4kOyhyn9i1xmuSSgwdCRKGw+8zTfZiJqELNqH0=;
 b=1n3SayWj8/hOgOU+vMli2hY+T8/nVKjzYQr8GhtNb/pCcfYeRM2jWHa0HYsrD9X9uFpFPiY7K
 09oyfBZbm1xC/s1gFzC4w4qKfix3MFbtcmLVaCqHbO7j9sDTLUVYNNR
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

From: Radu Sabau <radu.sabau@analog.com>

Add an optional self_test callback to struct adis_data, for devices
whose self-test doesn't fit the generic mask-write/sleep/check-status
sequence. Purely additive: defaults to NULL, no change for existing
drivers.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       | 3 +++
 include/linux/iio/imu/adis.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 793e3b6b0ea7..5c3bb7259037 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -357,6 +357,9 @@ static int adis_self_test(struct adis *adis)
 	int ret;
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 
+	if (adis->data->self_test)
+		return adis->data->self_test(adis);
+
 	ret = __adis_write_reg_16(adis, adis->data->self_test_reg,
 				  adis->data->self_test_mask);
 	if (ret) {
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 97323b8d1cb3..c09b381eb619 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -52,6 +52,12 @@ struct adis_timeout {
  * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
  * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
+ * @self_test: Optional device-specific self-test override. When set,
+ *		it is called instead of the generic mask-write/sleep/
+ *		check-status sequence. The callback owns its own pass/fail
+ *		determination entirely (it should call __adis_check_status()
+ *		itself if it wants status-register checks). Must return 0 on
+ *		success, a negative error code otherwise.
  * @status_error_msgs: Array of error messages
  * @status_error_mask: Bitmask of errors supported by the device
  * @timeouts: Chip specific delays
@@ -82,6 +88,7 @@ struct adis_data {
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
 	bool self_test_no_autoclear;
+	int (*self_test)(struct adis *adis);
 	const struct adis_timeout *timeouts;
 
 	const char * const *status_error_msgs;

-- 
2.43.0


