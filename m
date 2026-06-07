Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7621990A7
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852944; cv=none; b=FCVtdii6EaK4EkTunZ98OtDkSjAyS9bDg4wqdIBpo8uh1UB+tCGcAbbzzqP6WIsb9NyGwNZgcFmS364xx7wx7iNVsVCz0Cvs3Y7Lgiid7LjJS1Dd/E14HGI71LcoOPuPAo3YxStNMbVSmsMlNe6MfVxrFrRpaHeMYm5Y9YSR43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852944; c=relaxed/simple;
	bh=5RbHTpnWdbkgxX0/BbRdYNr3SUrIcLaDTgpsgMBl7ag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=NTNcbMtYag3EIc2h9XSyBsOAam6mG+r+sI0GgY3B//B48yheDM8nZeoygyXMaBIc6mfeOkYC0X8oUJq6PLVLORiOJVBf7xph2gp0GavKJ7gHd4bkoiz4yLY9maL1koShvKa1ceQaKBw+vuHCN92X/Cpiajx0/5KqrI4It8vV6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0yHdjy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0yHdjy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E601F00893;
	Sun,  7 Jun 2026 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780852941;
	bh=3kEi4S6/woIacnxGlWAvfuDoQa8EojIS6/9jqzG5/Jw=;
	h=Date:From:To:Subject;
	b=i0yHdjy5mtUEE+Wa6FHi0Ng69bb5FcNCfPrL7ZN4r3K/TaibCb9cpopgQsXp/fshE
	 sewbgyAFJ8+0ONCz44vNnGWyNyt8dOQIRtXK0VvDkWu6KeuOG6eWis58/+7niY2uuz
	 0fk59MFZlhMOxPMfeje26ycJwW7XFjZDclOT6z9QRhI3nHkw3k8vgomVCtmExptjvb
	 9bQeTR/m5NZ3GrB8DqnQVrMPoO3KcXoarexisMh9SOdj68vghbdN86jtIRVRNEVMkZ
	 xPJ+WFJmFXYLjY4P6fO7mtiQFXf6zik+r1OqBPJzZAOhV434jxjayFRMQ+REhmjPUI
	 2heQhURo1xUBQ==
Date: Sun, 7 Jun 2026 18:22:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features and cleanup for 7.2
Message-ID: <20260607182215.3e6e849e@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-7.2a

for you to fetch changes up to ae696dfa47c30016cd429b9db5e70b259b8f509e:

  iio: adc: nxp-sar-adc: harden buffer ISR against per-channel read failure=
 (2026-06-03 18:29:09 +0100)

----------------------------------------------------------------
IIO: New device support, features and cleanup for the 7.2 cycle.

Like many areas of the kernel IIO has seen a lot of new contributors
though in this case that is not all AI driven, but also reflects and annual
surge of student contributions from usp.br. We also have several new
regular reviewers who are helping with the surge (thanks to all our
active reviewers!)

Given there was a lot of cases of similar improvements applied to
different drivers, I have grouped those into a special section (various
drivers) to avoid mass duplication.

New device support
------------------

adi,ad4130
- Add support for AD4129-4, AD4129-8, AD4130-4, AD4131-4 and AD4131-8
  after reworking the driver to be suitable for multiple device support.
adi,ad4080
- Support the AD4880 and AD4884 dual-channel parts. Interesting parts
  as have two separate data pipelines (including SPI buses interfaces),
  but the only current backend IP combines the two so they cannot be
  treated as independent devices.
adi,ad5706r
- New driver for this 4 channel current output DAC.
adi,ad4691
- New driver supporting this family of ADCs. Support for AD4691, AD4692,
  AD4693 and AD4694 which support either 8 or 16 channels with different
  max sampling rates. Feature rich driver including SPI offload support.
adi,ltc2983
- Add support for the ADT7604 in which the same sensor die as the
  LTC2984 is used for leak detection (liquid coverage of a sense area).
allwinner,adc
- Support for A523 SoCs. Similar to existing parts but with an additional
  clock.  Includes adding support for non contiguous channel lookup
  for in kernel use (fwnode_xlate callback).
broadcomm,apds9999
- New driver for the APDS9999 Ambient Light, RGB and proximity sensor.
memsic,mmc5983
- New driver for this 3-axis magnetometer.
taos,tsl2772
- Add support for the AVAGO APDS9900 and APDS9901 Ambient Light and
  Proximity sensors. which are very similar to existing part with slightly
  different integration time choices.  Includes removal of driver for these
  parts from drivers/misc.
vishay,veml3328
- New driver for this RGB+IR light sensor.

Features
--------

IIO Core
- Support for IEEE 754 floating point values in buffer scan elements.
- Support quaternion axis representation (missing the scaler part)
microchip,mcp4821
- Add configurable gain control
qcom,pm8xxx-xoadc
- Add per channel labels.
st,lsm6dsx
- Support for rotation sensing on the LSM6DSV and LSM6DSV16X using
  both floating point and new quaterionaxis rotation modifier.

MAINTAINERS update
------------------

IIO top level entry
- Include Documentation/driver-api/iio/
adi,*
- Top level ADI entry maintainer switch from Lars-Peter Clausen to Nuno S=
=C3=A1
  reflecting what has been the reality for some time. Thanks to Lars-Peter
  who was very active for many years, but has moved on to other things.
  Also add the linux@analog.com email list to ensure we don't get a gap
  in future.
- Maintainer updates to reflect Cosmin Tanislav having moved on - thanks
  to Marcelo Schmitt for taking these over.
sensiron,scd30
- Replace maintainer (Tomasz Duszynski) with Maxwell Doose.

Cleanups, minor fixes and hardening.
------------------------------------

Documentation
- Add missing powerdown modes to ABI docs.
- Use modern helpers for buffer definition in the examples.
core
- Rework of the handling of timestamps so that the offset is cached at
  buffer resize time (during enabling) rather than based on assumption
  that relied in the timestamp being last and the largest element and
  so always 8 bytes before end of the scan. Underlying problem was
  triggered by scans with repeated type elements such as quaternions
  with each element more than 2 bytes - Giving a 16 byte+ aligned channel
  with result that a following timestamp may be 16 bytes from end of scan,
  rather than 8. Note that for the bosch,bno55 a compatibility hack means
  that it will duplicate the timestamp putting  a second copy at previously
  incorrect location.
- Tidy up use of kernel types in buffer code to not use int64_t given all
  calls use s64.
various drivers
- Drop unused driver_data in device id tables - includes cleanup of various
  drivers that had only one choice where it can be hard coded elsewhere.
