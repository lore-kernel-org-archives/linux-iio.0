Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C67386435;
	Mon, 15 Jun 2026 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557788; cv=none; b=YJVHDVmTP99OvtDq3PJPHkV4sfHkNPjHa6xwaT5ISNZLB8TH0zPik/uMnsQsMmhu0q3C9JtpaLEam55pNsLLsuyY4usZScDOv72Y5pZtijJBB0J4NBgtj6YgpA2T4ZlzM3IDmvV8Q3V0+9OBZdG9ex9+jYhrHl1AFC+lSqdByNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557788; c=relaxed/simple;
	bh=8NR6ObcG14xkPCdSeoafwm3McZnQUv+ovqFPt8ui9WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pr2lwWRkFxbIzm4JJNE4kwyV/WznOcMsX8RmF02jsTqoxQt1cfotI4uj/H67tmGKrQUlngkGi5JRZtF1wMf/5IhrQO3xehHN3hlOv3T44cnvhCRqYwCOdjR8mxhIAo6CTvlNsuOqdbb9toqt5EpLGWDXL8RCU6tbCF2Rx8xaH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmpnNG7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmpnNG7B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CD09C2BCB8;
	Mon, 15 Jun 2026 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781557788;
	bh=8NR6ObcG14xkPCdSeoafwm3McZnQUv+ovqFPt8ui9WE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LmpnNG7Bcy+XZ5aYmBZcr4glwNLrenmI7PaEIchEZUQjWzANj54Q7qQgjhpyefzlV
	 EboTfuq/BCBXvhxEimVJ6yuSi2AcQlsG1P9iV0UUAl9VUz8zNr4N1Fs6XpwFjDz1gK
	 nM3s1/nAORtlvTapL8BuHm69CInJ3QDpGgu4Pn+RsX4aqveNveFSFeFpIPaViz6FQq
	 0+ljs42UP54dEzm7Uz4yDcligE2DLkoEn4vE/vSm5M92UzszhoNRD2x4sFPzF+eCgg
	 MLr5iO22JDT0ZL/auASWuRhk1nvnLEsuLF+weDvJOkmTsMW+kp8HzzWjXIabqkqv54
	 KLv00CrMhyUGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C9CD98DE;
	Mon, 15 Jun 2026 21:09:47 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 15 Jun 2026 16:09:48 -0500
Subject: [PATCH v2] iio: imu: inv_icm45600: clamp the device-reported FIFO
 sample count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me>
X-B4-Tracking: v=1; b=H4sIABtqMGoC/x3MTQqAIBBA4avIrBsw86e6SrTIGms2JQoRSHdPW
 n6L9wpkSkwZRlEg0c2Zr7NCNQLWYzl3Qt6qQUllpW0Neo0b54iBfDso6TAY3RvnXUdWQ81iosD
 Pv5zm9/0AoAycjmIAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Remi Buisson <remi.buisson@tdk.com>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781557787; l=4287;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=5j3TOXUliweVsbrZqo+njvf17WNAXJT8JPkwkj3g8e4=;
 b=lX8/nFY1cjM+5Msb0S98OITTcCf6aeyC2135ltUe4avwq0gWTHobLUBN24kuRXrwZkfCQdxFt
 Rs8q9a/DLKtAlGcQTQmZ3yahlUUXe3pCbgtC9g7UBIGtBNYk/EZzCY/
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

inv_icm45600_buffer_fifo_read() takes the number of samples to fetch from
the device's FIFO_COUNT register and uses it, unclamped, as the length of a
regmap_noinc_read() into the fixed 8 KiB st->fifo.data buffer:

	fifo_nb = le16_to_cpup(raw_fifo_count);
	...
	if (max > 0 && fifo_nb > max)
		fifo_nb = max;
	st->fifo.count = fifo_nb * packet_size;
	regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
			  st->fifo.data, st->fifo.count);

The only bound on fifo_nb is "max", but the interrupt handler calls
inv_icm45600_buffer_fifo_read(st, 0), so on that path the clamp is
skipped. A malfunctioning or malicious device (a counterfeit or
compromised IMU, or a bus interposer) can then report up to 65535 in
FIFO_COUNT, making fifo_nb * packet_size (16 bytes per packet) as large
as ~1 MiB and overflowing the 8 KiB st->fifo.data heap buffer with
device-controlled data.

Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
packet_size), mirroring the existing watermark cap in
inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver, which
bounds its FIFO count to the buffer size. The clamp is a no-op for
well-behaved hardware, whose FIFO never exceeds the buffer size.

This hardens the read against a malformed device-reported count; it is not
reachable with conforming hardware, so it is not marked for stable. The
unbounded count has been present since buffer support was added in commit
06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices").

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2 (review [1] Jonathan Cameron):
- use min() instead of min_t(size_t, ...) (fifo_nb is size_t and
  INV_ICM45600_FIFO_SIZE_MAX / packet_size is unsigned long, so min()
  needs no cast here; builds clean under make W=1).
- drop Fixes: and Cc: stable -- this is hardening against a malformed
  device-reported count, not a fix reachable with conforming hardware, per
  Jonathan ("Not a fix - rather this is nice to have hardening"). The
  introducing commit is now noted in the commit message instead.

[1] https://lore.kernel.org/all/20260614144557.196a5c4c@jic23-huawei/
v1: https://lore.kernel.org/all/20260613-b4-disp-58b984f3-v1-1-352b2f925f58@proton.me/

Reproduced with an in-kernel KASAN litmus mirroring the exact allocation
and the FIFO_COUNT -> regmap_noinc_read() length computation, plus a
userspace AddressSanitizer model for the full magnitude:

  Without this patch (device FIFO_COUNT = 0x208 = 520 packets -> 8320 bytes):
    BUG: KASAN: slab-out-of-bounds ... Write of size 8320
    ... the buggy address belongs to the cache kmalloc-8k of size 8192
    ... located 0 bytes inside of allocated 8192-byte region
  With this patch (count clamped to 8192 bytes): clean, no KASAN report.
  ASan model at the full magnitude (FIFO_COUNT = 0xFFFF -> 1048560 bytes):
    AddressSanitizer: heap-buffer-overflow WRITE of size 1048560,
    0 bytes after the 8192-byte region (reproduces on 64- and 32-bit).

The sibling inv_icm42600 driver bounds its FIFO count to the buffer size on
the same interrupt path (max == 0 -> max_count = sizeof(st->fifo.data));
this restores the equivalent guard for inv_icm45600. Reproducer and full
logs available on request.
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
change-id: 20260615-b4-disp-feb19207-f54857b73e64

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


