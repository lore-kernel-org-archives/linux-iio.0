Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671076;
	b=IJ1+yEkkVO9jkwopn7qxgVm4V3yLyrxU5vYPEq1o9nRaGhGYygKYmzUTvB7YBgYJYta7
	 sXEn/jEUq5O2CxfiNNrbyS3I7AQdcgifQxHn9nWf+B0UD0zXyW5cTy9IUoOpP1tqrzn1y
	 tSnMlbPSUoSOaVGzjv6HP05zmNp741aIsDUVycabrNfq3CrtLmH1BZquxlNtY1XlueT1X
	 EGy5DvtTY8MqhhRIfcYVknlU/DT1IYZ151NDRvOHWl2luADMM2eYdDr2CN0tx+BK2rbhv
	 hdph8g9IbBYL+ypTV08FJvFhvQADTB3oUoC4IupRCRHzTM3Gs+N+KZaVmhPz0vk5apA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5mSI3ygXKsW/OwLZiR2YvgT/uFmunlZkjWCA05tV8u8=;
	b=BHiaqXkMes2HzADLYYqTiGHiDOuE8GjZ3Mhlm429GEqLBMwiySwhXNokJPVDB3vtMyy+
	 TUucaa3AAHHndGILAszh0aTal4fCTp0LwQpk+SmU5fgPGyw3QEC/X0OXK8Rt9Lcwr0Ao1
	 el9IXapU0pF74x6bm2P1EPCxtzlsg5DC4BBv4IVD9kKU/UQELV3YPLHYKZhCLNeMuHQdk
	 lgZzNJaeh09XJnaUFOAZZwm0ukWuq9juk6SiTU+OanfiCLX6PDRuWQO0iwQoE/UlKsaE0
	 lonC7ZzxLhgxdOSBRxhyH2pDfcvZmwksMkK1bW2o8I/BM2HgzCDEQXCE3SToG0FEtnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXF31PvS;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C8606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 542C8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXF31PvS
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso3402266a12.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671076; x=1796275876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mSI3ygXKsW/OwLZiR2YvgT/uFmunlZkjWCA05tV8u8=;
        b=EXF31PvS6uhy7QwK9PgvUsmqkvUS87utw2nnzx6T7zdhWTDe4GwkemuudlAF4Du6iu
         PIIzCAsOxvPhdKuBxmQm9hjeTzoQyM/KfHWRkgV1vVIzGdfZmi/BCL/WxRXvo47+axl3
         0qbgkMe2T3FQuLV15qXjyJFQujFQx3Fv6aNFsczegue623/8V3fI7lkhjaqhg87elVLg
         6F/kxDPVhmcXYowkk8Ef6qr/d/ji8fpqI5m6NAdkHHkbLbUxyOIsU1rO8jC6EIBB2V6Z
         BlpVYFtuFFYbuarbJeJybM7mljj92LBkgoaGpFYVVQU+uLGs73u7/uhkTRuOFiLXFqL8
         YOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671076; x=1796275876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mSI3ygXKsW/OwLZiR2YvgT/uFmunlZkjWCA05tV8u8=;
        b=1uGaYcPwoF5Nv4WBDkIJAOHyNj3761XiJm9I/5XhB+4myU1+X2PJoduWaXv5OHVaos
         H8VkUBSsuhqtfY7YgfAIlwR8BUUJUDmNsD+rQwoQg97qqkxwrGuXstgIbJss8FVIgjo6
         l5LwG/FoNRoXyiYUanfo1ByO6tlzA81bD7XzaEhSXkMcW+3hf5+Efl5Yi0sRBpw+zR2r
         qg1QWalYeImfbkzmyax2g4xs8xczHU4FxPkjB25KhrmEHLtIsTthmNSli8OmV2cnZB2F
         KqB8d5h+Rs8Zg9Hb+YYhaw2PV8x7aSshOr60G622g1SL9zB2RnvfN+hXsVb6RoazyIja
         GMWw==
X-Forwarded-Encrypted: i=1; AL+hErGKNIlRqE3PClTj7g7nNnURpYqqLCvI5iWj2m/M6kObVd18VVBnWw9PHcXIZycxgkn03iRrTWJ/j0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wGQuu+Col6Tv6gDJXR5AoViPeZT8w8fEHsaDunL21Z3HbIiq7
	xrYxYaQDT3Do7hRqnpWe7wCekppGTm/6pXwyL4kYd0GKr3WxiCDy5/5R5Y2aY5C9AZtQxg==
