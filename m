Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816B343D91;
	Fri, 20 Feb 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594584; cv=none; b=OBCga0gPlsvzf3RCOYZQXezo1vouBcvo/fy9IsaESXj8eZsvyu+0I8Vtp4SPcIp8R9+/mWYFkokUEarcPhFKblWqxXe3TAxf32u4QSHcbiVNwKM74Q+djsiHexWcz0pVwXVYBuqsSX23RC7Ui0u96Y4elhFyyyb3a69sr5hl7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594584; c=relaxed/simple;
	bh=dMId3ZV9kqzUHPVu1T1WTkrU1f5ZyLlqLFUV3S1K8fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mpxfK5O5MA1KKibBKNDQ64ZxLl4MrfVRWkaSeLtA1synR/539XsTpIZSgF7CIbpJ1xxlUthbp8kBeDuf4qW37tm0+mP6YoagKGPxxIRSoCJw/i4cf9/yCXzhKTSvA90PtEwXppzXI6ilyllwfdXhJIF+TRJcJyfuZJSBOaVQ2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4fuZX5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4fuZX5I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 686D4C19421;
	Fri, 20 Feb 2026 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771594584;
	bh=dMId3ZV9kqzUHPVu1T1WTkrU1f5ZyLlqLFUV3S1K8fM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=N4fuZX5Iu7eNACpyRg3r1cNaYF4JlCv9AZN94Mo8D3kLgEDECfK1pgqUzilCPa+or
	 JxLHKvMwH0QeymPZaHvmNzasV9BdhAZyK7TaZbL0wmi683MndAXzoRFtPXLBCj9mps
	 Pozu74Q9m3boyNqNiNWwFMw6oSo/CaJcWgaNZkCJJJPZSKO8dSBbuT4CbE8N1dFrmP
	 amYSMQst/xs0Y2yXMs/s1bsbEr7Bm7btz3Tr+P+DBdX1CjlJBH61kVPH8+sEJwjlIs
	 C5nIfObsXMdZ1ddLR/YsnEsktd2e7ImJMKgJbc3zHhGugTuiUa/w9PFuPSuxfeGF6b
	 DIBopJghhwaBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE9C54FD3;
	Fri, 20 Feb 2026 13:36:23 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 20 Feb 2026 15:36:17 +0200
Subject: [PATCH] iio: imu: adis: Fix NULL pointer dereference in adis_init
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-adis-fix-v1-1-9fa10cce812f@analog.com>
X-B4-Tracking: v=1; b=H4sIAFBjmGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMD3cSUzGLdtMwKXUNz8+REAxMD0xSLRCWg8oKiVKAw2Kjo2NpaAHI
 rlHRaAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594577; l=3182;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=kI9J4huE67pPn8S62AKdcWN4aDigHYDhih5UlDtH0k0=;
 b=ZXARvjyJBgjz2RcOFZjWD6TZfC3HJXy6WSBHXtA3RpnFyh1ztKAsMTMEF9bVX3Wg8CfrqDTKV
 tf1LGmXCHgZDfhSj4ntdlyCnoMFS3EjUG29tEMK7TYyM/ivT4ocS8ac
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

    Unable to handle kernel NULL pointer dereference at virtual
    address 0000000000000000
    pc : adis_init+0xc0/0x118
    Call trace:
     adis_init+0xc0/0x118
     adis16480_probe+0xe0/0x670

Fix this by checking if adis->ops is NULL before dereferencing it,
falling through to assign the default ops in that case.

Fixes: 7f15d7a7d12d ("iio: imu: adis: Add reset to custom ops")
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

  The bug was introduced in 7f15d7 ("iio: imu: adis: Add reset to custom ops")
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
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index d160147cce0b..e68bc1c36ed1 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -526,7 +526,7 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 
 	adis->spi = spi;
 	adis->data = data;
-	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
+	if (!adis->ops || (!adis->ops->write && !adis->ops->read && !adis->ops->reset))
 		adis->ops = &adis_default_ops;
 	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
 		return -EINVAL;

---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-adis-fix-177ca0405d8a

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


