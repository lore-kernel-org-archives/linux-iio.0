Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFD55295B
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790156; cv=none; b=Oa7a2V+NrHuGWpMjACRODJv63zIKiWOtr6ofgbxRalmLiPiafltW6eMvBKyEuhOLUxKz880BC+QDJQTx87FX+1MZhT8caaBp9IB9GxqSPS2DNvUR5c43+yPEFNxrGmyNJyjq41QgnkUNY4J1HS/c8Lv1q63H2wOIXT+pZ9ZUvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790156; c=relaxed/simple;
	bh=xnnEyF/emFv4Q/K61hnfvrCFW8pE8o05+D5rhY9YwjQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=KrCbc4jt2XAskcinL1ba54GgADjhHcsM8HuoYAdwlJ9OY+LCuqmAgYYVRjRBA5aNQ6sG10eCiZsnTDsLw6wviye2jUC9Wx6ye03NLfwUa8DvMzk1fFMXsKJ0HTXVbIqSDvZrTruc8HO1a9F87sITh2d1R7QaH59j8rWDREJ74VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvdW9een; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvdW9een"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8561F000FF;
	Wed, 30 Sep 2026 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790152;
	bh=Ysd5sNorrblGIYosuLh3BN2iFGSiPzixV1uAlfdzylA=;
	h=Date:From:To:Subject;
	b=TvdW9eenC4HTjniGWwaTK0/G6pLwQ6cV5/w1adbaU6T2t/DA8CvL4AVa69yXXDm6K
	 49I8LEgfS5JzIkTu9/k/Op+HR541mzflF4/GI2hvN6ezcYvWJo5SZspocxiBfR1x9z
	 GBoOi5O8MTAZUP6Dy+fcMTPKiM3skYQ8bH7QhDkN/JeS/QgAweIntdWTc1NWsZXCmP
	 d++hBDqdlqv0meEv/WJpOV4FTO3Ecd/Vf2Qoog2S3VIfuXd2mQAjl1+qBu7ZolI83a
	 5sW46y3nonLbuBOayJ+Jz1C22DH2CVA6HGa/uH7A6xYP2QYaURV9HiMhZ1csxQmioo
	 5BNUKwqddUTNg==
Date: Wed, 30 Sep 2026 18:42:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support, features, cleanup and
 fixes for 7.4
Message-ID: <20260930184226.723762b9@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-7.4a

for you to fetch changes up to a3b3580713f3ac5a32dc2874ee546828977a1d68:

  iio: dac: ad5758: Fix the offset calculation (2026-09-28 17:07:37 +0100)

----------------------------------------------------------------
IIO: 1st set of device support, features and cleanup for 7.4

2 merges
- v7.3-rc4 to get a x86 build fix needed by the ad9910 driver.
- devm_notifier_chain_register to pick up the IIO specific users of this
  new infrastructure.

New device support
------------------

Major refactors or new drivers needed:

adi,ad3530r
- Support for the AD5710R and AD5711R 8 channel IDAC / VDAC parts.
  Needed substantial driver rework to support channel type controls.
adi,ad5529r
- New driver for this 16 channel DAC with 12 and 16 bit variants.
adi,ad7768
- New driver for the 8 (AD7768) and 4 (AD7768-4) channel variants of this
  24-bit simultaneous sampling ADC family. They are very different from
  the 1 channel variant that has as separate driver.
adi,ad9910
- New driver for this DDS (Direct Digital Synthesizer). This was a large
  undertaking is it is a complex chip requiring quite a lot of new IIO ABI.
  Delayed from last cycle by an x86 bug that was fixed in rc4.
adi,ade9000
- Add support for the ADE9078 polyphase energy metering device.
  Required significant changes to introduce multiple part support into
  this driver.
adi,adis16201
- Add support for the ADIS16203 device, replacing the driver in staging.
axiado,saradc
- New driver for the SARADC found on the AX3000 and ADX3005 SoCs.
liteon,ltr501
- Add support for the LTR-329ALS-01 ambient light sensor. Included
  various bits of driver modernization.
microchip,mcp48fev02
- Split previously I2C specific mcp47feb02 into core and I2C specific
  parts.
- Add an SPI specific part for the many parts in the MCP48FxBy1/2/4/8
  series of SPI DACS 24 different part numbers covering:
  - 8, 10 and 12 bit resolutions
  - 1, 2, 4, and 8 channels
  - EEPROM and no non volatile storage variants.
- Substantial driver modification and cleanup was needed prior to the new
  support.
maxim,max40080
- New driver for this current-sense amplifier with integrated ADC.
renesas,rzg2l_adc
- Support the RZ/G3L ADC 1 that is dedicate to the on-chip thermal
  sensor unit. The thermal parts of this support will be going through
  that tree.
sensortek,stk3310
- Add support for the STK36C61 Ambient Light, proximity and RGB color
  sensor. Handling had to be added for RGB elements and the driver in
  general had to be made ready for support multiple parts.
ti,ads1100
- Add support for the ADS1110 with faster data rate and 2.048V reference.
ti,ads112c04
- New driver to support this 16bit sigma-delta ADC.
vishay,veml6031x00
- New driver for this ambient light sensor that was built in in stages.
- Add triggered buffer data capture.
- Add support for events and triggers.
- Enable mysterious 'internal calibration' setting.

