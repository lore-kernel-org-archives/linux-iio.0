Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366305;
	b=ANJiMRI1H3Ndk3g7051cxFRo8z0YudTP9xJZgGjTtCunqM1InZz5Jy493bOaQA2xVJEF
	 GI426Z4c3OIS/f4985IW2RZyTXuvg5u+p8Bx7ufhBfbR8GdG+eRlRNys5rLbM2aax2J0A
	 n8vkN5kavZcv2bPLDcAOyw5SV4lMoXESYNRBn/Yg4iF05h1aD9qFUbbAmEaCE+9KFkfzm
	 2OnsRPS3QDHiz1kJBsoNtuX2iqKDPNTD/pXcvlICv9/IVJvtdrEQcmdlC0RVe4FEI5AbW
	 FklOp5naNQotyNwDxFv5+JYAdtaK9U1nOCColRBCYjSTwObmn/seGGUuUql5dbwuVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366305;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m4ksFALdsZnw9x4BekeGDsKIE2z9wrI5Xgv5CuaTDAQ=;
	b=Wu7lCp+Vce5QVpsrV2aFvlzBYhDSHnWDlmTvqj+3KZCWz2FVOkIQvCpU6kT/oqxMsq4y
	 +6YSNwlVva4hO3ZdAawg1GtU5BYJ6M5JAmdtqCXDJf18bXc4E7Eb0i2RzkViWvqzCZGrm
	 hG0Zu63f22h3OpdZigiDLvQLwjgWO/JxdP/LqlB2gWTKD1wJppL6ZJui3LCcSg41ZvQh/
	 Az77HRGFxdFPlnvZQnA6zQvTPG2Loq/hq6WF8kfU/Aj9IbUimR449xgUJBIGXQJDEKDL5
	 IZ7rgC1A/MKolpLDUsRlAigBkOWUah/ObnTSLyuyTVnfN3gof3ot99B0VW4ubymaj5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QQud1/BX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D7606A31C
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQud1/BX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318D1F0089F;
	Wed, 11 Nov 2026 03:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366305;
	bh=m4ksFALdsZnw9x4BekeGDsKIE2z9wrI5Xgv5CuaTDAQ=;
	h=Date:From:To:Subject;
	b=QQud1/BXedyetfZmjXm2SP2S2UxyFklSbRD1wrICXyPdDvfaervFbgt7ygkIe8x2Y
	 b58NP7HT9niCOxuW7/H+rsgQgk0mpJ7Tf5K6GQrlJIWndyPNg6j0hgFa3WPACPS71+
	 hAQOcsvsIl1kYAtbHWj/D1NDtGI4AUN4MjP3w34zMfKIlxFqduvdiuRBWKlAJzznij
	 BQnMx8y60vVru5XXrHQff/4+CcEIe02vij99/H0jkKkvnRWU+DBzZz3iQ5qDbH0PtK
	 JMkVd4KVoq92rGGNwjGiayO4eq3J0fAf5txuXFH04LDGuyMgd1EVE4LjGKjp7oiWLb
	 GvnQqHrBPJKvQ==
Date: Wed, 11 Nov 2026 03:05:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 7.4 cycle.
Message-ID: <20261111030502.4b68277a@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.4a

for you to fetch changes up to 79c8dffd84e9784ec05bea68dbe5e71f7ec9941a:

  iio: hid-sensors: fix fractional part for unit exponents -7 and -8 (2026-11-11 02:53:02 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for the 7.4 cycle.

A bumper set at least partly because I was traveling for a few
weeks at the end of last cycle so things that would otherwise
have hit for the merge window are in here.

Usual mixed bag of recent stuff and older bugs. More trivial recent
fixes are separately queued for next merge window.

Rebase just now to drop a patch that should go via drivers/hid, rest
have been in linux-next for a few days at least.

core
- Return an error rather than eating attempt to have more consumers
  of a trigger than supported.
- Fix an ordering issue which could lead to a trigger ID reuse before
  sysfs is torn down resulting in a failure to create file.
acpi
- Allow for commas in ROTM strings (unofficial but common windows ACPI
  extension). Fixes a bunch of machines.
hid-sensors
- Fix handling of fraction part of value for unit exponents -7 and -8.
- Avoiding reading past end of short data fields for ALS.
- Fix scaling for magnetic north heading.
- Use per instance callbacks to ensure multiple instances don't clash.
afe-rescale
- Don't hide the offset attribute if the source has one (just pass that
  through).
 - Avoid a division by zero.
adi,ad_sigma_delta library
- Ensure ad_sd_init() return value always checked as gpio request
  may result in a -EPROBE_DEFER.
