Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CF1E1A3D
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965197; cv=none; b=n3u+dSR2K1MRhLOyAyyvAofWJnxU6EMeXBWnT1is2DmHbyPxyZZr1c3YrFg7YchhEODp4No4F6DpU53O3Up0E3mWpPc+K7E8no05JpmuTlgGRd3ZAt6hvo8Ll/ijGfQwTM4QfoDhRSlmopoBwR1vYHiDiYSG37HqMZ5CQP8nXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965197; c=relaxed/simple;
	bh=AQYHmYjPYyD189rqo7p96mkrM93+UIZRQfd6ZhCD+K0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=C/WO9jFBU+AKxgl1r80TqkquQ+phWRqtFZOmo+Caqelwp3qVzKrcfgVsukS5VLJGMX/8HTYK4aLpQsM5h4p5tXfqEDE8aPRU6ydufbNMhaIcpe+8lMdomHFgIcviEfITnfJwf7fQmMthIaqaqGgDM7kMHiQU/QezNY73McjHSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPOFEAVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPOFEAVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A962C4CEF7;
	Sun,  1 Feb 2026 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769965197;
	bh=AQYHmYjPYyD189rqo7p96mkrM93+UIZRQfd6ZhCD+K0=;
	h=Date:From:To:Subject:From;
	b=LPOFEAVhluuvoNHEOzJXzn0KYxzUq7iad6Bnh1Uii3afGEVd4sNPC+ADazzUjcQEJ
	 8FWtreL0WHZ3cbOvVvMFE3D9uV72yqrmR6a/Cy6j5vLyFD0fNgf7LMOs/WnbWGQ6I9
	 RQADospQB0kyBvIQZseu4uQ5Pk62TSU4+g0+KDHDbjF44p965gJGQILUpoP2L+Cc4c
	 VI6DaURiMjukdVB/xslTN7wgP8kOJGne2JOROMaY8zfeZSZQ1PnFsRUZ5bPSdsRWdc
	 3uuv35B6irua1g04yUI/bSu6nkSMOSiWZZIJxQNMBGU9BqgrYEoZA/yOHGIE4ih5nf
	 1GKq5cPIRRuKQ==
Date: Sun, 1 Feb 2026 16:59:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features and cleanup for 7.0
Message-ID: <20260201165951.481378da@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-7.0a

for you to fetch changes up to 0713b26190addfa3a774b386c8658952ef9f7faf:

  iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and driv=
er builtin (2026-02-01 16:53:35 +0000)

----------------------------------------------------------------
IIO: New device support, features and cleanup for the 6.20/7.0 cycle.

Slightly messier than normal unfortunately due to some conflicts
and build config bugs related to I3C drivers.

One last minute Kconfig fix right at the top after a linux-next report.
I've simplified the Kconfig and made it match other instances in the kernel
so that should be safe enough despite short soak time in front of build bot=
s.

Merge of an immutable branch from I3C to get some stubs that were missing
and caused build issues with dual I2C / I3C drivers. This also brought in a
drop of some deprecated interfaces so there is also one patch to update a
new driver to not use those.

We are having another go at using cleanup.h magic with the IIO mode claim
functions after backing out last try at this. This time we have wrappers
around the new ACQUIRE() and ACQUIRE_ERR() macros.
Having been burnt once, we will be taking it a bit more slowly this time
wrt to wide adoption of these! Thanks in particular to Kurt for taking
on this core IIO work.

New Device Support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad18113
- New driver to support the AD18113 amplifier - an interesting device due
  to the external bypass paths where we need to describe what gain those
  paths have in DT. Longer term it will be interesting to see if this
  simplistic description is enough for real deployments.
adi,ad4062
- New driver for the AD4060 and AD4052 SAR ADCs including trigger, event
  and GPIO controller support.  Follow up patch replaced use of some
  deprecated I3C interfaces prior to the I3C immutable branch merge as
  that includes dropping them.