X-Gm-Gg: AZFdTZfqAELeNzpXxeb6BjqbH9nEDfGHePi662VuDL9KbD+LlfjhQKIs8u6enuMX1BD
	Wlwj52cO+O5aZ3hXWbUsKdBe9dobTP40sCqvlP752WZmENRT8pqw6O3L+qCHJWO8gOH/UENnBIJ
	o5boPGaauWsfiEjgk+vi6Z/J3HiguMlNDZNhyutCEoDwtrxEyccnYRgG4LwGhp97d7RX148u752
	o9n7i+/1R9KsGQ+JygzbAfpjMCYjwEpEeNzTjKtJ9qMvhi6EPzR11X95KifbsvXcFFg7jZObyHM
	TmoEfaNsDErxpZxW2ghZaT7rYSzIbGnSMg4ekY0kb+MMwdg/HkhhWqqwy1Pk9bqKIwTw4vVUTIm
	iGi3ETZn8JZKaoDLPKerloYXEINKzdfgpE80m0pDaCXfdlp8gA87uRjyxYu1oPyfZt42XN7eXxb
	uphbsSeA59OrO0egXZPSJHqK/z/sG2w2DV4PEDZrZMSbtdfhrwNFk/Ql1n/iX5Uwa+E2x3OVNVN
	R3g4YuM1+0gnQUsYXV6A01CclPlmuPruQz1ZKU5NwO0gNlx4+p26If6Pen5Ky+Ydu2G4yh0tBt8
	mr0YdPrNV7LiO5cbnXb8Hz3GgkVk2cnnyHGIN4qIYUOup+m4XDyR0FRt/nAXnnlprDzGzWbdw8f
	5HPiH+BkvuMu3S021DhA9zO6y2Nx0sARWSV4xlzOk4LqDMGe3pGaM4ZCse8ORObetMLCKOVgNYV
	wpWZLyb6LwszQW34nX1n2xh5M=
X-Received: by 2002:a17:90b:3810:b0:3b3:cb3b:1965 with SMTP id 98e67ed59e1d1-3b41c8fe1f8mr19194774a91.16.1795671075704;
        Wed, 25 Nov 2026 21:31:15 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm33700520a91.7.2026.11.25.21.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:31:15 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Wang Shuaijie <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 3/4] iio: proximity: aw96103: wait for the configuration load before freeing
Date: Thu, 26 Nov 2026 11:00:27 +0530
Message-ID: <20261126053033.603086-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126053033.603086-1-kapoorarnav43@gmail.com>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aw96103_i2c_probe() loads the register configuration with
request_firmware_nowait(), and aw96103_cfg_update() runs later and
writes to the driver data and the chip. Nothing waits for it: if probe
fails after the request (e.g. aw96103_interrupt_init() fails because the
device has no interrupt), or the driver is unbound before the callback
has run, the devm-allocated iio_dev that holds that data is freed first,
and the callback then uses freed memory. The regmap and the vcc supply
it uses are devm-managed as well.

Signal a completion at the end of aw96103_cfg_update() and wait for it
in a devm action added right after the request, so it runs before any
of those resources are released.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 504e92ab9b07..b4aa31a65369 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
@@ -118,6 +119,8 @@ struct aw96103 {
 	struct aw_channels_info channels_arr[6];
 	unsigned int max_channels;
 	unsigned int chan_en;
+	/* Signalled when the asynchronous configuration load has finished */
+	struct completion cfg_done;
 };
 
 static const unsigned int aw96103_reg_default[] = {
@@ -605,7 +608,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 		ret = aw96103_para_loaded(aw96103);
 		if (ret) {
 			dev_err(aw96103->dev, "load param error.\n");
-			return;
+			goto out;
 		}
 	}
 
@@ -615,6 +618,16 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 		else
 			aw96103->channels_arr[i].used = false;
 	}
+
+out:
+	complete(&aw96103->cfg_done);
+}
+
+static void aw96103_wait_cfg_update(void *data)
+{
+	struct aw96103 *aw96103 = data;
+
+	wait_for_completion(&aw96103->cfg_done);
 }
 
 static int aw96103_sw_reset(struct aw96103 *aw96103)
@@ -811,12 +824,19 @@ static int aw96103_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	init_completion(&aw96103->cfg_done);
 	ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
 				      aw96103->dev, GFP_KERNEL, aw96103,
 				      aw96103_cfg_update);
 	if (ret)
 		return ret;
 
+	/* The callback uses aw96103, so it must finish before that is freed */
+	ret = devm_add_action_or_reset(aw96103->dev, aw96103_wait_cfg_update,
+				       aw96103);
+	if (ret)
+		return ret;
+
 	ret = aw96103_interrupt_init(indio_dev, i2c);
 	if (ret)
 		return ret;
-- 
2.53.0