adi,ad5758
- Fix miss specified current range matched against dt binding. Given
  it is obviously wrong we assume no one was using that value.
adi,ad74413r
- Fix values passed to gpio set multiple.
adi,ad7923
- Add missing AD7927 entry to the SPI ID table to ensure autoprobe
  works when fallback compatible in use.
adi,adxl313
- Missing Kconfig dependencies.
adi,adxl345
- Missing Kconfig dependencies.
adi,adxl380
- Don't get stuck in standby on invalid value write attempt.
aosong,am2315
- Fix handling of negative temperatures.
aspeed,adc
- Use sycon phandle for trimming data rather than just finding
  first syscon which is the wrong one on some devices.
arm,scmi-sensors
- Fix truncation in a 64 bit division.
atlas,ezo
- Don't reject attempts to read the humdity channel.
bosch,bmg160
- Fix underflow on repeated event disable.
google,cros_ec
- Use correct union member for calibscale
invensense,mpu6050
- Fix scaling of magnetometer Y and Z axis due to missing address values.
- Startup times for gyroscope and accelerometer were swapped.
kionix,kmx61
- Fix underflow on repeated event disable.
kionix,kxsd9
- Fix a use after free due to wrong remove() ordering.
infineon,tlv493d
- Fix scaling of magnetic field which was out by a factor of 100.
invensense,sensors
- Corner case fixes for timestamp estimation and handling of data
  rate changes..
melexis,mlx90614
- Fix probe check on dual channels which was inverted.
memsic,mmc5633
- Ensure we aren't in regmap cache only mode when syncing the cache.
memsic,mmc35240
- Ensure we aren't in regmap cache only mode when syncing the cache.
microchip,mcp3564
- Reject probe if no match data found, avoiding NULL dereference.
microchip,mcp4725
- Ensure cached value is only update on write success.
microchip,mcp47feb02
- Reject out of range raw values being written to this DAC.
qcom,spmi-adc5-gen3
- Ensure unique IDs used for ADC_TM aux devices by reusing the IIO
  device ID.
semtech,sx9301
- Use i2c_get_match_data() to allow new_device based matching.
semtech,sx9324
- Fix an out of bounds read of the scan period table as table
  was too short.
semtech,sx9360
- Fix writing of the sampling frequency and what values are in the
  presented available range.
semtech,sx9500
- Ignore event config writes that don't change current state to
  avoid reference tracking overflow/underflow.
taos,tsl2591
- Avoid a divide by zero.
tyhx,hx9023s
- Ensure trigger is allocated before interrupt that uses it is registered.
vishay,vcnl4035
- Fixed inverted ALS mode bit.

----------------------------------------------------------------
Alexander Sarmanow (1):
      iio: light: vcnl4035: Fix reversed ALS mode bit

Alexis Bouzigues (2):
      iio: accel: adxl345: select IIO_BUFFER and IIO_KFIFO_BUF
      iio: accel: adxl313: add missing buffer selections in Kconfig

Andrea Amer (1):
      iio: afe: rescale: expose offset if rescaler or source has one

Arka Mondal (2):
      dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA current range
      iio: dac: ad5758: Fix the 4 mA to 20 mA current range

Arnav Kapoor (8):
      iio: imu: inv_mpu6050: fix magnetometer scale of Y and Z axes
      iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
      iio: common: scmi_sensors: fix truncating 64-bit divisions
      iio: common: cros_ec_sensors: use sensor_scale union member for CALIBSCALE
      iio: proximity: sx9324: fix out-of-bounds read of scan period table
      iio: adc: mcp3564: reject devices without match data
      iio: proximity: sx9360: fix sampling frequency write and available range
      iio: proximity: sx9500: ignore event config writes that don't change state

Baek Kyu, Kim (1):
      iio: dac: mcp4725: Update the cached DAC value only on success

Billy Tsai (2):
      dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
      iio: adc: aspeed: Use syscon phandle for trimming data when available

Changyul Lee (1):
      iio: trigger: free the trigger ID after device_del()

Christopher Hoover (2):
      iio: temperature: hid-sensor-temperature: Use per-instance callbacks
      iio: humidity: hid-sensor-humidity: Use per-instance callbacks

Daniel Schaefer (1):
      iio: light: hid-sensor-als: Don't read past the end of short fields

David Carlier (1):
      iio: dac: mcp47feb02: reject out-of-range raw values

Guangshuo Li (1):
      iio: accel: kxsd9: Fix potential use-after-free on removal

Jan Remes (1):
      iio: light: tsl2591: don't divide by zero