Minor additions such as IDs, compatibles or device specific data.

adi,ad3530r
- Support the AD3536R which is low resolution equivalent of the already
  supported AD3532R.
adi,ad4080
- Support the AD4885 - only needed chip specific data.
aosong,am2315
- Add support for the AM2320, fully compatible wth the AM2315.
invensense,icm42600
- Minor tweaks + addition of compatible for the ICM42630 IMU.
mediatek,mt2701-adc
- Compatible for the MT6572
rockchip,saradc
- Support the RV1106.

Features
--------

IIO Core
- Add a helper to discover if timestamps are enabled.  In a few cases
  (typically when there is batching involved) we may have to refuse
  to start the buffer if timestamps are enabled.  Provided a helper
  to allow that to be queried.
IIO backend
- CRC support.
infineon,dps310
- Add triggered buffer support.
linear,ltc2497
- Add 2x conversion speed mode.
- Add the internal temperature channel.
renesas,r9a09g077
- Add missing DMA properties to DT and enable use of DMA
- Expose the sampling frequency as per channel attributes.
ti,ad1015
- Add per channel labels from DT support.
ti,ads112c14
- Add dataready trigger using continuous mode if only one channel is
  enabled.
- Add burnout current control including new IIO ABI.
- Add filter control.
- Add new ABI for settling time.

Cleanup and minor or late breaking fixes
----------------------------------------

Only calling out the more significant changes or ones that were carried
on out on several drivers.

multiple drivers
- Add sanity check for spi_device_get_match_data() returning NULL due
  to use of driver_override.
- Add some useful __counted_by_ptr markings.
- Add some missing MODULE_DEVICE_TABLE() calls.
- Use dmaenginge_get_dma_device() instead of chan->device->dev
- A few precursor cleanups for planed devm_ object allocators.
- Disable autosuspend on exit.  Note there is work ongoing to make
  this unnecessary.
- Header reorders and IWYU being applied to what was included.
- Use devm_blocking_notifier_chain_register() to replace open coded
  equivalent.
- Ensure some clk related structures are always fully initialized.
- Use the size checked iio_push_to_buffers_with_ts() replacement for
  iio_push_to_buffers_with_timestamp().
- Avoid shadowing various error codes from store() callbacks.
adi,axi-adc
- Fix missing mutex_init()
adi,ad4080
- Ensure autoincrement is set for multi register reads.
adi,ad5758
- Fix wrong offset calculation
- Reject out of range values rather than truncating values.
- Make sure buffer used for bulk acceses is DMA safe.
adi,ad7816
- Local lock to protect state by serializing accesses. A few extra locations
  were added much later in the cycle.
- Stop using non DMA safe buffers by using spi_write_then_read()
  to ensure the data was bounce buffered.
adi,adxl367
- Ensure interrupt mapping is resolved before device setup reducing work
  done before potential deferral.
- Support INT2 pin.
asahi-kasei,ak8975
- Use BIT() and GENMASK() to improve readability of defines.
- Add an enum for scan mask elements.
- Switch to devm_ for all resources.
avago,apds9306
- Fix the default sampling frequency.
awinc,aw96103
- Fix an early return that stopped all channels being checked.
broadcom,iproc-adc
- General modernization and conversion to devm managed cleanup.
- Use dev_err_probe(), local dev pointer and drop some duplicate error
  messages.
capella,cm32181
- Add device specific dt-binding as trivial-devices doesn't provide
  vdd-supply or interrupt properties.
freescale,mma8452
- Modernize driver via guard(), IIO specific cleanup helpers and
  bulk regulator handling.
infineon,dps310
- Add context analysis lock markings.
- Single local acquire / release per raw read.
- Replace opencoded get_unaligned_be24().
- Fix incorrect CFG_REG bit definitions.
invensense,icm42600
- Ensure ODR is updated when switching power mode to paper over a hardware
  bug.
- Fix detecting ODR change in invalid data packets.
- Optimize high frequency data readback by not bothering to read the
  FIFO count when the watermark is known to have been passed.
- Various other minor fixes.
isil,isl29028
- Fix a runtime pm reference leak.
liteon,ltr501
- Make the dt-binding property proximit-near-level only available
  on parts that support it.
kionix,kx022a
- Use as structure to make the channel layout explicit and use that for
  all cases (previously there were two similar buffers).
pulsed-light,lidar-lite-v2
- Move binding from trivial-devices to it's own file as there are power
  enable and mode control pins that needs describing.
renesas,r9a09g077
- Drop some interrupt descriptions for interrupts that aren't connected to
  the interrupt controller.
- Avoid direct reads when buffer enabled.
- Store the device PA and IRQ in state ready for the DMA support.
st,hts221
- Fix a potential division by zero if calibration data corrupted.
- Allow an unknown Who Am I value to support fallback dt-compatibles.
- Replace opencoded oversampling_ration_available handling with read_avail
  callback.
st,stm32-adc
- Fix up some wrong minimum sample times.
ti,ads1100
- Fix readings after datarate change by ensuring a long enough wait for
  a new sample.
ti,tmp117
- Fix case where cached state was updated before we know if the write
  to the device succeeds.