adi,ad4134
- New driver for the AD4134 24bit 4 channel simultaneous sampling ADC.
adi,ad7768-1,
- Add support for the ADAQ767-1, ADAQ7768-1 and ADAQ7769-1 ADCs after some
  rework to enable the driver to support multiple device types.
adi,ad9467
- Add support for the similar ad9211 ADC to this existing driver.
- Make the selection of 2s comp mode explicit for normal operation and
  switch to offset binary when entering calibration mode.
honeywell,abp2
- New driver to support this huge family (100+) of board mount pressure and
  temperature sensors.
maxim,max22007
- New drier for this 4 channel DAC.
memsic,mmc5633
- New driver for this I2C/I3C magnetometer. Follow on patches fixed up
  issues related to single driver supporting both bus types.
microchip,mcp747feb02
- New driver for the Microchip MCP47F(E/V)B(0/1/2)1,
  MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8
  buffered voltage output DACs.
nxp,sar-adc
- New driver support ADCs found on s32g2 and s32g3 platforms.
ti,ads1018
- New drier for the ADS1018 and ADS1118 SPI ADCs.
ti,ads131m02
- New driver supporting ADS131M(02/03/04/06/08)24-bit simultaneous sampling
  ADCs.

Features
=3D=3D=3D=3D=3D=3D=3D=3D

iio-core
- New IIO_DEV_ACQUIRE_DIRECT_MODE() / IIO_DEV_ACQUIRE_FAILED() +
  equivalents for the much rarer case where the mode needs pinning
  whether or not it is in direct mode.  These use the ACQUIRE()
  / ACQUIRE_ERR() infrastructure underneath to provide both simple
  checks on whether we got the requested mode and to provide scope
  based release. Applied in a few initial drivers.
adi,ad9467
- Support calibbias control
adi,adf4377
- Add support to act as a clock provider.
adi,adxl380
- Support low power 1KHz sampling frequency mode. Required rework of
  how events and filters were configured, plus applying of constraints
  when in this mode.
rf-digital,rfd77402
- Add interrupt support as alternative to polling for completion.
st,lsm6dsx
- Tap event detection (after considerable driver rework)

Cleanup and Minor Fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

More minor cleanup such as typos, white space etc not called out except
where they were applied to a lot of drivers.

Various drivers.
- Use of dev_err_probe() to cleanup error handling.
- Introduce local struct device and struct device_node variables to
  reduce duplication of getting them from containing structs.
- Ensure uses of iio_trigger_generic_data_rdy_poll() set IRQF_NO_THREAD
  as that function calls non threaded child interrupt handlers.
- Replace IRQF_ONESHOT in not thread interrupt handlers with
  IRQF_NO_THREAD to ensure they run as intended. Drop one unnecessary case.
iio-sw-device/trigger.
- Constify configs_group_operations structures.
iio-buffer-dma / buffer-dma-engine
- Use lockdep_assert_held() to replace WARN_ON() to check lock is
  correctly held.
- Make use of cleanup.h magic to simplify various code paths.
- Make iio_dma_buffer_init() return void rather than always success.

adi,ad7766
- Replace custom interrupt handler with iio_trigger_generic_data_rdy_poll()
adi,ad9832
- Drop legacy platform_data support.
adi,ade9000
- Add a maintainer entry.
adi,adt7316
- Move to EXPORT_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so the compiler
  can cleanly drop unused pm structures and callbacks.
adi,adxl345
- Relax build constraint vs the driver that is in input so both may be
  built as modules and selection made at runtime.
adi,adxl380
- Make sure we don't read tail entries in the hardware fifo if a partial
  new scan has been written.
- Move to a single larger regmap_noinc_read() to read the hardware fifo.
aspeed,ast2600
- Add missing interrupts property to DT binding.
bosch,bmi270_i2c
- Add missing MODULE_DEVICE_TABLE() macros so auto probing of modules can
  work.
bosch,smi330
- Drop duplicate assignment of IIO_TYPE in smi330_read_avail()
- Use new common field_get() and field_prep() helpers to replace local
  version.
