Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA92F39CE
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774785869; cv=none; b=YyOm424R4U5CPA1Nfi1TEW9hLrNlwXQpo58fTY0vexkS69sji9bnRJLFddfIhbw8ZYgnsrCGtLAPl0CW5gOlBR1qvdMrvppHOyH00h02iWzhNzRgYUfBM5WKJk++AFJs4LS1zdszse6anVJsKNWUO66ap3qHE8qg30/q+Od9kNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774785869; c=relaxed/simple;
	bh=E1/62LPmlxC2qAn9NhZpo7ZyIpL0+BzNc6PV/IlhL2w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=o3SlDeZT6OM3jUTshu5Q4NLn7FArcl18wvCsYobT/BkRcR6/rjHOxTMrmExV1vxh0kwpKfylWujADH+Awovtt5+eKWxs3CihhQdLjcVwP5HYDN8mDo1lt+ECkO5CnX6v59L6JwwHX0RS9awKCA+3YTEhwIUI2BJ/6EN3lbxPaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAV5lWET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAV5lWET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEE2C116C6;
	Sun, 29 Mar 2026 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774785868;
	bh=E1/62LPmlxC2qAn9NhZpo7ZyIpL0+BzNc6PV/IlhL2w=;
	h=Date:From:To:Subject:From;
	b=RAV5lWET4+9NMohwuhZBzcM9Xw0tU/6GrRDKfUVCloy8TflfnTBKBNK7dhqIcx9ci
	 h3O9pLtNgdYjG18BB3uVyVA9fg1vqPSOaNblj+zjA45W3fisDJCmQlfmpyRfLQmyxR
	 IYDZ/cIUCjLlC3FerOeDLv0/2GzKRb5VJBBO61gwy6DgU8/k7RV6MYh+iMb7eIMbPA
	 5V1YswPTuT9pkVsxjy6VDN2msfpxg7a81ACSCp/l3rld79ea7YeH6vilWMQgKsJ/n6
	 oI/DnpjGghTipTGvDw0wjbAFBYhPDqbBy4trD+CcTb/dGaQvve0HpB7fyWe3ETdmR/
	 uMWZUDDWOdtMA==
Date: Sun, 29 Mar 2026 13:04:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: new device support, features and cleanup for the 7.1
 cycle.
Message-ID: <20260329130422.7f8481ee@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-7.1a

for you to fetch changes up to d2a4ec19d2a2e54c23b5180e939994d3da4a6b91:

  Docs: iio: ad7191 Correct clock configuration (2026-03-27 07:31:19 +0000)

----------------------------------------------------------------
IIO: New devices support, features and cleanup for 7.1