vishay,veml3328
- Reshape the scale array to improve readability as it is made up
  of value pairs.

----------------------------------------------------------------
Abdelnasser Hussein (4):
      staging: iio: adc: ad7816: Sort headers alphabetically
      staging: iio: adc: ad7816: Serialize SPI operations
      staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers
      staging: iio: adc: ad7816: Protect sysfs attributes with mutex

Adi Nata (4):
      iio: humidity: hts221: report available values via read_avail()
      iio: humidity: hts221: Allow unknown whoami for DT fallback
      iio: humidity: hts221: use dev_err_probe() in probe paths
      iio: humidity: hts221: fix division by zero in calibration parsing

Amiitesh TSP (1):
      docs: fix typos in drivers/staging/iio

Andrei Stancovici (3):
      iio: adc: ltc2497: add LTC2499 internal temperature channel
      iio: adc: ltc2497: add 2x conversion speed mode
      dt-bindings: iio: adc: lltc,ltc2497: generalise the title

Andy Shevchenko (8):
      iio: light: Unshadow error codes in ->store()
      iio: imu: inv_mpu6050: Unshadow error codes in ->store()
      iio: chemical: sps30: Unshadow error codes in ->store()
      iio: adc: pac1934: Unshadow error codes in ->store()
      iio: magnetometer: ak8975: switch to using managed resources
      iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
      iio: magnetometer: ak8975: use temporary variable for struct device
      iio: magnetometer: ak8975: make use of the macros from bits.h

Antoniu Miclaus (13):
      iio: adc: ade9000: introduce chip_info structure
      dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
      iio: adc: ade9000: add support for ADE9078
      docs: iio: ade9000: document ADE9078 support
      iio: adc: ad4080: allow debugfs register access to both channels
      dt-bindings: iio: update unreachable maintainer entries
      dt-bindings: iio: accel: adi,adxl367: add interrupt-names
      iio: accel: adxl367: use regmap_assign_bits()
      iio: accel: adxl367: add support for INT2 interrupt pin
      iio: accel: adxl367: resolve interrupt mapping before device setup
      dt-bindings: iio: adc: ad4080: add AD4885 support
      iio: adc: ad4080: add support for AD4885
      iio: adc: ad4080: enable address ascension for chip identification

Ariana Lazar (12):
      iio: dac: mcp47feb02: initialize dac_data field in channel data struc=
t at probe
      iio: dac: mcp47feb02: Fix gain field initialization for active channe=
ls
      iio: dac: mcp47feb02: Return len when disabling EEPROM store
      iio: dac: mcp47feb02: Increase EEPROM Programming Write Cycle Time
      iio: dac: mcp47feb02: use field_get() instead of custom dynamic macros
      iio: dac: mcp47feb02: correct typo from a comment
      iio: dac: mcp47feb02: use field_prep() instead of custom dynamic macr=
os
      iio: dac: mcp47feb02: Avoid unjustified probe error on missing label
      iio: dac: mcp47feb02: protect EEPROM store sequence with mutex
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

Arka Mondal (3):
      iio: dac: ad5758: Fix alignment for DMA safety
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Biju Das (3):
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
      iio: adc: rzg2l_adc: Rename num_channels to max_channels
      iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU

Bill Wendling (3):
      iio: gts-helper: add __counted_by_ptr to struct iio_gts
      iio: adc: qcom-adc5-gen3: Annotate struct adc5_device_data with __cou=
nted_by_ptr
      iio: add __counted_by_ptr attribute to channels in struct iio_dev

Carlos Casadiego (1):
      iio: accel: kx022a: fix typo in comment

Chang Yu (1):
      iio: light: ltr390: Remove stale TODOs

Cheick Traore (1):
      iio: adc: stm32: fix minimum sampling time values

Cosmin Tanislav (7):
      iio: adc: rzt2h: remove unused struct rzt2h_adc::max_channels
      iio: adc: rzt2h: store IRQ in private state
      iio: adc: rzt2h: store the physical address in private state
      iio: adc: rzt2h: claim direct mode on single reads
      iio: adc: rzt2h: implement DMA buffer support
      iio: adc: rzt2h: expose sampling frequency
      dt-bindings: iio: adc: renesas,r9a09g077-adc: document DMA support

David Lechner (TI) (10):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: create data read helper functions
      iio: adc: ti-ads112c14: add continuous mode support
      iio: adc: ti-ads112c14: add burnout current support
      iio: ABI: add sysfs attribute for _burnoutraw
      iio: adc: ti-ads112c14: support external clock
      iio: adc: ti-ads112c14: add filter support
      iio: ABI: add sinc4+sinc1+pf1 filter_type
      iio: adc: ti-ads112c14: add settlingtime attribute
      iio: ABI: add settlingtime attributes

Donggeun Yoo (1):
      iio: light: vcnl4000: use sysfs_emit() for near_level

Eliav Farber (3):
      notifier: add device-managed registration APIs
      iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
      iio: position: iqs624: use devm_blocking_notifier_chain_register()

Esben Haabendal (7):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Power down chip if request irq fails
      iio: light: ltr501: Add ltr329 driver support
      iio: light: ltr501: Fix sorting order of device arrays
      dt-bindings: iio: light: ltr501: Make proximity-near-level conditional

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Flaviu Nistor (2):
      dt-bindings: iio: adc: ti,ads1015: Add label property
      iio: adc: ti-ads1015: Add support for label

