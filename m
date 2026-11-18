Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007866;
	b=WZH9rYJ/A5geoQ7jWOV9QzkWVdhKdboTusD5mT+/MgstxoUu6d5UHkCY7/1io44/xfnK
	 LjC+pZUYnMvuydKLkpNns2t/Djx6I3zm/2bJrzqCQU9cMPlhSXR3cslzld5uQ5ZAV0MNL
	 YYYLQin4DvmqzgqDcmcDDRUUlb3KbH9o2cS6Mit3tPFDR/QPimQODm2CQmtPq8eKSl7lw
	 TGBIoQwbLHxb5zrJyitLJ0+em2cKGJGzzUQ2vMKNNNTsFlGTfcORdB3hjauGnWwDFWv6M
	 jNFZpZz3IWsJiroavXNl5L6nJh9EY4V8+icIUq7gxT2SPVvMc/dLXAQ8Ve3pm2iE8qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007866;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	b=eh1KPFtUp0YetXuJe2zTS34vjWxe0r8R3D8en80lUby4cWf5QG3RxeVurrgvUvCGNILf
	 atD4SWasVqoLrKLmv+anwkYAFJD/IZbzZ+Vb7S3SswIy9QV94i4c5aYcJP+uMHH8Uy22i
	 pgZT09GWITKqmJkKqiKJpVR+ZVoZQfyvefGCpht3ggtVlO84tp3mHmxBMXgUSSrBkFUm/
	 R7WdcGU0H1VcuKfS7rpASQgziFJiZUG4yK0hGNu5iEWnRKThYyO6LKdAm09Yi98ilgBTb
	 Me5VAWBM3j9mPJQBKoWmb14TdXbvFAXocH6q49xHiMHuzdCj4sAcHvqWQKBbVO5iW4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbpNfYzf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C3606A320;
	Wed, 18 Nov 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbpNfYzf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007866;
	b=qFBiplP9IZy+MDvCgbjdNZTJqcPujvUWWaxoJycEr32ihyAHE7Dgi68tkOTuUxEau+6P
	 kwW9gbuvsD10edblvANyMrJImJpqdPdQN4OBNGk2uuMe+741R1qXFL890vFmSNKH+AQ/5
	 VxiCVxEKE5blz4ZDMGyzo9elt7z3jfjRS1jRblKbovC8G7wjYXMRmSHfMcH/FR8q1kv/q
	 fbNsydHSz3RvKTHEEWyG082bAONAeHuEkBFFaQXsWTrclnLN+i0QCcp8Cj+prNXopM+ZC
	 FTEULPyafTBjw59ZqTKg0S6LJNwYbQ5opYcLjTffkE5uiMi3A3BGHzt7ccvpyv9cJYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007866;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	b=mrgzkdk3og5e+ArhIHyqjnhR755L5LcidBLVn/Vei9GODHxc7jQBzSEHxeVQtFIiMGbQ
	 J2EMPNviby7Y9OKqJDpDcfby37KkWSDthW5tYeTrhAvjHom61sRRoxpwPIrLYsNkkQh+s
	 cY42uEi6DOxklZtyJtR4q/ck67+v1QsXEpQl1p9MUu2jWxerLxIMxnmW8t/n++sw1Hoa1
	 uGDF4e/8UUytwiPbknIdpWqzeauk0/fHLIINvJ40uLczNidL5YHOI28j/QX/peC3gT4rg
	 q2Pf/qETuvAcPSYz61wHtXCmKGPEuCbtTZrjMo6A/IhldErbMhRonsSUV6sOjYRptZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB0D61F000CC;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007866;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QbpNfYzfIdfkvTyBU6bo9xc/0ven0ZqxCMe3C4USb+JrihvST3w4Bu5Zx4xtxAOxt
	 Q+Bx3DZKLHWuIj43vgXzC5LMkVdETfF0Toi3Ti/kt0hU1kVy3KmMQ/TQeseD5otZqu
	 uanu+Mk09WvYZIFWeKvTgc0yOzf0RCP6+thjHjilHZf28uLEQpxgkJDqItPkHqgKcR
	 skZijf6C71uX+srf8y0Lu0J9FMvQlG2cyu1KETXf72H3/e8vKX2qgPW73+PPel/oUY
	 3CjmFI68fvtQf/Uh0AgzedU1Gz7NhM4XwXO2QZfkmHN2H29nE+cOdqErluUcXnJOIY
	 3P94wFNMNcrUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 494F04AD80;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 18 Nov 2026 15:17:43 +0200
