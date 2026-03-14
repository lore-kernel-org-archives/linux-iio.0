Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36B17B50F
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486560; cv=none; b=tZd02gvNr8SG9pw2QShIUxOdgbp+lNQdLTIhM0+XA3k7nujKsjzwb/Vt/yYElfeyFEXHTab5kxiLaUu909UiPlggzsShdZbO4OOs+GHeSlE7FxwB8Zv9yfSnNljtiL04RyR9U9TkXoGQaHej0/NeSvCXb5nrwxxG7owqwyeNhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486560; c=relaxed/simple;
	bh=VRepjSdDediREukNkStpB82QJL8QzdgIi2HmfMMg7BE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Hte/NTfBm7yq7BNTeSILuUI+EU2gHwfOFHCy1ZrZ59f5FXA6NWJ64DU0hsClAZZNHOQkAb2V+SjhimaieGc/wqvQcDzbsMchgnC9w33gQ17ir0sFDfcf4ETt17lYw2UWtP3OdyLXLmrRlNvvBzMSVpdqOp9atj6PChr2Bx8/O2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo6uG8oP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo6uG8oP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16066C116C6;
	Sat, 14 Mar 2026 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773486559;
	bh=VRepjSdDediREukNkStpB82QJL8QzdgIi2HmfMMg7BE=;
	h=Date:From:To:Subject:From;
	b=Wo6uG8oPuCXFo/D65YN34Iwgb8xoPJBrB+0YtSwnzZDwHr3Ox2Yy67wS2BC1ZftJa
	 f2XuK6+XfHK2P1Oj7Ulca+nKD9gx3hVUJ973CaKlCcTRH7hM4yv7pHuwFtJbg9j3k/
	 dwXYZPzKci1Gyb7FCkqaDV3ECp+9oS92DxetMIIMXFajS4k0pYXLD/z7vvuHoWCvEu
	 hTYg8IvKAbarO9Ao2R6NUZ4zeIL4yf4h9VivpMyUS4UfNJU+m7RV37hVLfkEM2DE0j
	 f4kMReDj6Uvotiiqyw2NWsKIWsVSIJSPRmLnND1i3tIDKH92KyrAV6Nl+pRgC9NrYQ
	 ktCh7+HD63Ciw==
