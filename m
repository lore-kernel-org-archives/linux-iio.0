Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27039060C;
	Mon, 22 Jun 2026 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118514; cv=none; b=gvKkv66n0EtCH2M2/tU7niuUenJfBrMn/PRHUz9Fg4I9ozLs6dfYO8bf9uH5mNu+J75tGrQBzb8jRWbujP34j07KMhVrWhMq3g4bDgHzqT7GuXaj9pJgAMSgEGaJ1wpeX0ucuvCab1xYOq7goTkAZTfXgaYQnxywU/kdWc9jNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118514; c=relaxed/simple;
	bh=4Apv8CsJQhRk7yelJjKg+7zpCvm7XJwJnAJQ0ESTBhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cwty/jwAjJ9CFF99naO96Eub1rdcw0JWTNBRHiCxh3gxOPqbpbxqpYiSOHZy36H7OaKUYaP82gADplgw8BikQPIR7IVsTSQ0n3FUBTrzVlX/C1r48X10h7S+0rQXNLI8/JiFMTqorGCdQaTgpVxjFb7azwmxF3QFaSqg3SxIaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THLDSwwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THLDSwwq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB51C2BCB4;
	Mon, 22 Jun 2026 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782118513;
	bh=4Apv8CsJQhRk7yelJjKg+7zpCvm7XJwJnAJQ0ESTBhw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=THLDSwwqP8jh+LjVfgV9vRAW0Eu5byboWu2sXwX3seX+8i5TmFchw/Js3niju1MM/
	 O1W4BKLYeeLaG0yT8f/l7XaYMOVc7H3IrSaugzxVo3vR9/aH85zh2CK+LPXrPDT4cq
	 gat6SXYC8xsTnoW+zDS55AuhlLtwDZ3xgOvDnvOQUCUpv5cog30YtE3kUUqMl+eAi/
	 RPnOLDZQFGWTiyHJXWE68jpYGiWeYOyx1qDxacCgtadyzxx3vMX0pwDiejYcGnqX7w
	 h8lLqBSKoc3WCwbgsugUalD2MSEm/FHlRPluc8YYXhHDJ85MfzWiuuK7JCE86J6muQ
	 zBq/fa2q03bmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B7CDB46F;
	Mon, 22 Jun 2026 08:55:13 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 03:55:13 -0500
Subject: [PATCH v4] iio: imu: inv_icm45600: clamp the device-reported FIFO
 sample count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-disp-ca8d55df-v4-1-e306208ecbb0@proton.me>
X-B4-Tracking: v=1; b=H4sIAHD4OGoC/x3MPQqAMAxA4atIZgMaTf25ijhoGzVLlRZEkN7d4
 vgN770QJahEGIsXgtwa9fQZbVmAPRa/C6rLBqrIVIYI1xadxgvt0jtmt6FpBivMTcc1Qc6uIJs
 +/3KaU/oAByG122IAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Remi Buisson <remi.buisson@tdk.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782118512; l=4600;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=xe1uIrNY7gVIBxa290oSlcAmIpUHYZrdadGSkjhELaI=;
 b=QQ5eQ4tI9Yqb3Hr8bVElRTvXB2EBhkg7jiFFTXerEl3cTtmmQFsc6E2y+R6StNHelF0GXigIX
 s1RuWB0EEAZCzQT0tCmqjU2c6+OHTT/nu1v9bJ0DTQQJpbD2BB9t4YL
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

inv_icm45600_buffer_fifo_read() uses the FIFO_COUNT the device reports,
unclamped, as the length of a regmap_noinc_read() into the fixed
INV_ICM45600_FIFO_SIZE_MAX (8 KiB) st->fifo.data buffer. The only bound is
the caller's "max", which the interrupt path skips (it passes 0). A device,
or an attacker on the bus, reporting up to 65535 makes the read as large as
~1 MiB: a heap out-of-bounds write of device-controlled data.

Clamp st->fifo.count to the buffer capacity before the read, and allocate
the buffer with the same INV_ICM45600_FIFO_SIZE_MAX define, so the bound
and the allocation reference one constant. The clamp is a no-op for
conforming hardware.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4 (Jonathan [3]): clamp the byte count directly --
    st->fifo.count = min(fifo_nb * packet_size, INV_ICM45600_FIFO_SIZE_MAX) --
    rather than dividing then multiplying by packet_size. fifo_nb is unused
    after this point (the read, the one-by-one fallback and the decode loop all
    bound on st->fifo.count), so clamping the byte count is sufficient. Also
    allocate st->fifo.data with INV_ICM45600_FIFO_SIZE_MAX in _core.c (was a
    bare 8192) so the allocation and the clamp reference one define.
v3 (Andy [2]): shrink the commit message; register/byte detail below the cut.
v2 (Jonathan [1]): use min() instead of min_t(size_t, ...); drop the backport
    tags -- hardening against a malformed device-reported count, not reachable
    with conforming hardware.

[1] https://lore.kernel.org/all/20260614144557.196a5c4c@jic23-huawei/
[2] https://lore.kernel.org/all/ajEMfH-_76M1OBqE@ashevche-desk.local/
[3] https://lore.kernel.org/all/20260621190804.04894168@jic23-huawei/
v1: https://lore.kernel.org/all/20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me/
v2: https://lore.kernel.org/all/20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me/
v3: https://lore.kernel.org/all/20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me/

fifo_nb = le16_to_cpup(raw_fifo_count) is 0..65535; the interrupt handler calls
inv_icm45600_buffer_fifo_read(st, 0), so the "max" clamp is skipped, and
fifo_nb * packet_size (16 bytes per packet) reaches ~1 MiB into the 8 KiB
buffer. Present since 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support
in iio devices"); not marked for stable as it needs a malicious or defective
device, or bus tampering.

Reproduced with an in-kernel KASAN litmus and a userspace ASan model: without
the clamp a FIFO_COUNT of 0x208 (520 packets -> 8320 bytes) gives a
slab-out-of-bounds write past the 8192-byte region, and 0xFFFF (1048560 bytes)
reproduces under ASan on x86_64 and i386; with the clamp the read is bounded to
the buffer. Reproducer and full logs available on request.
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 7 +++++--
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index 2b9ea317385c..42111c543d3c 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -422,8 +422,11 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
 	if (max > 0 && fifo_nb > max)
 		fifo_nb = max;
 
-	/* Try to read all FIFO data in internal buffer. */
-	st->fifo.count = fifo_nb * packet_size;
+	/*
+	 * Read all FIFO data into the internal buffer, clamping the
+	 * device-reported count to the buffer capacity.
+	 */
+	st->fifo.count = min(fifo_nb * packet_size, INV_ICM45600_FIFO_SIZE_MAX);
 	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
 				st->fifo.data, st->fifo.count);
 	if (ret == -ENOTSUPP || ret == -EFBIG) {
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index d49053161a65..c1d7aa7e950d 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -716,7 +716,7 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 
 	dev_set_drvdata(dev, st);
 
-	st->fifo.data = devm_kzalloc(dev, 8192, GFP_KERNEL);
+	st->fifo.data = devm_kzalloc(dev, INV_ICM45600_FIFO_SIZE_MAX, GFP_KERNEL);
 	if (!st->fifo.data)
 		return -ENOMEM;
 

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260622-b4-disp-ca8d55df-639ce5537512

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