- Move to named initializers for many i2c_device_id and platform_device_id
  tables (I have no idea how we go into habit of using named initializers
  for only a subset of the table types - e.g. of_device_id).
- Make IIO_CHAN_SOFT_TIMESTAMP() macro a compound literal allowing simple
  use in various drivers that do dynamic channel definitions. Use it in
  all such cases.
- Use dev_err_probe() and local dev variables to tidy up older drivers.
- Switch more drivers to devm_mutex_init() to provide minor debug benefits.
- Reorder code to put MODULE_DEVICE_TABLE() next to the tables.
- Lots of use of cleanup.h magic to improve code flow, often including
  related refactors such as introducing helpers.
- Replacement of usleep_range() with fsleep()
- Reduce logging noise where functions either provide their own extensive
  reports on error, or where a clear error code is returned to userspace.
- Minor spelling and style fixes (improving bracket usage, not using
  __packed etc)
hid-sensors-*
- Drop helpers for setting channel bit masks in favor of a compound
  literal at the call site.  Also general cleanup of surrounding code.
hid-sensors-magn
- Use u32 rather than bare unsigned for types.
hid-sensors-rotation
- Make sue of ext_scan_type handling for static case rather than duplicate
  chan_info structures.
adi,ad3552r
- Use field_get() to replace open coded equivalent.
adi,ad4170
- Switch from switch to table lookup for GPIO modes.
adi,ad5686
- Apply IWYU principal to included a consistent set of headers.
- Deduplicate regmaps for AD5684 and AD5693 as identical.
- Switch from an enum value in driver data and array look up to pointers
  to separate structures, improving readabilty and avoiding issues with
  0 value when using helpers to deal with different firmware types.
- Add of_match_id table to SPI driver rather than relying on fallback to
  spi_device_id table.
- Introduce some helpers for powerdown mask control.
- Add helpers for control sync simplifying a couple of corner cases.
- Docs fixes.
- Add an ops structure to simplify future addition of operations beyond
  read and write.
adi,ad7191
- Switch to best practice of using device_property_present() to detect
  if an optional property is there rather than error values on querying
  the property.
adi,ad7280a
- Use local variables to improve readability of breaking up chan-address.
adi,ad7825
- Cleanup a type mismatch in clamp() call.
adi,ad799x
- Include improvements
- Local dev variable to shorten code lines.
- Cache regulator voltage at probe (these never change in practice)
- Convert to devm for all unwind handling.
adi,ad9832
- Improve include relevance including replacing kernel.h with more specific
  headers.
- Simplify some maths.
adi,ad9834
- Improve include relevance including replacing kernel.h with more specific
  headers.
adi,adt7316
- Add a comment to avoid future 'fixes' for error handling during the
  odd sequence used to flip from I2C mode to SPI mode.
adi,adxl*
- Documentation consistency improvements.
asahi-kasei,ak8975
- Fix missing runtime pm calls for buffered capture.
- Fix missing pm_runtime_put_autosuspend() in an error path that would leave
  the device stuck on.
- Close a potential uninitialized kernel stack leak.
- Extensive driver modernization including: header relevance, fsleep()
  various minor bugs, dropping duplicate error messages and avoiding
  magic lengths for buffers.
- Replace opencoded polling with iopoll().
- Add error checking to gpio reads.
avia,hx711
- Move scale computation from global data to per device avoiding problems
  if multiple devices present.
- General binding text cleanup.
bosch,bmg160
- Add missing mount-matrix entry to binding.
bosch,bno55
- Terminate error strings with newlines.
devantech,srf08
- Replace sprintf() with sysfs_emit() and sysfs_emit_at() to make intent
  clearer.
freescale,mma8452
- Add missing return value check.
- Fix potential probe ordering issue by switching to non devm irq request.
linear,ltc2309
- Add chip specific read delays.
- Improve chip_info structure, adding __counted_by_ptr marking and
  reorganizing to improve packing.
linear,ltc2983
- Fix a firmware combination where default n_wires of 2 bypasses exclusion
  of adi,current-rotate whereas explicitly setting it to 2 does not.
- Fix potential race with completion reinit.
- Improve error message wording consistency.
- Use fwnode_property_present() to detect optional properties rather
  than fragile return value checking.
microchip,mcp3422
- Use of GENMASK(), FIELD_GET(), FIELD_PREP() to improve readability and
  generally modernize driver.
microchip,mcp47feb02
- Fix binding example to use a possible I2C address.
- Fix binding bounds on channel number.
- Standardize binding example indentation
nxp,saradc
- Increase chances of recovering from a failure in the interrupt handler
  by notifying the trigger that it can reenable even when the read failed.
- Use field_get() to replace opencoded equivalent.
qualcomm,*
- Standardize on Qualcomm company naming in Kconfig.
richtek,rtq6056
- Add i2c_device_id table for legacy instantiation.
samsung,ssp
- Replace custom timestamp channel macro with main one.
sciosense,ens210
- Now scoped_guard() has been reworked, no need for a return
  that can never be reached.
sensiron,scd30
- Constify command lookup table.
- Sanity check for NULL buffer of non zero size being provided to
  sc30_i2c_command()
sensortek,stk3310
- Include  more appropriate headers.
- Ensure interrupt in appropriate mode after resume.
- Structure definition improvements.
- Use size_of() to replace opencoded sizes.
siliconimage,si1133
- Resolve counter related issues on timeout error paths.
- Unused macro removal, improved macro definitions,.
- Include relevance improvements.
st,lsm6dsx
- Fix an issue with applying invalid data check to wrong type of sample.
taos,tcs3472
- Try to powerdown chip on probe failure.
- Devm usage and dropping of remove() callback.
- Various other minor cleanup.
taos,tsl2591
- Dead code removal.
- Simplify tsl2591_persist functions using a look up table.
ti,ads1298
- Fix wrong comment on timeout (and minor code improvement)
- Drop unnecessary CONFIG2 write during init.
ti,ads7950
- Check ret rather that ret < 0 for spi_setup() call.
- Use fully devm managed resources including moving to
  devm_regulator_get_enable_read_voltage() at probe time rather than
  querying evey time.
- Using spi_optimize_message() to reduce CPU usage.
ti,ads8688
- User read_avail() callback rather than open coding handling of
  available attributes.
ti,opt3001
- Header relevance improvements
- Use GENMASK for field definitions to improve readability.
vishay,vcnl4000
- Switch from enum in device_data to individual names structures
  impmroving code readabililty.
- Move to devm handling for remainder of probe.
vishay,veml6030
- Drop pointless read of current Iteration Time index as it is not used.
xilinx,ams
- Fix potential out of bound channel lookup.
- Replace some large switch statements with table lookups.
yamaha,yas530
- Put label in chip info structure to avoid look up in i2c_device_id table.