honeywell,mprls0025pa
  Fixes delayed to merge window as late in cycle and we didn't want to delay
  the rest of the series.
- Allow Kconfig selection of specific bus sub-drivers rather than tying that
  to the buses themselves being supported.
- Zero spi_transfer structure to avoid chance of unintentionally set fields
  effecting transfer.
- Fix a potential timing violation wrt to the chip select to first clock
  edge timing.
- As recent driver, take risk inherent in dropping interrupt direction from
  driver as that should be set by firmware.
- Fix wrong reported number of data bits for channel.
- Fix a pressure channel calculation bug.
- Rework to allow embedding the tx buffer in the iio_priv() structure rather
  than requiring separate allocation.
- Move the buffer clearing to the shared core bringing it into affect for
  SPI as well as I2C.
- Stricter checks for status byte.
- Greatly simplify the measurement sequence.
- Add a copyright entry to reflect Petre's continued work on this driver.
intersil,isl29018
- Switch from spritnf to sysfs_emit_at() to make it clear overflow can't
  occur.
invensense,icm42600
- Allow sysfs access to temperature when buffered capture in use as it
  does not impact other sensor data paths.
invensense,itg3200
- Check unused return value in read_raw() callback.
men,z188
- Drop now duplicated module alias.
rf-digital,rfd77402
- Add DT binding doc and explicit of_device_id table.
- Poll for timeout with times as on datasheet, then replace opencoded
  version with read_poll_timeout().
sensiron,scd4x
- Add missing timestamp channel. The code to push it to the buffer was there
  but there was no way to turn it on.
vti,sca3000
- Fix resource leak if iio_device_register() fails.

----------------------------------------------------------------
Adrian Ng Ho Yin (4):
      i3c: add sysfs entry and attribute for Device NACK Retry count
      i3c: dw: Add support for Device NACK Retry configuration
      i3c: dw: use FIELD_PREP for device address table macros
      i3c: dw: Preserve DAT entry bits when restoring addresses

Andrew Jeffery (1):
      dt-bindings: iio: adc: Allow interrupts property for AST2600

Antoniu Miclaus (8):
      dt-bindings: iio: frequency: adf4377: add clk provider
      iio: frequency: adf4377: add clk provider support
      dt-bindings: iio: amplifiers: add adl8113
      iio: amplifiers: adl8113: add driver support
      iio: accel: adxl372: remove unused int2_bitmask field
      iio: accel: sca3000: remove unused last_timestamp field
      MAINTAINERS: add entry for ADE9000 driver
      iio: gyro: itg3200: Fix unchecked return value in read_raw

Ariana Lazar (2):
      dt-bindings: iio: dac: adding support for Microchip MCP47FEB02
      iio: dac: adding support for Microchip MCP47FEB02

Chen Ni (1):
      iio: adc: ad7476: Remove duplicate include

Christophe JAILLET (1):
      iio: core: Constify struct configfs_item_operations and configfs_grou=
p_operations

Daniel Lezcano (2):
      dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
      iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

David Jander (1):
      iio: adc: Add TI ADS131M0x ADC driver

Derek J. Clark (1):
      iio: bmi270_i2c: Add MODULE_DEVICE_TABLE for BMI260/270

Fiona Klute (1):
      iio: chemical: scd4x: expose timestamp channel

Francesco Lavra (13):
      iio: imu: st_lsm6dsx: make event_settings more generic
      iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
      iio: imu: st_lsm6dsx: rework code to check for enabled events
      iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
      iio: imu: st_lsm6dsx: make event management functions generic
      iio: imu: st_lsm6dsx: add event configurability on a per axis basis
      iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec initi=
alizer
      iio: imu: st_lsm6dsx: add tap event detection
      iio: accel: adxl380: Store sampling frequency index in odr struct mem=
ber
      iio: accel: adxl380: Introduce helper function for activity detection
      iio: accel: adxl380: Add support for 1 kHz sampling frequency
      iio: accel: adxl380: Avoid reading more entries than present in FIFO
      iio: accel: adxl380: Optimize reading of FIFO entries in interrupt ha=