Frank Li (1):
      iio: use dmaengine_get_dma_device() instead of chan->device->dev

Gabriel Rondon (5):
      iio: accel: kionix-kx022a: use scan struct for one-shot and trigger r=
eads
      iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
      iio: gyro: adxrs290: use iio_push_to_buffers_with_ts()
      iio: gyro: bmg160: use iio_push_to_buffers_with_ts()
      iio: gyro: itg3200: use iio_push_to_buffers_with_ts()

Geert Uytterhoeven (2):
      iio: adc: meson-saradc: Make sure clk_init_data is fully initialized
      iio: frequency: adf4350: Make sure clk_init_data is fully initialized

Giorgi Tchankvetadze (1):
      iio: light: veml3328: reshape scale array for readability

Guangshuo Li (4):
      iio: accel: kxcjk-1013: Disable autosuspend on remove
      iio: accel: mma9551: disable autosuspend on remove
      iio: accel: mma9553: disable autosuspend on remove
      iio: adc: at91-sama5d2: disable autosuspend on remove

Hemanth Selam (1):
      iio: fix typos in comments

Jakub Szczudlo (3):
      dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
      iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in =
single mode
      iio: adc: ti-ads1100: Add ti-ads1110 support to ti-ads1100 driver

Janani Sunil (20):
      spi: dt-bindings: Add spi-device-addr peripheral property
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support
      iio: adc: adi-axi-adc: Initialize state mutex
      dt-bindings: iio: adc: Add AD7768
      iio: backend: Add support for CRC
      iio: adc: adi-axi-adc: Add support for CRC
      iio: adc: Add AD7768 and AD7768-4 core support
      iio: adc: ad7768: Validate master clock rate
      iio: adc: ad7768: Add power mode helper
      iio: adc: ad7768: Derive output data rates
      iio: adc: ad7768: Configure channel sampling profiles
      iio: adc: ad7768: Add sampling frequency controls
      iio: adc: ad7768: Add per-channel filter controls
      iio: adc: ad7768: Wait for digital filters to settle
      iio: adc: ad7768: Add calibration controls
      iio: adc: ad7768: Add per-channel conversion delay
      iio: adc: ad7768: Add VCM regulator support
      iio: adc: ad7768: Register GPIO auxiliary device
      Documentation: iio: Add AD7768 Documentation

Javier Carrasco (7):
      iio: gts-helper: fix error headers
      iio: rename stale IIO_DEV_ACQUIRE_ERR reference to IIO_DEV_ACQUIRE_FA=
ILED
      dt-bindings: iio: light: veml6030: add veml6031x00 ALS series
      iio: light: add support for veml6031x00 ALS series
      iio: light: veml6031x00: add support for triggered buffers
      iio: light: veml6031x00: add support for events and trigger
      iio: light: veml6031x00: Enable internal calibration

Jean-Baptiste Maneyrol (6):
      iio: imu: inv_icm42600: sleep before enabling FIFO data
      iio: imu: inv_icm42600: use 2 sensors fixed packet size of 16 bytes
      iio: imu: inv_icm42600: simplify watermark computation by using GCD
      iio: imu: inv_icm42600: do not read FIFO count for watermark it
      iio: imu: inv_icm42600: fix odr change not caught in certain cases
      iio: imu: inv_icm42600: force accel odr change when switching power m=
ode

Jiale Yao (20):
      iio: amplifiers: ad8366: reject devices without match data
      iio: dac: ad5755: validate SPI match data
      iio: dac: mcp4821: reject devices without match data
      iio: frequency: adf4377: reject devices without match data
      iio: imu: adis16400: validate SPI match data
      iio: potentiometer: x9250: reject devices without match data
      iio: pressure: bmp280: validate SPI match data
      iio: adc: ad7192: reject devices without match data
      iio: adc: ad7606: reject devices without match data
      iio: adc: ad7768-1: reject devices without match data
      iio: adc: max11205: reject devices without match data
      iio: adc: mcp3911: reject devices without match data
      iio: adc: ti-adc128s052: validate SPI match data
      iio: adc: ti-ads1018: reject devices without match data
      iio: adc: ti-ads131m02: reject devices without match data
      iio: adc: ti-ads7950: validate SPI match data
      iio: accel: adxl313: reject devices without match data
      iio: accel: adxl372: reject devices without match data
      iio: accel: adxl380: reject devices without match data
      iio: accel: sca3000: reject devices without match data

Jonathan Cameron (2):
      Merge tag 'devm_notifier_chain_register-for-7.4' into togreg
      Merge tag 'v7.3-rc4' into togreg

Jorijn van der Graaf (8):
      iio: imu: inv_icm42600: sort device id tables numerically
      iio: imu: inv_icm42600: log whoami mismatch instead of failing probe
      dt-bindings: iio: imu: icm42600: add icm42630
      iio: light: stk3310: lower-case the i2c device ID names
      dt-bindings: iio: light: stk33xx: document the Sensortek STK36C61
      iio: light: stk3310: move the data registers into the channel address
      iio: light: stk3310: add per-chip match data
      iio: light: stk3310: support the Sensortek STK36C61