Drop
----

iio-trig-interrupt.
- Not used for some time and no support for modern firmware bindings or
  in kernel users. So drop it.

----------------------------------------------------------------
Aldo Conte (7):
      iio: tcs3472: power down chip on probe failure
      iio: tcs3472: sort headers alphabetically
      iio: tcs3472: convert remaining locking to guard(mutex)
      iio: tcs3472: use ! instead of explicit NULL check
      iio: tcs3472: use devm for resource management
      iio: tcs3472: use local struct device * for remaining cases
      iio: tcs3472: move standalone return to default case

Alexis Czezar Torreno (2):
      dt-bindings: iio: dac: Add ADI AD5706R
      iio: dac: ad5706r: Add support for AD5706R DAC

Andy Shevchenko (13):
      iio: adc: ad7191: Don't check for specific errors when parsing proper=
ties
      iio: buffer: Move from int64_t to s64 for timestamp
      iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend() ca=
ll
      iio: magnetometer: ak8975: avoid using temporary variable
      iio: magnetometer: ak8975: drop duplicate NULL check
      iio: magnetometer: ak8975: remove duplicate error message
      iio: magnetometer: ak8975: reduce usage of magic lengths of the buffer
      iio: magnetometer: ak8975: unify return code variable name
      iio: magnetometer: yamaha-yas530: Get rid of i2c_client_get_device_id=
()
      iio: magnetometer: yamaha-yas530: Use devm_mutex_init() for mutex ini=
tialization
      iio: magnetometer: yamaha-yas530: replace usleep_range() with fsleep()
      iio: magnetometer: ak8975: consistently use 'data' parameter
      iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal

Angus Gardner (3):
      staging: iio: ad9834: simplify -ENOMEM return in probe
      staging: iio: ad9834: use dev_err_probe() in probe function
      staging: iio: ad9834: fix chip name typo in comments

Antoniu Miclaus (19):
      iio: adc: ad7949: use dev_err_probe()
      iio: adc: ad7780: add dev variable
      iio: adc: ad7780: use dev_err_probe()
      iio: adc: ad7793: add dev variable
      iio: adc: ad7793: use dev_err_probe()
      iio: adc: ad7292: add dev variable
      iio: adc: ad7292: use dev_err_probe()
      iio: adc: ad7791: add dev variable
      iio: adc: ad7791: use dev_err_probe()
      iio: adc: ad7280a: use dev_err_probe()
      iio: adc: ad7768-1: use dev_err_probe()
      iio: adc: ad9467: use dev_err_probe()
      iio: adc: ad4062: use dev_err_probe()
      iio: backend: add devm_iio_backend_get_by_index()
      dt-bindings: iio: adc: ad4080: add AD4880 support
      iio: adc: ad4080: add support for AD4880 dual-channel ADC
      dt-bindings: iio: adc: ad4080: add AD4884 support
      iio: adc: ad4080: add support for AD4884
      iio: adc: ad4080: fix AD4880 chip ID

Antony Kurniawan Soemardi (3):
      iio: adc: qcom-pm8xxx-xoadc: remove redundant error logs when reading=
 values
      iio: adc: qcom-pm8xxx-xoadc: add support for reading channel labels
      dt-bindings: iio: adc: qcom,pm8018-adc: add label property for ADC ch=
annels

Archit Anant (5):
      iio: adc: ad799x: sort headers alphabetically
      iio: adc: ad799x: use local device pointer in probe
      iio: adc: ad799x: use a static buffer for scan data
      iio: adc: ad799x: cache regulator voltages during probe
      iio: adc: ad799x: convert to fully managed resources and drop remove()

Ariana Lazar (3):
      dt-bindings: iio: dac: mcp47feb02: Fix I2C address in example
      dt-bindings: iio: dac: mcp47feb02: fix reg property value bounds
      dt-bindings: iio: dac: mcp47feb02: fix example indentation

Carlos Jones Jr (2):
      iio: adc: ltc2309: add read delay for ltc2305
      iio: adc: ltc2309: Optimize chip_info structure layout

David Carlier (7):
      iio: dac: ad3552r: Use devm_mutex_init()
      iio: dac: ad7303: Use devm_mutex_init()
      iio: dac: ad5758: Use devm_mutex_init()
      iio: dac: ad5755: Use devm_mutex_init()
      iio: dac: ad5686: Use devm_mutex_init()
      iio: dac: ltc2664: Use devm_mutex_init()
      iio: addac: ad74115: Use devm_mutex_init()

David Lechner (19):
      iio: buffer: check return value of iio_compute_scan_bytes()
      iio: buffer: cache timestamp offset in scan buffer
      iio: buffer: ensure repeat alignment is a power of two
      iio: buffer: fix timestamp alignment when quaternion in scan
      iio: imu: bno055: add explicit scan buf layout
      iio: orientation: hid-sensor-rotation: use ext_scan_type
      iio: adc: ti-ads7950: use spi_optimize_message()
      MAINTAINERS: add match for IIO API docs
      docs: iio: triggered-buffers: use new helpers in example
      iio: common: ssp: remove SSP_CHAN_TIMESTAMP() macro
      iio: humidity: ens210: remove compiler warning workaround
      iio: common: scmi_sensors: simplify timestamp channel definition
      iio: adc: dln2-adc: simplify timestamp channel definition
      iio: adc: at91_adc: simplify timestamp channel definition
      iio: adc: cc10001_adc: simplify timestamp channel definition
      iio: adc: stm32-adc: simplify timestamp channel definition
      iio: common: cros_ec_sensors: simplify timestamp channel definition
      iio: light: cros_ec_light_prox: simplify timestamp channel definition
      iio: pressure: cros_ec_baro: simplify timestamp channel definition

Dmitry Torokhov (4):
      iio: adc: ti-ads7950: switch to using guard() notation
      iio: adc: ti-ads7950: simplify check for spi_setup() failures
      iio: adc: ti-ads7950: switch to using devm_regulator_get_enable_read_=
voltage()
      iio: adc: ti-ads7950: complete conversion to using managed resources

Erikas Bitovtas (6):
      iio: light: vcnl4000: validate device by prod ID instead of table ID
      iio: light: vcnl4000: drop enum id table in favor of chip structs
      iio: light: vcnl4000: move device tree entries into one line
      iio: light: vcnl4000: move power state function into device-managed a=
ction
      iio: light: vcnl4000: make pm_runtime_enable() device-managed
      iio: light: vcnl4000: register an IIO device with a device-managed fu=
nction

