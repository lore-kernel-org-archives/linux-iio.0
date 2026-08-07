Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929143B2FD0
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143307; cv=none; b=L64QJ9jLyaA3fsf0WNf+Jl9sjbjdbObr6SoAWyoDbiHkroWhjXerjio3vD0EZMPNVGzMWeuE3qa4nKJ/cdPA/LNloJ2NnBoupl2+jNQmw3IQtB5OojjmyCNM5JtZ1SP4UOHN3PkZvaXU0hTPFlYMYhaq3/i2pan2A/zIxeGF39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143307; c=relaxed/simple;
	bh=6RydFHh9wdOYgRVl4l5TysYLo4n98NqR+ddW0EwXylc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=IMWViqwzJLa/15zCwIPEYQyTr29aPzLty9yIij32E/Y7FZQMl6gymCXvky8grKkKJ6h/0r1uhgrUKnFqrnxO/q5cXPKa94AG6JuFB0uM1HyJaMySdNDMnxOKudd9c2vHTuHFF0EyqN2U1RONOq/JZPa8qKlY9PtmWeHzHaKgFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJKTpoZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJKTpoZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F51F000E9;
	Fri,  7 Aug 2026 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143306;
	bh=BLnoGHJPfPgkKfLrmo28e182xojX+OuwbsbLs3afci4=;
	h=Date:From:To:Subject;
	b=YJKTpoZEFtgEDNbBZ5YRXidYJmK5iV808AjZdThJYbN+xNy2gbXF3EDoN7aA9F5QV
	 6cKItHCfXMT/PkUsgW9NhlJL1N8l9MYUPir4wcT4Rpl6pnQgD/veX6vm5KkmIek/Rr
	 6SlhMojg492OkmRNb8ghTmrYJKCwV3Tn5PQTJasP1MS8OImHE+bw6hqSmjq02JOXPN
	 pSFD9yifc/pacZBdGA4mmnraYtl+xyK3B5xh0+hhhrxu0bQiyg4y8F7yn4uS1ANURS
	 Po2ZRbvdkHLwvW0tPrUzdFm2CMKYYsEBPfxkVUHdHarCLGJvIh6G8XnXuTvRaj0buX
	 Caj8yvWMtfgNQ==
Date: Fri, 7 Aug 2026 23:55:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL v2] IIO: Fixes for 7.2 set 2 (probably now for merge window)
Message-ID: <20260807235501.68268be2@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 3585cfd4563731a8ae406b32807613c667c2b887:

  Merge tag 'iio-fixes-for-7.2a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-07-09 07:44:06 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.2b-take2

for you to fetch changes up to be61c8c6252671ecf1fee0ad90f87669e0be1e20:

  iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF (2026-08-07 23:51:05 +0100)

----------------------------------------------------------------
IIO: 2nd set of fixes for the 7.2 cycle.

Given timing these are probably now merge window material.

Usual mixed bunch of ancient issues and newer ones.

core,buffer
- Fix a potential UAF in release on anonymous buffers.
- Make sure DMA fence lock lifetime matches that of the DMA fence.
- Make IIO DMA fence release RCU safe.
various
- Kconfig missing REGMAP* related selects.
- Unbalance of runtime pm or regulators in error paths.

adi,ad3552r-hs
- Fixing wrong buffers size for string printing.
adi,ad4080
- Fix 16-bit part support by adding path to tell the backend what
  the data size is - avoiding corrupted data capture.
adi,ad5446
- Wrong MODULE_DEVICE_TABLE() type due to case error.
atlas,sensor
- Drop use of irq_work() in favour of iio_trigger_poll_nested() avoiding
  a possible UAF.
hid-temperature
- Potential release ordering issue due to mixed devm and not that
  can lead to long timeouts.
infineon,dps310
- Fix NULL dereference on ACPI platforms.
invense,mpu3050
- Fix sign of raw angular velocity readings.
mitsubishi,m62332
- Fix a regulator reference counting issue when switching channels.
sharp,gp2ap002
- Unbalanced runtime PM on repeated event writes.
- Reenable irq if runtime suspend fails.
ti,ads7138
- Disable statistics gathering whilst reading conversions results
  to avoid data corruption.
