Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C83E868A
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843523; cv=none; b=nyT2VFV9PD7tS5DIfVu1PW4HIlxjxiyJAiANTRlv1rfEjcoV9UMNV/S1FZYJIFkgJc7qAbP7VlSU0XgZPfNonuhHNsQ4bMYV6bQqhFXSpWaaybCRiUCyoWYfX+TzDHoVVE2LU4jCmebO2Vj4ebPYynkZvPM0YGU6Wd21n9PL6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843523; c=relaxed/simple;
	bh=5UBiTC5jgNys+kDWiKl8fJ8ACJ4XLqmi9gJg1zF5Un0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=cAMJf97JGgQRTqU67DcBPew7brWTMHAg0UqxBrHCNcPMZw2ncVJBalSx81rDBy6fsu5ZjwfMCZrg9Zv4DmDxqDB5K49pxg06IuKWiZ7qOX2sSm74IlekyEI18mvoZOIjSqFEBxGW0f0VFbtB2hzl3GBzWqY6uHHNY+dNnJW6fJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDm4pUQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDm4pUQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C91FC2BCB0;
	Fri, 15 May 2026 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778843523;
	bh=5UBiTC5jgNys+kDWiKl8fJ8ACJ4XLqmi9gJg1zF5Un0=;
	h=Date:From:To:Subject:From;
	b=DDm4pUQ6KqTTz4tnSkcBKY0tvGnvAOsVGR59Yr6023b3SeroXX4uLLJhOT/W4GkCK
	 MpZJySNEdpVu4EyPpxYkO3tcC5VXg6FHTfyOT7Y6kWMmDrWRyYqaI+5Weuk3+6ORE0
	 FoQXIKgL4Vs39cb0Qtra/JnQrDo+mc7Js//uA/h4Ox8udVD9OByQ+njqJZMUAsZTA7
	 pSI7J7tlPL/GgoNbYahYHJXMaG2TEq8panWAT/Zg+Sal0G9zBqjhNclOMMYrDyPTxJ
	 l8gcgYuttyT1Mdzjrmg/bMlPUgtNaP4UEcLX2FJGkGtUpC64ZF6vO7NfQ19usKsTF7
	 vlatntHPMfk7Q==
Date: Fri, 15 May 2026 12:11:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 7.1 cycle.
Message-ID: <20260515121157.4bfc1195@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-7.1a

for you to fetch changes up to 422b5bbf333f75fb486855ad0eedc23cf21f3277:

  iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw (2026-05-=
15 12:05:35 +0100)

----------------------------------------------------------------
iio-fixes-for-7.a IIO: 1st set of fixes for the 7.1 cycle

Usual mixed bag of ancient issues and more recent.
Lots of new contributors this cycle and some of that work has
uncovered bugs in the code they were looking at.

core,buffer
- Add missing dma_fence_put()
- hw-consumer - Fix a use after free in cleaning up a list.
  core,inkern
- Fix return value  handling in iio_read_channel_processed_scale() that
  meant a correct result was treated as an error.

adi,ad3530r
- Fix powerdown mode strings for AD3531 and AD3531R.
adi,ad4695
- Fix ordering so by the time device transitions to offload mode
  all setup transfers are done. This avoids issues with offload
  controllers that cannot handle normal transfers after offload has
  begun.
adi,ad5686
- Fix wrong initialization of reference bit for single channel parts.
- Fix off by one in check on input raw value
adi,adis16260
- Fix division by zero triggerable from sysfs.
adi,adis16550
- Fix a stack leak to userspace.
amlogic,meson-adc
- Fix a buffer allocation leak in an error path.
bosch,bmp280
- Fix a stack leak to userspace.
capella,cm3323
- Fix wrong return value rather than register value being written
  data->reg_conf on write.
maxim,max5821
- Check correct length i2c_master_send() in max5821_sync_powerdown_mode().
mediatek,mt6359
- Fix potential uninitialized value.
nuvoton,npcm_adc
- Fix unbalance clk_disable_unprepare()
nxp,sar-adc
- Avoid a division by zero if the common clock framework is disabled.
- Fix a division by zero triggerable from sysfs.
- Ensure all of struct dma_slave_config is initialized.
qcom,spmi-adc-gen3
- Fix an off by one that leads to an out of bounds array read.
samsung,ssp_sensors
- Ensure work is cancelled during remove to avoid use after free.
sensiron,scd30
- Fix a division by zero triggerable from sysfs.
st,lsm6dsx
- Fix a stack leak to userspace.
st,magn
- Fix default value for data ready pin selection for devices that
  have no data ready pin selection.