ndler

Frank Li (5):
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor
      i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()
      i3c: master: svc: Initialize 'dev' to NULL in svc_i3c_master_ibi_isr()
      i3c: Add stub functions when I3C support is disabled

Geert Uytterhoeven (1):
      iio: imu: smi330: Convert to common field_{get,prep}() helpers

Gwendal Grignou (1):
      iio: cros_ec: Allow enabling/disabling calibration mode

Harshit Mogalapalli (1):
      iio: sca3000: Fix a resource leak in sca3000_probe()

Janani Sunil (2):
      dt-bindings: iio: dac: Add max22007
      iio: dac: Add MAX22007 DAC driver support

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: enable temp polling when buffer is on

Jonathan Cameron (4):
      iio: adc: ad4062: Switch from struct i3c_priv_xfer to struct i3c_xfer
      iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is=
 not.
      Merge remote-tracking branch 'i3c/ib-i3c-iio-v6.20' into togreg
      iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and =
driver builtin

Jonathan Santos (5):
      dt-bindings: iio: adc: ad7768-1: add new supported parts
      iio: adc: ad7768-1: introduce chip info for future multidevice support
      units: add conversion macros for percentage related units
      iio: adc: ad7768-1: refactor ad7768_write_raw()
      iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

Jorge Marques (10):
      iio: accel: Change adxl345 depend to negate adxl35x
      dt-bindings: iio: adc: Add adi,ad4062
      docs: iio: New docs for ad4062 driver
      iio: adc: Add support for ad4062
      docs: iio: ad4062: Add IIO Trigger support
      iio: adc: ad4062: Add IIO Trigger support
      docs: iio: ad4062: Add IIO Events support
      iio: adc: ad4062: Add IIO Events support
      docs: iio: ad4062: Add GPIO Controller support
      iio: adc: ad4062: Add GPIO Controller support

Jose Javier Rodriguez Barbarin (1):
      iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS

Krzysztof Kozlowski (9):
      iio: adc: aspeed: Simplify with dev_err_probe
      iio: adc: exynos: Simplify with dev_err_probe
      iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
      iio: adc: rockchip: Simplify with dev_err_probe
      iio: adc: sc27xx: Simplify with dev_err_probe
      iio: adc: aspeed: Simplify probe() with local 'dev' and 'np'
      iio: adc: exynos: Simplify probe() with local 'dev' and 'np'
      iio: adc: rockchip: Simplify probe() with local 'dev'
      i3c: master: Simplify with scoped for each OF child loop

Kurt Borja (10):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1018 driver
      iio: adc: ti-ads1018: Drop stale kernel-doc function context
      iio: core: Add and export __iio_dev_mode_lock()
      iio: core: Refactor iio_device_claim_direct() implementation
      iio: core: Match iio_device_claim_*() semantics and implementation
      iio: core: Add cleanup.h support for iio_device_claim_*()
      iio: light: vcnl4000: Use IIO cleanup helpers
      iio: health: max30102: Use IIO cleanup helpers
      iio: light: opt4060: Use IIO cleanup helpers

Marcelo Schmitt (2):
      dt-bindings: iio: adc: Add AD4134
      iio: adc: Initial support for AD4134

Massimiliano Pellizzer (1):
      iio: imu: smi330: remove redundant assignment in smi330_read_avail

Michael Harris (1):
      staging: iio: adt7316: modernize power management

Nuno S=C3=A1 (10):
      iio: adc: adi-axi-adc: Make use of dev_err_probe()
      iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_devi=
ce()
      iio: buffer-dma: Use lockdep for locking annotations
      iio: buffer-dma: Use the cleanup.h API
      iio: buffer-dma: Turn iio_dma_buffer_init() void
      iio: buffer-dma: Fix coding style complains
      iio: buffer-dmaengine: Use the cleanup.h API
      iio: buffer-dmaengine: Fix coding style complains
      iio: dac: adi-axi-dac: Make use of a local struct device variable
      iio: dac: adi-axi-dac: Make use of dev_err_probe()

