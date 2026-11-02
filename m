Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611544;
	b=UTUq0ykTFX/1KtNJd3OjFoqILc/seVP63iVhfIbvaP0k7oDZkblOhgl/nYeZqyl7C2zS
	 rE+4ef0oo447nbuO+oGbYlAyZ8LBeTB7fkJGhTryTzr24vYaN1+Aj3U4xH++mt/4+mufd
	 P9JE1n9c44brI16+SAALrmWHZKNvafnjZ6/LySaprWl6hjAWcwiSrAzFYRDU58V6C+eJH
	 GXf8lxfVtJxbvzczqo2FpULMa40MHMNlMRe0G0bW93G0nDpISoRRK8beC045NyPzsOnzN
	 NPk0zCupOHjGHKHvVSm650qI6nCN9XEcuNDSTpVW1PW+gtZqoeur10cRnjnqQqeDu3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611544;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B6FWExT2fb6Xky06N6AZDMgw3GehroiiOZbmgn0b7+k=;
	b=4Twrk3/iF9YCh+bsklNqaY2VGuWL/qxakT1M1f4W545EjpEjV381lWkL0yk7KhFRyfAZ
	 xZzHmaM9AOmWKv16R80BAca30NSIB119lPrTz6V/Bmuaf+gH/MbKLESI8rPLhZOZpxeGr
	 ul/pWKPG2zBD9ea323pb2fbwl5lHKAkrOBFeOuj7cZcMI+A6ODm9K975osTYQbV3mZqOV
	 k36YiBIUSlvQvo04zIioWqaMKswf3HnZkDXl5SBeTuqE3rZXL9Og2BfZs4GeoQ4KZk0x+
	 A2SjRjoRC9oF98ZWvkSflRHXArlnL56/+66PKvdtBZAvbzRp5uUbAPHONbIcQMOmbcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1uMcm7q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A960A3808;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1uMcm7q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611544;
	b=VzTGxI1I3fAta/XDNWaCAHCD0G8Q2noJrrXJOnq0UO5UAYDX5fM6lqcb2eY4nWV4w/Ff
	 IEjcUpUDqu5v9/HHWahlp6m7QocQCzYBtdvLbn3ImUIsXb0YR+A4IZrBQ9UczGNZ1hC5K
	 pOKUPxEKOTgWoxv/bsvmSsf9BqmvDEveVi8w/ZLVhAZ329cP3t5LJ9hHaPkVm7lGHZrvg
	 FER2x3hGYdzyIf/zSAEedJ/AqNnclYb7tDWC1KHVb6hoLBtptgUqhtGdmZGtS0oCiCVRh
	 SUIWX1kCpfrHf5TJh2zH/qQhTbnEvjppkqJmlOBdYS41t3yeF4z6M7S7lTWYfFAeGqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611544;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B6FWExT2fb6Xky06N6AZDMgw3GehroiiOZbmgn0b7+k=;
	b=QHnZQU+VNy8XPCbRKunvyV76RhCUAVC39WY/ShrEYMyfsz0fRgbtunc8Q0j9hPiYnPnv
	 FUv7V2SyghzSBCeRVwhn54wx/8YECbitT1wTZ8USYVKaFGXHunFvXhDYH4v7tyEpgIoDS
	 3n7sUC2RqhPjoUvZI5hAOqBM4aG8dKmSxIQzZ30VeL0aM8Kq+SwQKpX1ShYYtNS40+8j7
	 eE9xDzSkHQk6y9kSTadYdBFRcsLQ0YUiGrPS/LTCV5b4gChUxdRaCl8FgbsjjMGWtzkjU
	 9x7tZZkmWlE7NwFMgCINjU4ndpDjYdIkyN7t/aR16K0PTrs6NttXfvCDPU4Q1Te9rIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 20F1E1F00A02;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611544;
	bh=B6FWExT2fb6Xky06N6AZDMgw3GehroiiOZbmgn0b7+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F1uMcm7q4lJksF3rk50+DEdhGbeQZEIRs8ndLnN59P1R7Xmxm+69NUvnteutEvMSl
	 YwfWftjrn5YB+S2ugGKGka3aO/1MKiIopT5s2eoVxLirGmOBsKpMDuWX4WdLjxHLbF
	 t13nWf44MHU1Imp77QVxUmIs/3KSrB9imcqxh3pS1hSrsNInY6zHZITFxAriFYnjXR
	 BZJeE21O4K0ZPvP6zOuM9Zf52JQc20Idh4BTdSStSQ9Q/PRrnIyu/llAiIbMNNi9sA
	 q6Tev1MPYI/VPTUGZuX7UIYImVONUxxVfPU21FEo0EKJ/XSXiKAd6BXruzJedGmaBg
	 1XU0efm+mM7vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AC1BE4642C;
	Mon,  2 Nov 2026 09:25:40 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:37 +0200
Subject: [PATCH v5 1/8] iio: imu: adis: Fix custom reset dispatch in
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
Message-Id: <20261102-adis16607-v5-1-4f98b0d271ac@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=2794;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=SC/SubIQdTMZFTL014FlawEjYwq6iuRw3fYYRQBfK7Q=;
 b=NEgpqLVygM+nDG23xfzaxjfKjvQRdtQbJuMROEdwQsTVjoTgn14nHNkmiFqPWdIAdzQrqfIHl
 kVAdCY0RIAYA9qRllp1or/SSu4peU5owNr2voTIpnyrgscXAi9GoIp9
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

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