Joshua Crofts (14):
      MAINTAINERS: add patchwork link to iio entry
      iio: temperature: iqs620at-temp: make headers conform to IWYU
      iio: temperature: ltc2983: reorder headers
      iio: temperature: ltc2983: make headers conform to IWYU
      iio: temperature: mlx90632: make headers conform to IWYU
      iio: temperature: mlx90635: make headers conform to IWYU
      iio: temperature: tmp117: sort headers alphabetically
      iio: temperature: tmp117: make headers conform to IWYU
      iio: temperature: tsys01: reorder headers
      iio: temperature: tsys01: make headers conform to IWYU
      iio: temperature: tsys02d: reorder headers
      iio: temperature: tsys02d: make headers conform to IWYU
      iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
      iio: magnetometer: ak8975: add scan mask index enum

Karl Mehltretter (1):
      docs: iio: Correct ADXL380 filter descriptions

Kees Cook (2):
      iio: adc: ad7173: Remove const from chan_arr allocation type
      iio: imu: st_lsm6dsx: Allocate ext_channels with ARRAY_SIZE()

Kim Seer Paller (6):
      iio: ABI: Add DAC current powerdown attributes and 15kohm_to_gnd mode
      dt-bindings: iio: dac: add adi,ad5710r.yaml
      iio: dac: ad3530r: parameterize DAC resolution
      iio: dac: ad3530r: add support for AD5710R/AD5711R
      dt-bindings: iio: dac: ad3530r: add AD3536R
      iio: dac: ad3530r: add support for AD3536R

Krzysztof Kozlowski (1):
      dt-bindings: iio: Use consistent indentation in the example

Kyle Hsieh (2):
      dt-bindings: iio: adc: ti,ads112c04: Add binding for ADS112C04
      iio: adc: ti-ads112c04: Add support for TI ADS112C04

Lad Prabhakar (1):
      dt-bindings: iio: adc: renesas,r9a09g077-adc: Drop unwired interrupts

Liviu Stan (1):
      dt-bindings: iio: temperature: adi,ltc2983: Add ADT7604 datasheet link

Marcelo Schmitt (2):
      iio: Fix typo in vendor name
      iio: adc: ad4134: Drop import to empty name space

Marco Chen (1):
      iio: accel: bma400: remove completed tasks from TODO list

Matti Vaittinen (2):
      iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
      iio: accel: kionix-kx022a: Fix IPOL macro name

Mohamad Raizudeen (1):
      staging: iio: frequency: ad9832/ad9834: add comment explaining do_div=
 usage

Mohammad Shahid (9):
      iio: adc: bcm_iproc_adc: Remove redundant probe error messages
      iio: adc: bcm_iproc_adc: Introduce local device pointer
      iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_prob=
e()
      iio: adc: bcm_iproc_adc: sort headers alphabetically
      iio: adc: bcm_iproc_adc: fix include dependencies
      iio: adc: bcm_iproc_adc: use devm-managed clock
      iio: adc: bcm_iproc_adc: use devm-managed ADC cleanup
      iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
      iio: adc: bcm_iproc_adc: use devm-managed IIO device registration

Nicol=C3=A1s Antinori (2):
      dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
      iio: humidity: am2315: add support for am2320

Nuno S=C3=A1 (1):
      iio: buffer-dmaengine: drop dead max_size computation

Peng Fan (1):
      iio: chemical: ens160: use regmap_assign_bits() for conditional set/c=
lear

Pengpeng Hou (1):
      iio: accel: bma220: publish the SPI driver ACPI alias

Petar Stepanovic (2):
      dt-bindings: iio: adc: add Axiado AX3000/AX3005 SARADC
      iio: adc: add Axiado SARADC driver

Randy Dunlap (1):
      docs: iio: backend: use literal block for commands

Rishab Madhugiri (1):
      iio: core: Replace BUG() with WARN_ON_ONCE() and error return

Rob Herring (Arm) (1):
      dt-bindings: iio: Add dedicated CM32181 schema

Rodrigo Alencar (17):
      iio: ABI: add attributes for altcurrent channels
      iio: ABI: raw, scale and offset for frequency/phase channels
      iio: ABI: add parent entry for iio channels
      iio: add IIO_FREQUENCY channel type
      iio: core: support 64-bit register through debugfs
      iio: core: create local __iio_chan_prefix_emit() for reuse
      iio: test: add kunit tests for channel prefix naming generation
      iio: core: add hierarchical channel relationships
      dt-bindings: iio: frequency: add ad9910
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add basic parallel port support
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: show channel priority in debugfs
      iio: ABI: add docs for ad9910 sysfs and debugfs entries
      docs: iio: add documentation for ad9910 driver

Rodrigo Gobbi (2):
      dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
      dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback compatib=
le

Roman Vivchar (1):
      dt-bindings: iio: adc: mediatek,mt2701-auxadc: add mt6572

Rupesh Majhi (7):
      iio: pressure: dps310: fix CFG_REG bit definitions
      iio: pressure: dps310: use a local device pointer in probe
      iio: pressure: dps310: use get_unaligned_be24() for the 24-bit results
      iio: pressure: dps310: take the lock once per raw read
      iio: pressure: dps310: add triggered buffer support
      iio: core: add an accessor for scan_timestamp
      iio: pressure: dps310: check the lock markings with context analysis

