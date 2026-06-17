Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DC72627;
	Wed, 17 Jun 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661448; cv=none; b=gVbjX9Oqbd3vgdbIKkc/x1mTlDg2Zdrv+K54OXhzNSbgnb8HLqxxpVTh49b0setjzS3WTqNeWeDXq8Zc94H/9hxPKpWDcGdkyCO4Y7p1zPuGnbcTe/aEgmjLByI53rEgE0e8sNidaEM/sPY0hlpT6WCX/vemuwjhSTIYpwHAhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661448; c=relaxed/simple;
	bh=58f3TAbK48fW96V5CQ7OODzhoZJvBg6h/FfavTTvGWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EQryDbBuB9ZjhpsHDYicVp6ySX0I3zGMNkmOslcqKL7V7E2GV3JCgeu6a2RQDGXkepc4kIfju9C249gPvPaHgAim4yXG7bCrkTyCvJhQK7bjf2PtSKz/x3tH9iNo8+zgkErJ5wsVthX6Ig8a7mlLM3NXgEibqXI4AOMnwGfstIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O39eyjLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O39eyjLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 574EFC2BCB7;
	Wed, 17 Jun 2026 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781661448;
	bh=58f3TAbK48fW96V5CQ7OODzhoZJvBg6h/FfavTTvGWo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=O39eyjLZ3bLz7i982UE6D1XqDtHvUs29G835RgziQMBezhL3nLjQjsYNdq8LpPMtY
	 t49VCIWZVD75jr+eLVul6MJFPGgtd6Won6r1N1e5A/iBz5tteU8QsVwnhT/+omW7x0
	 by8Rj8mQ7Qhi1xReLh+zW0SsnuGvdMocgsE9P7GLHmReoMatl6cDgdOOV2aCimMNhG
	 iSqrYdLgroQG4m0Kh2KNRTu6xBYoAAvHKrOT3MkFqufmdCuED+wB5OetSmviG6oHrb
	 +aVgx6qWT5KaVvPahSAI7stm6tmFi9cGZmphfpNOuQX/5ynvA9DOeeU+8xOlYD2wr6
	 ZYaImYdvyP38A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F1CD98EE;
	Wed, 17 Jun 2026 01:57:28 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 16 Jun 2026 20:57:28 -0500
Subject: [PATCH v3] iio: imu: inv_icm45600: clamp the device-reported FIFO
 sample count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me>
X-B4-Tracking: v=1; b=H4sIAAf/MWoC/x3MQQqAIBBA0avErBsolbG6SrSoHGs2JQoRiHdPW
 r7F/xkSR+EEU5Mh8iNJ7qtCtw3s53odjOKqQXWKOuoJN4NOUkBLrL01GsfBKbNbppUN1CxE9vL
 +y3kp5QPHnSCzYgAAAA==
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781661447; l=3241;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=eW5J0QMRckFzzjMN390KcVFdu6pXodW5o1qjHfegiwM=;
 b=nPV0rM9j+MBsRn3+QL/trmgMPBHPJv6rucTuasakqBRJadcJdkMtaz2/yv1WVv3vov1JyhF6e
 uL01fON7sjyDCn3w+UI8O7LWlOZ/7ig95hQd9cIhuqAECrEw+1bBxMb
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

inv_icm45600_buffer_fifo_read() uses the FIFO_COUNT the device reports,
unclamped, as the length of a regmap_noinc_read() into the fixed 8 KiB
st->fifo.data buffer. The only bound is the caller's "max", which the
interrupt path skips (it passes 0). A device, or an attacker on the bus,
reporting up to 65535 makes the read as large as ~1 MiB: a heap
out-of-bounds write of device-controlled data.

Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
packet_size) before the read, mirroring the watermark cap in
inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver. The clamp
is a no-op for conforming hardware.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3 (Andy [2]): shrink the commit message; the register/byte detail, the
not-for-stable rationale and the introducing commit moved below the cut.
v2 (Jonathan [1]): use min() instead of min_t(size_t, ...), and drop the
backport tags -- this is hardening against a malformed device-reported
count, not reachable with conforming hardware ("nice to have hardening",
Jonathan).

[1] https://lore.kernel.org/all/20260614144557.196a5c4c@jic23-huawei/
[2] https://lore.kernel.org/all/ajEMfH-_76M1OBqE@ashevche-desk.local/
v1: https://lore.kernel.org/all/20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me/
v2: https://lore.kernel.org/all/20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me/

fifo_nb = le16_to_cpup(raw_fifo_count) is 0..65535; the interrupt handler
calls inv_icm45600_buffer_fifo_read(st, 0), so the "max" clamp is skipped,
and fifo_nb * packet_size (16 bytes per packet) reaches ~1 MiB into the
8 KiB st->fifo.data buffer. Present since 06674a72cf7a ("iio: imu:
inv_icm45600: add buffer support in iio devices"); not marked for stable as
it needs a malicious or defective device, or bus tampering.

Reproduced with an in-kernel KASAN litmus and a userspace ASan model:
without the clamp a FIFO_COUNT of 0x208 (520 packets -> 8320 bytes) gives a
slab-out-of-bounds write past the 8192-byte region, and the full magnitude
(0xFFFF -> 1048560 bytes) reproduces under ASan on x86_64 and i386; with the
clamp the read is bounded to the buffer. Reproducer and full logs available
on request.
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index 2b9ea317385c..5cde42f70c2e 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -422,6 +422,9 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
 	if (max > 0 && fifo_nb > max)
 		fifo_nb = max;
 
+	/* Limit to the internal buffer capacity; the count is device-provided. */
+	fifo_nb = min(fifo_nb, INV_ICM45600_FIFO_SIZE_MAX / packet_size);
+
 	/* Try to read all FIFO data in internal buffer. */
 	st->fifo.count = fifo_nb * packet_size;
 	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260616-b4-disp-76e3f743-98d24c7e6ae4

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


