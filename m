Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE843935A
	for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2026 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563094; cv=none; b=cfbwvuCz6VvVbCl7lKTDTjYK9YD0wNcw+PEyI06pNd01G/HX9PFcQqA/lC35mP+LwcMgBGLOZ1482NqIkIgQjIJyGqfJzbb9bznByzxiAiiPzh2am2eDEceJLHLzAhTR+9ZMUTl591rkXKXfcdVnjsQp9rQZVYiMNn8cACaQgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563094; c=relaxed/simple;
	bh=c7DR7FFiMi/royKn3N3F6wKK1pQ1nP6n9zK7de1t13k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=cm3Nb9XBHWu2SuBjjDcG11zWtFIqu1VpJIgV1j99IRAiFKyWyF73HFlqiBNxDDDYIaBsv7tvMwz2j3GqYaWRuflsyxE1wkfXEpSwPqbAtrA9o18q82pRdOd23DMCtxpNIdQK9kY5fQvl4L1oxKrAbdZ5W6cylGk3QYe3g6GWBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0hp7xpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0hp7xpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB0E1F000E9;
	Thu,  9 Jul 2026 02:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783563093;
	bh=fPzjjgOemkiqWQAajZufJ60qch0KXCKVp0W3NqxeTu8=;
	h=Date:From:To:Subject;
	b=f0hp7xpDH04+lpOieYdJbq+lxVx2X9tFUSCWfNGLKvar5CTdYe7BN4mWvX25dVojp
	 +QobVDlZeJWyaVRgPdxw+C6XyHSIwLnd1lj8olV7nCN81+wDyeD6ptXpEikp2e/FQX
	 6dtd72LR3ZloFgEEqkEQf0NsYVEd+fkvPy+8q0lwBwhZytNG5lqVk97SgYhmkWtyrG
	 orROkPgYYijqMi+NoRJer4M9wbpVRToLfL1N7svBJ6mjNvjfbkOwHl6Jz/qXsQtWLV
	 HBmTh9aDHW3zJwwTf3T2aoeLHzh04CbRfZB54TG0h2Af075Dj3DKV73cPX6/dC1Rul
	 wnUcSIWd939Sg==
Date: Thu, 9 Jul 2026 03:11:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 7.2 cycle.
Message-ID: <20260709031127.39661e79@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.2a