Jean-Baptiste Maneyrol (3):
      iio: inv_sensors: prevent timestamps going back in time in transitions
      iio: inv_sensors: do not compute period estimation when updating odr
      iio: imu: inv_icm42600: fix parsing of all FIFO frames for odr change

Jiale Yao (2):
      iio: gyro: bmg160: reject duplicate event disable
      iio: imu: kmx61: reject duplicate event disable

Josef Bacik (6):
      iio: sx9310: use the data of the I2C table
      iio: addac: ad74413r: fix the values of set_multiple
      iio: adc: ad7923: add the AD7927 to the SPI ID table
      iio: adc: check the result of ad_sd_init()
      iio: accel: adxl380: don't stay in standby on -EINVAL
      iio: hid-sensors: fix a division by zero

Karl Mehltretter (1):
      iio: trigger: Return an error when the trigger has no free irq

Loic Poulain (1):
      iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for ADC_TM aux device

Maximilian Czirr (1):
      iio: hid-sensor: Fix scale for magnetic north heading

Myeonghun Pak (1):
      iio: proximity: hx9023s: Allocate trigger before requesting IRQ

Nikhil Gautam (1):
      iio: atlas-ezo: Fix humidity channel read support

Salah Triki (1):
      iio: temperature: mlx90614: Fix dual channel probe condition check

Shashank Mohan Jain (2):
      iio: magnetometer: mmc35240: leave cache-only mode before the cache sync
      iio: magnetometer: mmc5633: leave cache-only mode before the cache sync

Srinivas Pandruvada (1):
      iio: hid-sensors: fix fractional part for unit exponents -7 and -8

Vidhu Sarwal (1):
      iio: humidity: am2315: fix negative temperature decoding

Viral Patel (1):
      iio: magnetometer: tlv493d: fix magnetic field scale

Yu-Hsiang Tseng (1):
      iio: acpi: Accept comma separated values in ROTM strings

 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 17 ++++
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |  4 +-
 drivers/iio/accel/Kconfig                          |  4 +
 drivers/iio/accel/adxl380.c                        | 11 ++-
 drivers/iio/accel/kxsd9.c                          |  2 +-
 drivers/iio/adc/ad7780.c                           |  4 +-
 drivers/iio/adc/ad7791.c                           |  4 +-
 drivers/iio/adc/ad7793.c                           |  4 +-
 drivers/iio/adc/ad7923.c                           |  1 +
 drivers/iio/adc/aspeed_adc.c                       | 25 ++++--
 drivers/iio/adc/max11205.c                         |  4 +-
 drivers/iio/adc/mcp3564.c                          |  3 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c              |  5 +-
 drivers/iio/addac/ad74413r.c                       |  2 +-
 drivers/iio/afe/iio-rescale.c                      |  3 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |  3 -
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  5 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 14 +++-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 24 ++++--
 drivers/iio/common/scmi_sensors/scmi_iio.c         | 27 +++---
 drivers/iio/dac/ad5758.c                           |  4 +-
 drivers/iio/dac/mcp4725.c                          |  2 +
 drivers/iio/dac/mcp47feb02-core.c                  |  3 +
 drivers/iio/gyro/bmg160_core.c                     |  2 +-
 drivers/iio/humidity/am2315.c                      | 12 ++-
 drivers/iio/humidity/hid-sensor-humidity.c         | 14 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 24 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 97 +++++++++++++++++-----
 drivers/iio/imu/kmx61.c                            |  2 +-
 drivers/iio/industrialio-acpi.c                    |  9 ++
 drivers/iio/industrialio-trigger.c                 |  4 +-
 drivers/iio/light/hid-sensor-als.c                 | 16 +++-
 drivers/iio/light/tsl2591.c                        | 32 ++++---
 drivers/iio/light/vcnl4035.c                       |  4 +-
 drivers/iio/magnetometer/mmc35240.c                |  3 +-
 drivers/iio/magnetometer/mmc5633.c                 |  3 +-
 drivers/iio/magnetometer/tlv493d.c                 |  6 +-
 drivers/iio/proximity/hx9023s.c                    | 16 ++--
 drivers/iio/proximity/sx9310.c                     |  2 +-
 drivers/iio/proximity/sx9324.c                     | 13 ++-
 drivers/iio/proximity/sx9360.c                     | 29 +++++--
 drivers/iio/proximity/sx9500.c                     |  6 ++
 drivers/iio/temperature/hid-sensor-temperature.c   | 14 ++--
 drivers/iio/temperature/mlx90614.c                 |  2 +-
 include/linux/iio/common/inv_sensors_timestamp.h   |  3 +-
 45 files changed, 348 insertions(+), 140 deletions(-)
