Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594184;
	b=rqJii1rfycyg+JeBKCBPzwCaltvhJ9iuRtcDnCcDiZ9Qetft80w8DtsKaNrJ8wX44CtF
	 pzDx1xoWXvAQbT8c/sGrfIj7lRONwNujj53ZEkbtikv9MeYE4LlNKmGckjpdPVmuz86t8
	 yULzH5bu5eTxQbXlC3jJgeilHifdXV4320rlSRSMxuP/Qh57iwC1/iOYfF/KKTtwu+8CI
	 i15QvujR7mNSI/88TOYdJcvZjIa5MpI7fakrGgld163/vIfzdQkJF38oE07PnCU/7Dhgo
	 fu/8s2dapRMuOrGvDFhAq7biecHFV4Pq4k9gIf5f2MchmNLGbLH6rwXI/2yxh/W3uYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594184;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A+43Ngp34qQ6Pwnw6V0uikrG+/eUrfHRHkaCmN3yD74=;
	b=dbfAZwhTaIsJKJ5L01OjVdWmmnEoENuwmrDF4ZXGEI4K+99i1PQliMSHP6a+HHNSWUho
	 nBMeUhU26ZFiHfadvG8isWQcL5AuUR/kWNwHZR8LxGAZ1PTMECSULwX9lsPvPhAmLe+aH
	 wPanf+T/Z3M4SKvMMJ5I1+gZZ7jTkFPfS8IjSnqDmYs1eSKx14FclaszMlthfsOCquXco
	 +dufAOMQh2VbRkLBfXSLdcS0gXkML7ThKwpcPDyn0JPpkClA7fln6rNuQom89SUqTp3l4
	 yPgo81Y7FXr5AP4aSq3JEvqLoAcBqJRWswJMLTcTYyg6SVJxMnui9RlG+Gumi03+2SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgQCKE6x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB75606A329;
	Wed, 25 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgQCKE6x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795594184;
	b=ihTGhtOYPP6exBZrdeXKT84+cgARmpGJ8MYfIZknN0YNht3tQKjX8gns/CiSQ4rBq2qP
	 do+cLccluW0HYhue/G4+B87FXvvVPF9iWA5lt2I03Kgjcg7IOTXaD17vSd8tiMcknTkn8
	 kWAI5Z7LgNMzJ923cRlCMO/CacQboXbDVTiJZVZyr6nOxZiVgegC7J2+ui9KAigh6iD6Q
	 MiQIj2j6sFCGOmnrsM5D/gN3Ayu9K7d5597RB2D5nArbRDbP6FNELW5gp+PxmkoRpWHl3
	 mis595tDVnORSNZxEWjIxsva0wCxfOiKelAKw5VdE0y1nCPbogUF1KLasRY5GLl/GXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795594184;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A+43Ngp34qQ6Pwnw6V0uikrG+/eUrfHRHkaCmN3yD74=;
	b=u0EI5LPJjvGZ/44wjbyBJ9xEfuZgjCxXJLMlwxijJ2LGf8uiLCjf+ysRTF+4lfM+ijMk
	 rqykWkWNesmr29FH64O4hrIIfdrRSy0ENImFv9GxKp+w39IDOwBVJmNQdZzvAxblU1jzr
	 0V0oStW0Da2L6hBMN0npHwtIL4IdZSGCigZ6c19Fm35ghnbiZsL0pph7DUehy5iRG7aXb
	 zYbHfzxyZ8FL/2gBm9jeuf2YV8DRa5iybfZMi0uYIx/+DJbmfApCjrIpyDlzp2EJVn9Ff
	 ZSD4uwW8FPdo7tMK8nSMVFCB3hTPxbbcT/9FcIxNVx+v/bLCys1nRMiT1Krd3cVeycQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B01B31F000C4;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594184;
	bh=A+43Ngp34qQ6Pwnw6V0uikrG+/eUrfHRHkaCmN3yD74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TgQCKE6xyhZeVYOC9MmvBUdYH6mOmr9xU0VDnfGgAXIQ/S4kfUfySRFsii8HrV4N6
	 iv9/bw2H6YNmSFlYfY0u4HEaavALW6LRcYvV3i1ZQAvpkvi7jqOyCMP+btF0VjDkCc
	 KABYeL6KzRUx4f0ANTqmG7A2jnel5IahRIOl00EbByJtzndbOcyOgm5qJlfL8oqMGF
	 IRndzSL4c8554YatJ+G4X0znQOw0kj+vqlX6+znlaXoFE8Q7xFxyI8VwHGIXmCnbBW
	 hgBQUTlInuq1Tmj1U6NUuodkFBypqNSYVuwbC6QDAZ6q7e9nH30RbTKviD73k6EeXe
	 ZP96eX/Fgstvg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 38AC54CD70;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 25 Nov 2026 08:09:30 +0000
Subject: [PATCH v2 1/3] ASoC: codecs: nau8360: set val_bits to the widest
 register size
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
Message-Id: <20261125-regmap-kunit-val-bits-v2-1-81db3b79cd3f@gmail.com>
References: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
In-Reply-To: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795594173; l=1897;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=JtoiIZBSgQWLgUfHX+0oV8XepiuXh0sLdsFtw7Od4h8=;
 b=1pnp4emTHZHWJ/xOuImgjppfJ1X+BZki0slWTa1vwKXToTv/KnEDt60B4D9OEe45m5Bi5Nnam
 Q0GX083bRUaC2Kr63Dj1SlROLEJmAjHGuiqeZ4mDT3Er2pDwyDIZCIf
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

The regmap is configured with val_bits = 16, but the two DSP registers
are 32 bits wide: nau8360_reg_write() sends four bytes for them, and the
DSP messages written with snd_soc_component_write() use all 32 bits.

This works because the driver provides its own reg_read() and
reg_write() and regmap passes the value through unmodified. As regmap is
going to mask values to val_bits, set it to 32, the size of the widest
register. The size of each access is still selected in the driver's
reg_read() and reg_write().

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 sound/soc/codecs/nau8360.c | 3 ++-
 sound/soc/codecs/nau8360.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index f0942739d7ab..d4cab3c8e29d 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -1918,7 +1918,8 @@ static int nau8360_reg_read(void *context, unsigned int reg, unsigned int *value
 
 static const struct regmap_config nau8360_regmap_config = {
 	.reg_bits = NAU8360_REG_ADDR_LEN,
-	.val_bits = NAU8360_REG_DATA_LEN,
+	/* Codec registers are 16 bits wide, DSP registers are 32 bits wide */
+	.val_bits = 32,
 
 	.max_register = NAU8360_REG_MAX,
 	.readable_reg = nau8360_readable_reg,
diff --git a/sound/soc/codecs/nau8360.h b/sound/soc/codecs/nau8360.h
index 71396747c0fa..3d9711804073 100644
--- a/sound/soc/codecs/nau8360.h
+++ b/sound/soc/codecs/nau8360.h
@@ -123,9 +123,8 @@
 #define NAU8360_RF002_DSP_COMM			0xf002
 #define NAU8360_REG_MAX				NAU8360_RF002_DSP_COMM
 
-/* 16-bit control register address, and 16-bits control register data */
+/* 16-bit control register address */
 #define NAU8360_REG_ADDR_LEN			16
-#define NAU8360_REG_DATA_LEN			16
 
 /* NAU8360_R03_CLK_CTRL0 (0x03) */
 #define NAU8360_MCLK_DIV_SFT			10

-- 
2.56.0