for you to fetch changes up to af791d295737ea6b6ff2c8d8488462a49c14af01:

  iio: event: Fix event FIFO reset race (2026-07-08 15:47:34 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for the 7.2 cycle

Usual mixed bag of recently introduced issues and much older ones.

core
- Ensure kfifo is reset before fd is allocated avoiding concurrent use of
  fifo with reset.
multiple drivers
- Fix up missing Kconfig dependencies.
hid-sensors
- Add support for multibyte read as necessary precursor to...
- Fix stale or zero output when reading raw values for quaternions.
adi,adis
- Add IRQF_NO_THREAD to ensure interrupt is not pushed to the software
  interrupt chip used for trigger demux in the IIO core from a thread.
bosch,bmc150
- Hardening against device returning a reserved out of range value for
  how many entries are in the FIFO.
bosch,bmi160
- Add IRQF_NO_THREAD to ensure interrupt is not pushed to the software
  interrupt chip used for trigger demux in the IIO core from a thread.
dynaimage,al3010
- Fix wrong scale for highest gain_range due to too many digits in the
  micro part (val2).
freescale,mpl3115
- Fix unbalanced runtime pm on error in read_raw().
invensens,icm42600
- Avoid wrong divisor for fifo timestamps when using the watermark
  interrupt.
- Fix timestamp accuracy loss due to excessive divisor for calculations.
kionix,kxsd9
- Fix unbalanced runtime pm on an error in write_raw().
microchip,mcp37feb02
- Fix an uninitialized reference voltage value for particular DT config.
melix,mlx90635
- Build on basis of right Kconfig symbol.
nxp,lpc32xx
- Ensure completion initialized before requesting irq. Hardening against
  spurious IRQ.
nxp,saradc
- Fix a delay calculation.
sharp,gp2ap0002
- Fix unbalanced runtime pm on error in read_raw().
st,lsm6dsx
- Fix an issue seen in wild where an unplanned CPU reset can leave the
  device on the wrong register page, thus leaving the driver wedged.
st,st_sensors library
- Make sure to handle a device that provides data as big endian correctly.
st,spear
- Ensure completion initialized before requesting irq. Hardening against
  spurious IRQ.
taos,tsl2591
- Don't eat return from devm_request_threaded_irq() as that breaks
  deferred probing.
ti,ads1119
- Fix a pm reference count leak in an error path.
ti,ads124s08
- Handle gpio look up errors correctly.

----------------------------------------------------------------
Andreas Kempe (1):
      iio: imu: st_lsm6dsx: deselect shub page before reading whoami

Andy Shevchenko (1):
      iio: adc: nxp-sar-adc: Fix the delay calculation in nxp_sar_adc_wait_for()

Ariana Lazar (1):
      iio: dac: mcp47feb02: Fix passing uninitialized vref1_uV for no Vref1 case

Biren Pandya (3):
      iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
      iio: pressure: mpl115: fix runtime PM leak on read error
      iio: light: gp2ap002: fix runtime PM leak on read error

Bryam Vargas (1):
      iio: accel: bmc150: clamp the device-reported FIFO frame count

Guangshuo Li (1):
      iio: adc: ti-ads1119: fix PM reference leak in buffer preenable

Herman van Hazendonk (1):
      iio: common: st_sensors: honour channel endianness in read_axis_data

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
      iio: imu: inv_icm42600: fix timestamp clock period by using lower value

Joshua Crofts (5):
      iio: light: al3000a: add missing REGMAP_I2C to Kconfig
      iio: light: al3010: add missing REGMAP_I2C to Kconfig
      iio: light: al3320a: add missing REGMAP_I2C to Kconfig
      iio: adc: ad4130: add missing `select IIO_TRIGGERED_BUFFER` to Kconfig
      iio: adc: ad7779: add missing 'select IIO_TRIGGERED_BUFFER' to Kconfig

Lars-Peter Clausen (1):
      iio: event: Fix event FIFO reset race

Maxwell Doose (2):
      iio: adc: lpc32xx: Initialize completion before requesting IRQ
      iio: adc: spear: Initialize completion before requesting IRQ

Pengpeng Hou (2):
      iio: temperature: Build mlx90635 with CONFIG_MLX90635
      iio: adc: ti-ads124s08: Return reset GPIO lookup errors

Runyu Xiao (2):
      iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
      iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ

Samuel Moelius (1):
      iio: adc: ad7380: select REGMAP

Srinivas Pandruvada (1):
      HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads

Stepan Ionichev (1):
      iio: light: tsl2591: return actual error from probe IRQ failure

Vidhu Sarwal (1):
      iio: light: al3010: fix incorrect scale for the highest gain range

Zhang Lixu (1):
      iio: hid-sensor-rotation: Fix stale or zero output when reading raw values

 drivers/hid/hid-sensor-hub.c                       | 77 ++++++++++++++++++++--
 drivers/iio/accel/bmc150-accel-core.c              |  2 +
 drivers/iio/accel/kxsd9.c                          |  5 +-
 drivers/iio/adc/Kconfig                            |  3 +
 drivers/iio/adc/lpc32xx_adc.c                      |  4 +-
 drivers/iio/adc/nxp-sar-adc.c                      |  4 +-
 drivers/iio/adc/spear_adc.c                        |  3 +-
 drivers/iio/adc/ti-ads1119.c                       |  6 +-
 drivers/iio/adc/ti-ads124s08.c                     |  3 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    | 23 +++++--
 drivers/iio/dac/mcp47feb02.c                       | 37 ++++++-----
 drivers/iio/imu/adis_trigger.c                     |  2 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |  3 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  9 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 21 +++++-
 drivers/iio/industrialio-event.c                   |  5 +-
 drivers/iio/light/Kconfig                          |  3 +
 drivers/iio/light/al3010.c                         |  2 +-
 drivers/iio/light/gp2ap002.c                       |  2 +-
 drivers/iio/light/tsl2591.c                        |  6 +-
 drivers/iio/orientation/hid-sensor-rotation.c      | 40 ++++++++++-
 drivers/iio/pressure/mpl115.c                      |  4 +-
 drivers/iio/temperature/Makefile                   |  2 +-
 include/linux/hid-sensor-hub.h                     | 25 +++++++
 27 files changed, 238 insertions(+), 62 deletions(-)