ti,opt4001
- Ensure integration times with integer part are rejected rather than
  ignoring the integer part of the value.
- Fix use of wrong register.
- Pointer type mismatch to div_u64_rem()
- Fix reversed GENMASK() arguements.
ti,opt4060
- Ensure integration times with integer part are rejected rather than
  ignoring the integer part of the value.
- Pointer type mismatch to div_u64_rem()
- Wrong register name in an error print.
ti,pac1921
- Fix wrong channel used in the trigger handler for some combinations
  of enabled channels.

----------------------------------------------------------------
Antoniu Miclaus (2):
      iio: adc: adi-axi-adc: add data size support for AD408X backend
      iio: adc: ad4080: configure backend data size

Babanpreet Singh (1):
      iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source show

Can Peng (1):
      iio: dac: ad5446: fix OF module device table

Cong Nguyen (3):
      iio: srf04: fix pm_runtime handling on probe error path
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: adc: pac1921: fix wrong channel used in trigger handler read

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

Fan Wu (1):
      iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF

Joshua Crofts (3):
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig
      iio: adc: max14001: add missing 'select REGMAP' to Kconfig
      iio: dac: mcp47feb02: add missing 'select REGMAP_I2C' to Kconfig

Lars-Peter Clausen (3):
      iio: buffer: Fix potential use-after-free in anonymous buffer release
      iio: buffer: Tie IIO dma fence lock lifetime to the fence
      iio: buffer: Make IIO DMA fence release RCU-safe

Laxman Acharya Padhya (1):
      iio: light: gp2ap002: Disable regulators on resume failure

Moksh Panicker (2):
      iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable
      iio: light: apds9306: fix PM reference leak in apds9306_read_data()

Nikhil Gautam (6):
      iio: light: opt4001: Fix power down clearing bits of the wrong register
      iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
      iio: light: opt4001: Reject integration times with a non-zero seconds part
      iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Paul Geurts (1):
      iio: ti-ads7138: Disable STATS_EN bit while reading conversion results

Rupesh Majhi (1):
      iio: pressure: dps310: fix NULL pointer dereference on ACPI probe

Sanjay Chitroda (1):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()

Vidhu Sarwal (4):
      iio: light: ltrf216a: fix runtime PM reference leak in error path
      iio: light: opt4060: Reject integration times with a non-zero seconds part
      iio: light: opt4060: Fix pointer type passed to div_u64_rem()
      iio: light: opt4060: Fix incorrect register name in threshold read error message

 drivers/iio/adc/Kconfig                          |  2 ++
 drivers/iio/adc/ad4080.c                         |  5 +++
 drivers/iio/adc/adi-axi-adc.c                    | 30 +++++++++++++++++
 drivers/iio/adc/pac1921.c                        |  2 +-
 drivers/iio/adc/ti-ads7138.c                     | 42 +++++++++++++++++++-----
 drivers/iio/chemical/atlas-sensor.c              | 19 ++++-------
 drivers/iio/dac/Kconfig                          |  1 +
 drivers/iio/dac/ad3552r-hs.c                     |  2 +-
 drivers/iio/dac/ad5446-i2c.c                     |  2 +-
 drivers/iio/dac/m62332.c                         | 17 +++++++---
 drivers/iio/gyro/mpu3050-core.c                  |  2 +-
 drivers/iio/industrialio-buffer.c                | 38 ++++++++++-----------
 drivers/iio/light/apds9306.c                     |  8 ++---
 drivers/iio/light/gp2ap002.c                     | 24 +++++++++++---
 drivers/iio/light/ltrf216a.c                     |  3 +-
 drivers/iio/light/opt4001.c                      | 37 +++++++--------------
 drivers/iio/light/opt4060.c                      |  9 +++--
 drivers/iio/pressure/dps310.c                    |  3 +-
 drivers/iio/proximity/srf04.c                    |  1 +
 drivers/iio/temperature/hid-sensor-temperature.c |  3 +-
 20 files changed, 156 insertions(+), 94 deletions(-)
