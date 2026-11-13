Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573215;
	b=grPd38zQDXEu7erE+4TFiF2AkTtmHPpttx8yfbd5rthf4QMju+UU7ac72xqQouqE4Xlv
	 wTE/ILBrNNlAJFtGqh/8U+tR6+rrB1M7kN5IXS59OONonL7bAoWb06uxwogyZGgHF8LCW
	 tM5gy6gxJByoh1yaUTebqF/uGMRgkaeuUShqYU39OCv0f/YY5COCr4BCuCGGlffGVKVXg
	 d5ceHBILpGoEa/aCH5/x32NtDqZwL+TEhpNcat3hfu+zklhsDz//88k/cB/h2Xqe8wGVG
	 sULqgO4nAk1Xii46PZ2LQQNbtEjdBkVyEYH3J2oK+3OcIz7BjNnqDII6xZ7ZWiT3wDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	b=VacbgAhj/+VlwRz5cyM6644+uj0Mkp/ktzpP8xRgbLcQX2T/ZocuaoPVsZAH7KenINW+
	 A1I/Lr9WepkgfREky5SVXePtIJadD3BsoV7ucvzE/KMoBc0SuP+Hxrvrn1VpOVBnQUWaY
	 RwjG4iAhzCtQEcVN/MKERTnq/SqMDrsxKP2QFak05dYgJSjkpw07w3rhAQE05oKNT+MZb
	 M6dEOR+4h7qxiJ8z8pAttCQBPImNwyXypfnpNmGYt6DCxdZbS/WjkfG0SHaz5+tnuWA+x
	 sMFszhO6VJz9PThO0A478gBU7lqMtg6wWj/EQw9pfwi41WlNKgkzI0oYZahPsXkpQYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Khag/d07";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E763606A338;
	Fri, 13 Nov 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Khag/d07
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794573215;
	b=l/w2S3OAIne5sNfQfOhMhGATf9l/VULKSczs+FufPmCJvq3oyTanxgsU7rupVZap/9wY
	 LO8Z+bW3JXll5lf1x7ubzoAmidfIJKvVUh2VxR+okWJk7jLCPKfQ3K1+0a+kpZ4fJXKCH
	 ZreriGHAUjAIqfvIG0ZF9x1DvCEodyW8T6/k+6XYyvxArONQ/wziShJY1FH/magQ26RPy
	 hAKyZNzm+Esk/H3rJAFxE3wX1AishbpkG8mIzgOxuBzndBQt66oLjQi0QsbBgSzioOksn
	 TgRQnT0cNXM/3brnX/XLc8ohdIcoNBe3tb/HZKm5Oews2opoFg/U2/GXjy3AUGqS3LQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	b=aMViJyM/wfu+wfU0jY4eOHuks+qhyBjuzL2Nui4Z7WExYIeVhHGSnpnvwNAdEjYzk0/3
	 GxIxFz9YRWr3FRNikB/JnYyZXymyLxk6yL2dRBiBoIGztPC2ugNHUN+wmD+0GNSyu2Jqx
	 jLeGh6JUtRojTfzy95of+StWegQ9BgjVpQjxd/Kw7ValAUDr8jU+CU3sB54rFscS5PoUe
	 hmbSzT1ltsodsBJC8hgaoBh8weyrHSUBnan1db8AAvT3Be3suoNKlDsxQOB0tEmactbEG
	 ioxtxiBG2sJHpZcQlJSadXQ76uKEHE0I14310yt32pq5/uI7fBZZLR9ISrdwp4P2A9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E4CD1F000C7;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573215;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Khag/d07GJwD4m0iTkwrJ8lL2zuRIr2q0KGxMsx0lMRiArCBrkWvX8wx6PqjnvaWN
	 WWxkHRQlYzvJH0mMcgVwJ//jcxKCkpg/jQjOUncYpp07curwOTNXqces2dvpEr+PFT
	 7XgI1DyDFvWaLJ4timy+TsnADeX3Ny2ab4hB4Uud/1BxLBG+HsbFLYwszCiiQLwkEk
	 qCtgodFnRZuGVt4zKvwzI1r2/ZUbYXk+iCeQ0rFFP94WbUm9UQ0sqLtPkgrpalHF6z
	 mGdkgCmsfmtdS1+uD5fQQfIh45uQNO5lPSaPWkc60Dbr+vg1poR7DRxVyVWfN+TNnC
	 ILK7q+lLD5QBw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A427A4779C;
	Fri, 13 Nov 2026 12:33:33 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Nov 2026 14:33:33 +0200
Subject: [PATCH v6 3/8] iio: imu: adis: Add optional init callback
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
Message-Id: <20261113-adis16607-v6-3-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794573212; l=2194;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=SjMU42Lj85caa9S//To07byzpthfksaMvSiYpZwwChI=;
 b=uPi7zpD5bu/rfCns9/6nz+lb9kUc+RDS6M1gbbByll04qhpAIS4TCuSeVVOgVhG8ToW54oNcm
 wX3/QSzntNZDASDTdP278py0UdhM7ku+9s9gMBnp6woao3A8Qook/GL
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add an optional init callback to struct adis_data, called right
after reset and before self-test. Not all ADIS devices need extra
bring-up between reset and self-test (SPI mode locking, status or
bootloader checks, pin or burst-mode configuration, etc.) - purely
additive: defaults to NULL, no change for existing drivers.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       | 6 ++++++
 include/linux/iio/imu/adis.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 5c3bb7259037..e2cf42b8b946 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -419,6 +419,12 @@ int __adis_initial_startup(struct adis *adis)
 		msleep(timeouts->sw_reset_ms);
 	}
 
+	if (adis->data->init) {
+		ret = adis->data->init(adis);
+		if (ret)
+			return ret;
+	}
+
 	ret = adis_self_test(adis);
 	if (ret)
 		return ret;
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index c09b381eb619..c9016f636530 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -52,6 +52,12 @@ struct adis_timeout {
  * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
  * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
+ * @init: Optional device-specific hook called after reset,
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
+	int (*init)(struct adis *adis);
 	int (*self_test)(struct adis *adis);
 	const struct adis_timeout *timeouts;
 

-- 
2.43.0


