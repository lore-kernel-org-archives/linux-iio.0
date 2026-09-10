Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5049E137
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080820; cv=none; b=iGqYL28UemgYbhP0tjr+El3M471mAvGDW0tT3HWQregvgkkoL4vs/5oJ1B/crqiOOPCWGhcUu6sd13pPddFb6V3Wd+oNgJq/TGai6YCy3+QOWv6oxrn/kavkplD1JBVUsSLjqZQ8Sq6WrL2iEctCRPo6m00lKQU36+jOpfFkK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080820; c=relaxed/simple;
	bh=ywzAVpVd9woxyUyRNiq5qwV0q+ZG82FlOyUa1OL/WUI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=lG/5knI2Cv9cRgytayEZa5O9E+Ssxs4rAcn17KWwvs8DkWSF8BjJts6oLh1LslJ+Nrc+C2YGs6VGEKFdhaAFOWHysVV5ne/sdsGvrNipTMNBVoLXYzq8iW43ohe79GKnivCG2WrTz43B8aHyW49FiVh33YVCTvHYTovudOq5FK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7nJRHxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7nJRHxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C561F000FF;
	Thu, 10 Sep 2026 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789080818;
	bh=ubAUsJUdX9jQ5XJ0mhQuBEarQkVu42iOcmZUpSJtThQ=;
	h=Date:From:To:Subject;
	b=D7nJRHxq+ioeBB0FIasIp750izQFr3yTg7q32LULw+LNVzj1sLhQUPl79LeUDBI97
	 ZWKZPGyvQStR1xpEZbgkcUykph8wFoxdtDOWBi5n5C1gayWJxFHp8n/0s1nrGwdqSp
	 hLSoHz11hAbWLmAqJJeAvcqvritAAeRBW4St9NAfqj8ZePL4dmkrQLlwu4cOIJeBKF
	 e+Ik6IlTaxs2fbQwFtByz8FIwJAZr5+IsnEjgyeWe11qobfkLyBM2AiLH7r3LWct9g
	 Fq63CPpvt+Sc8LOpslqmU6d0eS8nxENiuexWjJVjZUmL5r6fvn8C27ic0S0+9qI9KN
	 CUOEI+yn8T8DQ==
Date: Thu, 10 Sep 2026 23:53:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 7.3 cycle
Message-ID: <20260910235336.6673c019@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-7.3a

