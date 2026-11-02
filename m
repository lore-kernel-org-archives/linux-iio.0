Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611545;
	b=0Mr0T1mip63hzhs2WYFEj2pulfawWTsOLi3r3lhg1jUdUXT/74nCR+fuzos92VRfi8Fx
	 oWuevuKh+DDcYeK+NyjX3fKAYn9E0TbBvR5Ktdtl3iIskzrMLIYyX/92CY9hffanE2bJa
	 rHzb3TfiZk6OWVEvtTUqxPjrU6kDUlbUP1Ieem4aygBY8H9eh3G1b/1A6l4Xbw7it/kkW
	 kZ/X3JwxKFc0achK6YOgFInJ9TNewrQY71k8V2Bg+gZZSiwDnl3KJz6YUjPBiXmBPXlmY
	 EAH9w8on8Z4LynlmNrnGe1s9ZISu2h4j28jUvgVgQZVVfsGpjVdm6MeFQqfYUg+tgxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611545;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	b=vaJ7HOZL5V0q6J0Wfa4QZGNrez7BZ9I8ALvESCRIC2TOZArt2Zr8HXzkPGt6oLcG8lTx
	 SfrL6r+dvcn1dLrmaZlwqcnI20jVk2KYtpdGMdXpmgafXYZ4J8NDEaHLg6skbjJijEWlE
	 Ptx8mJrC0ZEd/PlKpjnVNievIGW90eatNFTdI6iatdOQZza4jIbhq9nZ833US0FsHlGun
	 po+uLx07zFu3f+5gb+5EuYNBjfnND8y7oK603nyibF5DZGA984sTCFjAFmRc5y/YZRraK
	 dIndtNGbgTemxthcT4Nd6bHURelrSgyTqqQLeZv4H4gAP761egYz0FSD1qNCiPhBYqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0qLjR8S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B360A260A;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0qLjR8S
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611544;
	b=zdBeqPIkvZB/Nbqax2ooVftCex9ivFFiinYQFPBH8FdoCWl56/5YMTd2qq1OrMltuxV9
	 pJvdsqlDJXX6aqyOnhzJefFv9RLTR4DSOxgqjFwfv9A3b+/ltOVWw0TePA6dVbqYynRZq
	 Isgj/eLJp4icDSSuuJ6YL6P+TjEgPd7MsESkkHwm3bjnzYkKzxa1V8Qxm2IxOlwyj1rfV
	 gl/DpeSy4RYMbl94xq4nokRD6bS9TBjh2e8XFWdnTkDOI6LoTiY6rYL6Xp1pp0PPxz4Rt
	 mQIkuVJUXOtgT369boo2bG7wTpSYh2FLifGeKPC8jyNOzqoJZx0/Lrs0iPkndeEz4fA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611544;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	b=rs8U7zfssBbPgOCoQdd1QQrnO9in4W37AoDZbMazZNl6IvN0OLyPUWVviM75oA9XCOUI
	 pnF17bGD9ASSuMEO20P2+7Qo7LVrwiAJy1IEQLNZw/WsoKl8J7/ketr7z726j6Y+d0FX+
	 qsAJEdVs7vPlFyL1IOWVjUkXn94l239fCUAFlT6efSUhEf7wKk5AwVpNPgB1/TU1+51/D
	 zKIC5cMPc4f153IX2+rkGREVYLtiRnqjm149QKIsJaG4+/V9HQMHZTiGdT5/su4KCsYcb
	 incaH6vNoZ6uwkWMYGdhpS0WdCZptdfE0WHp6nL6az2r884ElZL4r4W+GFrpgjg6aOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3FD371F00A1C;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611544;
	bh=KABoEQ6oOeZnkbi23GW6NJ3GnOO7bT2WVCVPECPyMPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l0qLjR8SU8RkF6OtE69tprIMjbk8NFnd3bHgGAJJ9WVPMWwqKcAdlUxU/m2cHEgat
	 n+GCqHA9e9jZvCMkR3uU5HEiwqureSyvSmOP9V720EklNS8baZ0qwzTKCS+tExnK/o
	 J92d4wuGQWqQ4egOQu1iB1MO5Oha0Enhg3/9CmrEIgf79VL5q8t7fLKPf+6qhZTjul
	 oPk0aFUMF2CyL08CHxwJD75+lXL5tlxdI9+vhhs1ZoXQDZCRg5HIlVezxBPzZDI8kD
	 GagzY1HoJC7xErbIgZVFpLzUT5+tQNe6YiWFXdCbYTcYHv04aICdgAL06rsrPskNYB
	 P0/4c4XxUk9Ig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5B7B46445;
	Mon,  2 Nov 2026 09:25:40 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:39 +0200
Subject: [PATCH v5 3/8] iio: imu: adis: Add optional init callback
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
Message-Id: <20261102-adis16607-v5-3-4f98b0d271ac@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=2194;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=SjMU42Lj85caa9S//To07byzpthfksaMvSiYpZwwChI=;
 b=UVk5r8rF0ubBzgKUEh5ffk7cpzkZd/gdBlQb91Y7RbN78aAV0OP9BUareconQtWXrs16N2M4i
 PZgAxDXYPrZBjM9cX3k6562+FLbGFEDQijO7dZFbKVM+QG4021CwHDk
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


