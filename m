Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747823;
	b=WxWOhx+vkhBVW/nwD2IHd9rg4Ocw84tf1ybhRgZ/1+XYRls8CBQD8CJo3DPT5PY/C/iA
	 /wV9Z8O1H7dcIqvLXu8nnkk8XdmyCw7+GmLS1+DubclHJ6g6S8IFO3Hzh1J6LWfLptq2U
	 5kWepmfL/0l8zYuZPxQBqeevzYs4yncI61wJv4IghR10dkjo0D509qO5kcZ/b8gcmWLCe
	 buA4epk5I4qE66FvtQbVhwqlgTQmQGt2fAwik9v9VWRt6LfNXSo3DmemEakEuK46L/Y+0
	 SR2AtR1pvkKHfKeMa1iU9VMtv4EhdNo+1nGufqEAZhn9CauFmtIEH/w7YgZJK2WPM7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747823;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3EpzDGuO8u0kVCltVrxaYONhwLletiSmFRu42c4xoh0=;
	b=V6kQJB4uhnWbRWmhtlw/hR0qrmvM/hk0Xp9DHC5WjfKnjdy4BcIvUlN0lf8ocULScgua
	 eo3Ijrn9hlehpdc+hj7SthN2yN/XOud+177dTUVm7SjDfBpjh3VxdRckdP47ljZx47JCE
	 4KYLKyp+POGlzHxIIGlblk3zkL0W99i7xLzyJ7hgX578VRPWDvCjoJQe49r/lcgSYo73U
	 b23RvK2NAtFHT6i+HIC/USfNWkSV4LUFgLSX9DY/q66qYsASIqwlnE2BZviQSyEsLuYqJ
	 EvKKtGVrtokmqN29/tblqhU5Idvo7FOTPOhQ72TlvFkyTFrvtwJus1UhDaCtn40g9nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcGC3TDo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40F606A322;
	Fri, 23 Oct 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcGC3TDo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747822;
	b=OH/8W0UTzePGoB4J5Z9NSecFksceWH3ytYTo4gKpUD9gwYOBYOKeS57yybr8AxbWkY4Q
	 9OH+0TEzssoxB8+rezShbWsXWjOEeOezBzTQHWKCnzUXgB5X4+tLwCC0RM9NE7V6cxG29
	 sGc+jSDDXedf80qHxpN/6RrNW55Gn7NGbcBKwM0FVkXG0YuhUY+2aJSbgxCCVzgxcOfd4
	 nLlwGjlKB7OzpF/0DxqDByDxGXPpJRvbzIEYTY7UhTL4o6iEmoYDbspTax7TNRUojVAUP
	 kZkjvvOSIo5ntUwagYdGE2oueYCvjWJwaefTTPwkabsXveDW171/ou1lvS3YD9bXqQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747822;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3EpzDGuO8u0kVCltVrxaYONhwLletiSmFRu42c4xoh0=;
	b=DnLl/mX2KMmO/+EWK8UenmijXYvRJKJxeBvOHAZSv9UqeUws/CwinCMe0mPuMFpws2b3
	 UIklgm9NYN5zZERf9MoqF1QyeSSwQG4pWY5NzBeKRKzjzGm3qrUrybIXReCn6CdJLw5LP
	 t42yR8xZH1Otk8tn4/dh+mvlYxBv4nEZlswFzm5vQo2pPRHKmyqapjunzjpGOD/RA6NNa
	 R7W9kxKkIJufqQUru8yyqGDn3Lf96sXqzS7gR27EBYQc+oFuU8kcwFlh+KIMy/CFW5F4a
	 GanEqYrPxizKOPfDPqo3FGNJXiucbOxoRhtkQMdTD+j/urojn7pzIpsfHznUO0ZSvAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D95521F031E0;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747822;
	bh=3EpzDGuO8u0kVCltVrxaYONhwLletiSmFRu42c4xoh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RcGC3TDo9pGZPmEMBUQj0NfjQFbPAV3zFjK25NdNxaRSETbQlJfs7I8hSYAXeP7n3
	 JcARxIHEcY9HFyClJAHV+tt7OJ12Y85GTFlYDoGsmZtdw4adVgOsYB5lCs5lZeeRqZ
	 /PR7VNBtARlCsYBHaitnDXL0TYkiTcRNUrsioO27wdXeOMGjb1mue9ZRXZ9RgevcJV
	 1P+jFpGbAInUVf56tpi2UUcvcRGefPsrfaSurUVL8hFco2KI/ErX4VHT4x2IgQgQh5
	 7o1uBK3VJXnwXgz2QoyyVDexE+XZrsaYBcmPqBzlnIDVf4EC0txaytRLTgNSW9EXMS
	 h747qHJhqgNyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4EB314445C;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:19 +0300
Subject: [PATCH v4 2/8] iio: imu: adis: Fix custom reset dispatch in
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
Message-Id: <20261023-adis16607-v4-2-a4d541ebfd13@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=2750;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=vuWXnWSiWcah16SzlQvOsXkP8u5qRQjoUvxICsehtNU=;
 b=65/j/nI+nWzwoH+3gaT2k/GBM/HGxFEJGyisaCl4wFLSsn1LkCV4yahYp2TccX+AomiRmS88b
 mPtBMxJeCFPCFQc0n4gZijKj8SaqAr1pOCTpaHUy7uhEI0KP/7rwjHs
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

__adis_initial_startup()'s no-reset-gpio path called __adis_reset()
directly instead of adis->ops->reset(), silently ignoring any driver's
custom reset implementation. Invisible until now since
adis_default_ops.reset is __adis_reset() itself. Dispatch through
adis->ops->reset() instead - the same bug existed in the public
adis_reset() wrapper, fixed here too.

Move the settle-time sleep out of __adis_reset() and into both call
sites instead, so every reset op (default or custom) is treated
uniformly: adis->ops->reset() is expected to just do the write, and
the library always sleeps the settle time afterwards. This removes
the previous asymmetric "sleep here only for custom ops" special
case entirely.

Fixes: ecb010d44108 ("iio: imu: adis: Refactor adis_initial_startup")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis.c       |  6 ++----
 include/linux/iio/imu/adis.h | 12 +++++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 388518ebba2e..5c3bb7259037 100644
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
@@ -416,9 +413,10 @@ int __adis_initial_startup(struct adis *adis)
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
index 14f9b304c252..c09b381eb619 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -10,6 +10,7 @@
 #define __IIO_ADIS_H__
 
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/iio/iio.h>
@@ -178,8 +179,17 @@ int __adis_reset(struct adis *adis);
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


