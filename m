Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B512EA498;
	Wed, 17 Jun 2026 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661376; cv=none; b=YL96SG8KglSKg2uiNzO1YEPkgHNu0FzUep54QzaCHshjIRGaePoAT8CUKIWJAgIXzimVtEgxNVq2n48brZJ4T5K4iW9hcXrxoEG39mHGH211FqX5kE6J0TlGiGoxbg4lx3bVLRiyIBkHAWmAMw+VXyafc7RY5RoKAKxiBjWnPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661376; c=relaxed/simple;
	bh=qjPeqOlmNU/riWbGt7a4NeYXglZ96U7tySJCrMzrRSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LKHoIBtYCgsT7LUUcS+oxrt/Pcaj80hSviZMqcbQJ/oFEocR/c1MF8bBVw1OBfYsnBCKyduCn8wD9XxDHCi/oBWtlwpWTXWH4DvAnIsO3OaRdeLxdDxeoi9xkATh+Nz18n4LtFLQ+mLVv/IsY1nVMptFJWp02E0jgS2dHwUB+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgjyk3iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgjyk3iq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DD1FC4AF0F;
	Wed, 17 Jun 2026 01:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781661376;
	bh=qjPeqOlmNU/riWbGt7a4NeYXglZ96U7tySJCrMzrRSU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Qgjyk3iq1b/QOD3z2sqrhyKsfsw4eOE5h/T/gFse21Uw1zdBAtXGKBJJ35hPB1XMB
	 t/4BY4WBehFtNp70zg9vBgXUuwsKIvShaH+qfFAT9qhNkw5uRMkYVDBZ5AlTTWRH2J
	 coJuJEP/wdszYxeoEvl3tOsaILf/2Td52TyJ4kRzlqr2yP3fgZLOmAJimUPbT2v2ST
	 gIC6ZfsPtIACH7Fjd+F06FB+ImTUh0gQicacUfL64SL/sbOJ3t5HQxU8DPnTvkWvVC
	 a1/Yq1PQEKMlOPQU3E811FKQ+hQ7NB7Y6ABy0VYNxY1bFHZNyDBlnwDeE5L7kcDOs7
	 dfwrgRFgYUjiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C46CD98E1;
	Wed, 17 Jun 2026 01:56:16 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 16 Jun 2026 20:56:15 -0500
Subject: [PATCH v3] iio: accel: fxls8962af: clamp the device-reported FIFO
 sample count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-disp-2e8d94cf-v3-1-c4e092eef3a2@proton.me>
X-B4-Tracking: v=1; b=H4sIAL7+MWoC/x3MQQqAIBBA0avErBswLa2uEi3KGWs2FgoRRHdPW
 r7F/w9kTsIZxuqBxJdkOWKBqSvw+xI3RqFi0EpbZRuLa4sk+UTNPQ2tDxhccEoTOWM7KNmZOMj
 9L6f5fT/3yoFuYgAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781661374; l=3254;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=EYfWdZDOsGfm+jKR7ChwMWskcYwWWhSAnxO/QMWeWw8=;
 b=K9AHdy7tvI85JfpIVDolk41qGKVXg8rHTKKMFmLUVNIqCo+1DKiEV3Hi7gCLahXu/Z7gLgkOp
 Zm1NYspPsY3CnZY+H/s0serk7QH8AKerPap17lARqBjVPjM2ZDmqNfx
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

fxls8962af_fifo_flush() transfers the sample count the device reports in
BUF_STATUS into an on-stack buffer sized for FXLS8962AF_FIFO_LENGTH (32)
samples, but the count is a 6-bit field (0..63) that is only checked for
zero. A device, or an attacker on the I2C/SPI bus, reporting 33..63
overflows the buffer by up to 186 bytes: a stack out-of-bounds write.

Clamp the count to FXLS8962AF_FIFO_LENGTH before the transfer, mirroring
the clamp already applied in fxls8962af_set_watermark(). Conforming
hardware reports at most that many samples and is unaffected.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3 (Andy [2]): shrink the commit message; the register/byte detail, the
not-for-stable rationale and the introducing commit moved below the cut.
v2 (Jonathan [1], Andy [2]): clamp with min() instead of min_t(u8, ...);
drop Fixes: and Cc: stable -- this hardens against a malformed
device-reported count, not reachable with conforming hardware ("not a fix
and not back port material", Jonathan).

[1] https://lore.kernel.org/all/20260614144337.3b3dab1a@jic23-huawei/
[2] https://lore.kernel.org/all/ai_RF9BG17SZ7Tiz@ashevche-desk.local/
v1: https://lore.kernel.org/all/20260613-b4-disp-22362900-v1-1-c5e49f6af027@proton.me/
v2: https://lore.kernel.org/all/20260615-b4-disp-1a8c7886-v2-1-072a8d1721e9@proton.me/

count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT is GENMASK(5, 0), so 0..63;
fxls8962af_fifo_transfer() then reads count * 3 * sizeof(u16) bytes, so a
count of 33..63 writes up to 378 bytes into the 192-byte buffer (up to 186
past its end), clobbering the stack canary, saved registers and the return
address. The unbounded count has been present since commit 79e3a5bdd9ef
("iio: accel: fxls8962af: add hw buffered sampling"); not marked for stable
as it needs a malicious or defective device, or bus tampering.

This is a different bug from CVE-2025-38485, the use-after-free in the same
function fixed by commit 1fe16dc1a2f5 ("iio: accel: fxls8962af: Fix use
after free in fxls8962af_fifo_flush"): that commit added a synchronize_irq()
and did not bound the FIFO count, so this overflow is still present at
mainline HEAD.

Verified with an in-kernel KASAN litmus (CONFIG_KASAN_STACK=y) and a
userspace ASan model on x86_64 and i386: without the clamp a device
reporting count=63 drives the transfer 186 bytes past the buffer
(stack-out-of-bounds write, both ABIs); with the clamp it is bounded to 32.
Reproducer and full logs available on request.
---
 drivers/iio/accel/fxls8962af-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 8763e91c63d2..1ecffbf41f64 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -970,6 +970,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	if (!count)
 		return 0;
 
+	count = min(count, FXLS8962AF_FIFO_LENGTH);
+
 	data->old_timestamp = data->timestamp;
 	data->timestamp = iio_get_time_ns(indio_dev);
 

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260616-b4-disp-2e8d94cf-f7f702dd7365

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