Date: Sat, 14 Mar 2026 11:09:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of fixes for 7.0
Message-ID: <20260314110912.7f512f0a@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit a0b9b0f1433c845bda708753db32befef78e0f1f:

  rust_binder: use lock_vma_under_rcu() in use_page_slow() (2026-02-26 21:34:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0b

for you to fetch changes up to ea7e2e43d768102e2601dbbda42041c78d7a99f9:

  iio: imu: adis16550: fix swapped gyro/accel filter functions (2026-03-07 14:11:30 +0000)

----------------------------------------------------------------
IIO: 2nd set of fixes for the 7.0 cycle

Usual mixed bag of fixes for recent code and much older issues that have
surfaced. Biggest group are continued resolution of IRQF_ONE_SHOT
being used incorrectly (which now triggers a warning)

adi,ad4062
- Replace IRQF_ONESHOT (as no threaded handler) with IRQF_NO_THREAD as
  the caller makes use of iio_trigger_poll() which cannot run from a
  thread.
adi,ade9000
- Move mutex_init() earlier to ensure it is available if spurious IRQ
  occurs.
adi,adis16550
- Fix swapped gyro and accel filter functions.
adi,adxl3380
- Fix some bit manipulation that was always resulting in 0.
- Fix incorrect register map for calibbias on the active power channel.
- Fix returning IRQF_HANDLED from a function that should return 0 or
  -ERRNO.
aspeed,adc
- Clear a reference voltage bit that might be set prior to driver load.
bosch,bno055
- Off by one channel buffer sizing. Benine due to padding prior to the
  subsequent timestamp.
hid-sensors
- A more complex fix to IRQF_ONESHOT warning as this driver had a trigger
  that was never actually used but the ABI that exposed had to be
  maintained to avoid regressions.
hid-sensors-rotation
- An obscure buffer alignment case that applies to quaternions only was
  recently broken resulting in writes beyond the end of the channel buffer.
  Add a new core macro and apply it in this driver to make it very clear
  what was going on.
honeywell,abp2030pa
- Remove meaningless IRQF_ONESHOT from a non threaded IRQ handler.
  Warning fix only.
invense,mpu3050
- Fix token passed to free_irq() to match the one used at setup.
- Fix an irq resource leak in error path.
- Reorder probe so that userspace interfaces are exposed only after
  everything else has finished.
- Reorder remove slightly to cleanup the buffer only after irq removed
  ensuring reverse of probe sequence.
microchip,mcp47feb02
- Fix use of mutex before it was initialized by not performing unnecessary
  lock that was early enough in probe that all code was serial.
st,lsm6dsx
- Ensure that FIFO ODR is only controllable for accel and gyro channels
  avoiding incorrect register accesses.
- Restrict separation of buffer sampling from main sampling rate to
  accelerometer. It is only useful for running event detection faster
  than the fifo and the only events are on the accelerometer.
ti,ads1018
- Fix overflow of u8 which wasn't big enough to store max data rate value.
ti,ads1119:
- Fix unbalanced pm in an error path.
- IRQF_ONESHOT (as no threaded handler) replaced with IRQF_NO_THREAD
  (needed for iio_trigger_poll()).
- Ensure complete reinitialized before reuse. Previously it would have
  completed immediate after the first time.
ti,ads7950
- Fix return value of gpio_get() to be 0 or 1.
- Avoid accidental overwrite of state resulting in gpio_get() only
  returning 0 or -ERRNO but never 1.

----------------------------------------------------------------
Antoniu Miclaus (3):
      iio: adc: ade9000: move mutex init before IRQ registration
      iio: accel: adxl380: fix FIFO watermark bit 8 always written as 0
      iio: imu: adis16550: fix swapped gyro/accel filter functions

Billy Tsai (1):
      iio: adc: aspeed: clear reference voltage bits before configuring vref

Chunyang Chen (1):
      iio: adc: ti-ads1018: fix type overflow for data rate

David Lechner (3):
      iio: imu: bno055: fix BNO055_SCAN_CH_COUNT off by one
      iio: add IIO_DECLARE_QUATERNION() macro
      iio: orientation: hid-sensor-rotation: fix quaternion alignment

Dmitry Torokhov (2):
      iio: adc: ti-ads7950: normalize return value of gpio_get
      iio: adc: ti-ads7950: do not clobber gpio state in ti_ads7950_get()

Ethan Tidmore (4):
      iio: gyro: mpu3050: Fix incorrect free_irq() variable
      iio: gyro: mpu3050: Fix irq resource leak
      iio: gyro: mpu3050: Move iio_device_register() to correct location
      iio: gyro: mpu3050: Fix out-of-sequence free_irq()

Felix Gu (6):
      iio: adc: ti-ads1119: Fix unbalanced pm reference count in ds1119_single_conversion()
      iio: pressure: abp2030pa: Remove IRQF_ONESHOT from devm_request_irq()
      iio: dac: mcp47feb02: Fix mutex used before initialization
      iio: adc: ad4062: Replace IRQF_ONESHOT with IRQF_NO_THREAD
      iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD
      iio: adc: ti-ads1119: Reinit completion before wait_for_completion_timeout()

Francesco Lavra (2):
      iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
      iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only

Giorgi Tchankvetadze (2):
      iio: adc: ade9000: fix wrong register in CALIBBIAS case for active power
      iio: adc: ade9000: fix wrong return type in streaming push

Srinivas Pandruvada (1):
      iio: hid-sensors: Use software trigger

 drivers/iio/accel/adxl380.c                        |  2 +-
 drivers/iio/adc/ad4062.c                           |  8 ++--
 drivers/iio/adc/ade9000.c                          | 12 +++---
 drivers/iio/adc/aspeed_adc.c                       |  1 +
 drivers/iio/adc/ti-ads1018.c                       |  2 +-
 drivers/iio/adc/ti-ads1119.c                       | 11 ++---
 drivers/iio/adc/ti-ads7950.c                       |  8 ++--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 48 ++++++++++++++--------
 drivers/iio/dac/mcp47feb02.c                       |  2 -
 drivers/iio/gyro/mpu3050-core.c                    | 32 ++++++++++-----
 drivers/iio/imu/adis16550.c                        |  8 ++--
 drivers/iio/imu/bno055/bno055.c                    |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 15 ++++++-
 drivers/iio/orientation/hid-sensor-rotation.c      |  2 +-
 drivers/iio/pressure/abp2030pa.c                   |  2 +-
 include/linux/iio/iio.h                            | 12 ++++++
 16 files changed, 107 insertions(+), 60 deletions(-)