Salah Triki (4):
      iio: humidity: ens210: Extend I2C functionality check
      iio: temperature: tmp117: fix calibbias cache update on I2C write fai=
lure
      iio: proximity: aw96103: Fix early return in IRQ handler loop
      iio: imu: adis16400: Check return value of spi_setup()

Sanjay Chitroda (4):
      iio: accel: mma8452: convert to bulk regulator usage
      iio: accel: mma8452: use local struct device
      iio: accel: mma8452: Use IIO cleanup helpers
      iio: accel: mma8452: use guard() to release mutexes

Shehryar Ahmad (7):
      iio: accel: adis16201: fix channel order for buffer mode
      iio: accel: adis16201: add SPI device ID table
      iio: accel: adis16201: add OF device ID table
      iio: accel: adis16201: prepare driver to support additional parts
      iio: accel: adis16201: add ADIS16203 support
      staging: iio: accel: remove adis16203, merged into mainline adis16201=
 driver
      dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible

Shengzhuo Wei (2):
      iio: accel: adxl380: reject out-of-range FIFO entry count
      iio: accel: adxl367: reject out-of-range FIFO entry count

Stefan Popa (2):
      dt-bindings: iio: adc: add adi,max40080
      iio: adc: add MAX40080 current-sense amplifier driver

Surendra Singh Chouhan (1):
      iio: light: apds9999: register standby action after enabling device

Triet Hoang (1):
      iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Tsz Shan Chan (1):
      iio: light: apds9306: fix default sampling frequency definition

Vladislav Leonov (1):
      iio: adc: rockchip_saradc: Add support for RV1106