Oleksij Rempel (1):
      bindings: iio: adc: Add bindings for TI ADS131M0x ADCs

Petre Rodan (19):
      dt-bindings: iio: pressure: add honeywell,abp2030pa
      iio: pressure: add Honeywell ABP2 driver
      iio: pressure: mprls0025pa: Kconfig allow bus selection
      iio: pressure: abp2030pa: fix typo in Kconfig description
      iio: pressure: abp2030pa: remove error message
      iio: pressure: mprls0025pa: fix spi_transfer struct initialisation
      iio: pressure: mprls0025pa: fix SPI CS delay violation
      iio: pressure: mprls0025pa: fix interrupt flag
      iio: pressure: mprls0025pa: fix scan_type struct
      iio: pressure: mprls0025pa: fix pressure calculation
      iio: pressure: mprls0025pa: cleanup includes
      iio: pressure: mprls0025pa: remove redundant declarations
      iio: pressure: mprls0025pa: rename buffer variable
      iio: pressure: mprls0025pa: introduce tx buffer
      iio: pressure: mprls0025pa: move memset to core
      iio: pressure: mprls0025pa: stricter checks for the status byte
      iio: pressure: mprls0025pa: change measurement sequence
      iio: pressure: mprls0025pa: add copyright line
      iio: pressure: mprls0025pa: remove error message

Randy Dunlap (3):
      iio: test: drop dangling symbol in gain-time-scale helpers
      iio: buffer: buffer_impl.h: fix kernel-doc warnings
      iio: frequency: ad9523: correct kernel-doc bad line warning

Romain Gantois (1):
      iio: dac: ds4424: drop unused include IIO consumer header

Sebastian Andrzej Siewior (4):
      iio: Use IRQF_NO_THREAD
      iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
      iio: magnetometer: Remove IRQF_ONESHOT
      iio: adc: ad7766: Use iio_trigger_generic_data_rdy_poll()

Shrikant Raskar (8):
      dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
      iio: proximity: rfd77402: Add OF device ID for enumeration via DT
      iio: proximity: rfd77402: Reorder header includes
      iio: proximity: rfd77402: Align polling timeout with datasheet
      iio: proximity: rfd77402: Use kernel helper for result polling
      iio: proximity: rfd77402: Use devm-managed mutex initialization
      iio: proximity: rfd77402: Document device private data structure
      iio: proximity: rfd77402: Add interrupt handling support

Svyatoslav Ryhel (1):
      drivers: iio: mpu3050: use dev_err_probe for regulator request

Tomas Borquez (3):
      staging: iio: ad9832: remove platform_data support
      iio: light: isl29018: replace sprintf() with safer alternatives
      staging: iio: ad9832: clean up whitespace

Tomas Melin (5):
      iio: adc: ad9467: support write/read offset via _calibbias
      dt-bindings: adc: ad9467: add support for ad9211
      iio: adc: ad9467: sort header includes
      iio: adc: ad9467: add support for ad9211
      iio: adc: ad9467: include two's complement in default mode

Yury Norov (NVIDIA) (1):
      iio: adc: ad7606_spi: use bitmap_full() in ad7606_spi_update_scan_mod=
