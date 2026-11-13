Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573215;
	b=fEC/DHT+Us/uwtnJwvq2B45NENSFJrivlDX1w0ZJH1N0G8q1mbkNjSOLDNnOMbMzyXN3
	 s+SqhiGTupTrxQbKXAZn80LaICZYv9IlYx+uqT8nPcfKgpYxtswOOjbvGefw6L3sdSecE
	 9skloEiyJejJpKtU/DVD94UtCaWzCHPNsPvOd3s3I+QzTHwc/vwnLZKusTyoJUlZbuJAM
	 oA7I8ODvksSEd95+Jo2GjL7zfpLjlnIub3ytATrJ3svstryGiOICQs/LLOdvFY6j78XA2
	 tkWOB41jUOxigHXGykK3NCLqmCsbRuUBtD+1J3j8Fs4X2HIkW0d7yInDtAi2SVq4Z2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	b=fTGre6i0htQNP4lK0kROwW2ZXb9eEABHyvUwzH+lPBskjduakNN/dbpFBjzlzwgcbgkE
	 mTdOFJlF0x6qIcYDc9DWyX4zWzaJ3eg9hhDr4b9W6BvC8R4pmLxiOOl0oC+X7uLsur1T/
	 2gVsL9e461BE+fs8Cwekotm6FCoMt4+yzSIYzVwIaOY/mIaUzpTmxAP4P1REWdaB7uu8C
	 YY+W2DK4tulm5/3aB6kkNFDeuSYl300cilXUEWxkXtFDpeN8XRFGY88m4v0ziMO/V3XCB
	 t42PzO+IbeS7ezU8AuQ0pr5r6DZDFSvyHgciUrSejHjJCvZuf8JvzYP6smflt0AHhQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ephzzQRh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C06606A336;
	Fri, 13 Nov 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ephzzQRh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794573215;
	b=QOZz1G31Mk/gs2zeXTb63Wzo2CLjHHKIIvROFQdZYZ0hlHqvVLVsEH0t2D3H3wM3WJWM
	 BrPBVvzkjEYGzFbWd/TT/PK7XW0u7kXMDqYjaMBf6ax5WXLRT7Qa3iU74mvwzclUWbQMi
	 LNZJhhvh/xy1g3ZN9FxOMqLYU3O/Pii4Ya+Otak1VKU1AnCfqaxblDmEl6xJ55aHVkO7m
	 qRLbXHvngBlXx5fbH1K4H++eBS1aU+jnhwmie71UmH9CYCdPeXAAEeTRReV553Jo0GnzD
	 hBiP7kkWCOnrkfCh08S0I2+zyyFB1dM58oPycNCePn2AAW0CemiGEkWSJtxuKuUZasQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	b=znSvY0oOhYBT4PlRp+3kcjF5mb/YaTqje2CyGmnYDa2NTjwtTuMYAQZXU5GoGYxxFspZ
	 pScnPWZVTPURqwyqW+uW6MrKX80IIBZhz5XEwQb2IMdC92WL2QHp4wYLYH74d00/Z4VHY
	 vc39W5CIx7WDWWnl4vTStbOyaNqmAGlqGghXyH85E/o+9kObjFT8WEoaZ77K5v/hsLH03
	 Foc7Fc8FjQFpvi7CjPEdUrSe9vr+fjv1mHKvrSy36jTVgO/lSSWgOs4g51XoRWh+zUJ+V
	 GjSsvreCBZKxDXbYg+GusHkuVU2bjLYM439Q8ckDoSN/JeYJz2sIuAkOWyBK2w0wqXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 106CE1F000C5;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573214;
	bh=sKu4sajsaOiA59TaqrDTQKPw1T5k64p4/BcVcn5hHs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ephzzQRhCuX3jaNO4akitFJd8s753E46/M94eklW8tBt7F2icjfGZWkyhZ09ZsZyI
	 Tmw2zzXorUhaw1JoLW5J81yxkbfFUQn6X+JUWhtEAYnfHmxHOZSriGyFA8tGl+QspX
	 FmqLO6bt2ub4TesWiiRV06ROyOWeYkjki8cnFdsUcd5ADPx5Ow4NfCFDhPKGEy8VkV
	 riaq0UYVAKN/hmJ73hSftvpWnJBRrZ0FRk2kYa4rUEAGFSwMCyZLdxOPOuULAQi9dj
	 G2YWMWpJ2bopuViDUlQ60ccvKxfN3XJwLI9VHH+2ZVBjAS34EkCa6Sb9HaUBTDASqD
	 AVRyEGbIGfpIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F6DA47780;
	Fri, 13 Nov 2026 12:33:33 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Nov 2026 14:33:31 +0200
Subject: [PATCH v6 1/8] iio: imu: adis: Fix custom reset dispatch in
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
Message-Id: <20261113-adis16607-v6-1-3f678719942a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794573212; l=2714;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=2aOaWEQmm87V8mWHa6wanBq4j6mhu4yDD8PVM0G4y9A=;
 b=9N2BB89X2hbV5FBm2lC+42qNK7w42F948QLoTTqz9uL4ku8beUXYTyozi0y/AU5Gbk/4iIE5O
 Fq6oqjSqrHADqlb0ydUf5snw1siCdFGl1viSbrVmBZhHk3ytKDLxmZl
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