Includes merge of v7.0-rc4 to pull in a fix and a merge of
ib-iio-thermal-qcom-pmic5 immutable branch (provided from the IIO tree so
thermal could also pick this up and add thermal specific remainder
of the series on top.

New device support
------------------

adi,ad4030
- Add support for ADA4316 and ADAQ4224 ADCs with PGAs.
adi,ad4080
- Add support for AD4082, AD4085 and AD4088 ADCs.
adi,ad8366
- Add ADRF5702 and ADRF5703 digital step attenuators.
adi,adxl372
- Add support for the ADXL371 accelerometer after refactors to allow multip=
le
  device variants to be supported by the driver. In particular a silicon
  issue means the hardware FIFO doesn't work on the ADXL371
bosch,bma255/bmg160
- Add support for BMX055 gyroscope and magnetometer (effectively separate
  devices from point of view of interface).
lltc,ltc2309
- Add support for LTC2305 2 channel 12-bit ADC.
lltc,ltc2532
- Add support for 4 variants of the LTC2654 quad DAC.
maxim,ds4424
- Add IDs for DS4402 and DS4404 parts. Initially patch is ID only but addit=
ional
  features also added that are device dependent.
qcom,spmi-adc-gen3
- New driver supporting this generation of Qualcomm's SoC ADC.
st,vl53l1
- New driver for this Time Of Flight (TOF) sensor.
ti,ina2xx
- Support the INA236 digital power monitor.
vishay,vcnl4000
- Add support for CM36686 ambient light and proximity sensor.
- Add support for CM36672P proximity sensors.

ID only additions.
amlogic,meson-adc
- Support the Meson S4.

Features
--------

iio-backend framework
- Add capability discovery so front end drivers can know what features are
  available from the backend and adjust how they operate.
adi,ad4030
- Add SPI offload support requiring a non trivial PWM setup.
adi,ad7380
- Add support for multiple SPI lanes to improve throughput.
adi,ad7768-1
- Support SPI offload and always use continuous mode, enabling more
  filter options.
adi,ad8366
- Device tree bindings and support.
aspeed,adc
- Handle battery channel.
maxim,ds4424
- Add external resistor controlled scale and per-variant limits.
- Handle per variant range limits.
- Move it to regmap.
motorola,cpcap-adc
- Support for the ADC found on the Motorola Mot board. Effectively some boa=
rd
  specific configuration handled in the driver.
vishay,vcnl4000
- Support explicit power supply regulators.
tyhx,hx9023s
- Allow device tree specification of firmware file name.

Cleanup and minor fixes
-----------------------

treewide
- Remove a bunch of unused structure elements.
- Replaces standard fixed width integers with kernel types.
- Replace some other error values that were returned on allocation failure
  with -ENOMEM
iio-core
- Replace a few custom devm implementations for devm_add_action_or_reset()
iio-trigger
- Use put_device() to cleanup on error.
iio-backend
- Use __free(fwmode_handle) to simplify some code.
hw-consumer
- Use separate allocation for scan mask bitmap to simplify code.
acpi-als
- Switch from ACPI driver to platform driver.
adi,ad4030
- Use BIT() to replace values that are always a power of 2 to slightly
  improve readability.
adi,ad4062
- Add a missing check for error form iio_get_current_scan_type()
adi,ad5933
- Use div64_ul() rather than do_div() as remainder was not used.
adi,ad7191
- Documentation fixes related to clocks
adi,ad7816
- Use sysfs_emit()
adi,ad8366
- General driver modernization
adi,adf4350
- Change a TOOD to NOTE in a comment to avoid anyone from walking into
  a tricky to improve corner case.
adi,admv1013
- Avoid a null pointer dereference if device_property_read_string() fails.
adi,admv4420
- Return error code rather than -1..
adi,adxl345
- Add separate scaling for events from that of raw channels.
amlogic,meson-adc
- Don't bother keeping nvmem cell access around when only used in probe.
atmel,at91-sama5d
- Don't bother keeping nvmem cell access around when only used in probe.
bosch,bmc150
- Use sysfs_emit() in a few places.
honeywell,hsc030pa
- Improve handling of return values from i2c_transfer.
liteon,ltr501
- Return error values rather than -1 replaced by -EINVAL at higher
  levels of the callstack.
maxim,ds4424
- A bunch of general minor improvements prior to adding new features.
maxim,max11410
- Make some const string arrays static.
maxim,max5522
- Use devm_regulator_get_enable_read_voltage() at probe to cache the
  voltage rather than keeping the regulator around to access and query
  later.
vishay,vcnl4000
- Various code improvements.
sharp,gp2ap020a00f
- General driver modernization.
silabs,si7210
- Use devm_regulator_get_enable_read_voltage() at probe to cache the
  voltage rather than keeping the regulator around to access and query
  later.
st,lsm6dsx
- Add SMOCF00 ACPI ID seen on products by SHIFT.
st,st_sensors
- Fix up various kernel-doc issues.
- Avoid kmalloc of a single use buffer and instead reused existing
  buffer_data.
taos,tsl2772
- Fix some kernel-doc warnings due to missing :
ti,ads7950
- Use iio_push_to_buffers_with_ts_unaligned() as first few elements of
  array are not the data that is pushed.
- Move from array of chip_info structures to individual named ones. This
  is part of slowly replacing use of a code pattern that we don't want
  replicated in new drivers.
vti,sca3000
- General driver modernization included use of devm and guard().

Various other more minor stuff not called out explicitly.
Includes things like typo fixes, use of dev_err_probe() and local
variables to avoid repeated dereferencing of the same member as well as
increasing use of guard() to simplify release of locks.

Another slow improvement to code quality is both standardizing on
header order and ensure all appropriate headers are included.

----------------------------------------------------------------
Ammar Mustafa (1):
      Docs: iio: ad7191 Correct clock configuration

Andy Shevchenko (10):
      iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
      iio: core: Simplify IIO core managed APIs
      iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
      iio: light: gp2ap020a00f: Return directly from the switch cases
      iio: light: gp2ap020a00f: Replace custom implementation of min()
      iio: light: gp2ap020a00f: Use temporary variable for struct device
      iio: light: gp2ap020a00f: Explicitly use string literal for driver na=
me
      iio: light: gp2ap020a00f: Remove trailing comma in termination entry
      iio: light: gp2ap020a00f: Join some lines of code to be a single line
      iio: imu: inv_icm42600: Convert to uXX and sXX integer types

Antoniu Miclaus (50):
      iio: adc: pac1934: Return -ENOMEM on memory allocation failure
      iio: frequency: adf4350: Return -ENOMEM on memory allocation failure
      iio: magnetometer: si7210: simplify probe with devm_regulator_get_ena=
ble_read_voltage()
      iio: dac: max5522: simplify probe with devm_regulator_get_enable_read=
_voltage()
      dt-bindings: iio: adc: adi,ad4080: add support for AD4082, AD4085 and=
 AD4088
      iio: adc: ad4080: add support for AD4082, AD4085 and AD4088
      iio: filter: admv8818: remove redundant else after return
      iio: adc: ad7266: simplify error return
      iio: adc: ade9000: use dev_err_probe() in probe path
      iio: adc: at91_adc: change at91_ts_sample to return void
      iio: addac: ad74413r: simplify timeout return
      iio: frequency: adrf6780: add dev variable
      iio: frequency: adrf6780: use dev_err_probe()
      iio: frequency: admv1014: add dev variable
      iio: frequency: admv1014: use dev_err_probe()
      iio: frequency: admv1013: add dev variable
      iio: frequency: admv1013: use dev_err_probe()
      iio: frequency: adf4377: add dev variable
      iio: frequency: adf4377: use dev_err_probe()
      iio: dac: ad7293: add dev variable
      iio: dac: ad7293: use dev_err_probe()
      iio: filter: admv8818: add dev variable
      iio: filter: admv8818: use dev_err_probe()
      iio: frequency: admv4420: return proper error code from admv4420_calc=
_parameters()
      MAINTAINERS: add entry for ADL8113 driver
      iio: pressure: hsc030pa: Improve i2c_transfer return value handling
      iio: adc: ad4080: remove unused dec_rate field
      iio: adc: ad7768-1: remove unused mclk_div field
      iio: adc: ad7793: remove unused int_vref_mv field
      iio: adc: ad9467: remove unused output_mode field
      iio: adc: max1363: remove unused requestedmask field
      iio: adc: nau7802: remove unused min_conversions field
      iio: adc: ti-ads1015: remove unused enabled field
      iio: dac: adi-axi-dac: remove unused int_tone field
      iio: dac: ti-dac5571: remove unused id field
      iio: humidity: hdc2010: remove unused interrupt_config
      iio: imu: bmi323: remove unused drdy_trigger_enabled
      iio: light: apds9306: remove unused nlux_per_count
      iio: light: gp2ap020a00f: remove unused debug_reg_addr
      iio: light: ltr501: return proper error code from ltr501_get_gain_ind=
ex()
      iio: frequency: admv1013: fix NULL pointer dereference on str
      iio: accel: adxl372: introduce chip_info structure
      dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
      iio: accel: adxl372: factor out buffer and trigger setup
      iio: accel: adxl372: add support for ADXL371
      iio: backend: use __free(fwnode_handle) for automatic cleanup
      iio: frequency: admv4420: add dev variable
      iio: frequency: admv4420: use dev_err_probe
      iio: frequency: ad9523: add dev variable
      iio: frequency: ad9523: use dev_err_probe

Archit Anant (1):
      staging: iio: impedance-analyzer: ad5933: use div64_ul() instead of d=
o_div()

Bhargav Joshi (4):
      iio: frequency: ad9523: fix implicit variable macros
      iio: frequency: ad9523: fix multi-line dereferences
      iio: frequency: ad9523: use octal permissions
      iio: hid-sensor-gyro-3d: fix typo in array name

Billy Tsai (4):
      iio: adc: Add battery channel definition for ADC
      iio: adc: Enable multiple consecutive channels based on model data
      iio: adc: aspeed: Replace mdelay() with fsleep() for ADC stabilizatio=
n delay
      iio: adc: aspeed: Reserve battery sensing channel for on-demand use

Bruno Martins (1):
      staging: iio: ad7816: Replace sprintf() with sysfs_emit()

Chuang Zhu (1):
      iio: adc: ina2xx: add INA236 support

Cosmin Tanislav (1):
      iio: ABI: fix current_trigger description

David Jander (1):
      iio: dac: ds4424: add DS4402/DS4404 device IDs

David Lechner (5):
      dt-bindings: iio: adc: adi,ad7380: add spi-rx-bus-width property
      iio: adc: ad7380: add support for multiple SPI lanes
      iio: adc: ti-ads7950: remove chip_info[]
      iio: light: as73211: remove duplicate zero init of scan.chan[3]
      iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

David Marinovic (3):
      iio: dac: ltc2632: drop enum and use individual chip_info objects
      dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings
      iio: dac: ltc2632: add support for LTC2654 DAC family

Erikas Bitovtas (10):
      dt-bindings: iio: light: vcnl4000: add Capella CM36686 and CM36672P
      iio: light: vcnl4000: add support for Capella CM36686 and CM36672P
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: sort includes by their name
      iio: light: vcnl4000: move power enablement from init to probe
      iio: light: vcnl4000: replace mutex_init() with devm_mutex_init()
      iio: light: vcnl4000: remove error messages for trigger and irq
      iio: light: vcnl4000: use variables for I2C client and device instanc=
es
      iio: light: vcnl4000: remove redundant check for proximity-near-level
      iio: light: vcnl4000: add support for regulators

Ethan Tidmore (4):
      iio: adc: ad4062: Add missing IS_ERR() check
      iio: light: gp2ap020a00f: simplify locking with guard()
      iio: light: gp2ap020a00f: correct return type to int
      iio: light: gp2ap020a00f: Fix possible error swallow

Felix Gu (2):
      iio: adc: nxp-sar-adc: Remove unnecessary type casting
      iio: adc: ti-ads1119: Drop redundant error message

Gabriel Almeida (2):
      iio: light: zopt2201: Reorder header includes
      iio: light: zopt2201: use lock guards

Gabriel Rondon (3):
      staging: iio: ad5933: use sysfs_emit() in show functions
      staging: iio: ad9834: use sysfs_emit() and simplify show functions
      iio: accel: bmc150-accel-core: use sysfs_emit() in show functions

Giorgi Tchankvetadze (9):
      iio: adc: ad7173: move opening brace to a separate line
      iio: adc: ade9000: remove unused AD9000_CHANNELS_PER_PHASE macro
      iio: adc: fix typos found by codespell
      iio: adc: ade9000: remove unused ADE9000_ST_ERROR macro
      iio: adc: max1363: Reformat enum and array initializers
      iio: adc: palmas_gpadc: Replace leading space indentation with tabs
      iio: adc: mt6359-auxadc: Fix comma spacing
      iio: adc: ad_sigma_delta: Format block comments
      iio: adc: max11410: make vref register name arrays static const

Harshit Mogalapalli (8):
      iio: sca3000: simplify with spi_get_device_match_data()
      iio: sca3000: reuse device pointer for devm helpers
      iio: sca3000: switch IRQ handling to devm helpers
      iio: sca3000: Move sca3000_stop_all_interrupts() above sca3000_probe()
      iio: sca3000: make stop_all_interrupts() return void
      iio: sca3000: use guard(mutex) to simplify return paths
      iio: sca3000: stop interrupts via devm_add_action_or_reset()
      iio: sca3000: manage device registration with devm helper

Jishnu Prakash (3):
      dt-bindings: iio: adc: Split out QCOM VADC channel properties
      dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
      iio: adc: Add support for QCOM PMIC5 Gen3 ADC

Jonathan Cameron (2):
      Merge branch 'ib-iio-thermal-qcom-pmic5' into togreg Immutable branch=
 to allow this base work to be merged into thermal.
      Merge tag 'v7.0-rc4' into togreg

Jonathan Santos (4):
      iio: adc: ad7768-1: fix one-shot mode data acquisition
      iio: adc: ad7768-1: remove switch to one-shot mode
      iio: adc: ad7768-1: disable IRQ autoenable
      iio: adc: ad7768-1: add support for SPI offload

Jun Yan (3):
      dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
      dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magneto=
meter binding
      dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope bindi=
ng

Kyle Hsieh (3):
      dt-bindings: adc: ltc2497: add support for ltc2305
      iio: adc: ltc2309: explicitly assign hex values to channel enums
      iio: adc: ltc2309: add support for ltc2305

Marcelo Schmitt (7):
      dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
      iio: adc: ad4030: Use BIT macro to improve code readability
      Docs: iio: ad4030: Add double PWM SPI offload doc
      dt-bindings: iio: adc: adi,ad4030: Add PWM
      iio: adc: ad4030: Add SPI offload support
      dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
      iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

Menderes Sabaz (1):
      iio: dac: ad5360: converting to guard(mutex)

Milan Misic (1):
      iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope

Neel Bullywon (4):
      iio: magnetometer: bmc150_magn: replace msleep with fsleep
      iio: magnetometer: bmc150_magn: minor formatting cleanup
      iio: magnetometer: bmc150_magn: use automated cleanup for mutex
      iio: frequency: adf4350: replace TODO with NOTE in adf4350_set_freq()

Nick Xie (2):
      dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
      iio: adc: meson-saradc: add support for Meson S4

Nikhil Gautam (1):
      iio: accel: adxl380: fix typo in PART_ID register macro

Nuno S=C3=A1 (1):
      iio: buffer: hw-consumer: remove redundant scan_mask flexible array

Oleksij Rempel (11):
      iio: dac: ds4424: refactor raw access to use bitwise operations
      iio: dac: ds4424: ratelimit read errors and use device context
      iio: dac: ds4424: sort headers alphabetically
      iio: dac: ds4424: rename iio_info struct to avoid ambiguity
      iio: dac: ds4424: use device match data for chip info
      iio: dac: ds4424: use fsleep() instead of usleep_range()
      dt-bindings: iio: dac: maxim,ds4424: add ds4402/ds4404
      iio: dac: ds4424: support per-variant output range limits
      iio: dac: ds4424: convert to regmap
      dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
      iio: dac: ds4424: add Rfs-based scale and per-variant limits

Pranav Kharche (1):
      dt-bindings: iio: dac: Fix typo in ti,dac7612.yaml

Rafael J. Wysocki (2):
      iio: light: acpi-als: Register ACPI notify handler directly
      iio: light: acpi-als: Convert ACPI driver to a platform one

Rajveer Chaudhari (2):
      iio: accel: adxl313: convert to guard(mutex)
      iio: accel: adxl372: convert to guard(mutex)

Randy Dunlap (2):
      iio: tsl2772: fix all kernel-doc warnings
      iio: st_sensors: correct kernel-doc issues

Rodrigo Alencar (13):
      MAINTAINERS: Add missing maintainer entry for AD8366 driver
      dt-bindings: iio: amplifiers: Add AD8366 support
      iio: amplifiers: ad8366: refactor include headers
      iio: amplifiers: ad8366: add local dev pointer to the probe function
      iio: amplifiers: ad8366: use devm_mutex_init() and drop mutex_init()
      iio: amplifiers: ad8366: refactor device resource management
      iio: amplifiers: ad8366: replace reset-gpio with reset controller
      iio: amplifiers: ad8366: prepare for device-tree support
      iio: amplifiers: ad8366: add device tree support
      iio: amplifiers: ad8366: consume enable gpio
      iio: amplifiers: ad8366: update device support
      dt-bindings: iio: amplifiers: ad8366: add adrf5702/3 support
      iio: amplifiers: ad8366: add support for adrf5702/3

Rosen Penev (2):
      iio: adc: at91-sama5d2_adc: no devm for nvmem_cell_get
      iio: adc: meson: no devm for nvmem_cell_get

SAJJA EASWAR SAI (1):
      iio: light: apds9306: remove redundant explicit pointer cast

Salah Triki (1):
      iio: core: Clean up device correctly on viio_trigger_alloc() failure

Sanjay Chitroda (1):
      iio: st_sensors: drop temporary kmalloc buffer and reuse buffer_data

Shi Hao (14):
      iio: accel: fix typo celcius to Celsius
      iio: light: fix several incorrect spellings
      iio: adc: add an article and use digitize instead of digitalize
      iio: imu: fix typo from adjustement to adjustment
      iio: magnetometer: fix various spelling mistakes
      iio: pressure: fix spelling mistakes in comments
      iio: proximity: fix typo from currenly to currently
      iio: resolver: fix typo from degredation to degradation
      iio: temp: fix spelling mistakes in comments
      iio: test: fix typo from neeeds to needs in comment
      iio: common: fix spelling mistakes in comments
      iio: chemical: rephrase comment and fix a typo
      iio: cdc: fix spelling mistakes in comments
      iio: amplifiers: fix typo from Curren to Current

Siratul Islam (2):
      dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
      iio: proximity: add driver for ST VL53L1X ToF sensor

Svyatoslav Ryhel (2):
      dt-bindings: iio: adc: cpcap-adc: document Mot ADC
      iio: adc: cpcap-adc: add support for Mot ADC

Taha Ed-Dafili (5):
      docs: iio: adxl345: grammar and formatting cleanups
      iio: core: Add IIO_EV_INFO_SCALE to event info
      iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
      iio: accel: adxl345: Implement event scaling for ABI compliance
      docs: iio: adxl345: update event attributes and scaling math

Tomas Melin (6):
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: dac: adi-axi-dac: define supported iio-backend capabilities
      iio: adc: sd_adc_modulator: define supported iio-backend capabilities
      iio: adc: ad9467: simplify device pointer in probe
      iio: adc: ad9467: check for backend capabilities

Yasin Lee (2):
      dt-bindings: iio: proximity: hx9023s: support firmware-name property
      iio: proximity: hx9023s: support firmware-name property

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |   9 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |  40 +-
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  64 ++
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   3 +
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  23 +
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     |   4 +
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   7 +
 .../bindings/iio/adc/motorola,cpcap-adc.yaml       |   1 +
 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 151 ++++
 .../bindings/iio/adc/qcom,spmi-vadc-common.yaml    |  84 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |  78 +-
 .../bindings/iio/amplifiers/adi,ad8366.yaml        | 101 +++
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |  57 +-
 .../devicetree/bindings/iio/dac/maxim,ds4424.yaml  |  42 +-
 .../devicetree/bindings/iio/dac/ti,dac7612.yaml    |   2 +-
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |  12 +-
 .../bindings/iio/light/vishay,vcnl4000.yaml        |  31 +-
 .../iio/magnetometer/bosch,bmc150_magn.yaml        |  14 +-
 .../bindings/iio/proximity/st,vl53l0x.yaml         |  22 +-
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |   4 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 Documentation/iio/ad4030.rst                       |  39 +
 Documentation/iio/ad7191.rst                       |   6 +-
 Documentation/iio/adxl345.rst                      |  81 +-
 MAINTAINERS                                        |  29 +-
 drivers/iio/accel/Kconfig                          |  12 +-
 drivers/iio/accel/adis16201.c                      |   2 +-
 drivers/iio/accel/adis16209.c                      |   2 +-
 drivers/iio/accel/adxl313_core.c                   |  11 +-
 drivers/iio/accel/adxl345_core.c                   |  32 +-
 drivers/iio/accel/adxl372.c                        | 314 +++++---
 drivers/iio/accel/adxl372.h                        |  20 +-
 drivers/iio/accel/adxl372_i2c.c                    |  17 +-
 drivers/iio/accel/adxl372_spi.c                    |  17 +-
 drivers/iio/accel/adxl380.c                        |   4 +-
 drivers/iio/accel/bmc150-accel-core.c              |   4 +-
 drivers/iio/accel/sca3000.c                        | 215 +++---
 drivers/iio/adc/Kconfig                            |  33 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad4030.c                           | 618 ++++++++++++++-
 drivers/iio/adc/ad4062.c                           |  12 +-
 drivers/iio/adc/ad4080.c                           |  46 +-
 drivers/iio/adc/ad4170-4.c                         |   6 +-
 drivers/iio/adc/ad7173.c                           |   3 +-
 drivers/iio/adc/ad7192.c                           |   3 -
 drivers/iio/adc/ad7266.c                           |   6 +-
 drivers/iio/adc/ad7380.c                           |  53 +-
 drivers/iio/adc/ad7768-1.c                         | 221 +++++-
 drivers/iio/adc/ad7793.c                           |   3 +-
 drivers/iio/adc/ad7887.c                           |   2 +-
 drivers/iio/adc/ad7923.c                           |   4 +-
 drivers/iio/adc/ad9467.c                           |  95 ++-
 drivers/iio/adc/ad_sigma_delta.c                   |   6 +-
 drivers/iio/adc/ade9000.c                          |  13 +-
 drivers/iio/adc/adi-axi-adc.c                      |   5 +
 drivers/iio/adc/aspeed_adc.c                       |  72 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   5 +-
 drivers/iio/adc/at91_adc.c                         |  12 +-
 drivers/iio/adc/cpcap-adc.c                        |  15 +
 drivers/iio/adc/fsl-imx25-gcq.c                    |   2 +-
 drivers/iio/adc/ina2xx-adc.c                       |  65 +-
 drivers/iio/adc/ltc2309.c                          |  81 +-
 drivers/iio/adc/max11410.c                         |   4 +-
 drivers/iio/adc/max1363.c                          |  87 +--
 drivers/iio/adc/mcp3564.c                          |   2 +-
 drivers/iio/adc/men_z188_adc.c                     |   2 +-
 drivers/iio/adc/meson_saradc.c                     |  21 +-
 drivers/iio/adc/mt6359-auxadc.c                    |   2 +-
 drivers/iio/adc/nau7802.c                          |   3 +-
 drivers/iio/adc/npcm_adc.c                         |   2 +-
 drivers/iio/adc/nxp-sar-adc.c                      |   3 +-
 drivers/iio/adc/pac1921.c                          |   2 +-
 drivers/iio/adc/pac1934.c                          |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   8 +-
 drivers/iio/adc/qcom-spmi-adc5-gen3.c              | 860 +++++++++++++++++=
++++
 drivers/iio/adc/rohm-bd79124.c                     |   4 +-
 drivers/iio/adc/sd_adc_modulator.c                 |   1 +
 drivers/iio/adc/spear_adc.c                        |   2 +-
 drivers/iio/adc/stm32-adc-core.c                   |   2 +-
 drivers/iio/adc/stm32-adc.c                        |   2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                 |   2 +-
 drivers/iio/adc/ti-ads1015.c                       |   1 -
 drivers/iio/adc/ti-ads1119.c                       |   3 +-
 drivers/iio/adc/ti-ads7950.c                       | 183 +++--
 drivers/iio/adc/ti_am335x_adc.c                    |   6 +-
 drivers/iio/adc/twl4030-madc.c                     |   2 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   2 +-
 drivers/iio/addac/ad74413r.c                       |   9 +-
 drivers/iio/amplifiers/Kconfig                     |   8 +
 drivers/iio/amplifiers/ad8366.c                    | 405 +++++-----
 drivers/iio/amplifiers/ada4250.c                   |   2 +-
 drivers/iio/buffer/industrialio-hw-consumer.c      |  11 +-
 drivers/iio/buffer/kfifo_buf.c                     |  41 +-
 drivers/iio/cdc/ad7150.c                           |   2 +-
 drivers/iio/cdc/ad7746.c                           |   2 +-
 drivers/iio/chemical/bme680_core.c                 |   2 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   2 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   2 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |   4 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  11 +-
 drivers/iio/dac/Kconfig                            |   1 +
 drivers/iio/dac/ad5360.c                           |  29 +-
 drivers/iio/dac/ad7293.c                           |  31 +-
 drivers/iio/dac/adi-axi-dac.c                      |   3 +-
 drivers/iio/dac/ds4424.c                           | 373 ++++++---
 drivers/iio/dac/ltc2632.c                          | 353 ++++-----
 drivers/iio/dac/max5522.c                          |  22 +-
 drivers/iio/dac/ti-dac5571.c                       |   1 -
 drivers/iio/filter/admv8818.c                      |  60 +-
 drivers/iio/frequency/ad9523.c                     | 110 ++-
 drivers/iio/frequency/adf4350.c                    |  10 +-
 drivers/iio/frequency/adf4377.c                    |  56 +-
 drivers/iio/frequency/admv1013.c                   | 104 +--
 drivers/iio/frequency/admv1014.c                   |  89 +--
 drivers/iio/frequency/admv4420.c                   |  37 +-
 drivers/iio/frequency/adrf6780.c                   |  60 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   6 +-
 drivers/iio/humidity/hdc2010.c                     |   1 -
 drivers/iio/imu/bmi323/bmi323_core.c               |   1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   1 +
 drivers/iio/industrialio-backend.c                 |  22 +-
 drivers/iio/industrialio-event.c                   |   1 +
 drivers/iio/industrialio-trigger.c                 |  33 +-
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/acpi-als.c                       |  42 +-
 drivers/iio/light/apds9160.c                       |   2 +-
 drivers/iio/light/apds9306.c                       |   4 +-
 drivers/iio/light/as73211.c                        |   3 -
 drivers/iio/light/gp2ap020a00f.c                   | 310 +++-----
 drivers/iio/light/ltr390.c                         |   2 +-
 drivers/iio/light/ltr501.c                         |   6 +-
 drivers/iio/light/opt3001.c                        |   2 +-
 drivers/iio/light/tsl2772.c                        |   2 +-
 drivers/iio/light/vcnl4000.c                       | 131 +++-
 drivers/iio/light/zopt2201.c                       |  45 +-
 drivers/iio/magnetometer/ak8974.c                  |   2 +-
 drivers/iio/magnetometer/ak8975.c                  |   6 +-
 drivers/iio/magnetometer/bmc150_magn.c             | 145 ++--
 drivers/iio/magnetometer/si7210.c                  |  21 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |   2 +-
 drivers/iio/pressure/bmp280-spi.c                  |   2 +-
 drivers/iio/pressure/hsc030pa.c                    |   2 +-
 drivers/iio/pressure/hsc030pa_i2c.c                |   7 +-
 drivers/iio/pressure/rohm-bm1390.c                 |   2 +-
 drivers/iio/pressure/zpa2326.c                     |   2 +-
 drivers/iio/proximity/Kconfig                      |  15 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/hx9023s.c                    |   5 +-
 drivers/iio/proximity/sx9324.c                     |   2 +-
 drivers/iio/proximity/vl53l1x-i2c.c                | 756 ++++++++++++++++++
 drivers/iio/resolver/ad2s1210.c                    |   6 +-
 drivers/iio/temperature/ltc2983.c                  |   4 +-
 drivers/iio/test/iio-test-gts.c                    |   2 +-
 drivers/staging/iio/adc/ad7816.c                   |  16 +-
 drivers/staging/iio/frequency/ad9834.c             |  20 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  28 +-
 include/linux/iio/adc/qcom-adc5-gen3-common.h      | 211 +++++
 include/linux/iio/backend.h                        |  24 +
 include/linux/iio/common/st_sensors.h              |  11 +-
 include/linux/iio/types.h                          |   1 +
 include/linux/platform_data/tsl2772.h              |   4 +-
 165 files changed, 5740 insertions(+), 2166 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc=
5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vad=
c-common.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad=
8366.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
