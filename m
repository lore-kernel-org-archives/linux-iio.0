Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF13C3C07;
	Sat, 13 Jun 2026 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338399; cv=none; b=tCUhjIAkvIWcdCX6tA130XDVREU44Uu40g1YbvR+BimAG+IcRmZHQQGDf3EK3fc6lIecLHOSzbbgil7AsZZ6TNYQ5l8FN2gNhqB0qhtJNucNhcWgGgr7edekB0YNALVQQ+TsJC/wX9sS6t7Op8IuTbs56F5yj02gHvsVxusXdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338399; c=relaxed/simple;
	bh=tyoM3rTkPdiM/lN903783vOG1wz7eBOsIx+fjRonJEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jCC7Bu40JyDLIkF/hSEY703X0tTRPbXb6+Clv2Q/otnQkExDQ1C50ZajHPSDCeF0XIQJCSFtSxJmXVgA1W9h7Ra4rP4WKZmDcActqi5Qdewl84gUz/JqeWB2FV0SYlH9XQDedDWDkMzmUHhqCTlhWrjpPHrFTDRU+yVzXMixB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgQUaUz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgQUaUz/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B684C19425;
	Sat, 13 Jun 2026 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781338399;
	bh=tyoM3rTkPdiM/lN903783vOG1wz7eBOsIx+fjRonJEg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BgQUaUz/I8oO/rG9/kaGQ6U3K2s3VVlFOQLAfFBONFpKj+mErTJ5hEQ5SZbAkvzyv
	 J0VuMmhn3ZmTCMTGj42+dS800OZ0rEk+FHedvlH4x+3ITkQybjq//KOiMzJ7PXTQ1R
	 hwSThjN3sDiUei70v7wTS0Dmq92rOTWvgMAP2qMo+dpNd88ahHpqYV/wX3H/10dvbo
	 t1Lf0lxvhxQD6kysEzew3M6dkEGsAMji0uf349O1LaMJfACnH75v4F54fLQK2WQfjZ
	 cQtfYPsHsL1GuqWSljgC6aJCYjzxTbLFqlPwA2vJ2QQ0x8Z5WkC+/2zvpyPAXCGKSe
	 T94kTk1SzsA4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1FCD98D2;
	Sat, 13 Jun 2026 08:13:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 13 Jun 2026 03:13:19 -0500
Subject: [PATCH] iio: accel: fxls8962af: clamp the device-reported FIFO
 sample count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-b4-disp-22362900-v1-1-c5e49f6af027@proton.me>
X-B4-Tracking: v=1; b=H4sIAB4RLWoC/x3MMQqAMAxA0atIZgNpWgt6FXFQGzVLlRZEkN7d4
 viG/1/IklQyDM0LSW7NesYK0zawHnPcBTVUAxN78sbi4jBovpDZeu6JcPNk3BKo651Aza4kmz7
 /cpxK+QDbkw+JYgAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781338398; l=3598;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=pREP1uFWXVwXkWAbHlcUOetdWzMCYtAeass2fBY2qT0=;
 b=shQQc3236zNSZVFnsbDnoULPUcXvIHQbtvFHgVXQnMnpeW4Z+ucOBouVpbSGkkZytolKsj33O
 ABt4f+wueGcD2hxkWGS5niBY0pO9EJOco1iJG9kzLzd3i+eNu2XJGMt
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

fxls8962af_fifo_flush() copies the number of samples the device reports
in its hardware FIFO into an on-stack buffer

	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];

which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The count
is read from the BUF_STATUS register and masked with a 6-bit field:

	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;

where FXLS8962AF_BUF_STATUS_BUF_CNT is GENMASK(5, 0), so count can be
0..63 - nearly double the 32-deep FIFO the buffer is sized for. The only
check applied to it is the zero test; unlike the bmc150 flush there is no
caller-supplied bound at all. count samples are then transferred into
buffer[]:

	fxls8962af_fifo_transfer(data, buffer, count);

fxls8962af_fifo_transfer() reads count * 3 * sizeof(u16) = count * 6
bytes through regmap, so a malfunctioning, malicious or counterfeit
accelerometer (or an attacker tampering with the I2C/SPI bus) that
reports a count of 33..63 writes up to 63 * 6 = 378 bytes into the
192-byte buffer: a stack out-of-bounds write of up to 186 bytes that
clobbers the stack canary, saved registers and the return address.

Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
sized for, before the transfer, mirroring the watermark clamp already
done in fxls8962af_set_watermark(). A well-formed flush reports at most
FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
This is a different bug from CVE-2025-38485, the use-after-free in the same
function fixed by commit 1fe16dc1a2f5 ("iio: accel: fxls8962af: Fix use after
free in fxls8962af_fifo_flush"): that commit added a synchronize_irq() in
fxls8962af_buffer_predisable and did not bound the FIFO sample count, so this
stack overflow is still present at mainline HEAD.

I reproduced the out-of-bounds write with an in-kernel test that drives
the fxls8962af_fifo_flush() buffer geometry verbatim under KASAN
(CONFIG_KASAN_STACK=y), with the device-supplied sample count:

  count=36, no clamp:
    BUG: KASAN: stack-out-of-bounds in ...fifo_flush
    Write of size 216 ... [32, 224) 'buffer'   (the 192-byte buffer)
  with this patch (clamp to FXLS8962AF_FIFO_LENGTH): the transfer is
    bounded to 32 samples, no KASAN report.
  a well-formed (<= 32 sample) flush is unaffected, no KASAN report.

The full device range - count=63, a 378-byte write = 186 bytes past the
buffer, smashing the stack canary and the return address - reproduces the
same way under userspace AddressSanitizer on both -m32 and -m64.

The FIFO sample count is read over I2C/SPI from the accelerometer, so
triggering this requires a malicious or defective device, or tampering
on the bus.
---
 drivers/iio/accel/fxls8962af-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 8763e91c63d2..fdd049223006 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -970,6 +970,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	if (!count)
 		return 0;
 
+	count = min_t(u8, count, FXLS8962AF_FIFO_LENGTH);
+
 	data->old_timestamp = data->timestamp;
 	data->timestamp = iio_get_time_ns(indio_dev);
 

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260613-b4-disp-22362900-f6014bd0594e

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