vishay,veml6070
- Close a resource leak in an error path.
winsen,mhz19b
- Reject over-sized serial messages from device.
xilinx,xadc
- Fix sequencer handling for dual MUX cases

----------------------------------------------------------------
Advait Dhamorikar (1):
      iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Andy Shevchenko (1):
      iio: adc: nxp-sar-adc: Avoid division by zero

Antoniu Miclaus (3):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw
      iio: adc: nxp-sar-adc: fix division by zero in write_raw

Beno=C3=AEt Monin (1):
      iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Dan Carpenter (1):
      iio: adc: qcom-spmi-adc5-gen3: Fix off by one in adc5_gen3_get_fw_cha=
nnel_data()

David Carlier (2):
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()
      iio: gyro: itg3200: fix i2c read into the wrong stack location

Felix Gu (3):
      iio: light: veml6070: Fix resource leak in probe error path
      iio: adc: meson-saradc: fix calibration buffer leak on error
      iio: buffer: hw-consumer: fix use-after-free in error path

Greg Kroah-Hartman (3):
      iio: pressure: bmp280: fix stack leak in bmp580 trigger handler
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      iio: imu: adis16550: fix stack leak in trigger handler

Kim Seer Paller (1):
      iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings

Pengpeng Hou (1):
      iio: chemical: mhz19b: reject oversized serial replies

Radu Sabau (1):
      iio: adc: ad4695: Fix call ordering in offload buffer postenable

Rodrigo Alencar (4):
      iio: dac: ad5686: fix ref bit initialization for single-channel parts
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix powerdown control on dual-channel devices

Salah Triki (4):
      iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
      iio: dac: max5821: fix return value check in powerdown sync
      iio: temperature: tsys01: fix broken PROM checksum validation
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Shuvam Pandey (1):
      iio: adc: nxp-sar-adc: zero-initialize dma_slave_config

Svyatoslav Ryhel (1):
      iio: Fix iio_multiply_value use in iio_read_channel_processed_scale

 drivers/iio/adc/ad4695.c                       | 23 ++++-------
 drivers/iio/adc/meson_saradc.c                 |  4 +-
 drivers/iio/adc/mt6359-auxadc.c                |  1 +
 drivers/iio/adc/npcm_adc.c                     | 25 ++++--------
 drivers/iio/adc/nxp-sar-adc.c                  | 24 +++++++++--
 drivers/iio/adc/qcom-spmi-adc5-gen3.c          |  2 +-
 drivers/iio/adc/viperboard_adc.c               |  4 +-
 drivers/iio/adc/xilinx-xadc-core.c             | 11 ++++-
 drivers/iio/buffer/industrialio-hw-consumer.c  |  4 +-
 drivers/iio/chemical/mhz19b.c                  | 17 ++++++++
 drivers/iio/chemical/scd30_core.c              |  2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c       |  1 +
 drivers/iio/dac/ad3530r.c                      | 54 ++++++++++++++++++----=
---
 drivers/iio/dac/ad5686.c                       | 56 +++++++++++++++++++---=
----
 drivers/iio/dac/ad5686.h                       |  1 +
 drivers/iio/dac/max5821.c                      |  9 ++++-
 drivers/iio/gyro/adis16260.c                   |  3 ++
 drivers/iio/gyro/itg3200_buffer.c              |  2 +-
 drivers/iio/imu/adis16550.c                    |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  2 +-
 drivers/iio/industrialio-buffer.c              |  1 +
 drivers/iio/inkern.c                           |  6 ++-
 drivers/iio/light/cm3323.c                     |  5 +--
 drivers/iio/light/veml6070.c                   | 14 +------
 drivers/iio/magnetometer/st_magn_core.c        | 13 +++++-
 drivers/iio/pressure/bmp280-core.c             |  2 +-
 drivers/iio/temperature/tsys01.c               |  2 +-
 27 files changed, 194 insertions(+), 96 deletions(-)
