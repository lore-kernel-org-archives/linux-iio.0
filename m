Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52227371890
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790102; cv=none; b=SEasbPSRgYx4sJ8L7qvwE4W4iMqHUcG9T9fFxZL+hWKkJ+aw0Y+Fo1RYhQIfd3u8VE5wIC/DOcPvsHAfxWm4P4np+yiFkIfuzg4dgrmYFrGivqKbQVHyZh5i5aElsqduFg/AjOoantS0si6+0p62HvMy9T5ZZA8jY5k+kdKcu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790102; c=relaxed/simple;
	bh=rX+r/BcdL0P1WONffiFDB44oLUKo3FYarIYRm3oasAc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=mm6QhjZXG8Xsjq4anHRIQu6/d2udroZoqsNHiB8Bmz4HMe0LbK+UFXvtx7jaZZgjUsATuqPkFrX9rjc3hi3C6uVNguT99bFBosImb+4AEz3f6gJc7wa35qbGGQ7kIkoQ7VDq2xmYqd8V+9H//Y7DvQ1YT2RM2jr12dcDjZXJT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrlMYK67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrlMYK67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B970AC2BC9E;
	Sun, 29 Mar 2026 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774790101;
	bh=rX+r/BcdL0P1WONffiFDB44oLUKo3FYarIYRm3oasAc=;
	h=Date:From:To:Subject:From;
	b=hrlMYK67XuLjcWJ8IyXeTV8L3am9DBVMiXAHgW5yMx0uOD7wiqGRWZREIFYSaBSSg
	 jXHLqP9u5q4WikLN73KorObjBB5Xx19kUamxBYiAuGg4pqeWzHdZXSl/RjBN+Nkckl
	 SXYTPZ+A47w5FpP/n7UUvz9O4p94Phba1JFa5iLRHONSg3LG1U94piNjNTA/rkYoJk
	 aHidZLYa5YVcZt9PPs9xMzpugIhmqzyXTAEbZvVnHPaHgcAElQ/SnSBxwd6zCLnf/R
	 pvb7ZFekcB+eWL7IAuIopS5rCRr/8wqJ8yBSuxnXd6sUD1vdDGaeDNimhB4FT7jR8l
	 z1Q8Zx5p8jdfg==
Date: Sun, 29 Mar 2026 14:14:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 3rd set of fixes for the 7.0 cycle (or 7.1 merge
 window)
Message-ID: <20260329141456.0860794e@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit ea7e2e43d768102e2601dbbda42041c78d7a99f9:

  iio: imu: adis16550: fix swapped gyro/accel filter functions (2026-03-07 14:11:30 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0c

for you to fetch changes up to d0b224cf9ab12e86a4d1ca55c760dfaa5c19cbe7:

  iio: light: veml6070: fix veml6070_read() return value (2026-03-26 08:22:33 +0000)

----------------------------------------------------------------
IIO: 3rd set of fixes for the 7.0 cycle.

Note that this pull is in addition to the 2nd set of such fixes that are
waiting to be picked up. Absolutely fine to queue these for the merge
window if that makes more sense.

Usual mixed back of ancient issues surfacing and newer problems.

adi,ad57770r
- Stop eating an error in read_raw.
adi,adxl313
- Check return of regmap_write() instead of ignoring it in one place.
adi,adxl355
- Fix the description of the temperature channel to be unsigned rather
  than signed.
bosch,bmi160
- Avoid use of uninitialized data.
- Fix validation of small reference voltages.
hid-sensor-rotation:
- The timestamp location in this driver has unfortunately been broken for
  a long time. Given it was correct for 6 years and then broken for the
  next 6 years, use a one off hack to duplicate it in both locations.
  The issue was as a result of the unique nature of quaternion
  representation combined with large precision resulting in an
  128 bit aligned channel.
nxp,sar-adc
- Avoid leaking a dma channel.
rfdigital,rfd77402
- Close a race between reinit_completion() and the irq happening.
ti,adc161s626
- Fix up buffer handling on big endian hosts which was broken due to
  casting of pointers to different sized integers.
- Ensure a DMA safe buffer is used.
vishay,vcnl4035
- Fix up buffer handling on big endian hosts which was broken due to
  casting of pointers to different sized integers.
vishay,veml6070
- Fix return value mess up that occurred when doing a guard() conversion.

----------------------------------------------------------------
Aldo Conte (1):
      iio: light: veml6070: fix veml6070_read() return value

Antoniu Miclaus (2):
      iio: dac: ad5770r: fix error return in ad5770r_read_raw()
      iio: accel: adxl313: add missing error check in predisable

Ariana Lazar (1):
      iio: dac: mcp47feb02: Fix Vref validation [1-999] case

David Lechner (4):
      iio: orientation: hid-sensor-rotation: add timestamp hack to not break userspace
      iio: adc: ti-adc161s626: fix buffer read on big-endian
      iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()
      iio: light: vcnl4035: fix scan buffer on big-endian

Felix Gu (2):
      iio: proximity: rfd77402: Fix completion race condition in IRQ mode
      iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger mode

Josh Poimboeuf (1):
      iio: imu: bmi160: Remove potential undefined behavior in bmi160_config_pin()

Valek Andrej (1):
      iio: accel: fix ADXL355 temperature signature value

 drivers/iio/accel/adxl313_core.c              |  2 ++
 drivers/iio/accel/adxl355_core.c              |  2 +-
 drivers/iio/adc/nxp-sar-adc.c                 |  9 ++---
 drivers/iio/adc/ti-adc161s626.c               | 41 +++++++++++-----------
 drivers/iio/dac/ad5770r.c                     |  2 +-
 drivers/iio/dac/mcp47feb02.c                  | 49 ++++++++++++---------------
 drivers/iio/imu/bmi160/bmi160_core.c          | 15 +++-----
 drivers/iio/light/vcnl4035.c                  | 18 ++++++----
 drivers/iio/light/veml6070.c                  |  4 +--
 drivers/iio/orientation/hid-sensor-rotation.c | 22 ++++++++++--
 drivers/iio/proximity/rfd77402.c              |  7 ++--
 11 files changed, 92 insertions(+), 79 deletions(-)