bui duc phuc (1):
      iio: adc: sophgo-saradc: Handle errors from optional IRQ lookup

 Documentation/ABI/testing/debugfs-iio-ad9910       |   23 +
 Documentation/ABI/testing/debugfs-iio-backend      |   16 +-
 Documentation/ABI/testing/sysfs-bus-iio            |  115 +
 Documentation/ABI/testing/sysfs-bus-iio-adc        |    9 +
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     |   31 +
 .../bindings/iio/accel/adi,adis16201.yaml          |    6 +-
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml |   13 +-
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   38 +-
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |    3 +-
 .../devicetree/bindings/iio/adc/adi,ad4851.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |    2 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |    6 +-
 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    |  270 +++
 .../devicetree/bindings/iio/adc/adi,ad7779.yaml    |   30 +-
 .../devicetree/bindings/iio/adc/adi,ade9000.yaml   |   62 +-
 .../devicetree/bindings/iio/adc/adi,max40080.yaml  |   65 +
 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     |   63 +
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |    2 +-
 .../bindings/iio/adc/maxim,max34408.yaml           |   34 +-
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml          |    2 +-
 .../bindings/iio/adc/renesas,r9a09g077-adc.yaml    |   22 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |   17 +-
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    6 +
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml    |   10 +-
 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  |  149 ++
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |   18 +-
 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |    3 +-
 .../bindings/iio/addac/adi,ad74413r.yaml           |    3 +-
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |   15 +-
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   |  254 +++
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   |  145 ++
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     |  221 +-
 .../bindings/iio/frequency/adi,ad9910.yaml         |  209 ++
 .../bindings/iio/imu/invensense,icm42600.yaml      |   24 +-
 .../devicetree/bindings/iio/light/adux1020.yaml    |    8 +-
 .../bindings/iio/light/amstaos,tsl2591.yaml        |    2 +-
 .../bindings/iio/light/capella,cm32181.yaml        |   44 +
 .../devicetree/bindings/iio/light/isl29018.yaml    |    6 +-
 .../bindings/iio/light/liteon,ltr501.yaml          |   32 +-
 .../devicetree/bindings/iio/light/noa1305.yaml     |    4 +-
 .../devicetree/bindings/iio/light/stk33xx.yaml     |   19 +-
 .../devicetree/bindings/iio/light/tsl2583.yaml     |    4 +-
 .../devicetree/bindings/iio/light/tsl2772.yaml     |   14 +-
 .../bindings/iio/light/vishay,veml6030.yaml        |   21 +-
 .../bindings/iio/pressure/infineon,dps310.yaml     |   10 +-
 .../iio/proximity/pulsedlight,lidar-lite-v2.yaml   |   71 +
 .../bindings/iio/proximity/vishay,vcnl3020.yaml    |    6 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |    1 +
 .../bindings/spi/spi-peripheral-props.yaml         |    7 +
 .../devicetree/bindings/trivial-devices.yaml       |    6 +-
 Documentation/iio/ad7768.rst                       |  275 +++
 Documentation/iio/ad9910.rst                       |  792 +++++++
 Documentation/iio/ade9000.rst                      |   28 +-
 Documentation/iio/adis16475.rst                    |    2 +-
 Documentation/iio/adis16480.rst                    |    2 +-
 Documentation/iio/adis16550.rst                    |    2 +-
 Documentation/iio/adxl313.rst                      |    2 +-
 Documentation/iio/adxl345.rst                      |    2 +-
 Documentation/iio/adxl380.rst                      |   10 +-
 Documentation/iio/index.rst                        |    2 +
 MAINTAINERS                                        |   74 +-
 drivers/iio/accel/Kconfig                          |    7 +-
 drivers/iio/accel/adis16201.c                      |  133 +-
 drivers/iio/accel/adxl313_spi.c                    |    2 +
 drivers/iio/accel/adxl367.c                        |   59 +-
 drivers/iio/accel/adxl372_spi.c                    |    2 +
 drivers/iio/accel/adxl380.c                        |    7 +
 drivers/iio/accel/adxl380_spi.c                    |    2 +
 drivers/iio/accel/bma220_spi.c                     |    3 +-
 drivers/iio/accel/bma400_core.c                    |    2 -
 drivers/iio/accel/kionix-kx022a.c                  |   22 +-
 drivers/iio/accel/kionix-kx022a.h                  |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    1 +
 drivers/iio/accel/mma8452.c                        |  145 +-
 drivers/iio/accel/mma9551.c                        |    1 +
 drivers/iio/accel/mma9553.c                        |    1 +
 drivers/iio/accel/sca3000.c                        |    2 +
 drivers/iio/adc/Kconfig                            |   86 +-
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/ad4080.c                           |   34 +-
 drivers/iio/adc/ad4134.c                           |    1 -
 drivers/iio/adc/ad7173.c                           |    3 +-
 drivers/iio/adc/ad7192.c                           |    3 +
 drivers/iio/adc/ad7606_spi.c                       |    6 +-
 drivers/iio/adc/ad7768-1.c                         |    3 +
 drivers/iio/adc/ad7768.c                           | 1921 ++++++++++++++++
 drivers/iio/adc/ade9000.c                          |  180 +-
 drivers/iio/adc/adi-axi-adc.c                      |   25 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |   10 +-
 drivers/iio/adc/axiado_saradc.c                    |  277 +++
 drivers/iio/adc/bcm_iproc_adc.c                    |   99 +-
 drivers/iio/adc/ltc2497-core.c                     |  297 ++-
 drivers/iio/adc/ltc2497.c                          |   42 +
 drivers/iio/adc/ltc2497.h                          |   31 +-
 drivers/iio/adc/max11205.c                         |    2 +
 drivers/iio/adc/max14001.c                         |    1 +
 drivers/iio/adc/max40080.c                         |  574 +++++
 drivers/iio/adc/mcp3911.c                          |    2 +
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/iio/adc/nxp-sar-adc.c                      |    2 +-
 drivers/iio/adc/pac1934.c                          |    9 +-
 drivers/iio/adc/rockchip_saradc.c                  |   16 +
 drivers/iio/adc/rzg2l_adc.c                        |   29 +-
 drivers/iio/adc/rzt2h_adc.c                        |  499 ++++-
 drivers/iio/adc/sophgo-cv1800b-adc.c               |    2 +
 drivers/iio/adc/stm32-adc.c                        |   14 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    4 +-
 drivers/iio/adc/ti-adc128s052.c                    |    8 +-
 drivers/iio/adc/ti-ads1015.c                       |   30 +
 drivers/iio/adc/ti-ads1018.c                       |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |  188 +-
 drivers/iio/adc/ti-ads112c04.c                     |  524 +++++
 drivers/iio/adc/ti-ads112c14.c                     | 1298 ++++++++++-
 drivers/iio/adc/ti-ads131m02.c                     |    2 +
 drivers/iio/adc/ti-ads7950.c                       |    4 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    4 +-
 drivers/iio/amplifiers/ad8366.c                    |    2 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    8 +-
 drivers/iio/chemical/ens160_core.c                 |    7 +-
 drivers/iio/chemical/sps30.c                       |   11 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    5 +-
 drivers/iio/dac/Kconfig                            |   50 +-
 drivers/iio/dac/Makefile                           |    5 +-
 drivers/iio/dac/ad3530r.c                          |  321 ++-
 drivers/iio/dac/ad3552r.c                          |    2 +-
 drivers/iio/dac/ad5529r.c                          |  546 +++++
 drivers/iio/dac/ad5755.c                           |    3 +
 drivers/iio/dac/ad5758.c                           |    8 +-
 drivers/iio/dac/ad8460.c                           |    2 +-
 .../iio/dac/{mcp47feb02.c =3D> mcp47feb02-core.c}    |  393 +---
 drivers/iio/dac/mcp47feb02-i2c.c                   |  145 ++
 drivers/iio/dac/mcp47feb02-spi.c                   |  145 ++
 drivers/iio/dac/mcp47feb02.h                       |   41 +
 drivers/iio/dac/mcp4821.c                          |    7 +-
 drivers/iio/dummy/iio_simple_dummy.c               |    2 +-
 drivers/iio/frequency/Kconfig                      |   21 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2347 ++++++++++++++++=
