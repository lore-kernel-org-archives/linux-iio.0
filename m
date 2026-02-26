Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841B3A1E72
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101634; cv=none; b=WQC2IWJHUWwlfpH3PXjidL+bev80q/hn/b44BpoGa5gEJDXlVCsszWyXDp8+lVjwO4a5ICCQ0gmiL7urrl/MfTjylaWItjaNAj+P5SnW2HGyPeQUShC2poN7OgCvOQ3R07QhaIfG8P/p6eyEatNJQJrSPoIrB4jFXrqtpFHWmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101634; c=relaxed/simple;
	bh=BXYQJNytoThcPX9lrGTwUr/LSrzBo2cBwcJ8Plj7rFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZAyhqwXkSoau0ILqD7G25h+UCf1iXl+lZJ0DGK1y22pSNBMnKmxuHvlBcquCIliGr/Zfz2x0lbj84Q9xt0E23/oZS4+WqEvjFBCIHHiTX/bBT5OhdpMO+tbpWxE4QsI1mbiOhydAaq6/k6cU5a3PI9SQqWpxv1tQ3Axjvkzd1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3QEZHT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3QEZHT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26BAC19422;
	Thu, 26 Feb 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772101633;
	bh=BXYQJNytoThcPX9lrGTwUr/LSrzBo2cBwcJ8Plj7rFU=;
	h=Date:From:To:Subject:From;
	b=Z3QEZHT1dQ1DR8CI//Leze7M9pxT3jyTAnNkv7DfPFK+KuDGQyDxvI+Zbfm04uqUS
	 5PXQuFhNAafJTq2wXtSpo8+tWs62K/4/D2TQ2po0dR7+GgMuUjae4Y2QtKQcKdB4jM
	 34niHULPELQFw2O1t7ODxU1bFmY1dJFkfdhqHYAB9YvkVBuzWTzVOHR7af3a98rRjG
	 MnRjTmpQRBva4VwR/pQc1TQx4ECr6C28Tk3WAxsfGERyfaxWh0UDFEUYouLahtcyWT
	 reaO348VA3gTWmO/7AwgO4PJ60azFJEnA56eRW336KDFyFk5dTYys7iEKObXqY3q8c
	 jkL+pkcM6xc4w==
Date: Thu, 26 Feb 2026 10:27:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 7.0
Message-ID: <20260226102709.37fa6f2b@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-7.0a

for you to fetch changes up to 9990cd4f8827bd1ae3fb6eb7407630d8d463c430:

  iio: imu: adis: Fix NULL pointer dereference in adis_init (2026-02-23 08:=
24:39 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for the 7.0 cycle

Usual mixed bag of ancient bugs that have been discovered and more
recent stuff.

core
- Cleanup a wait_queue if a driver is removed at exacty the wrong
  moment.
adi,adf4377
- Check correct masks when waiting for reset to complete.
adi,adis
- Fix a NULL pointer dereference if ops not provided to adis_init()
bosch,bme680
- Fix typo in value used to calculate measurement wait duration.
infineon,tlv493d
- Drop incorrect shifting of some bits for x-axis
invensense,icm42600
- Fix corner case of output data rate being set to the value it already
  has which resulted in waiting for ever for a flag to say the update was
  completed.
- Fix a case where the buffer is turned off whilst ODR switch is in progres=
s.
invensense,icm45600
- Interrupt 1 drive bit was inverted.
- Fix a underflow for regulator put warning if probe fails
invensense,mpu9150
- Work around a hardware quirk where reading from irq status is not suffici=
ent
  to acknowledge an interrupt.
maxim,ds4424
- Reject -128 as a possible raw value as it's out of range with the sign
  / magnitude encoding used by this chip.
microchip,mcp4131
- Shift the wiper value only once.
rohm,bh1780
- Fix a runtime reference count issue on an error path.
sensiron,sps30
- Fix two buffer size issues due to sizeof() wrong thing.
tyhx,hx9023s
- Ensure count used by __counted_by is set before accessing the buffer.
- Avoid a potential division by zero.

----------------------------------------------------------------
Andreas Kemnade (1):
      iio: imu: inv-mpu9150: fix irq ack preventing irq storms

Antoniu Miclaus (6):
      iio: light: bh1780: fix PM runtime leak on error path
      iio: magnetometer: tlv493d: remove erroneous shift in X-axis data
      iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
      iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_mea=
s()
      iio: gyro: mpu3050-i2c: fix pm_runtime error handling
      iio: gyro: mpu3050-core: fix pm_runtime error handling

Chris Spencer (1):
      iio: chemical: bme680: Fix measurement wait duration calculation

Ethan Tidmore (1):
      iio: adc: ad7768-1: Fix ERR_PTR dereference in ad7768_fill_scale_tbl

Jean-Baptiste Maneyrol (4):
      iio: imu: inv_icm42600: fix odr switch to the same value
      iio: imu: inv_icm42600: fix odr switch when turning buffer off
      iio: imu: inv_icm45600: fix INT1 drive bit inverted
      iio: imu: inv_icm45600: fix regulator put warning when probe fails

Lukas Schmid (1):
      iio: potentiometer: mcp4131: fix double application of wiper shift

Nuno S=C3=A1 (1):
      iio: buffer: Fix wait_queue not being removed

Oleksij Rempel (1):
      iio: dac: ds4424: reject -128 RAW value

Radu Sabau (1):
      iio: imu: adis: Fix NULL pointer dereference in adis_init

SeungJu Cheon (1):
      iio: frequency: adf4377: Fix duplicated soft reset mask

Yasin Lee (2):
      iio: proximity: hx9023s: fix assignment order for __counted_by
      iio: proximity: hx9023s: Protect against division by zero in set_samp=
_freq

 drivers/iio/adc/ad7768-1.c                         | 13 +++++++++++--
 drivers/iio/chemical/bme680_core.c                 |  2 +-
 drivers/iio/chemical/sps30_i2c.c                   |  2 +-
 drivers/iio/chemical/sps30_serial.c                |  2 +-
 drivers/iio/dac/ds4424.c                           |  2 +-
 drivers/iio/frequency/adf4377.c                    |  2 +-
 drivers/iio/gyro/mpu3050-core.c                    | 18 +++++++++++++-----
 drivers/iio/gyro/mpu3050-i2c.c                     |  3 +--
 drivers/iio/imu/adis.c                             |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  2 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        |  2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 11 ++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  5 ++++-
 drivers/iio/industrialio-buffer.c                  |  6 ++++--
 drivers/iio/light/bh1780.c                         |  2 +-
 drivers/iio/magnetometer/tlv493d.c                 |  2 +-
 drivers/iio/potentiometer/mcp4131.c                |  2 +-
 drivers/iio/proximity/hx9023s.c                    |  6 ++++--
 22 files changed, 73 insertions(+), 27 deletions(-)
