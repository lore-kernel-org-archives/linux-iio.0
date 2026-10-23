Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747823;
	b=4b748tyRSW8MF5oJybMP3/FStNEDb3OXJ7L7KZEUYp+wMT+hLsie6a1FhVp7FDQUEFWU
	 D5qrVC/KGX4NQQ6D8UbY3+aS0Xf7j6LL0kKFD18s8G6n/5VoVwDExLl7xvXI6mdQsO5HV
	 ZYmcQvaFz7WsE4NXmQH8/bL8SqsV5/koIlBEIgFy4POui/udjDqV+LrnvTGHqv6busud6
	 u/Q6DLPGqmN9i2NgDe0ynZ3KF7y5XAZPg53bjY/zl0FYiBmKiFd140CsuM/QOc5Cf3GUY
	 IcIZVuYKKfUgPuLSkvFopbpBjVwDdDBCZISraAD1J8R86CSGSuM8h3d3YSJAJFPjSkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747823;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pB36FfLi7RMVdPVfDUHJb5Dk460FVoky804DxF7wsCs=;
	b=i7jHKjPRsGSnVuXQN8F3ZSxDO0C2AHzKkZ5147Fp9Dp57XGdPfMBRr4RfDiNJN7sg6sc
	 efmEHd0AD0spGPTc9AgS/tA4R+DJbSY/e2ZarTxUkQWK5EEMXBAYoY/7ND0W2fISIhqgc
	 a6FuQcSXpF0mgo2pJ2ZQpl4C1V/+jt8Jq8iRvjjOmMdbBYv7DXj3G3ppOeAvIDE2bfLw5
	 oA5Qq2T5Gg5fg3NVBcbOpikqu8epCDY46eijm2zJXw9qzUZMX3QtCpKLbJyuVzcUJw0OB
	 IkndnLcPZX1nEjh0+73W3/b2Zzmt4rGAC30CsFYYqJHqJDJhNtuK4GFbyt4bCWS/57Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeyI0LX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54043606A32F;
	Fri, 23 Oct 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeyI0LX9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747822;
	b=1jUY+Mj+U39GIIXIKTYBEXgPnASaWe3YTwbEqwu7/9RZXGp116rYzNQlQukCpvuv+h1/
	 oKevx3TNHKCyZ5wMVF2pWS0rSEgZjKSW2H4Kin4PxnLdQY3j7teetTqCOPHqFgJTbiJlZ
	 yr0J9l5h+J2uQsAZe7BPu6kxKqJGEBKghfr4Uw0gD7tNj/BerX3A0ynrDXoPNL708guGu
	 4KhYlwBWM43G+fyezBMKmIkFLiBje11EXxisaDoDQ66bGIYP6IaA530jC7tOQyQ7djraz
	 9prq38vfhVs2RePTzekClaWKNk8ueT88jWbb7IuiMtzXtURmV9eCNKhQQtQx/wf0cyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747822;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pB36FfLi7RMVdPVfDUHJb5Dk460FVoky804DxF7wsCs=;
	b=IyMAXrvZBLeqjcT5TNCKyx9gsTaIZnhDE7Wuu8o6l2KqbTNE7kDj14TR6NZzZCQnP88s
	 zg8LH727H2nrL5SQqpSohez2xhAcbfCO6+aqmxZ3HmacgSo9ePtB/PpfyJIF9/6lXoe1H
	 Vdy7ae9KXrgFjDzoK1q5FSeX341xPfowKaoJMaiMgnuEiRocReTropjmZE3c8D5pvraAD
	 gbmN3Mks+NZirjd/CGixshdsLjBmWtj/ZxGruyuLf5BMFmBDymOpnLUoLAPFY+AMMVIvd
	 11ElBoMQ8K+ehw3afFqeCDNXviTCDYzhXlGdp29B2ry7js0Z/qK7NDt7OWWr2n7XBJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D892C1F01825;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747822;
	bh=pB36FfLi7RMVdPVfDUHJb5Dk460FVoky804DxF7wsCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LeyI0LX9W6M9nvamNf/WvubSSp6ZLywAw9VKtBBR3JO09EZg0Gig/DO0jencNHAP5
	 0jmGXY4X9fyux8P9ZEJa1YrV7cU5QcrRVYRLasdlH4UftdhGf7CvnS5Or7c4PNTMKw
	 NEuysyBljurui/hB2//uE1ewPntzwOekDbsDmtfOSd0E7cTJ48VJoL9sBpnuZ1j8Hh
	 XLeHqe3Mkj/EpRGFl4q+EcxnGP0jxDBVThZ2cGUn18EQlsL3oK+2VFVQ2Ksh6Rt5fj
	 nTeJbgkL0ynMetV81upPSET1h2L2NLiiaFU8q9WL8Zi8ao2y8aqLk1YdWkFcQ88dxY
	 qSA8JhU2HidYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57AE344460;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:20 +0300
Subject: [PATCH v4 3/8] iio: imu: adis: Add optional post_reset_setup
 callback
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
Message-Id: <20261023-adis16607-v4-3-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
In-Reply-To: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=2254;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=AxyPMdWe1dfHmRZJ8557DpedZhOiyzpzTaIVnfJheV8=;
 b=FZXhlGaYJE1OPG3ofpX4RgWCnZf6/yfkixVe6xYjUp/sgvByJFsh1LO9NEQu5KAw2U3UYHodq
 xTliY6bzpeoCMBmJtCPDVLcHFkc23PjHo3ax/yy0Q3gfmtXj2bnplTd
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add an optional post_reset_setup callback to struct adis_data, called
right after reset and before self-test. Not all ADIS devices need
extra bring-up between reset and self-test (SPI mode locking, status
or bootloader checks, pin or burst-mode configuration, etc.) - purely
additive: defaults to NULL, no change for existing drivers.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       | 6 ++++++
 include/linux/iio/imu/adis.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 5c3bb7259037..332cc7b0ff35 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -419,6 +419,12 @@ int __adis_initial_startup(struct adis *adis)
 		msleep(timeouts->sw_reset_ms);
 	}
 
+	if (adis->data->post_reset_setup) {
+		ret = adis->data->post_reset_setup(adis);
+		if (ret)
+			return ret;
+	}
+
 	ret = adis_self_test(adis);
 	if (ret)
 		return ret;
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index c09b381eb619..3d7c7febaec6 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -52,6 +52,12 @@ struct adis_timeout {
  * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
  * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
+ * @post_reset_setup: Optional device-specific hook called after reset,
+ *		before self-test. Not all ADIS devices need extra bring-up
+ *		between reset and self-test (SPI mode locking, status or
+ *		bootloader checks, pin or burst-mode configuration, etc.) -
+ *		only called when set. Must return 0 on success, a negative
+ *		error code otherwise.
  * @self_test: Optional device-specific self-test override. When set,
  *		it is called instead of the generic mask-write/sleep/
  *		check-status sequence. The callback owns its own pass/fail
@@ -88,6 +94,7 @@ struct adis_data {
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
 	bool self_test_no_autoclear;
+	int (*post_reset_setup)(struct adis *adis);
 	int (*self_test)(struct adis *adis);
 	const struct adis_timeout *timeouts;
 

-- 
2.43.0