++++
 drivers/iio/frequency/adf4350.c                    |    2 +-
 drivers/iio/frequency/adf4377.c                    |    3 +
 drivers/iio/gyro/adxrs290.c                        |    4 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    3 +-
 drivers/iio/humidity/Kconfig                       |    8 +-
 drivers/iio/humidity/am2315.c                      |   34 +-
 drivers/iio/humidity/ens210.c                      |    4 +-
 drivers/iio/humidity/hts221_core.c                 |  168 +-
 drivers/iio/humidity/hts221_i2c.c                  |   11 +-
 drivers/iio/humidity/hts221_spi.c                  |   11 +-
 drivers/iio/iio_core.h                             |    7 +
 drivers/iio/imu/adis16400.c                        |    8 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   33 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  114 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   26 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   24 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   16 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   16 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |    4 +-
 drivers/iio/industrialio-backend.c                 |   33 +
 drivers/iio/industrialio-core.c                    |  255 ++-
 drivers/iio/industrialio-gts-helper.c              |    2 +-
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9306.c                       |    2 +-
 drivers/iio/light/apds9999.c                       |   12 +-
 drivers/iio/light/cros_ec_light_prox.c             |    2 +-
 drivers/iio/light/iqs621-als.c                     |   24 +-
 drivers/iio/light/isl29018.c                       |    7 +-
 drivers/iio/light/isl29028.c                       |   33 +-
 drivers/iio/light/lm3533-als.c                     |   11 +-
 drivers/iio/light/ltr390.c                         |    6 -
 drivers/iio/light/ltr501.c                         |  113 +-
 drivers/iio/light/stk3310.c                        |  203 +-
 drivers/iio/light/tsl2583.c                        |   15 +-
 drivers/iio/light/tsl2772.c                        |   16 +-
 drivers/iio/light/vcnl4000.c                       |    3 +-
 drivers/iio/light/veml3328.c                       |   53 +-
 drivers/iio/light/veml6031x00.c                    | 1387 ++++++++++++
 drivers/iio/magnetometer/ak8975.c                  |  234 +-
 drivers/iio/position/iqs624-pos.c                  |   24 +-
 drivers/iio/potentiometer/x9250.c                  |    7 +-
 drivers/iio/pressure/Kconfig                       |    2 +
 drivers/iio/pressure/Makefile                      |    2 +
 drivers/iio/pressure/bmp280-spi.c                  |    2 +
 drivers/iio/pressure/cros_ec_baro.c                |    2 +-
 drivers/iio/pressure/dps310.c                      |  313 ++-
 drivers/iio/pressure/rohm-bm1390.c                 |    6 +-
 drivers/iio/proximity/aw96103.c                    |    2 +-
 drivers/iio/temperature/iqs620at-temp.c            |    9 +-
 drivers/iio/temperature/ltc2983.c                  |   19 +-
 drivers/iio/temperature/mlx90632.c                 |   10 +-
 drivers/iio/temperature/mlx90635.c                 |   11 +-
 drivers/iio/temperature/tmp117.c                   |   18 +-
 drivers/iio/temperature/tsys01.c                   |   17 +-
 drivers/iio/temperature/tsys02d.c                  |   12 +-
 drivers/iio/test/Kconfig                           |   13 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-channel-prefix.c         |  307 +++
 drivers/iio/test/iio-test-rescale.c                |    4 +-
 .../iio/Documentation/sysfs-bus-iio-adc-ad7280a    |    2 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/accel/Kconfig                  |   19 -
 drivers/staging/iio/accel/Makefile                 |    6 -
 drivers/staging/iio/accel/adis16203.c              |  315 ---
 drivers/staging/iio/adc/ad7816.c                   |   33 +-
 drivers/staging/iio/frequency/ad9832.c             |    6 +
 drivers/staging/iio/frequency/ad9834.c             |    6 +
 include/linux/iio/adc/qcom-adc5-gen3-common.h      |    2 +-
 include/linux/iio/backend.h                        |    6 +
 include/linux/iio/iio-gts-helper.h                 |   11 +-
 include/linux/iio/iio-opaque.h                     |    2 +-
 include/linux/iio/iio.h                            |   25 +-
 include/linux/notifier.h                           |    7 +
 include/uapi/linux/iio/types.h                     |    1 +
 kernel/notifier.c                                  |  105 +
 tools/iio/iio_event_monitor.c                      |    2 +
 221 files changed, 16070 insertions(+), 2246 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-iio-ad9910
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axiado,ax3000=
-saradc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads112c04.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5529r.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5710r.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9=
910.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm3=
2181.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedl=
ight,lidar-lite-v2.yaml
 create mode 100644 Documentation/iio/ad7768.rst
 create mode 100644 Documentation/iio/ad9910.rst
 create mode 100644 drivers/iio/adc/ad7768.c
 create mode 100644 drivers/iio/adc/axiado_saradc.c
 create mode 100644 drivers/iio/adc/max40080.c
 create mode 100644 drivers/iio/adc/ti-ads112c04.c
 create mode 100644 drivers/iio/dac/ad5529r.c
 rename drivers/iio/dac/{mcp47feb02.c =3D> mcp47feb02-core.c} (69%)
 create mode 100644 drivers/iio/dac/mcp47feb02-i2c.c
 create mode 100644 drivers/iio/dac/mcp47feb02-spi.c
 create mode 100644 drivers/iio/dac/mcp47feb02.h
 create mode 100644 drivers/iio/frequency/ad9910.c
 create mode 100644 drivers/iio/light/veml6031x00.c
 create mode 100644 drivers/iio/test/iio-test-channel-prefix.c
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile
 delete mode 100644 drivers/staging/iio/accel/adis16203.c