e()

 Documentation/ABI/testing/sysfs-bus-i3c            |   11 +
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |    9 +-
 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    |  120 ++
 .../devicetree/bindings/iio/adc/adi,ad4134.yaml    |  191 +++
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |   64 +-
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    2 +
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       |    3 +
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml        |   63 +
 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |   82 +
 .../devicetree/bindings/iio/adc/ti,ads131m02.yaml  |  208 +++
 .../bindings/iio/amplifiers/adi,adl8113.yaml       |   87 ++
 .../devicetree/bindings/iio/dac/adi,max22007.yaml  |  120 ++
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     |  302 ++++
 .../bindings/iio/frequency/adi,adf4377.yaml        |    8 +
 .../bindings/iio/pressure/honeywell,abp2030pa.yaml |  132 ++
 .../bindings/iio/proximity/rfdigital,rfd77402.yaml |   53 +
 .../devicetree/bindings/trivial-devices.yaml       |    4 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/ad4062.rst                       |  148 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   53 +
 drivers/i3c/master.c                               |   46 +-
 drivers/i3c/master/dw-i3c-master.c                 |   59 +-
 drivers/i3c/master/svc-i3c-master.c                |    4 +-
 drivers/iio/accel/Kconfig                          |   10 +-
 drivers/iio/accel/adxl355_core.c                   |    5 +-
 drivers/iio/accel/adxl372.c                        |   10 +-
 drivers/iio/accel/adxl380.c                        |  138 +-
 drivers/iio/accel/adxl380.h                        |   10 +-
 drivers/iio/accel/bma180.c                         |    5 +-
 drivers/iio/accel/mxc4005.c                        |   11 +-
 drivers/iio/accel/sca3000.c                        |    8 +-
 drivers/iio/accel/stk8ba50.c                       |   11 +-
 drivers/iio/adc/Kconfig                            |   60 +
 drivers/iio/adc/Makefile                           |    5 +
 drivers/iio/adc/ad4062.c                           | 1609 ++++++++++++++++=
