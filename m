Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611544;
	b=XHKE+4JmduMFMTBo3RLrdfJi+RCWm1q3y3tw/RFPCW0y16uKz/dmBgtHWaYiOObfXkhr
	 hqoGj8qM6TIQHcYGk+XgtMB2LFYr3dv1tn+0oTXiW1uPF2EPQcW//J5YFhZVS7N/NsSz2
	 I/oWd1KLndqxzYKtqSrESN9qM2LOcStdesvrl+8Cpp0fQk5qCBo+Lv2EtJyJaxtEohn+s
	 o+hOzr6hotGNbDPujIn1OGb6bz+qFLnSsEMKm+nnlf8xnkk1Ovme0BWd7Jjbp/JrvrAMg
	 aS1kVDJb2GXlqybiCRqhSO1zQthovLT8hlEwXsFl7OXebTNJDlEOWR+MWdq0yCSOYKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611544;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=Ke9le9Z0Fdam5/PZUwVW1dF8jepVbTEwKVGZt0QCRj1zuRZ7IQMbyaIheZWlft53VEjv
	 qKM+XxsdG/GJ1XlTIxQTnEhES54dj8Tulfiep5/O/5UkIQtllxLVuJ7sZB/rl6ZHIopWq
	 8eMd/JXnhHMZCfgHxhk9d/ay3UZxpyKsWCF40vfb3I5e3ChIdd9zh+Kk2xm2rNCCpUdDL
	 jMzvXBdnR0uU5NtixzYhVsBtsIeWkpBNcFEZz4Z0mVbhuvzbMz+RlXqjbUTSTwDX8GBzD
	 zViILIvGS0wJDaKCxVzrRwfNmV5x2tEDCMkpKx15As5OJUpyMZik+h4s7iENxdLyKhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4ywVzIB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539960A3807;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4ywVzIB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611544;
	b=EIeFzAGPy6527TuyWQBPj1EtvP+bGZfJflcWXFx28ZlPYJltfQWbtg9lV0eDBNr3x5qU
	 JIa+q0fGVnZfv0LoobifB7KR2nQ0Je1t5wUjD2OP/CpXP4ZRcFE95XbW5NHbr2jVi3ETK
	 cM5Y6HGUcqQQsAoMjEw6S7GTIzU+EziDDYBdZpfKFg0BM6tR8Y3q0cdeKfUbLpzxNJPCq
	 C7d2+QuIhfG+MyBntoX+bPugtEg7D6ZSvrSOFNQURRnwXYm/vMqwe4USMK5+AYYjI3axu
	 PPAiDc+k1lHPmc9R81OrCoMAp7YABGW99D+3ivrpEPBdWBml2ZxkRwxnoDXlKxVLzHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611544;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	b=yPf5y6JoJYOWw/faz4vtcH2xxdnsg3OaIfKRFSdNywBu35ZfrVno/SwhfdU1vdS7Z1Xz
	 IIs39tL2yIJoGpAAZ1nbhz8nzQsXYrYkXcXg412jVhazjYAs3f6ASxCdAtMPhyvMKSr2E
	 KnoyIKezwj5IfngjvroVJ3Lr9a+oyHpzFLV1M4FJ79ad4ml4C6zKIdiaIoyPP2asjtjtQ
	 5McF+VSWaQMI76c+fykhXdVaYk57SMrbO81b8jXGP275cWQz88oSgwBItH4SMhAiylpRk
	 O566ThYorC8a+RNpMIe5J+4t5FJm/k44ZrxKrMma67YPT5YQdF7pRNvr04zeOlC2FxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2E93A1F00A18;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611544;
	bh=LSMose7FrhY6I+Ycp2huiawH1d1GE6nqj8yLgiqCN5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N4ywVzIBIEtQmqvjOfggr4iQRKOIOrBl7NBY7Fy4Uc8GMDAjvFrFniLftAhHcdRqI
	 XbkswJAjKdBk2HODOhIT0avLaVEEl9fahFEZn+j8LkAgU3So6TBCTrUaWSALWr6yqX
	 7aAY9zIXZQtRK3R1UNiffG8wPmmGGZNpVnZV3Ce+li3fcmkVJXzWi+lhppheD2OS5h
	 kJoFA3Xsw2iLTVgNfNI8NB7h6bsC+XqVtkJm+vt0v0xrD39sD0ghaONXpYDrMIMxfG
	 yDtoIGk/WxIwYqRnY5yuQ4G0fOaNg6LK3bVpeIRFC/K/mm1/TnomPHm2xb85Ays/x5
	 ypXN+fXuv19HQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B8A4346441;
	Mon,  2 Nov 2026 09:25:40 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:38 +0200
Subject: [PATCH v5 2/8] iio: imu: adis: Add optional self_test callback
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
Message-Id: <20261102-adis16607-v5-2-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
In-Reply-To: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=2180;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=tkzZy4kOyhyn9i1xmuSSgwdCRKGw+8zTfZiJqELNqH0=;
 b=oVEahSgG4RzTtjv74tBx8WYsbtF8LRQtXnEn7zbRWnRPrMx40EUB8Tps/VQ0ffhhz3OsTae59
 ak0yZ5HsOgMBOAdnK/80bv8gbiGfmi1N+oE91aXWeprr/rmZGxK+OdS
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