Felipe Ribeiro de Souza (3):
      iio: adc: ingenic-adc: rename ingenic_adc_enable_unlocked() function
      iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
      iio: adc: ingenic-adc: use guard()() and scoped_guard() to handle syn=
chronisation

Francesco Lavra (6):
      iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
      iio: Replace 'sign' field with union in struct iio_scan_type
      iio: tools: Add support for floating-point types in buffer scan eleme=
nts
      iio: ABI: Add support for floating-point numbers in buffer scan eleme=
nts
      iio: ABI: Add quaternion axis modifier
      iio: imu: st_lsm6dsx: Add support for rotation sensor

Gabriel Rondon (1):
      iio: adc: ti-ads8688: use read_avail for available attributes

Giorgi Tchankvetadze (3):
      iio: adc: ti-ads7924: Use guard(mutex) in ADC read helper
      iio: adc: ad7625: fix type mismatch in clamp() macro
      iio: chemical: scd30: make command lookup table const

Guilherme Dias (1):
      iio: gyro: adxrs290: Use guard(mutex) in lieu of manual lock+unlock

Guilherme Ivo Bozi (4):
      iio: adc: ad4170: use lookup table for gpio mask selection
      iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handl=
ing
      iio: adc: xilinx-ams: use guard(mutex) for automatic locking
      iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach

Hungyu Lin (1):
      staging: iio: addac: adt7316: document SPI interface switching sequen=
ce

Javier Carrasco (1):
      iio: light: veml6030: remove unnecessary read of IT index

Jonathan Cameron (2):
      iio: trigger: drop generic interrupt trigger.
      Merge tag 'v7.1-rc6' into work

Jonathan Santos (5):
      dt-bindings: iio: adc: ad4130: Document interrupts property
      dt-bindings: iio: adc: ad4130: Add new supported parts
      iio: adc: ad4130: Add SPI device ID table
      iio: adc: ad4130: introduce chip info for future multidevice support
      iio: adc: ad4130: add new supported parts

Jose A. Perez de Azpillaga (2):
      dt-bindings: iio: light: add Broadcom APDS9999
      iio: light: add support for APDS9999 sensor