Subject: [PATCH v7 1/7] iio: imu: adis: Fix custom reset dispatch in
 adislib
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
Message-Id: <20261118-adis16607-v7-1-707609737691@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=2714;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=2aOaWEQmm87V8mWHa6wanBq4j6mhu4yDD8PVM0G4y9A=;
 b=Sojl6PL8HfcWEbXCQ8TK2H89NVgInmhPsjc7bUHHSYzWiokPQIfTwrXtFb560gYcJFfZpNWaa
 JmLyM3Zt98vDrCP0KTGo0WqsDPanIoYreEN9kVdvBj52tcWV94EmhcN
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

From: Radu Sabau <radu.sabau@analog.com>

Commit 7f15d7a7d12d ("iio: imu: adis: Add reset to custom ops") added
a reset callback to struct adis_ops, but __adis_initial_startup()'s
no-reset-gpio path and the public adis_reset() wrapper kept calling
__adis_reset() directly, so a driver's custom reset implementation is
silently ignored there (adis16550 already provides one). Dispatch
through adis->ops->reset() instead.

__adis_reset() also did the settle-time sleep itself, which a custom op
never reaches even though its kernel-doc says the library takes care of
the delay. Move the sleep out of __adis_reset() and into both call
sites so it follows whichever reset op is used.

Fixes: 7f15d7a7d12d ("iio: imu: adis: Add reset to custom ops")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       |  6 ++----
 include/linux/iio/imu/adis.h | 12 +++++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index a2bc1d14ed91..793e3b6b0ea7 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -340,7 +340,6 @@ EXPORT_SYMBOL_NS_GPL(__adis_check_status, "IIO_ADISLIB");
 int __adis_reset(struct adis *adis)
 {
 	int ret;
-	const struct adis_timeout *timeouts = adis->data->timeouts;
 
 	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
 				 ADIS_GLOB_CMD_SW_RESET);
@@ -349,8 +348,6 @@ int __adis_reset(struct adis *adis)
 		return ret;
 	}
 
-	msleep(timeouts->sw_reset_ms);
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(__adis_reset, "IIO_ADIS_LIB");
@@ -413,9 +410,10 @@ int __adis_initial_startup(struct adis *adis)
 		gpiod_set_value_cansleep(gpio, 0);
 		msleep(timeouts->reset_ms);
 	} else {
-		ret = __adis_reset(adis);
+		ret = adis->ops->reset(adis);
 		if (ret)
 			return ret;
+		msleep(timeouts->sw_reset_ms);
 	}
 
 	ret = adis_self_test(adis);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index bfb6df68e6c9..97323b8d1cb3 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -10,6 +10,7 @@
 #define __IIO_ADIS_H__
 
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/iio/iio.h>
@@ -171,8 +172,17 @@ int __adis_reset(struct adis *adis);
  */
 static inline int adis_reset(struct adis *adis)
 {
+	int ret;
+
 	guard(mutex)(&adis->state_lock);
-	return __adis_reset(adis);
+
+	ret = adis->ops->reset(adis);
+	if (ret)
+		return ret;
+
+	msleep(adis->data->timeouts->sw_reset_ms);
+
+	return 0;
 }
 
 int __adis_write_reg(struct adis *adis, unsigned int reg,

-- 
2.43.0


