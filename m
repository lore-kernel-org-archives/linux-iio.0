Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252E3B6C15;
	Mon, 15 Jun 2026 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556198; cv=none; b=BTXpV2WfOnFd2ulhTq3PkWvCITy2NiFg+OdIsb8pofPOB7v1GjrRx1eFyKRqN91hJivPz7ToWuzMflvBKZJAWycOuQBmELc+0QzAGPjJnEvvVZpdW4m9ErBpsYJp/0/u8LNsu6eFeUopWtSAEqeaST5GCc6vtVC2GVkUH3uLXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556198; c=relaxed/simple;
	bh=fpjIHetr0SzMrBfzKQ4r/eaKYkdsvtCuloijxjKKTPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pDCqQBccTlAn72dn2SLXX6YessSGRQskBclfPo+tAoNXRpqU5wT/aBzAJMIGh37Cg/liWSOXmFEJopVE3mky/Vct5uMCrsTZzgaNuBXwn5PARg8nKVPPscf2UH4uPncC1sYu6mJHpIdtXSV0e0IvdLn3kORsZEiv1/DQgfYIwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUDd5zcA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUDd5zcA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FF7FC2BCB8;
	Mon, 15 Jun 2026 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781556198;
	bh=fpjIHetr0SzMrBfzKQ4r/eaKYkdsvtCuloijxjKKTPE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GUDd5zcA/McTeL8TkKO+UDtpLX64lwk5DLJuhg6Pv/F71r5QZdrDn6VQfPOKzRL57
	 pH3oMW4QcnOsnjUwSk2hAnlQrukjm+KOkvljWtd4EUjZ33PTrX7709ZeRJQuriTbye
	 CDamBeVZ4wmQyyRYwqPbndq0T95qpZTaiEZ6fV+s8ix/FNE0wekAfpi4ThKiNxpujS
	 If9xzIyzWtIvTNwXLd3sMjtn5q/bwz/f68qZy9TR8BCI2z/diiqdj+u8VXRvOpKpwz
	 EY43knTdOJos2p3AMs7yn6cuNHq0kL3e6PMzBMuOcuxMXnQ02lUjvCl1HW1VQKmH+o
	 zxm1wAn9oMFRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5DCCD98E2;
	Mon, 15 Jun 2026 20:43:17 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 15 Jun 2026 15:43:17 -0500
Subject: [PATCH v2] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-disp-ef4f7a59-v2-1-af5e980bcdd7@proton.me>
X-B4-Tracking: v=1; b=H4sIAORjMGoC/x3MQQqAIBBA0avErBswS8uuEi2mHGs2FgoRRHdPW
 r7F/w9kTsIZxuqBxJdkOWKBritYd4obo/hi0EpbZRuDS4de8okcutCTcdgqGpyzREY7KNmZOMj
 9L6f5fT8b2nTZYgAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781556196; l=3276;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=E/bT4EkVn+3iqP2XSaNpCV/pBBTqGy2zQ21wB6ceRL4=;
 b=PXWkrkqYThMHD3rxqBUcbkAjG9XFvr/XtEHGnLGpaM6Rl8UniD1G4+hYuGQvmXh5B1lWL8K7z
 9qyuqeCpzzNCP7N6DkgCr/ntZiTPcLbb9fV3aTwTdbmmD3I//M3J+vG
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

__bmc150_accel_fifo_flush() copies the number of samples the device
reports in its hardware FIFO into an on-stack buffer

	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];

which is sized for at most BMC150_ACCEL_FIFO_LENGTH (32) samples. The
frame count is read from the FIFO_STATUS register and only masked to its
7 valid bits:

	count = val & 0x7F;

so it can be 0..127. The only other limit applied to it is the optional
caller-supplied sample budget:

	if (samples && count > samples)
		count = samples;

which does not constrain count on the flush-all path (samples == 0), and
leaves it well above 32 whenever samples is larger. count samples are
then transferred into buffer[]:

	bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);

bmc150_accel_fifo_transfer() reads count * 6 bytes through regmap, so a
malfunctioning, malicious or counterfeit accelerometer (or an attacker
tampering with the I2C/SPI bus) that reports up to 127 frames writes up
to 762 bytes into the 192-byte buffer: a stack out-of-bounds write of up
to 570 bytes that clobbers the stack canary, saved registers and the
return address.

Clamp count to BMC150_ACCEL_FIFO_LENGTH, the number of samples buffer[]
is sized for, before the transfer, mirroring the watermark clamp already
done in bmc150_accel_set_watermark(). A well-formed flush reports at most
BMC150_ACCEL_FIFO_LENGTH frames, so legitimate devices are unaffected.

Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware fifo")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: use min() instead of min_t(u8, ...) per Jonathan Cameron's review [1].
    count is u8 and BMC150_ACCEL_FIFO_LENGTH is 32, so min() does the
    comparison as int and the clamped result (<= 32) fits back in count;
    builds clean under make W=1.

[1] https://lore.kernel.org/all/20260614141146.697dde04@jic23-huawei/
v1: https://lore.kernel.org/all/20260613-b4-disp-24d6b15f-v1-1-f5c3fe7294fc@proton.me/

Reachable on every FIFO flush (watermark IRQ or the sysfs buffer-disable
an in-kernel KASAN litmus (CONFIG_KASAN_STACK=y) and a userspace ASan model
on x86_64 and i386: without the clamp, a device reporting 127 frames drives
bmc150_accel_fifo_transfer() past the 192-byte on-stack buffer (stack
out-of-bounds write); with the clamp it is bounded to 32. Reproducer and
full logs available on request.

path: bmc150_accel_fifo_flush -> __bmc150_accel_fifo_flush). Verified with
---
 drivers/iio/accel/bmc150-accel-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2398eb7e12cd..24152be18cb4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -991,6 +991,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	if (samples && count > samples)
 		count = samples;
 
+	count = min(count, BMC150_ACCEL_FIFO_LENGTH);
+
 	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
 	if (ret)
 		return ret;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260615-b4-disp-ef4f7a59-30a8996aa529

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