Joshua Crofts (27):
      iio: magnetometer: ak8975: remove unnecessary braces
      iio: frequency: ad9832: remove kernel.h proxy header
      iio: frequency: ad9834: clean up includes
      iio: magnetometer: hid-sensor-magn-3d: prefer 'u32' type
      iio: frequency: ad9832: simplify bitwise math
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout
      iio: light: si1133: remove unused macros
      iio: light: si1133: prefer complex macros enclosed in parenthesis
      iio: light: si1133: add missing include headers
      iio: light: si1133: group generic <linux/*> headers
      iio: light: si1133: add local variable for timeout
      iio: light: si1133: use guard(mutex)() macro
      iio: magnetometer: ak8975: sort headers alphabetically
      iio: magnetometer: ak8975: update headers per IWYU principle
      iio: magnetometer: ak8975: replace usleep_range() with fsleep()
      iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
      iio: magnetometer: ak8975: fix wrong errno on return
      iio: magnetometer: ak8975: pass conversion timeouts as arguments
      iio: magnetometer: ak8975: modernize polling loops with iopoll() macr=
os
      iio: magnetometer: ak8975: check if gpiod read was successful
      iio: magnetometer: ak8975: ensure device is awake for buffered capture
      iio: magnetometer: ak8975: fix potential kernel stack memory leak
      iio: light: opt3001: make headers conform to iwyu
      iio: light: opt3001: use macros from bits.h header
      dt-bindings: iio: light: veml6030: add veml3328
      iio: light: veml3328: add support for new device

Kevin Tung (1):
      iio: adc: rtq6056: add i2c_device_id support

Kim Seer Paller (1):
      iio: ABI: Add DAC 500ohm, 3.85kohm, and 16kohm powerdown modes

Krzysztof Kozlowski (2):
      iio: adc: qcom: Unify user-visible "Qualcomm" name
      iio: Move MODULE_DEVICE_TABLE next to the table itself

Liviu Stan (9):
      iio: temperature: ltc2983: Fix n_wires default bypassing rotation che=
ck
      iio: temperature: ltc2983: Fix reinit_completion() called after conve=
rsion start
      iio: temperature: ltc2983: Fix macro parenthesization and rename
      iio: temperature: ltc2983: Use local device pointer consistently
      iio: temperature: ltc2983: Fix inconsistent channel wording in messag=
es
      iio: temperature: ltc2983: Use fwnode_property_present() for optional=
 properties
      iio: core: Add IIO_COVERAGE channel type
      dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
      iio: temperature: ltc2983: Add support for ADT7604

Lucas Ivars Cadima Ciziks (2):
      iio: adc: ad7280a: Extract chan->address bit fields into named local =
variables
      iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for=
 mutex locking

Lucas Rabaquim (1):
      iio: light: tsl2591: remove unneeded tsl2591_compatible_als_persist_c=
ycle()

Marcelo Machado Lage (2):
      iio: adc: mcp3422: rewrite mask macros with help of bits.h APIs
      iio: adc: mcp3422: write bit operations using bitfield.h APIs

Marek Vasut (1):
      iio: adc: rcar: Fix up Marek Vasut MAINTAINERS entry

Matheus Silveira (1):
      light: tsl2591: simplify tsl2591_persist functions via lookup table

Maxwell Doose (7):
      iio: proximity: srf08: Replace sprintf() with sysfs_emit()
      iio: magnetometer: rm3100: Modernize locking and refactor control flow
      MAINTAINERS: Add myself as SCD30 maintainer
      dt-bindings: iio: chemical: sensirion,scd30: Update maintainers field
      iio: imu: kmx61: Use guard(mutex)() over manual locking
      iio: chemical: sps30: Replace manual locking with RAII locking
      iio: chemical: scd30: Replace manual locking with RAII locking

Md Shofiqul Islam (3):
      iio: adc: ti-ads1298: Fix incorrect timeout comment
      iio: adc: ti-ads1298: Add parentheses around macro parameter
      iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init

Miao Li (3):
      iio: light: stk3310: Deal with the ps interrupt issue in PM
      iio: light: stk3310: Replace uint32_t with u32 and reorder members to=
 eliminate padding
      iio: light: stk3310: Use sizeof() for regmap_bulk_read/write count pa=
rameter

Michal Piekos (3):
      dt-bindings: iio: adc: Add GPADC for Allwinner A523
      iio: adc: sun20i-gpadc: add A523 gpadc support
      iio: adc: sun20i-gpadc: support non-contiguous channel lookups

Nat=C3=A1lia Salvino Andr=C3=A9 (6):
      iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
      iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
      iio: light: HID: hid-sensor-als: Refactor channel initialization
      iio: light: HID: hid-sensor-prox: Refactor channel initialization
      iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel initiali=
zation
      iio: pressure: HID: hid-sensor-press: Refactor channel initialization

Nikhil Gautam (4):
      iio: dac: mcp4821: fix spelling mistake in enum name
      iio: dac: mcp4821: move state initialization outside switch
      iio: dac: mcp4821: add configurable gain support
      iio: chemical: bme680: use BME680_NUM_CHANNELS for scan buffer

Pedro Barletta Gennari (2):
      iio: light: iqs621-als: use lock guards
      iio: light: iqs621-als: prefer early error handling over if (!ret)

Piyush Patle (4):
      iio: dac: ad3552r: use field_get() for power-down bit read
      iio: adc: nxp-sar-adc: use field_get() for EOC bit check
      dt-bindings: iio: adc: hx711: clean up existing binding text
      iio: adc: hx711: move scale computation to per-device storage

Radu Sabau (6):
      dt-bindings: iio: adc: add AD4691 family
      iio: adc: ad4691: add initial driver for AD4691 family
      iio: adc: ad4691: add triggered buffer support
      iio: adc: ad4691: add SPI offload support
      iio: adc: ad4691: add oversampling support
      docs: iio: adc: ad4691: add driver documentation

Rafael G. Dias (2):
      iio: light: stk3310: Sort headers alphabetically
      iio: light: stk3310: Update includes to match IWYU

Raffael Raiel Trindade (1):
      iio: light: vcnl4000: use lock guard()

Rahman Mahmutovi=C4=87 (1):
      iio: temperature: maxim_thermocouple: Fix indentation in of_match tab=
le

Rodrigo Alencar (8):
      iio: dac: ad5686: refactor include headers
      iio: dac: ad5686: remove redundant register definition
      iio: dac: ad5686: drop enum id
      iio: dac: ad5686: add of_match table to the spi driver
      iio: dac: ad5686: add helpers to handle powerdown masks
      iio: dac: ad5686: add control_sync() for single-channel devices
      iio: dac: ad5686: cleanup doc header of local structs
      iio: dac: ad5686: create bus ops struct

Rodrigo Gobbi (2):
      iio: adc: spear_adc: sort includes alphabetically
      iio: adc: spear_adc: align headers with IWYU principle

Sanjay Chitroda (18):
      iio: accel: adxl313_core: Use devm-managed mutex initialization
      iio: accel: adxl313: Use dev_err_probe()
      iio: accel: adxl380: Use devm-managed mutex initialization
      iio: accel: adxl355_core: Use devm-managed mutex initialization
      iio: accel: adxl355: Use dev_err_probe()
      iio: accel: adxl367: Use devm-managed mutex initialization
      iio: accel: adxl372: Use devm-managed mutex initialization
      iio: accel: adxl372: Use dev_err_probe()
      iio: ssp_sensors: cleanup codestyle warning
      iio: ssp_sensors: cleanup codestyle check
      iio: ssp_sensors: cleanup codestyle warning
      MAINTAINERS: Update Analog Devices IIO drivers entry
      MAINTAINERS: Update maintainer for IIO drivers
      iio: accel: mma8452: handle I2C read error(s) in mma8452_read()
      iio: accel: mma8452: switch to non-devm request_threaded_irq()
      iio: accel: mma8452: cleanup codestyle warning
      iio: accel: mma8452: sort headers alphabetically
      iio: accel: mma8452: Use dev_err_probe()

Stepan Ionichev (10):
      iio: chemical: scd30: reject (response=3DNULL, size>0) in scd30_i2c_c=
ommand()
      iio: adc: ad7793: replace usleep_range() with fsleep()
      iio: frequency: adrf6780: replace usleep_range() with fsleep()
      iio: adc: ad7192: replace usleep_range() with fsleep()
      iio: accel: adxl355: replace usleep_range() with fsleep()
      iio: adc: ad7192: fix GPOCON register access annotation
      Documentation: iio: fix typo in triggered-buffers example
      Documentation: iio: make ADXL Y-axis calibbias description consistent
      iio: imu: bno055: terminate dev_err() strings with a newline
      iio: adc: nxp-sar-adc: harden buffer ISR against per-channel read fai=
lure

Svyatoslav Ryhel (3):
      dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity s=
ensor
      iio: tsl2772: Add support for Avago APDS9900/9901 ALS/Proximity sensor
      misc: Remove old APDS990x driver

Taha Ed-Dafili (2):
      iio: dac: ad5504: sort headers alphabetically
      iio: dac: ad5504: introduce local dev pointer

Uwe Kleine-K=C3=B6nig (The Capable Hub) (9):
      iio: Drop unused driver_data in four i2c drivers
      iio: accel: bmc150: Explicitly set .driver_data
      iio: adc: ad7091r5: Simplify driver_data handling
      iio: dac: max5821: Drop unused i2c driver data
      iio: proximity: sx9324: Drop unused driver data
      iio: proximity: sx9360: Drop unused driver data
      staging: iio: Use named initializers for struct i2c_device_id
      iio: Initialize i2c_device_id arrays using member names
      iio: Use named initializers for platform_device_id arrays

Vishwas Rajashekar (1):
      dt-bindings: iio: gyroscope: add mount-matrix for bmg160

Vladislav Kulikov (2):
      dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
      iio: magnetometer: add driver for MEMSIC MMC5983MA

Wang Zihan (1):
      iio: adxl313: fix typos in documentation

 Documentation/ABI/testing/sysfs-bus-iio            |   68 +-
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   56 +-
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |   19 +-
 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    |  180 ++
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         |   32 +-
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   25 +-
 .../bindings/iio/adc/qcom,pm8018-adc.yaml          |   15 +
 .../bindings/iio/chemical/sensirion,scd30.yaml     |    2 +-
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   |  105 +
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     |   36 +-
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |    6 +
 .../bindings/iio/light/brcm,apds9999.yaml          |   54 +
 .../devicetree/bindings/iio/light/tsl2772.yaml     |    2 +
 .../bindings/iio/light/vishay,veml6030.yaml        |    5 +-
 .../bindings/iio/magnetometer/memsic,mmc5983.yaml  |   63 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  217 +-
 Documentation/driver-api/iio/buffers.rst           |    7 +-
 Documentation/driver-api/iio/triggered-buffers.rst |   10 +-
 Documentation/iio/ad4691.rst                       |  227 +++
 Documentation/iio/adxl313.rst                      |   10 +-
 Documentation/iio/adxl345.rst                      |    2 +-
 Documentation/iio/adxl380.rst                      |    2 +-
 Documentation/iio/iio_devbuf.rst                   |    3 +-
 Documentation/iio/index.rst                        |    1 +
 Documentation/misc-devices/apds990x.rst            |  128 --
 Documentation/misc-devices/index.rst               |    1 -
 MAINTAINERS                                        |   52 +-
 drivers/iio/accel/adxl313_core.c                   |   10 +-
 drivers/iio/accel/adxl313_i2c.c                    |   10 +-
 drivers/iio/accel/adxl313_spi.c                    |   11 +-
 drivers/iio/accel/adxl345_i2c.c                    |    4 +-
 drivers/iio/accel/adxl355_core.c                   |   30 +-
 drivers/iio/accel/adxl355_i2c.c                    |   15 +-
 drivers/iio/accel/adxl355_spi.c                    |   11 +-
 drivers/iio/accel/adxl367.c                        |    4 +-
 drivers/iio/accel/adxl367_i2c.c                    |    2 +-
 drivers/iio/accel/adxl372.c                        |   10 +-
 drivers/iio/accel/adxl372_i2c.c                    |    4 +-
 drivers/iio/accel/adxl380.c                        |    4 +-
 drivers/iio/accel/adxl380_i2c.c                    |    8 +-
 drivers/iio/accel/bma180.c                         |   10 +-
 drivers/iio/accel/bma220_i2c.c                     |    2 +-
 drivers/iio/accel/bma400_i2c.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |   20 +-
 drivers/iio/accel/bmi088-accel-i2c.c               |    6 +-
 drivers/iio/accel/da280.c                          |    6 +-
 drivers/iio/accel/da311.c                          |    2 +-
 drivers/iio/accel/dmard06.c                        |    6 +-
 drivers/iio/accel/dmard09.c                        |    2 +-
 drivers/iio/accel/dmard10.c                        |    2 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    8 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   27 +-
 drivers/iio/accel/kxcjk-1013.c                     |   10 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    2 +-
 drivers/iio/accel/mc3230.c                         |    4 +-
 drivers/iio/accel/mma7455_i2c.c                    |    4 +-
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/mma8452.c                        |  106 +-
 drivers/iio/accel/mma9551.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    2 +-
 drivers/iio/accel/mxc4005.c                        |    4 +-
 drivers/iio/accel/mxc6255.c                        |    4 +-
 drivers/iio/accel/ssp_accel_sensor.c               |    2 +-
 drivers/iio/accel/st_accel_i2c.c                   |   52 +-
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    2 +-
 drivers/iio/adc/88pm886-gpadc.c                    |    2 +-
 drivers/iio/adc/Kconfig                            |   20 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4062.c                           |    7 +-
 drivers/iio/adc/ad4080.c                           |  275 ++-
 drivers/iio/adc/ad4130.c                           |  493 ++++-
 drivers/iio/adc/ad4170-4.c                         |   47 +-
 drivers/iio/adc/ad4691.c                           | 2084 ++++++++++++++++=
++++
 drivers/iio/adc/ad7091r5.c                         |   12 +-
 drivers/iio/adc/ad7191.c                           |   63 +-
 drivers/iio/adc/ad7192.c                           |    9 +-
 drivers/iio/adc/ad7280a.c                          |   75 +-
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/ad7292.c                           |   16 +-
 drivers/iio/adc/ad7606.c                           |    2 +-
 drivers/iio/adc/ad7625.c                           |    4 +-
 drivers/iio/adc/ad7768-1.c                         |    6 +-
 drivers/iio/adc/ad7780.c                           |   46 +-
 drivers/iio/adc/ad7791.c                           |   19 +-
 drivers/iio/adc/ad7793.c                           |   37 +-
 drivers/iio/adc/ad7949.c                           |   25 +-
 drivers/iio/adc/ad799x.c                           |  149 +-
 drivers/iio/adc/ad9467.c                           |    9 +-
 drivers/iio/adc/at91_adc.c                         |   12 +-
 drivers/iio/adc/cc10001_adc.c                      |   10 +-
 drivers/iio/adc/dln2-adc.c                         |   12 +-
 drivers/iio/adc/gehc-pmc-adc.c                     |    2 +-
 drivers/iio/adc/hx711.c                            |   31 +-
 drivers/iio/adc/ina2xx-adc.c                       |   12 +-
 drivers/iio/adc/ingenic-adc.c                      |   68 +-
 drivers/iio/adc/ltc2309.c                          |   20 +-
 drivers/iio/adc/ltc2471.c                          |    4 +-
 drivers/iio/adc/ltc2485.c                          |    2 +-
 drivers/iio/adc/ltc2497.c                          |    4 +-
 drivers/iio/adc/max11410.c                         |    2 +-
 drivers/iio/adc/max34408.c                         |    4 +-
 drivers/iio/adc/max77541-adc.c                     |    2 +-
 drivers/iio/adc/mcp3422.c                          |   81 +-
 drivers/iio/adc/nau7802.c                          |    2 +-
 drivers/iio/adc/nxp-sar-adc.c                      |    7 +-
 drivers/iio/adc/pac1921.c                          |    2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   39 +-
 drivers/iio/adc/rohm-bd79124.c                     |    2 +-
 drivers/iio/adc/rtq6056.c                          |   10 +-
 drivers/iio/adc/spear_adc.c                        |   23 +-
 drivers/iio/adc/stm32-adc.c                        |   10 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                 |   28 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    6 +-
 drivers/iio/adc/ti-adc081c.c                       |    6 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |    4 +-
 drivers/iio/adc/ti-ads1119.c                       |    2 +-
 drivers/iio/adc/ti-ads1298.c                       |   19 +-
 drivers/iio/adc/ti-ads7138.c                       |    4 +-
 drivers/iio/adc/ti-ads7924.c                       |    7 +-
 drivers/iio/adc/ti-ads7950.c                       |  256 +--
 drivers/iio/adc/ti-ads8688.c                       |   70 +-
 drivers/iio/adc/xilinx-ams.c                       |  190 +-
 drivers/iio/addac/ad74115.c                        |    5 +-
 drivers/iio/cdc/ad7150.c                           |    6 +-
 drivers/iio/cdc/ad7746.c                           |    6 +-
 drivers/iio/chemical/ags02ma.c                     |    2 +-
 drivers/iio/chemical/ams-iaq-core.c                |    2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    6 +-
 drivers/iio/chemical/atlas-sensor.c                |   10 +-
 drivers/iio/chemical/bme680_core.c                 |    2 +-
 drivers/iio/chemical/bme680_i2c.c                  |    2 +-
 drivers/iio/chemical/ccs811.c                      |    4 +-
 drivers/iio/chemical/ens160_i2c.c                  |    2 +-
 drivers/iio/chemical/scd30_core.c                  |   58 +-
 drivers/iio/chemical/scd30_i2c.c                   |    5 +-
 drivers/iio/chemical/sgp30.c                       |    7 +-
 drivers/iio/chemical/sgp40.c                       |    2 +-
 drivers/iio/chemical/sps30.c                       |   24 +-
 drivers/iio/chemical/sps30_i2c.c                   |    2 +-
 drivers/iio/chemical/vz89x.c                       |    4 +-
 .../iio/common/cros_ec_sensors/cros_ec_activity.c  |    8 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    8 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   13 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |    2 +-
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h    |   12 -
 drivers/iio/common/ssp_sensors/ssp_spi.c           |    8 +-
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad3552r.c                          |    7 +-
 drivers/iio/dac/ad5064.c                           |   94 +-
 drivers/iio/dac/ad5380.c                           |   32 +-
 drivers/iio/dac/ad5446-i2c.c                       |   12 +-
 drivers/iio/dac/ad5504.c                           |   39 +-
 drivers/iio/dac/ad5686-spi.c                       |   73 +-
 drivers/iio/dac/ad5686.c                           |  530 +++--
 drivers/iio/dac/ad5686.h                           |  131 +-
 drivers/iio/dac/ad5696-i2c.c                       |   80 +-
 drivers/iio/dac/ad5706r.c                          |  253 +++
 drivers/iio/dac/ad5755.c                           |    5 +-
 drivers/iio/dac/ad5758.c                           |    4 +-
 drivers/iio/dac/ad7303.c                           |    4 +-
 drivers/iio/dac/ds4424.c                           |    8 +-
 drivers/iio/dac/ltc2664.c                          |    4 +-
 drivers/iio/dac/m62332.c                           |    2 +-
 drivers/iio/dac/max517.c                           |   10 +-
 drivers/iio/dac/max5821.c                          |    6 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/dac/mcp4728.c                          |    2 +-
 drivers/iio/dac/mcp47feb02.c                       |   48 +-
 drivers/iio/dac/mcp4821.c                          |  133 +-
 drivers/iio/dac/ti-dac5571.c                       |   22 +-
 drivers/iio/frequency/adrf6780.c                   |    7 +-
 drivers/iio/gyro/adxrs290.c                        |   75 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   27 +-
 drivers/iio/gyro/itg3200_core.c                    |    2 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    2 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |    2 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   18 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/health/max30100.c                      |    2 +-
 drivers/iio/health/max30102.c                      |    6 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/ens210.c                      |   31 +-
 drivers/iio/humidity/hdc100x.c                     |   12 +-
 drivers/iio/humidity/hdc2010.c                     |    4 +-
 drivers/iio/humidity/hdc3020.c                     |    6 +-
 drivers/iio/humidity/hts221_i2c.c                  |    2 +-
 drivers/iio/humidity/htu21.c                       |    4 +-
 drivers/iio/humidity/si7005.c                      |    4 +-
 drivers/iio/humidity/si7020.c                      |    4 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    4 +-
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    4 +-
 drivers/iio/imu/bmi323/bmi323_i2c.c                |    2 +-
 drivers/iio/imu/bno055/bno055.c                    |   27 +-
 drivers/iio/imu/bno055/bno055_i2c.c                |    2 +-
 drivers/iio/imu/bno055/bno055_ser_core.c           |    4 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   14 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |   16 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   36 +-
 drivers/iio/imu/kmx61.c                            |  131 +-
 drivers/iio/imu/st_lsm6dsx/Makefile                |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   28 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   43 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   58 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c     |  241 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   48 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    4 +-
 drivers/iio/industrialio-backend.c                 |   53 +-
 drivers/iio/industrialio-buffer.c                  |   48 +-
 drivers/iio/industrialio-core.c                    |    2 +
 drivers/iio/light/Kconfig                          |   25 +
 drivers/iio/light/Makefile                         |    2 +
 drivers/iio/light/adjd_s311.c                      |    2 +-
 drivers/iio/light/adux1020.c                       |    2 +-
 drivers/iio/light/al3000a.c                        |    2 +-
 drivers/iio/light/al3010.c                         |    2 +-
 drivers/iio/light/al3320a.c                        |    2 +-
 drivers/iio/light/apds9160.c                       |    2 +-
 drivers/iio/light/apds9300.c                       |    2 +-
 drivers/iio/light/apds9960.c                       |    2 +-
 drivers/iio/light/apds9999.c                       |  333 ++++
 drivers/iio/light/as73211.c                        |    4 +-
 drivers/iio/light/bh1745.c                         |    2 +-
 drivers/iio/light/bh1750.c                         |   10 +-
 drivers/iio/light/bh1780.c                         |    2 +-
 drivers/iio/light/cm3232.c                         |    5 +-
 drivers/iio/light/cm3323.c                         |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/cros_ec_light_prox.c             |    8 +-
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    2 +-
 drivers/iio/light/hid-sensor-als.c                 |   18 +-
 drivers/iio/light/hid-sensor-prox.c                |   19 +-
 drivers/iio/light/iqs621-als.c                     |  111 +-
 drivers/iio/light/isl29018.c                       |    6 +-
 drivers/iio/light/isl29028.c                       |    4 +-
 drivers/iio/light/isl29125.c                       |    2 +-
 drivers/iio/light/isl76682.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    2 +-
 drivers/iio/light/ltr390.c                         |    2 +-
 drivers/iio/light/ltr501.c                         |    8 +-
 drivers/iio/light/ltrf216a.c                       |    4 +-
 drivers/iio/light/lv0104cs.c                       |    2 +-
 drivers/iio/light/max44000.c                       |    2 +-
 drivers/iio/light/max44009.c                       |    2 +-
 drivers/iio/light/noa1305.c                        |    2 +-
 drivers/iio/light/opt3001.c                        |   24 +-
 drivers/iio/light/opt4001.c                        |    4 +-
 drivers/iio/light/opt4060.c                        |    2 +-
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/si1133.c                         |   72 +-
 drivers/iio/light/si1145.c                         |   14 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    2 +-
 drivers/iio/light/stk3310.c                        |  113 +-
 drivers/iio/light/tcs3414.c                        |    2 +-
 drivers/iio/light/tcs3472.c                        |  181 +-
 drivers/iio/light/tsl2563.c                        |    8 +-
 drivers/iio/light/tsl2583.c                        |    6 +-
 drivers/iio/light/tsl2591.c                        |  123 +-
 drivers/iio/light/tsl2772.c                        |   38 +-
 drivers/iio/light/tsl4531.c                        |    2 +-
 drivers/iio/light/us5182d.c                        |    2 +-
 drivers/iio/light/vcnl4000.c                       |  428 ++--
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/light/veml3235.c                       |    2 +-
 drivers/iio/light/veml3328.c                       |  423 ++++
 drivers/iio/light/veml6030.c                       |   12 +-
 drivers/iio/light/veml6040.c                       |    2 +-
 drivers/iio/light/veml6046x00.c                    |    2 +-
 drivers/iio/light/veml6070.c                       |    2 +-
 drivers/iio/light/veml6075.c                       |    2 +-
 drivers/iio/light/vl6180.c                         |    2 +-
 drivers/iio/light/zopt2201.c                       |    2 +-
 drivers/iio/magnetometer/Kconfig                   |   11 +
 drivers/iio/magnetometer/Makefile                  |    1 +
 drivers/iio/magnetometer/af8133j.c                 |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    8 +-
 drivers/iio/magnetometer/ak8975.c                  |  273 +--
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    6 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   26 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    8 +-
 drivers/iio/magnetometer/mag3110.c                 |    2 +-
 drivers/iio/magnetometer/mmc35240.c                |    2 +-
 drivers/iio/magnetometer/mmc5633.c                 |    4 +-
 drivers/iio/magnetometer/mmc5983.c                 |  348 ++++
 drivers/iio/magnetometer/rm3100-core.c             |   94 +-
 drivers/iio/magnetometer/si7210.c                  |    2 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   18 +-
 drivers/iio/magnetometer/tlv493d.c                 |    2 +-
 drivers/iio/magnetometer/tmag5273.c                |    2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |   30 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   71 +-
 drivers/iio/potentiometer/ad5272.c                 |   10 +-
 drivers/iio/potentiometer/ds1803.c                 |    8 +-
 drivers/iio/potentiometer/tpl0102.c                |    8 +-
 drivers/iio/potentiostat/lmp91000.c                |    4 +-
 drivers/iio/pressure/abp060mg.c                    |   90 +-
 drivers/iio/pressure/abp2030pa_i2c.c               |    2 +-
 drivers/iio/pressure/adp810.c                      |    2 +-
 drivers/iio/pressure/bmp280-i2c.c                  |   12 +-
 drivers/iio/pressure/cros_ec_baro.c                |    8 +-
 drivers/iio/pressure/dlhl60d.c                     |    4 +-
 drivers/iio/pressure/dps310.c                      |    2 +-
 drivers/iio/pressure/hid-sensor-press.c            |   19 +-
 drivers/iio/pressure/hp03.c                        |    2 +-
 drivers/iio/pressure/hp206c.c                      |    2 +-
 drivers/iio/pressure/hsc030pa_i2c.c                |    2 +-
 drivers/iio/pressure/icp10100.c                    |    2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    2 +-
 drivers/iio/pressure/mpl3115.c                     |    2 +-
 drivers/iio/pressure/mprls0025pa_i2c.c             |    2 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    4 +-
 drivers/iio/pressure/ms5637.c                      |    8 +-
 drivers/iio/pressure/rohm-bm1390.c                 |    2 +-
 drivers/iio/pressure/sdp500.c                      |    2 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   16 +-
 drivers/iio/pressure/t5403.c                       |    2 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    2 +-
 drivers/iio/proximity/aw96103.c                    |    4 +-
 drivers/iio/proximity/hx9023s.c                    |    2 +-
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/mb1232.c                     |   14 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    4 +-
 drivers/iio/proximity/rfd77402.c                   |    2 +-
 drivers/iio/proximity/srf08.c                      |   23 +-
 drivers/iio/proximity/sx9310.c                     |    4 +-
 drivers/iio/proximity/sx9324.c                     |    6 +-
 drivers/iio/proximity/sx9360.c                     |    8 +-
 drivers/iio/proximity/sx9500.c                     |    2 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
 drivers/iio/proximity/vl53l1x-i2c.c                |    2 +-
 drivers/iio/temperature/ltc2983.c                  |  621 +++++-
 drivers/iio/temperature/max30208.c                 |    2 +-
 drivers/iio/temperature/maxim_thermocouple.c       |    6 +-
 drivers/iio/temperature/mcp9600.c                  |    4 +-
 drivers/iio/temperature/mlx90614.c                 |    4 +-
 drivers/iio/temperature/mlx90632.c                 |    2 +-
 drivers/iio/temperature/mlx90635.c                 |    2 +-
 drivers/iio/temperature/tmp006.c                   |    2 +-
 drivers/iio/temperature/tmp007.c                   |    2 +-
 drivers/iio/temperature/tmp117.c                   |    4 +-
 drivers/iio/temperature/tsys01.c                   |    2 +-
 drivers/iio/temperature/tsys02d.c                  |    2 +-
 drivers/iio/trigger/Kconfig                        |    9 -
 drivers/iio/trigger/Makefile                       |    1 -
 drivers/iio/trigger/iio-trig-interrupt.c           |  109 -
 drivers/misc/Kconfig                               |   10 -
 drivers/misc/Makefile                              |    1 -
 drivers/misc/apds990x.c                            | 1284 ------------
 drivers/staging/iio/addac/adt7316-i2c.c            |   12 +-
 drivers/staging/iio/addac/adt7316-spi.c            |   13 +-
 drivers/staging/iio/frequency/ad9832.c             |   20 +-
 drivers/staging/iio/frequency/ad9834.c             |   45 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    4 +-
 include/linux/iio/backend.h                        |    1 +
 include/linux/iio/buffer.h                         |   14 +-
 include/linux/iio/iio.h                            |   39 +-
 include/linux/platform_data/apds990x.h             |   65 -
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_event_monitor.c                      |    3 +
 tools/iio/iio_generic_buffer.c                     |   70 +-
 tools/iio/iio_utils.c                              |   12 +-
 tools/iio/iio_utils.h                              |    4 +-
 369 files changed, 9331 insertions(+), 5131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4691.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5706r.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds99=
99.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mems=
ic,mmc5983.yaml
 create mode 100644 Documentation/iio/ad4691.rst
 delete mode 100644 Documentation/misc-devices/apds990x.rst
 create mode 100644 drivers/iio/adc/ad4691.c
 create mode 100644 drivers/iio/dac/ad5706r.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
 create mode 100644 drivers/iio/light/apds9999.c
 create mode 100644 drivers/iio/light/veml3328.c
 create mode 100644 drivers/iio/magnetometer/mmc5983.c
 delete mode 100644 drivers/iio/trigger/iio-trig-interrupt.c
 delete mode 100644 drivers/misc/apds990x.c
 delete mode 100644 include/linux/platform_data/apds990x.h