for you to fetch changes up to 7d38af8f20239a66e90de7632a79c9425256c574:

  iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler (2026-09-0=
7 03:12:17 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for the 7.3 cycle.

A couple of core fixes, the rest usual mix of driver issues that surfaced
from merge window until now.

core
- buffer: Ensure that when using the iio_push_to_buffers_with_ts_unaligned()
  that the full buffer is zeroed.
- trigger: Cancel reenable_work() before freeing the trigger that might be
  re-enabled.
dma-buffer
- Fix wrong sizing for a mapped sg_list.  If an IOMMU was using a fused
  entry the mapping might walk off the end.

adi,ade9000
- Wait for power up before requesting interrupts.
- Fix overlap in scan index for current and voltage channels.
- Ensure Phase C dip event included in IRQ1 handler.
adi,adf4377
- Initialize all of a clk_init_data.
adi,adis*
- Ensure debugfs reads are finished before unbind.
adi,axi-adc
- Initialize mutex.
adi,admv1013
- Ensure mutex is intialized before notifier that might use it is
  registered.
- Fix wrong channel field used for read_raw.
allwinner,sun4i
- Drop a pm_runtime_put() when there was no get.
- Ensure correct cleanup on driver probe fail due to any issues with
  the thermal zone.
aspeed,adc,
- Don't eat reset deassert errors.
awinic,aw96103
- Make sure firmware length is validated rather than blindly trusting
  it.
bosch,bmp280
- Fix out of bounds lookup of sampling frequency due to indexing based on
  elements in matrix rather than just the correct dimension.
invensense,timestamp library
- Ensure time estimate doesn't invert wrt to current time in a corner
  case occasionally seen.
kionix,kx022a
- Off by one in array boundary check.
- Close a memory leak and state corruption in error path.
maxim,max1363
- Sign extend bipolar values to ensure correct reporting to userspace.
maxim,max30102
- Fix NULL dereference by checking there is data in the FIFO before
  trying to do anything with it.
microchip,mcp47a1
- Ensure highest possible value actually settable.
pulsed-light,lidar-lite
- Don't leak the IIO device registration if runtime pm setup fails
  particularly as it was being freed.
rockchip,saradc
- Fix wrong fallback compatible for rv1106 that lead to trying
  to use too many channels (correct support will follow next
  merge window)
rohm,bd79124
- Correct limit used for rising alarms.
- Fix which registers related to limits are used in initialization.
- Apply GPIO mask to allow subset of GPIOs to be toggled.
- Add missing regmap error handling in a few places.
- Ensures scale is read only.
rohm,bm1390
- Don't silently eat a data read error.
rohm,bu27034
- Don't silently eat error when reading gain.
- Ensure we infinite delay doesn't happen on error.
semtech,sx9324
- Fix wrong proximity channel resolution.
sharp,gp2ap020a00f
- Make sure to drain irq_work in remove path.
st,vl5310x
- Ensure direct mode is claimed for read_raw avoiding corruption
  of buffered accesses.
vishay,vcnl3020
- Use write bits for ISR mask and ensure right event reported.
vti,sca3000
- Fix up a condition check for the frequency divider.
xilinx,xadc
- Swap registration of cleanup of work with that of irq
  to ensure that no irqs can cause work that has been freed
  to be queued.
x-powers,axp288
- Add bias override quirk for Haier HV103H.  Fix because we
  used to always override then moved to trusting the firmware
  setup - which fixed some boards, but broke others.

----------------------------------------------------------------
Antoniu Miclaus (3):
      iio: adc: ade9000: request interrupts after powering the device
      iio: adc: ade9000: fix overlapping scan_index for current and voltage=
 channels
      iio: adc: ade9000: handle Phase C dip events in IRQ1 handler

Arka Mondal (3):
      iio: imu: adis16480: fix unprotected debugfs reads
      iio: imu: adis16400: fix unprotected debugfs reads
      iio: gyro: adis16136: fix unprotected debugfs reads

Cong Nguyen (2):
      iio: adc: max1363: sign-extend bipolar differential channel reads
      iio: proximity: pulsedlight: fix iio_device left registered on PM set=
up failure

Donggeun Yoo (1):
      iio: proximity: vl53l0x-i2c: claim direct mode for raw reads

Fan Wu (3):
      iio: light: gp2ap020a00f: drain irq_work after free_irq
      iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker o=
n unbind
      iio: trigger: cancel reenable_work before freeing trigger

Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration fail=
ure

Geert Uytterhoeven (1):
      iio: frequency: adf4377: Fully initialize clk_init_data and clk_paren=
t_data

Hui Su (1):
      iio: pressure: bmp280: fix out-of-bounds access in sampling frequency=
 lookup

Janani Sunil (1):
      iio: adc: adi-axi-adc: Initialize state mutex

Jean-Baptiste Maneyrol (1):
      iio: inv_sensors: fix estimated value larger than interrupt timestamp

Jonathan Cameron (1):
      iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.

Laxman Acharya Padhya (1):
      iio: proximity: aw96103: validate firmware data length

Marco Chen (1):
      iio: health: max30102: fix NULL dereference in interrupt handler

Matti Vaittinen (10):
      iio: adc: rohm-bd79124: Fix rising alarm
      iio: adc: rohm-bd79124: Fix channel initialization
      iio: adc: rohm-bd79124: Fix GPIO mask check
      iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop
      iio: dac: rohm-bd79703: Do not allow writing SCALE
      iio: pressure: rohm-bm1390: Return error when read fails
      iio: light: rohm-bu27034: Fix error return
      iio: accel: kionix-kx022a: Fix array boundary check
      iio: light: rohm-bu27034: Fix infinite delay on error
      iio: accel: kionix-kx022a: Prevent memory leak and fix state

Michael Hennerich (1):
      iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs

Pengpeng Hou (1):
      iio: adc: aspeed: propagate reset deassert errors

Runyu Xiao (1):
      iio: admv1013: initialize callback mutex before registering notifier

Salah Triki (3):
      iio: accel: sca3000: fix frequency divider condition check
      iio: frequency: admv1013: fix wrong channel field used in admv1013_re=
ad_raw()
      iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler

Tuna K=C4=B1l=C4=B1=C3=A7 (1):
      iio: dac: mcp47a1: Allow full-scale output

Vladislav Leonov (2):
      dt-bindings: iio: adc: rockchip-saradc: Group single-entries into an =
enum list
      dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible

Vladyslav Ivashchenko (1):
      iio: adc: axp288: Add TS bias override for Haier HV103H

Zhang Jie (1):
      iio: proximity: sx9324: Correct proximity channel resolution

 .../bindings/iio/adc/rockchip-saradc.yaml          | 18 +++----
 drivers/iio/accel/kionix-kx022a.c                  | 30 ++++++++---
 drivers/iio/accel/sca3000.c                        |  2 +-
 drivers/iio/adc/ade9000.c                          | 31 +++++------
 drivers/iio/adc/adi-axi-adc.c                      |  4 ++
 drivers/iio/adc/aspeed_adc.c                       |  4 +-
 drivers/iio/adc/axp288_adc.c                       |  8 +++
 drivers/iio/adc/max1363.c                          |  8 +++
 drivers/iio/adc/rohm-bd79124.c                     | 20 ++++---
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 10 ++--
 drivers/iio/adc/xilinx-xadc-core.c                 |  9 ++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++--
 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 11 ++--
 drivers/iio/dac/mcp47a1.c                          |  4 +-
 drivers/iio/dac/rohm-bd79703.c                     |  3 ++
 drivers/iio/frequency/adf4377.c                    |  4 +-
 drivers/iio/frequency/admv1013.c                   |  9 ++--
 drivers/iio/gyro/adis16136.c                       |  2 +-
 drivers/iio/health/max30102.c                      | 12 +++--
 drivers/iio/imu/adis16400.c                        |  2 +-
 drivers/iio/imu/adis16480.c                        |  4 +-
 drivers/iio/industrialio-buffer.c                  |  3 +-
 drivers/iio/industrialio-trigger.c                 |  2 +
 drivers/iio/light/gp2ap020a00f.c                   |  2 +
 drivers/iio/light/rohm-bu27034.c                   | 62 +++++++++++++-----=
----
 drivers/iio/pressure/bmp280-core.c                 |  2 +-
 drivers/iio/pressure/rohm-bm1390.c                 |  2 +-
 drivers/iio/proximity/aw96103.c                    | 30 ++++++++---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  4 +-
 drivers/iio/proximity/sx9324.c                     |  2 +-
 drivers/iio/proximity/vcnl3020.c                   | 24 ++++++---
 drivers/iio/proximity/vl53l0x-i2c.c                |  3 ++
 32 files changed, 234 insertions(+), 113 deletions(-)