++++
 drivers/iio/adc/ad4134.c                           |  500 ++++++
 drivers/iio/adc/ad4170-4.c                         |    2 +-
 drivers/iio/adc/ad7476.c                           |    1 -
 drivers/iio/adc/ad7606_spi.c                       |    2 +-
 drivers/iio/adc/ad7766.c                           |   10 +-
 drivers/iio/adc/ad7768-1.c                         |  428 +++++-
 drivers/iio/adc/ad7779.c                           |    2 +-
 drivers/iio/adc/ad9467.c                           |  152 +-
 drivers/iio/adc/ade9000.c                          |    2 +-
 drivers/iio/adc/adi-axi-adc.c                      |   64 +-
 drivers/iio/adc/aspeed_adc.c                       |   49 +-
 drivers/iio/adc/exynos_adc.c                       |   57 +-
 drivers/iio/adc/mcp3911.c                          |    2 +-
 drivers/iio/adc/men_z188_adc.c                     |    1 -
 drivers/iio/adc/nxp-sar-adc.c                      | 1016 ++++++++++++
 drivers/iio/adc/qcom-spmi-rradc.c                  |   20 +-
 drivers/iio/adc/rockchip_saradc.c                  |   59 +-
 drivers/iio/adc/sc27xx_adc.c                       |   49 +-
 drivers/iio/adc/ti-ads1018.c                       |  739 +++++++++
 drivers/iio/adc/ti-ads131e08.c                     |    2 +-
 drivers/iio/adc/ti-ads131m02.c                     |  968 ++++++++++++
 drivers/iio/amplifiers/Kconfig                     |   12 +
 drivers/iio/amplifiers/Makefile                    |    1 +
 drivers/iio/amplifiers/adl8113.c                   |  269 ++++
 drivers/iio/buffer/industrialio-buffer-dma.c       |  188 +--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   23 +-
 drivers/iio/chemical/ens160_core.c                 |    9 +-
 drivers/iio/chemical/scd4x.c                       |    3 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   11 +-
 drivers/iio/dac/Kconfig                            |   33 +
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/adi-axi-dac.c                      |   66 +-
 drivers/iio/dac/ds4424.c                           |    1 -
 drivers/iio/dac/max22007.c                         |  491 ++++++
 drivers/iio/dac/mcp47feb02.c                       | 1250 +++++++++++++++
 drivers/iio/frequency/adf4377.c                    |  122 +-
 drivers/iio/gyro/adxrs290.c                        |    2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    8 +-
 drivers/iio/gyro/itg3200_core.c                    |    2 +
 drivers/iio/gyro/mpu3050-core.c                    |    6 +-
 drivers/iio/health/afe4403.c                       |    9 +-
 drivers/iio/health/afe4404.c                       |    9 +-
 drivers/iio/health/max30100.c                      |    8 +-
 drivers/iio/health/max30102.c                      |   35 +-
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    3 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    3 -
 drivers/iio/imu/smi330/smi330_core.c               |    9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   55 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  555 ++++---
 drivers/iio/industrialio-core.c                    |   86 +-
 drivers/iio/industrialio-sw-device.c               |    2 +-
 drivers/iio/industrialio-sw-trigger.c              |    2 +-
 drivers/iio/light/isl29018.c                       |   12 +-
 drivers/iio/light/opt4060.c                        |   52 +-
 drivers/iio/light/si1145.c                         |    2 +-
 drivers/iio/light/vcnl4000.c                       |   49 +-
 drivers/iio/magnetometer/Kconfig                   |   13 +
 drivers/iio/magnetometer/Makefile                  |    1 +
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    9 +-
 drivers/iio/magnetometer/mmc5633.c                 |  586 +++++++
 drivers/iio/pressure/Kconfig                       |   63 +-
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/abp2030pa.c                   |  544 +++++++
 drivers/iio/pressure/abp2030pa.h                   |   73 +
 drivers/iio/pressure/abp2030pa_i2c.c               |   90 ++
 drivers/iio/pressure/abp2030pa_spi.c               |   67 +
 drivers/iio/pressure/dlhl60d.c                     |    7 +-
 drivers/iio/pressure/mprls0025pa.c                 |  117 +-
 drivers/iio/pressure/mprls0025pa.h                 |   15 +-
 drivers/iio/pressure/mprls0025pa_i2c.c             |   13 +-
 drivers/iio/pressure/mprls0025pa_spi.c             |   41 +-
 drivers/iio/proximity/rfd77402.c                   |  185 ++-
 drivers/iio/temperature/tmp006.c                   |   10 +-
 drivers/iio/test/Kconfig                           |    1 -
 drivers/staging/iio/addac/adt7316-i2c.c            |    2 +-
 drivers/staging/iio/addac/adt7316-spi.c            |    2 +-
 drivers/staging/iio/addac/adt7316.c                |    6 +-
 drivers/staging/iio/addac/adt7316.h                |    6 +-
 drivers/staging/iio/frequency/ad9832.c             |   37 -
 drivers/staging/iio/frequency/ad9832.h             |   33 -
 include/linux/i3c/device.h                         |   22 +-
 include/linux/i3c/master.h                         |    6 +
 include/linux/iio/buffer-dma.h                     |   20 +-
 include/linux/iio/buffer_impl.h                    |    8 +-
 include/linux/iio/frequency/ad9523.h               |    2 +-
 include/linux/iio/iio.h                            |  139 +-
 include/linux/platform_data/cros_ec_commands.h     |   12 +-
 include/linux/units.h                              |   19 +
 125 files changed, 12096 insertions(+), 1227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4062.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar=
-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad=
l8113.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,max22007.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp=
47feb02.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywel=
l,abp2030pa.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigit=
al,rfd77402.yaml
 create mode 100644 Documentation/iio/ad4062.rst
 create mode 100644 drivers/iio/adc/ad4062.c
 create mode 100644 drivers/iio/adc/ad4134.c
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c
 create mode 100644 drivers/iio/adc/ti-ads1018.c
 create mode 100644 drivers/iio/adc/ti-ads131m02.c
 create mode 100644 drivers/iio/amplifiers/adl8113.c
 create mode 100644 drivers/iio/dac/max22007.c
 create mode 100644 drivers/iio/dac/mcp47feb02.c
 create mode 100644 drivers/iio/magnetometer/mmc5633.c
 create mode 100644 drivers/iio/pressure/abp2030pa.c
 create mode 100644 drivers/iio/pressure/abp2030pa.h
 create mode 100644 drivers/iio/pressure/abp2030pa_i2c.c
 create mode 100644 drivers/iio/pressure/abp2030pa_spi.c
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h
