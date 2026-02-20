Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31D34CFDE;
	Fri, 20 Feb 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597004; cv=none; b=SWc3KzQ5+NucNIcIxCSk/TLvBKtpntK/e8siitfLFXWFqhdpDEpdmbJRzO4TSvgykM9sObil4bW+aZQ+Oww/TwNbwjri2VncjaN4HnvEADq9yeNBolaKkJDl/8ei4I8lKw3HyHd7vDLuudTOz81Kgl4oXOzv/2Y9HlC6azNeWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597004; c=relaxed/simple;
	bh=MZecz68iDjv6pgwEGfUpFIteBjcFxBapw3Gv1rXHO5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rC6yWmGjvYyUJZkoA9uOYKBLqj2ySgJHH+tahvCl7rF5QbwDZMmMzFmchsKfqowMg8CHJeiEpvnZyxfxv8GpXiO7ESEWnNBf4L3R9my3piH1Jcej2dgS6b4Cvd6xK/FEza8wbEOVfk3mnyVg/tOadjMlkdjTycTRQ0DV5SEPbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8/2sIDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8/2sIDb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9416BC116D0;
	Fri, 20 Feb 2026 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771597003;
	bh=MZecz68iDjv6pgwEGfUpFIteBjcFxBapw3Gv1rXHO5o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=p8/2sIDbUfWIS6ZOQfNb8sGxydESaWJPET5nEXxkjKOx1+Pe3CpOKN0nvOCpdJDfN
	 JIll0KqlJwfdCM5a6cbfSXvNs7rzvR0mXO2Zk/NsqZeGcWdvNSbr3t+Gh151C7TMRA
	 oxPHG8fnu9bohD4b6OGk97A+Y1Jmblje06+k2Qs77iXHgQhg3u2UDW7d0f9XiL7ifn
	 M0DdGePUWZ01yOoRQjAgCA4gUjawJLZwUDoExvmQFbA/zg4gPdk96aaUXhtnOs/oMP
	 JLqXX+0YsvSxmPrPRAuLmUAfzySBQtzqnYO0MCHiS0TFcmZjwH1050qmwMfwD53RGT
	 WbvJuxIRzWoBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A6C55AB9;
	Fri, 20 Feb 2026 14:16:43 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 20 Feb 2026 16:16:41 +0200
Subject: [PATCH v2] iio: imu: adis: Fix NULL pointer dereference in
 adis_init
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-adis-fix-v2-1-4cc24a261306@analog.com>
X-B4-Tracking: v=1; b=H4sIAMhsmGkC/22MQQrCMBAAv1L27EqyqK2e/If0sKSbdkETSSQoJ
 X839uxxhmFWyJJUMly6FZIUzRpDA9p14BYOs6BOjYEMnQyRQZ40o9c32r53bA7mOA0MLX8maXp
 b3cbGi+ZXTJ/tXOzP/pkUixbPnq1xTgZL/sqB73Heu/iAsdb6BXwUTcKhAAAA
X-Change-ID: 20260220-adis-fix-177ca0405d8a
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Robert Budai <robert.budai@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771597002; l=3393;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=j7cynfRXNkYO1RlmBQEKsd6iLn8cQ9DPq0pFxeWKoVc=;
 b=VZwmslO2FNTnjjbSNylbaZMamDujGeJcM7vTTCrv93vtTDh2f2PDkF24gUuH9mf5cp5j8oZug
 RfnQeyM6zEFDTYHZTs8zb/UwENY9MqkXp4arbRbdNnqzsOU9XGEDLji
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

The adis_init() function dereferences adis->ops to check if the
individual function pointers (write, read, reset) are NULL, but does
not first check if adis->ops itself is NULL.

Drivers like adis16480, adis16490, adis16545 and others do not set
custom ops and rely on adis_init() assigning the defaults. Since struct
adis is zero-initialized by devm_iio_device_alloc(), adis->ops is NULL
when adis_init() is called, causing a NULL pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    pc : adis_init+0xc0/0x118
    Call trace:
     adis_init+0xc0/0x118
     adis16480_probe+0xe0/0x670

Fix this by checking if adis->ops is NULL before dereferencing it,
falling through to assign the default ops in that case.

Fixes: 3b29bcee8f6f ("iio: imu: adis: Add custom ops struct")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
adis_init() dereferences adis->ops to validate its function pointers
  before checking whether adis->ops itself is NULL. Drivers that rely on
  the default ops (adis16480, adis16490, adis16545, among others) never
  set adis->ops prior to calling adis_init(), so the field is NULL due to
  zero-initialisation by devm_iio_device_alloc(). The result is a kernel
  crash on probe:

      Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
      Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
      pc : adis_init+0xc0/0x118
      lr : adis_init+0x50/0x118
      Call trace:
       adis_init+0xc0/0x118
       adis16480_probe+0xe0/0x670
       spi_probe+0x8c/0xf8
       really_probe+0xc4/0x2b0

  The bug was introduced in 3b29bcee8f6f ("iio: imu: adis: Add custom ops struct")
  which added the ops validation logic without a prior NULL check
  on the pointer itself.

  The fix is a one-line addition of !adis->ops to the condition, so that
  a NULL ops pointer is treated the same as an ops struct with all-NULL
  function pointers, both falling through to the default ops assignment.
  The validation path for partially-populated custom ops structs is
  unchanged.

  Tested on Raspberry Pi 5 with adis16545-3 connected over SPI. Without
  the fix the kernel crashes at adis_init+0xc0. With the fix the driver
  probes successfully and the device is accessible via the IIO subsystem.
---
Changes in v2:
- put stack trace in a single line in the commit body
- split long line if in multiple statements and removed the redundant ones
- use correct git hash for fixes tag
- Link to v1: https://lore.kernel.org/r/20260220-adis-fix-v1-1-9fa10cce812f@analog.com
---
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index d160147cce0b..a2bc1d14ed91 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -526,7 +526,7 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
-	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
+	if (!adis->ops)
 		adis->ops = &adis_default_ops;
 	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
 		return -EINVAL;

---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-adis-fix-177ca0405d8a

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


