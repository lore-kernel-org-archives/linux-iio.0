Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7383B443F
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998273; cv=none; b=SXlipVRLFRDDYvNQAyZzcgK9RloytbIDW66D96R9QNh9FKZrxghs2gODL0WQQRcJOWR13f11rYB4CfQfBvqvIYetFQyRFSTF7uSA8sN39UGb2bYuvY0hk8g+3q6PVwDaopIJjPxK6DK1Uf9wkO2lyCH1CoanUPfW7FNlysbb3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998273; c=relaxed/simple;
	bh=WGbcXBrmnfRxox6AbcIKFwLu4rE6DL6dlzUOqwoGtmQ=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TntZMX8n45UhfO9ZZlsqViRdghlT6p6MVOnQBrL5DzFAB4j/KnxcBjmQhbdBIzj27M52rARLi7nI4Sygjtj1HCjJoNstNGluYmqm4CNSPOv5hIp9BY7Gp9Gf8FBvrFVdKO+EhScgRS2oQRrmuHseqCR48+42pbzopfe3B6N3tY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMaGXszn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMaGXszn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B41F000E9;
	Mon, 17 Aug 2026 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998270;
	bh=I/miDb3c5qgW0/mRK4N8tfcHo0I2idDpXu7mYfZnZvY=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=cMaGXszn7jFCaWzY041O6LTpgKOgiXAfGeUp4tQ42QyKs1pNN3TQGpY85yWb3dl5Y
	 mAnVr4lKwWObtSYSdjZSaMo0nTdpn340cqmWoj0KIdCySYgeyWVvgoJyf19R3uBfnQ
	 pQ0/ICxswnSAv6XDfGSdMGc4nbGuQqn2BWFVBrwb7+xi9JYHFHwoIpCV4l/nK6oW9j
	 gle8ff13GygRK+nm8hoU4KcwErKyCugBCCEnvkUfqt7BWjIAkP33vEV0yMZGzR6yVu
	 /bd1O5dX49mh9uWgnDmQ2Pf6NgBOZO64R+EvQkFwl/FOq2YaAgDT6hM/OLOLu6EEZA
	 6hK4spxXMZ2uw==
Date: Mon, 17 Aug 2026 21:24:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for the
 7.3 cycle
Message-ID: <20260817212425.0a3973a8@jic23-huawei>
In-Reply-To: <20260808001046.3477ca05@jic23-huawei>
References: <20260808001046.3477ca05@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Aug 2026 00:10:46 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8d=
da:
>=20
>   Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-7.3a
>=20
> for you to fetch changes up to 350d1fb9204b13c5f95e511e98b8bcb47574d425:
>=20
>   iio: dac: mcp47a1: add support for new device (2026-08-05 01:09:56 +010=
0)
>

Hi Greg,

Just a quick ping to check this one and the fixes pull request sent a few
ours earlier haven't fallen through the cracks

Thanks,

Jonathan

=20
> ----------------------------------------------------------------
> IIO new device support, features, cleanup for 7.3
>=20
> Includes a merge of 7.2-rc2 to pick up the changes around
> mod_devicetable.h and reduce resulting conflicts around includes.
>=20
> New device support
> ------------------
>=20
> adi,ad3530R
> - Add support for the AD3532R and AD3532 16 channel DACs.
> adi,ad4080
> - Add support for the AD4883 ADC.
> adi,ad5686
> - Add support for AD5313R, AD5317R, AD5674, AD5687R, AD5689, AD5689R DACs
>   over SPI
> - Add support for AD5316R, AD5674, AD5697R and AD5696 DACs over I2C
> - Significant driver refactoring prior to these additions, partly to redu=
ce
>   bus traffic and to add triggered buffer and gain control support. An
>   earlier set added support for missing supplies, reset and LDAC GPIO.
> adi,adf41513
> - New driver to support this PLL frequency synthesizer that runs up to
>   26.5 GHz.
> - Included infrastructure to handle higher precision attributes with
>   extensive tests
> adi,ltc2378-20
> - New driver supporting LTC2338, LTC2364, LTC2367, LTC2368, LT2369, LTC23=
70
>   LTC2376, LTC2377, LTC2378, LTC2379 and LTC23980 ADCs with both high spe=
ed
>   capture via appropriate backend and conventional triggered buffer SPI
>   capture.
> invensense,icm42607
> - New driver for this IMU.
> mediateck,mt6323
> - New driver for this PMIC ADC.
> microchip,mcp47a1
> - New driver for this I2C 6 bit DAC.
> nxp,mcf54415-dac
> - New driver for this DAC found in NXP SoCs.
> qst,qmc5884l
> - New driver for this 3 axis magnetometer. Included dt vendor entry for q=
st.
> qst,qmc6308
> - New driver for this 3 axis magnetometer.
> sensiron,slf3s
> - New driver for this liquid flow sensor. Includes adding IIO_VOLUMEFLOW
>   channel type.
> st,vl53l1x
> - Refactors to improve readability.
> ti,ads112c14
> - New driver supporting the ADS112C14 and ADS122C14 ADCs. These bring
>   some new ABI for input chopping, particular useful for resistive sensors
>   like thermocouples or Wheatstone bridges.
> - Support CRC8 detection of corruption on the bus.
> - Support buffered reads.
> ti,tmp117
> - (trivial) Add support for the tmp119 temperature sensor.
> xilinx,versal-sysmon
> - New ADC driver for this block found on various FPGAs including various
>   bus interfaces, threshold and oversampling support.
>=20
> dt binding updates
> ------------------
> new shared bindings
> - excitation-channels and excitation-current-nanoamp allow per channel
>   specification of currents used for resistive sensor measurement.
> - reference-sources property to allow selection of a per channel referenc=
e.
> rockchip,saradc
> - Add RV1106 which is compatible with the RV3588.
>=20
> Features
> --------
>=20
> buffer-dmaengine
> - Allow cyclic buffers, useful for repeating sequence generation with DAC=
s.
> devantech,dmard09
> - Implement read back of channel scale - previously interface always
>   returned an error.
> hid,sensors-als
> - Enable separate channel scaling for hardware that supports it.
> invensense,timestamp library
> - Various precision improvements.
> invensense,icm42600
> - Add support for hwfifo watermark interfaces.
> taos,tcs3472
> - Support wait time and sampling frequency control.
>=20
> Cleanups, minor fixes
> ---------------------
>=20
> Minor cleanups not mentioned at all in this summary such
> as white space fixes or typos.
>=20
> Affecting various drivers
> - Cleanup of conditionals that had no affect.
> - Drop some runtime pm local wrappers as now runtime_pm does the
>   mark_last_busy part inside the put, these provide no useful code
>   deduplication or readability advantages over directly calling the
>   runtime_pm functions.
> - Return 0 from write_raw() on success.
> - Use of dev_err_probe() to simplify code and sometimes provide useful
>   info for deferred probe debugging.
> - Drop some redundant error prints where the called function already
>   provides information on errors.
> - Make some read only arrays in functions static.
> - Fix up missing handling of regcache_sync() errors.
> - Drop some false kernel-doc markings.
> - Add missing MODULE_DEVICE_TABLE for some of_match_id tables.
> - Use local variables for things like the struct device to shorten and
>   improve readability of code.
> - Drop some unused structure elements.
> - Reorder dds.h macro parameters to be inline with others.
> - Header reorders and IWYU. Often part of a more significant series.
> - Remove abstractions designed to allow a driver to support multiple devi=
ce
>   types, when they have been around a long time and only the original part
>   showed up.
> - Initialize spi_device_id arrays using member names following dropping of
>   driver data from drivers that didn't actually use it.
> - Catch up with i2c_device_id tables added since previous effort to use
>   named initializers for all those.
> - Use kernel types in a few places instead of standard C ones or bare
>   unsigned.
>=20
> Misc
> - Update Xilinx AMS maintainer.
> - Update email address for Maxwell Doose.
> - Update email address for Siratul Islam.
> - Update email address for Tomasz Duszynski and re-add Tomasz to
>   various maintainer entries.
> Docs
> - Encourage use of differential channel naming even when there is no
>   flexibility in input to differential pair mapping. Intended to
>   provide a strong signal to userspace that a channel is differential.
> adi,ad_sigma_delta
> - Allow COMPILE_TEST without any users.
> adi,ad2s1201
> - Refactor trigger handler to avoid mix of guard() and goto.
> adi,ad5686
> - Avoid potential NULL dereference is user forces a driver bind.
> adi,ad5696
> - Add a couple of missing entries to the of_match_id table and update
>   binding to match.
> atmel,ad91_adc
> - Use const char * for DT string property allowing a cast to be dropped.
> avia,hx711
> - Various refactors and cleanup to enable support of additional parts
>   (to come)
> - Add missing supply and gpio dt-bindings.
> bosch,bmc150
> - Harden against device reporting too large a FIFO sample count.
> - Use FIELD_PREP() / FIELD_GET() to improve readability.
> freescale,fxls8962af
> - Harden against device reporting too large a FIFO sample count.
> hid-sensors-*
> - Reorder probe to not expose userspace interfaces until the rest of
>   the setup is done to avoid potentially dropping data.
> honeywell,abp2030pa
> - Drop an unreachable return.
> invensens,icm45600
> - Harden against bad value of FIFO sample count from device.
> - Use i2c_match_data if firmware table sourced match data isn't available.
> nxp,mpl1115
> - Ensure runtime_pm is balanced on error in probe.
> rohm,bm1390
> - Make the driver slightly more likely to recover from transient errors.
> sensiron,sgp30
> - Handle thread creation errors.
> st,lsm6dsx
> - Update the enable mask when doing sensor fusion to avoid incorrect fifo
>   data handling.
> st,stm32-dfsdm
> - Treat dt flags as booleans.
> ti,ads1015
> - Switch to devm helpers which simplified code and closed a resource leak.
> ti,opt3001
> - Split complicated opt3001_get_processed() logic into irq an no irq
>   helper functions.
> - Use devm to simplify code.
> - Use guard() to simplify code.
> - Reorder probe so final call exposes userspace interfaces.
> - Various other more minor cleanup
> taos,tsl2772
> - Fix calibscale readback to check right channel type.
> taos,tsl2583
> - Use sysfs_emit() and sysfs_emit_at() to replace open coded equivalents.
>=20
> ----------------------------------------------------------------
> Aldo Conte (2):
>       iio: light: tcs3472: implement wait time and sampling frequency
>       iio: light: cm3323: use dev_err_probe() in probe path
>=20
> Amin GATTOUT (1):
>       iio: adc: at91_adc: use const char * for DT string property
>=20
> Anas Khan (2):
>       iio: backend: fix typos in comments
>       iio: imu: fix typos in comments
>=20
> Andy Shevchenko (2):
>       lib: kstrtox: Make _parse_integer() take variadic arguments
>       lib: vsprintf: use _parse_integer() instead of _parse_integer_limit=
()
>=20
> Angelo Dureghello (1):
>       iio: dac: add mcf54415 DAC
>=20
> Antoniu Miclaus (2):
>       dt-bindings: iio: adc: ad4080: add AD4883 support
>       iio: adc: ad4080: add support for AD4883
>=20
> Babanpreet Singh (2):
>       staging: iio: frequency: remove incorrect kernel-doc markings in dd=
s.h
>       iio: pressure: abp2030pa: Remove unreachable return in abp2_read_ra=
w()
>=20
> Bryam Vargas (3):
>       iio: accel: bmc150: clamp the device-reported FIFO frame count
>       iio: accel: fxls8962af: clamp the device-reported FIFO sample count
>       iio: imu: inv_icm45600: clamp the device-reported FIFO sample count
>=20
> Can Peng (1):
>       iio: pressure: mpl115: Fix runtime PM cleanup
>=20
> Chengrui Liu (1):
>       iio: light: tsl2583: migrate to sysfs_emit() and sysfs_emit_at()
>=20
> Chris Morgan (8):
>       dt-bindings: iio: imu: icm42600: Add mount-matrix
>       dt-bindings: iio: imu: icm42600: Add icm42607
>       iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
>       iio: imu: inv_icm42607: Add SPI For icm42607
>       iio: imu: inv_icm42607: Add PM support for icm42607
>       iio: imu: inv_icm42607: Add Accelerometer for icm42607
>       iio: imu: inv_icm42607: Add Gyroscope to icm42607
>       iio: imu: inv_icm42607: Add Temp Support in icm42607
>=20
> Colin Ian King (2):
>       iio: light: vcnl4000: make read-only const array regulator_names st=
atic
>       iio: adc: make read-only const array config static
>=20
> Daniel Schaefer (1):
>       iio: hid-sensor: als: scale each channel individually
>=20
> David Laight (1):
>       iio: test: Use strscpy() to copy the test description
>=20
> David Lechner (1):
>       iio: resolver: ad2s1210: refactor trigger handler
>=20
> David Lechner (TI) (8):
>       dt-bindings: iio: adc: add input-chopping property
>       dt-bindings: iio: adc: add ti,ads112c14
>       iio: adc: add ti-ads112c14 driver
>       iio: adc: ti-ads112c14: implement gain on internal short SYS_MON ch=
annel
>       iio: adc: ti-ads112c14: add measurement channel support
>       iio: adc: ti-ads112c14: add debugfs register access
>       iio: adc: ti-ads112c14: add support for I2C CRC8
>       iio: adc: ti-ads112c14: add support for buffered read
>=20
> Eduardo Guedes (1):
>       iio: frequency: adf4377: replace mutex_lock/unlock with guard(mutex=
)()
>=20
> Ethan Nelson-Moore (1):
>       iio: core: trigger: correct CONFIG_IIO_TRIGGER macro name in #endif=
 comment
>=20
> Francesco Lavra (1):
>       iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion
>=20
> Giorgi Tchankvetadze (1):
>       iio: light: cm32181: return zero after writing calibscale
>=20
> Hungyu Lin (3):
>       iio: magnetometer: bmc150: sort includes
>       iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
>       iio: imu: bmi323: remove unnecessary cast in watermark limit
>=20
> Jean-Baptiste Maneyrol (5):
>       iio: imu: inv_icm42600: reorder all driver headers
>       iio: imu: inv_icm42600: add buffer hwfifo watermark attributes
>       iio: inv_sensors: convert to kernel types
>       iio: inv_sensors: better timestamp alignment when using watermark
>       iio: inv_sensors: improve period measurement by using a longer delay
>=20
> Jonathan Cameron (2):
>       Merge branch 'iio-inkern-namespace-ib' into togreg
>       Merge tag 'v7.2-rc2' into togreg
>=20
> Jorijn van der Graaf (2):
>       dt-bindings: iio: magnetometer: add QST QMC6308
>       iio: magnetometer: add support for QST QMC6308
>=20
> Joshua Crofts (11):
>       iio: light: opt3001: move device registration to end of probe()
>       iio: light: opt3001: use local struct device and i2c_client variabl=
es
>       iio: light: opt3001: prefer dev_err_probe()
>       iio: light: opt3001: ensure correct parenthesis alignment
>       iio: light: opt3001: localize for loop iterator
>       iio: light: opt3001: move driver to guard(mutex)() use
>       iio: light: opt3001: switch driver to managed resources
>       iio: light: opt3001: add comment to mutex
>       iio: light: opt3001: split opt3001_get_processed() logic
>       dt-bindings: iio: dac: add support for mcp47a1
>       iio: dac: mcp47a1: add support for new device
>=20
> Kim Seer Paller (6):
>       iio: ABI: add DAC 10kohm_to_gnd powerdown mode
>       dt-bindings: iio: dac: add support for AD3532R/AD3532
>       iio: dac: ad3530r: Convert sw_ldac_trig_reg to a function pointer
>       iio: dac: ad3530r: Refactor setup to table-driven register banks
>       iio: dac: ad3530r: Make regmap_config selectable per chip
>       iio: dac: ad3530r: Add support for AD3532R/AD3532
>=20
> Krzysztof Kozlowski (1):
>       iio: adc: ade9000: Drop incorrect kerneldoc marker
>=20
> Kurt Borja (3):
>       dt-bindings: iio: adc: Add reference-sources property
>       dt-bindings: iio: adc: Add excitation current sources properties
>       dt-bindings: iio: adc: Add burn-out current properties
>=20
> Linmao Li (1):
>       iio: chemical: sgp30: Handle IAQ thread creation failure
>=20
> Manuel Ebner (1):
>       Documentation: ABI: testing: iio: minor cleanup
>=20
> Marcelo Schmitt (6):
>       dt-bindings: iio: adc: Add ltc2378
>       iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
>       iio: adc: ltc2378: Enable high-speed data capture
>       iio: adc: ltc2378: Enable triggered buffer data capture
>       iio: adc: ltc2378: Add support for LTC2338-18
>       iio: ABI: Encourage differential voltage ABI usage
>=20
> Maxwell Doose (2):
>       iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_ini=
t()
>       iio: Update email for Maxwell Doose
>=20
> Mert Seftali (1):
>       iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
>=20
> Miao Li (2):
>       iio: accel: stk8312: Update includes to match IWYU
>       iio: accel: stk8ba50: Update includes to match IWYU
>=20
> Moksh Panicker (2):
>       iio: adc: ad7779: Remove unused completion field
>       iio: adc: ad7779: Remove redundant dev_err_probe() after devm_reque=
st_irq()
>=20
> Nuno S=C3=A1 (1):
>       iio: buffer-dmaengine: Add support for cyclic DMA transfers
>=20
> Pan Chuang (14):
>       staging: iio: adt7316: Remove redundant dev_err()
>       iio: accel: Remove redundant dev_err()/dev_err_probe()
>       iio: addac: ad74413r: Remove redundant dev_err_probe()
>       iio: chemical: Remove redundant dev_err()/dev_err_probe()
>       iio: st_sensors: Remove redundant dev_err()
>       iio: gyro: adxrs290: Remove redundant dev_err_probe()
>       iio: health: Remove redundant dev_err()
>       iio: humidity: Remove redundant dev_err()/dev_err_probe()
>       iio: imu: Remove redundant dev_err()/dev_err_probe()
>       iio: magnetometer: Remove redundant dev_err()
>       iio: pressure: Remove redundant dev_err()/dev_err_probe()
>       iio: proximity: Remove redundant dev_err()/dev_err_probe()
>       iio: light: Remove redundant dev_err()/dev_err_probe()
>       iio: temperature: Remove redundant dev_err()/dev_err_probe()
>=20
> Pengpeng Hou (5):
>       iio: imu: inv_icm45600: Use I2C match data
>       iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
>       iio: imu: bmi270: add missing MODULE_DEVICE_TABLE()
>       iio: light: vcnl4035: Propagate regcache_sync() errors
>       iio: light: rpr0521: Propagate regcache_sync() errors
>=20
> Piyush Patle (7):
>       dt-bindings: iio: adc: hx711: add VSUP and DVDD supply properties
>       dt-bindings: iio: adc: hx711: add RATE GPIO property
>       iio: adc: hx711: introduce hx711_chip_info structure
>       iio: adc: hx711: pass trailing pulse count into hx711_read
>       iio: adc: hx711: split variable assignments in hx711_read and hx711=
_reset
>       iio: adc: hx711: localize loop iterators in hx711_read
>       iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
>=20
> Prashant Rahul (2):
>       iio: adc: ti-adc081c: use dev_err_probe() for probe time error
>       iio: adc: ti-adc084s021: use dev_err_probe for probe time error
>=20
> Radu Sabau (1):
>       iio: adc: ad_sigma_delta: allow COMPILE_TEST in isolation
>=20
> Rob Herring (Arm) (1):
>       iio: stm32-dfsdm: Treat flags as booleans
>=20
> Rodrigo Alencar (32):
>       dt-bindings: iio: frequency: add adf41513
>       lib: kstrtox: add initial value to _parse_integer_limit()
>       lib: kstrtox: add kstrtoudec64() and kstrtodec64()
>       lib: test-kstrtox: tests for kstrtodec64() and kstrtoudec64()
>       lib: math: div64: add div64_s64_rem()
>       iio: core: add decimal value formatting into 64-bit value
>       iio: test: iio-test-format: add test case for decimal format
>       iio: frequency: adf41513: driver implementation
>       iio: frequency: adf41513: handle LE synchronization feature
>       iio: frequency: adf41513: features on frequency change
>       docs: iio: add documentation for adf41513 driver
>       Documentation: ABI: testing: add common ABI file for iio/frequency
>       dt-bindings: iio: dac: ad5696: add reset/ldac/gain support
>       dt-bindings: iio: dac: ad5696: rework on power supplies
>       dt-bindings: iio: dac: ad5686: add reset/ldac/gain support
>       dt-bindings: iio: dac: ad5686: rework on power supplies
>       iio: dac: ad5686: add support for missing power supplies
>       iio: dac: ad5686: consume optional reset signal
>       iio: dac: ad5686: add ldac gpio
>       iio: dac: ad5686: missing NULL check on match data
>       iio: dac: ad5686: refactor command/data macros
>       iio: dac: ad5686: introduce sync operation
>       iio: dac: ad5686: implement new sync() op for the spi bus
>       iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
>       iio: dac: ad5686: add triggered buffer support
>       iio: dac: ad5686: add gain control support
>       dt-bindings: iio: dac: ad5696: add AD5673R/AD5677R support
>       iio: dac: ad5696: add AD5673R/AD5677R entries to of_match table
>       iio: dac: ad5686: refactor device list and file header comments
>       dt-bindings: iio: dac: ad5696: extend device support
>       dt-bindings: iio: dac: ad5686: extend device support
>       iio: dac: ad5686: extend device support with new parts
>=20
> Romain Gantois (2):
>       dt-bindings: iio: ti,tmp117: add binding for the TMP119
>       iio: inkern: Use namespaced exports
>=20
> Roman Vivchar (3):
>       dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6323 PMIC AUXA=
DC
>       iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC driver
>       iio: adc: mt6323: remove unused header
>=20
> Sai Krishna Potthuri (1):
>       MAINTAINERS: Update Xilinx AMS driver maintainers
>=20
> Salih Erim (5):
>       dt-bindings: iio: adc: add xlnx,versal-sysmon binding
>       iio: adc: add Versal SysMon driver
>       iio: adc: versal-sysmon: add I2C driver
>       iio: adc: versal-sysmon: add threshold event support
>       iio: adc: versal-sysmon: add oversampling support
>=20
> Sang-Heon Jeon (9):
>       iio: light: isl29028: return zero in write_raw() on success
>       iio: light: tsl2583: return zero in write_raw() on success
>       iio: light: isl29028: remove isl29028_set_pm_runtime_busy() helper
>       iio: light: tsl2583: remove tsl2583_set_pm_runtime_busy() helper
>       iio: light: vcnl4035: remove vcnl4035_set_pm_runtime_state() helper
>       iio: light: vcnl4000: remove vcnl4000_set_pm_runtime_state() helper
>       iio: adc: rcar-gyroadc: remove rcar_gyroadc_set_power() helper
>       iio: light: tsl2583: remove conditional return with no effect
>       iio: magnetometer: ak8974: remove conditional return with no effect
>=20
> Sanjay Chitroda (25):
>       iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
>       iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
>       iio: light: hid-sensor-als: use u32 instead of unsigned
>       iio: light: hid-sensor-prox: use u32 instead of unsigned
>       iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
>       iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
>       iio: pressure: hid-sensor-press: use u32 instead of unsigned
>       iio: todo: fix typo and refine resource management items
>       iio: hid-sensor-temperature: use u32 instead of unsigned int
>       iio: hid-sensor-humidity: use u32 instead of unsigned int
>       iio: hid-sensor-custom-intel-hinge: use u32 instead of unsigned int
>       iio: humidity: hid-sensor-humidity: use common device for devres
>       iio: position: hid-sensor-custom-intel-hinge: use common device for=
 devres
>       iio: temperature: hid-sensor-temperature: use common device for dev=
res
>       iio: hid-sensors: add/remove blank line
>       iio: orientation: hid-sensor-rotation: Avoid race between callback =
setup and device exposure
>       iio: orientation: hid-sensor-incl-3d: Avoid race between callback s=
etup and device exposure
>       iio: gyro: hid-sensor-gyro-3d: Avoid race between callback setup an=
d device exposure
>       iio: pressure: hid-sensor-press: Avoid race between callback setup =
and device exposure
>       iio: light: hid-sensor-prox: Avoid race between callback setup and =
device exposure
>       iio: light: hid-sensor-als: Avoid race between callback setup and d=
evice exposure
>       iio: magnetometer: hid-sensor-magn-3d: Avoid race between callback =
setup and device exposure
>       iio: accel: hid-sensor-accel-3d: Avoid race between callback setup =
and device exposure
>       iio: hid-sensors: align function parenthesis for readability
>       iio: hid-sensors: Use implicit NULL pointer checks
>=20
> Simon Glass (1):
>       dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible
>=20
> Siratul Islam (6):
>       iio: proximity: sort the register values for vl53l1x-i2c
>       iio: proximity: cleanup fixes for vl53l1x-i2c
>       dt-bindings: add entry for qstcorp
>       dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
>       iio: magnetometer: add driver for QST QMC5883L Sensor
>       iio: update email for Siratul Islam
>=20
> Stepan Ionichev (2):
>       iio: pressure: rohm-bm1390: harden trigger handler against transien=
t errors
>       iio: adc: ti-ads1015: use devm helpers to fix probe error paths
>=20
> Tomasz Duszynski (4):
>       mailmap: add email mapping for Tomasz Duszynski
>       iio: chemical: sps30: update email for Tomasz Duszynski
>       iio: chemical: scd30: update email for Tomasz Duszynski
>       dt-bindings: iio: scd30: update maintainers field
>=20
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (12):
>       iio: Initialize i2c_device_id arrays using member names (part 2)
>       iio: adc: max1241: Simplify device abstraction
>       iio: dac: max5522: Simplify device abstraction
>       iio: frequency: ad9523: Simplify driver a bit
>       iio: magnetometer: hmc5843: Simplify device abstraction
>       iio: accel: bmc150: Explicitly set spi .driver_data
>       iio: Drop unused assignment of spi_device_id driver data
>       iio: Initialize spi_device_id arrays using member names
>       staging: iio: Drop unused assignment of spi_device_id driver data
>       staging: iio: Initialize spi_device_id arrays using member names
>       iio: adc: ti-tsc2046: Simplify device handling
>       iio: imu: adis16550: Simplify device abstraction
>=20
> Vojt=C4=9Bch Kr=C3=A1tk=C3=BD (2):
>       iio: resolver: ad2s1200: use dev_err_probe()
>       iio: chemical: bme680: Use dev_err_probe()
>=20
> Wadim Mueller (4):
>       iio: types: add IIO_VOLUMEFLOW channel type
>       dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
>       iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
>       iio: flow: add Sensirion SLF3S liquid flow sensor driver
>=20
> Wil Stark (1):
>       iio: temperature: tmp117: add TI TMP119 support
>=20
> Xiaofeng Yuan (1):
>       staging: iio: frequency: reorder dds.h macro parameters to match II=
O convention
>=20
> Yahya Toubali (1):
>       dt-bindings: iio: dac: fix spelling of 'reference' in adi,ad5791
>=20
> Yash Suthar (1):
>       iio: pressure: bmp280: return on runtime PM resume failure
>=20
> Yuanshen Cao (1):
>       iio: light: tsl2772: fix ALS calibscale readback
>=20
>  .mailmap                                           |    2 +
>  Documentation/ABI/testing/sysfs-bus-iio            |   31 +-
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |    2 +-
>  Documentation/ABI/testing/sysfs-bus-iio-flow       |   21 +
>  Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
>  .../ABI/testing/sysfs-bus-iio-frequency-adf4350    |   10 -
>  Documentation/devicetree/bindings/iio/adc/adc.yaml |   41 +
>  .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |    2 +
>  .../devicetree/bindings/iio/adc/adi,ltc2378.yaml   |  170 +++
>  .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   21 +
>  .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |    3 +-
>  .../bindings/iio/adc/rockchip-saradc.yaml          |    4 +-
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  219 +++
>  .../bindings/iio/adc/xlnx,versal-sysmon.yaml       |  154 +++
>  .../bindings/iio/chemical/sensirion,scd30.yaml     |    3 +-
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |   16 +-
>  .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |   86 +-
>  .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |   79 +-
>  .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |    4 +-
>  .../bindings/iio/dac/microchip,mcp47a1.yaml        |   50 +
>  .../bindings/iio/flow/sensirion,slf3s.yaml         |   55 +
>  .../bindings/iio/frequency/adi,adf41513.yaml       |  227 +++
>  .../bindings/iio/imu/invensense,icm42600.yaml      |   20 +-
>  .../iio/magnetometer/qstcorp,qmc5883l.yaml         |   52 +
>  .../bindings/iio/magnetometer/qstcorp,qmc6308.yaml |   47 +
>  .../bindings/iio/proximity/st,vl53l0x.yaml         |    2 +-
>  .../bindings/iio/temperature/ti,tmp117.yaml        |   16 +-
>  .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
>  Documentation/iio/adf41513.rst                     |  199 +++
>  Documentation/iio/index.rst                        |    1 +
>  MAINTAINERS                                        |   74 +-
>  drivers/extcon/extcon-adc-jack.c                   |    1 +
>  drivers/hwmon/iio_hwmon.c                          |    1 +
>  drivers/hwmon/ntc_thermistor.c                     |    1 +
>  drivers/iio/Kconfig                                |    1 +
>  drivers/iio/Makefile                               |    1 +
>  drivers/iio/TODO                                   |   13 +-
>  drivers/iio/accel/adxl345_spi.c                    |    4 +-
>  drivers/iio/accel/adxl355_core.c                   |    3 +-
>  drivers/iio/accel/adxl355_spi.c                    |    4 +-
>  drivers/iio/accel/adxl367.c                        |    2 +-
>  drivers/iio/accel/adxl367_spi.c                    |    2 +-
>  drivers/iio/accel/adxl372_spi.c                    |    4 +-
>  drivers/iio/accel/adxl380_spi.c                    |    8 +-
>  drivers/iio/accel/bma180.c                         |    4 +-
>  drivers/iio/accel/bma220_core.c                    |    3 +-
>  drivers/iio/accel/bma220_spi.c                     |    2 +-
>  drivers/iio/accel/bma400_core.c                    |    3 +-
>  drivers/iio/accel/bma400_spi.c                     |    2 +-
>  drivers/iio/accel/bmc150-accel-core.c              |    6 +-
>  drivers/iio/accel/bmc150-accel-spi.c               |   18 +-
>  drivers/iio/accel/bmi088-accel-spi.c               |    6 +-
>  drivers/iio/accel/dmard09.c                        |    7 +
>  drivers/iio/accel/fxls8962af-core.c                |    2 +
>  drivers/iio/accel/fxls8962af-spi.c                 |    4 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c            |   68 +-
>  drivers/iio/accel/kionix-kx022a.c                  |    2 +-
>  drivers/iio/accel/kxsd9-spi.c                      |    2 +-
>  drivers/iio/accel/mma7455_spi.c                    |    4 +-
>  drivers/iio/accel/mma9551.c                        |    4 +-
>  drivers/iio/accel/mma9553.c                        |    5 +-
>  drivers/iio/accel/msa311.c                         |    2 +-
>  drivers/iio/accel/mxc4005.c                        |    5 +-
>  drivers/iio/accel/sca3000.c                        |    8 +-
>  drivers/iio/accel/sca3300.c                        |    4 +-
>  drivers/iio/accel/st_accel_spi.c                   |   40 +-
>  drivers/iio/accel/stk8312.c                        |   17 +-
>  drivers/iio/accel/stk8ba50.c                       |   14 +-
>  drivers/iio/adc/88pm886-gpadc.c                    |    2 +-
>  drivers/iio/adc/Kconfig                            |   78 +-
>  drivers/iio/adc/Makefile                           |    6 +
>  drivers/iio/adc/ad4000.c                           |   62 +-
>  drivers/iio/adc/ad4030.c                           |   14 +-
>  drivers/iio/adc/ad4080.c                           |   40 +-
>  drivers/iio/adc/ad4130.c                           |   12 +-
>  drivers/iio/adc/ad4134.c                           |    2 +-
>  drivers/iio/adc/ad4170-4.c                         |    6 +-
>  drivers/iio/adc/ad4851.c                           |   18 +-
>  drivers/iio/adc/ad7091r8.c                         |    6 +-
>  drivers/iio/adc/ad7124.c                           |    4 +-
>  drivers/iio/adc/ad7173.c                           |   26 +-
>  drivers/iio/adc/ad7191.c                           |    2 +-
>  drivers/iio/adc/ad7192.c                           |   10 +-
>  drivers/iio/adc/ad7266.c                           |    4 +-
>  drivers/iio/adc/ad7280a.c                          |    2 +-
>  drivers/iio/adc/ad7292.c                           |    2 +-
>  drivers/iio/adc/ad7298.c                           |    2 +-
>  drivers/iio/adc/ad7380.c                           |   36 +-
>  drivers/iio/adc/ad7476.c                           |   60 +-
>  drivers/iio/adc/ad7606_spi.c                       |   22 +-
>  drivers/iio/adc/ad7766.c                           |   12 +-
>  drivers/iio/adc/ad7768-1.c                         |    8 +-
>  drivers/iio/adc/ad7779.c                           |    6 +-
>  drivers/iio/adc/ad7780.c                           |    8 +-
>  drivers/iio/adc/ad7791.c                           |   10 +-
>  drivers/iio/adc/ad7793.c                           |   18 +-
>  drivers/iio/adc/ad7887.c                           |    2 +-
>  drivers/iio/adc/ad7923.c                           |   14 +-
>  drivers/iio/adc/ad7944.c                           |    6 +-
>  drivers/iio/adc/ad7949.c                           |    6 +-
>  drivers/iio/adc/ad9467.c                           |   14 +-
>  drivers/iio/adc/ade9000.c                          |    4 +-
>  drivers/iio/adc/at91_adc.c                         |    4 +-
>  drivers/iio/adc/envelope-detector.c                |    1 +
>  drivers/iio/adc/hi8435.c                           |    2 +-
>  drivers/iio/adc/hx711.c                            |   98 +-
>  drivers/iio/adc/ltc2378.c                          |  857 ++++++++++++
>  drivers/iio/adc/max1027.c                          |   12 +-
>  drivers/iio/adc/max1118.c                          |    6 +-
>  drivers/iio/adc/max11205.c                         |    4 +-
>  drivers/iio/adc/max11410.c                         |    2 +-
>  drivers/iio/adc/max1241.c                          |    9 +-
>  drivers/iio/adc/max14001.c                         |    4 +-
>  drivers/iio/adc/mcp320x.c                          |   26 +-
>  drivers/iio/adc/mcp3564.c                          |   24 +-
>  drivers/iio/adc/mcp3911.c                          |   14 +-
>  drivers/iio/adc/mt6323-auxadc.c                    |  313 +++++
>  drivers/iio/adc/rcar-gyroadc.c                     |   14 +-
>  drivers/iio/adc/rohm-bd79112.c                     |    2 +-
>  drivers/iio/adc/rtq6056.c                          |    4 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c                  |   12 +-
>  drivers/iio/adc/ti-adc081c.c                       |    6 +-
>  drivers/iio/adc/ti-adc0832.c                       |    8 +-
>  drivers/iio/adc/ti-adc084s021.c                    |    8 +-
>  drivers/iio/adc/ti-adc108s102.c                    |    2 +-
>  drivers/iio/adc/ti-adc12138.c                      |    6 +-
>  drivers/iio/adc/ti-adc128s052.c                    |   24 +-
>  drivers/iio/adc/ti-adc161s626.c                    |    4 +-
>  drivers/iio/adc/ti-ads1015.c                       |   44 +-
>  drivers/iio/adc/ti-ads1018.c                       |    4 +-
>  drivers/iio/adc/ti-ads112c14.c                     | 1454 ++++++++++++++=
++++++
>  drivers/iio/adc/ti-ads124s08.c                     |    4 +-
>  drivers/iio/adc/ti-ads1298.c                       |    2 +-
>  drivers/iio/adc/ti-ads131e08.c                     |    6 +-
>  drivers/iio/adc/ti-ads131m02.c                     |   10 +-
>  drivers/iio/adc/ti-ads7950.c                       |   24 +-
>  drivers/iio/adc/ti-ads8688.c                       |    4 +-
>  drivers/iio/adc/ti-lmp92064.c                      |    2 +-
>  drivers/iio/adc/ti-tlc4541.c                       |    4 +-
>  drivers/iio/adc/ti-tsc2046.c                       |   25 +-
>  drivers/iio/adc/versal-sysmon-core.c               | 1052 ++++++++++++++
>  drivers/iio/adc/versal-sysmon-i2c.c                |  134 ++
>  drivers/iio/adc/versal-sysmon.c                    |   92 ++
>  drivers/iio/adc/versal-sysmon.h                    |  120 ++
>  drivers/iio/addac/ad74115.c                        |    2 +-
>  drivers/iio/addac/ad74413r.c                       |    2 +-
>  drivers/iio/afe/iio-rescale.c                      |    1 +
>  drivers/iio/amplifiers/ad8366.c                    |   26 +-
>  drivers/iio/amplifiers/ada4250.c                   |    2 +-
>  drivers/iio/buffer/industrialio-buffer-cb.c        |    1 +
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |   42 +-
>  drivers/iio/buffer/industrialio-hw-consumer.c      |    1 +
>  drivers/iio/chemical/bme680_i2c.c                  |    7 +-
>  drivers/iio/chemical/bme680_spi.c                  |    9 +-
>  drivers/iio/chemical/ccs811.c                      |    4 +-
>  drivers/iio/chemical/ens160_core.c                 |    2 +-
>  drivers/iio/chemical/ens160_spi.c                  |    2 +-
>  drivers/iio/chemical/scd30_core.c                  |   12 +-
>  drivers/iio/chemical/scd30_i2c.c                   |    4 +-
>  drivers/iio/chemical/scd30_serial.c                |    4 +-
>  drivers/iio/chemical/sgp30.c                       |    3 +
>  drivers/iio/chemical/sps30_i2c.c                   |    4 +-
>  drivers/iio/chemical/sps30_serial.c                |    4 +-
>  .../iio/common/hid-sensors/hid-sensor-attributes.c |   81 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |    7 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |    2 +-
>  .../iio/common/inv_sensors/inv_sensors_timestamp.c |  109 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
>  drivers/iio/dac/Kconfig                            |   61 +-
>  drivers/iio/dac/Makefile                           |    2 +
>  drivers/iio/dac/ad3530r.c                          |  359 ++++-
>  drivers/iio/dac/ad5064.c                           |   32 +-
>  drivers/iio/dac/ad5360.c                           |   16 +-
>  drivers/iio/dac/ad5380.c                           |   32 +-
>  drivers/iio/dac/ad5446-spi.c                       |   62 +-
>  drivers/iio/dac/ad5449.c                           |   14 +-
>  drivers/iio/dac/ad5504.c                           |    4 +-
>  drivers/iio/dac/ad5624r_spi.c                      |   12 +-
>  drivers/iio/dac/ad5686-spi.c                       |  165 ++-
>  drivers/iio/dac/ad5686.c                           |  307 ++++-
>  drivers/iio/dac/ad5686.h                           |   63 +-
>  drivers/iio/dac/ad5696-i2c.c                       |   32 +-
>  drivers/iio/dac/ad5706r.c                          |    2 +-
>  drivers/iio/dac/ad5755.c                           |   10 +-
>  drivers/iio/dac/ad5758.c                           |    2 +-
>  drivers/iio/dac/ad5761.c                           |    8 +-
>  drivers/iio/dac/ad5764.c                           |    8 +-
>  drivers/iio/dac/ad5766.c                           |    4 +-
>  drivers/iio/dac/ad5770r.c                          |    2 +-
>  drivers/iio/dac/ad5791.c                           |   10 +-
>  drivers/iio/dac/ad7293.c                           |    2 +-
>  drivers/iio/dac/ad7303.c                           |    2 +-
>  drivers/iio/dac/ad8460.c                           |    1 +
>  drivers/iio/dac/ad8801.c                           |    4 +-
>  drivers/iio/dac/ad9739a.c                          |    2 +-
>  drivers/iio/dac/dpot-dac.c                         |    1 +
>  drivers/iio/dac/ltc1660.c                          |    4 +-
>  drivers/iio/dac/ltc2632.c                          |   44 +-
>  drivers/iio/dac/ltc2664.c                          |    4 +-
>  drivers/iio/dac/ltc2688.c                          |    2 +-
>  drivers/iio/dac/max22007.c                         |    2 +-
>  drivers/iio/dac/max5522.c                          |   31 +-
>  drivers/iio/dac/mcf54415_dac.c                     |  180 +++
>  drivers/iio/dac/mcp47a1.c                          |  166 +++
>  drivers/iio/dac/mcp4821.c                          |   12 +-
>  drivers/iio/dac/mcp4922.c                          |    8 +-
>  drivers/iio/dac/rohm-bd79703.c                     |    8 +-
>  drivers/iio/dac/ti-dac082s085.c                    |   12 +-
>  drivers/iio/dac/ti-dac7311.c                       |    6 +-
>  drivers/iio/dac/ti-dac7612.c                       |    2 +-
>  drivers/iio/filter/admv8818.c                      |    2 +-
>  drivers/iio/flow/Kconfig                           |   22 +
>  drivers/iio/flow/Makefile                          |    7 +
>  drivers/iio/flow/slf3s.c                           |  542 ++++++++
>  drivers/iio/frequency/Kconfig                      |   10 +
>  drivers/iio/frequency/Makefile                     |    1 +
>  drivers/iio/frequency/ad9523.c                     |    3 +-
>  drivers/iio/frequency/adf41513.c                   | 1246 ++++++++++++++=
+++
>  drivers/iio/frequency/adf4350.c                    |    4 +-
>  drivers/iio/frequency/adf4371.c                    |    4 +-
>  drivers/iio/frequency/adf4377.c                    |   85 +-
>  drivers/iio/frequency/admv1013.c                   |    2 +-
>  drivers/iio/frequency/admv1014.c                   |    2 +-
>  drivers/iio/frequency/adrf6780.c                   |    2 +-
>  drivers/iio/gyro/adis16080.c                       |    4 +-
>  drivers/iio/gyro/adis16136.c                       |    8 +-
>  drivers/iio/gyro/adis16260.c                       |   12 +-
>  drivers/iio/gyro/adxrs290.c                        |    5 +-
>  drivers/iio/gyro/adxrs450.c                        |    4 +-
>  drivers/iio/gyro/bmg160_spi.c                      |    7 +-
>  drivers/iio/gyro/fxas21002c_spi.c                  |    2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |   57 +-
>  drivers/iio/gyro/st_gyro_spi.c                     |   18 +-
>  drivers/iio/health/afe4403.c                       |    6 +-
>  drivers/iio/health/afe4404.c                       |    4 +-
>  drivers/iio/health/max30100.c                      |    4 +-
>  drivers/iio/health/max30102.c                      |    4 +-
>  drivers/iio/humidity/hdc3020.c                     |    3 +-
>  drivers/iio/humidity/hid-sensor-humidity.c         |   35 +-
>  drivers/iio/humidity/hts221_buffer.c               |    5 +-
>  drivers/iio/humidity/hts221_spi.c                  |    2 +-
>  drivers/iio/iio_core_trigger.h                     |    2 +-
>  drivers/iio/imu/Kconfig                            |    1 +
>  drivers/iio/imu/Makefile                           |    1 +
>  drivers/iio/imu/adis16400.c                        |   30 +-
>  drivers/iio/imu/adis16460.c                        |    2 +-
>  drivers/iio/imu/adis16475.c                        |   54 +-
>  drivers/iio/imu/adis16480.c                        |   44 +-
>  drivers/iio/imu/adis16550.c                        |   89 +-
>  drivers/iio/imu/bmi160/bmi160_core.c               |    2 +-
>  drivers/iio/imu/bmi160/bmi160_spi.c                |    4 +-
>  drivers/iio/imu/bmi270/bmi270_core.c               |    2 +-
>  drivers/iio/imu/bmi270/bmi270_spi.c                |    5 +-
>  drivers/iio/imu/bmi323/bmi323_core.c               |    4 +-
>  drivers/iio/imu/bmi323/bmi323_spi.c                |    2 +-
>  drivers/iio/imu/fxos8700_core.c                    |    2 +-
>  drivers/iio/imu/fxos8700_spi.c                     |    2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   10 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   18 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   45 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |    3 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   12 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   16 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    6 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   20 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    3 +-
>  drivers/iio/imu/inv_icm42607/Kconfig               |   30 +
>  drivers/iio/imu/inv_icm42607/Makefile              |   13 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h        |  421 ++++++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  |  316 +++++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   |  702 ++++++++++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   |  313 +++++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |   97 ++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c    |  107 ++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c   |   99 ++
>  drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h   |   38 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        |    2 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c |    7 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   |    2 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |    2 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    |   16 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |    4 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   34 +-
>  drivers/iio/imu/smi240.c                           |    2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    5 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c     |    5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   48 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    4 +-
>  drivers/iio/industrialio-backend.c                 |    8 +-
>  drivers/iio/industrialio-core.c                    |   52 +-
>  drivers/iio/inkern.c                               |   54 +-
>  drivers/iio/light/adux1020.c                       |    4 +-
>  drivers/iio/light/apds9160.c                       |    7 +-
>  drivers/iio/light/apds9300.c                       |    4 +-
>  drivers/iio/light/apds9306.c                       |    3 +-
>  drivers/iio/light/apds9960.c                       |    4 +-
>  drivers/iio/light/bh1745.c                         |    3 +-
>  drivers/iio/light/cm32181.c                        |    2 +-
>  drivers/iio/light/cm3323.c                         |   17 +-
>  drivers/iio/light/cm3605.c                         |    5 +-
>  drivers/iio/light/gp2ap002.c                       |    5 +-
>  drivers/iio/light/hid-sensor-als.c                 |   74 +-
>  drivers/iio/light/hid-sensor-prox.c                |   49 +-
>  drivers/iio/light/isl29028.c                       |   22 +-
>  drivers/iio/light/ltr390.c                         |    3 +-
>  drivers/iio/light/ltr501.c                         |    5 +-
>  drivers/iio/light/opt3001.c                        |  539 ++++----
>  drivers/iio/light/opt4060.c                        |    2 +-
>  drivers/iio/light/rpr0521.c                        |   10 +-
>  drivers/iio/light/si1145.c                         |    4 +-
>  drivers/iio/light/st_uvis25_core.c                 |    5 +-
>  drivers/iio/light/st_uvis25_spi.c                  |    2 +-
>  drivers/iio/light/stk3310.c                        |    5 +-
>  drivers/iio/light/tcs3472.c                        |  319 ++++-
>  drivers/iio/light/tsl2563.c                        |    2 +-
>  drivers/iio/light/tsl2583.c                        |   44 +-
>  drivers/iio/light/tsl2772.c                        |    7 +-
>  drivers/iio/light/vcnl4000.c                       |   16 +-
>  drivers/iio/light/vcnl4035.c                       |   23 +-
>  drivers/iio/light/veml6030.c                       |    4 +-
>  drivers/iio/light/vl6180.c                         |    2 +-
>  drivers/iio/magnetometer/Kconfig                   |   22 +
>  drivers/iio/magnetometer/Makefile                  |    3 +
>  drivers/iio/magnetometer/ak8974.c                  |   11 +-
>  drivers/iio/magnetometer/bmc150_magn.c             |   50 +-
>  drivers/iio/magnetometer/bmc150_magn_spi.c         |    6 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   73 +-
>  drivers/iio/magnetometer/hmc5843_spi.c             |    6 +-
>  drivers/iio/magnetometer/mmc5983.c                 |    2 +-
>  drivers/iio/magnetometer/qmc5883l.c                |  516 +++++++
>  drivers/iio/magnetometer/qmc6308.c                 |  601 ++++++++
>  drivers/iio/magnetometer/rm3100-core.c             |    4 +-
>  drivers/iio/magnetometer/st_magn_spi.c             |   12 +-
>  drivers/iio/multiplexer/iio-mux.c                  |    1 +
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |   55 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |   48 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |   19 +-
>  drivers/iio/potentiometer/max5481.c                |    8 +-
>  drivers/iio/potentiometer/max5487.c                |    6 +-
>  drivers/iio/potentiometer/mcp41010.c               |   12 +-
>  drivers/iio/potentiometer/mcp4131.c                |  128 +-
>  drivers/iio/potentiometer/x9250.c                  |    4 +-
>  drivers/iio/potentiostat/lmp91000.c                |    1 +
>  drivers/iio/pressure/abp2030pa.c                   |    1 -
>  drivers/iio/pressure/abp2030pa_spi.c               |    2 +-
>  drivers/iio/pressure/bmp280-core.c                 |   34 +-
>  drivers/iio/pressure/bmp280-spi.c                  |   14 +-
>  drivers/iio/pressure/dlhl60d.c                     |    4 +-
>  drivers/iio/pressure/hid-sensor-press.c            |   57 +-
>  drivers/iio/pressure/hsc030pa_spi.c                |    2 +-
>  drivers/iio/pressure/mpl115.c                      |   11 +-
>  drivers/iio/pressure/mpl115_spi.c                  |    2 +-
>  drivers/iio/pressure/mprls0025pa_spi.c             |    2 +-
>  drivers/iio/pressure/ms5611_spi.c                  |    4 +-
>  drivers/iio/pressure/rohm-bm1390.c                 |   25 +-
>  drivers/iio/pressure/st_pressure_spi.c             |   24 +-
>  drivers/iio/pressure/zpa2326.c                     |    5 +-
>  drivers/iio/pressure/zpa2326_spi.c                 |    2 +-
>  drivers/iio/proximity/as3935.c                     |    6 +-
>  drivers/iio/proximity/d3323aa.c                    |    2 +-
>  drivers/iio/proximity/hx9023s.c                    |    2 +-
>  drivers/iio/proximity/irsd200.c                    |    2 +-
>  drivers/iio/proximity/mb1232.c                     |    4 +-
>  drivers/iio/proximity/srf04.c                      |    4 +-
>  drivers/iio/proximity/sx_common.c                  |    2 +-
>  drivers/iio/proximity/vcnl3020.c                   |    6 +-
>  drivers/iio/proximity/vl53l0x-i2c.c                |    4 +-
>  drivers/iio/proximity/vl53l1x-i2c.c                |   43 +-
>  drivers/iio/resolver/ad2s1200.c                    |   20 +-
>  drivers/iio/resolver/ad2s1210.c                    |   32 +-
>  drivers/iio/resolver/ad2s90.c                      |    2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c   |   34 +-
>  drivers/iio/temperature/ltc2983.c                  |   12 +-
>  drivers/iio/temperature/max31856.c                 |    2 +-
>  drivers/iio/temperature/max31865.c                 |    2 +-
>  drivers/iio/temperature/maxim_thermocouple.c       |   18 +-
>  drivers/iio/temperature/tmp007.c                   |    4 +-
>  drivers/iio/temperature/tmp117.c                   |   13 +
>  drivers/iio/test/iio-test-format.c                 |   97 +-
>  drivers/iio/test/iio-test-rescale.c                |    2 +-
>  drivers/input/joystick/adc-joystick.c              |    1 +
>  drivers/input/keyboard/adc-keys.c                  |    1 +
>  drivers/input/touchscreen/colibri-vf50-ts.c        |    1 +
>  drivers/input/touchscreen/resistive-adc-touch.c    |    1 +
>  drivers/phy/motorola/phy-cpcap-usb.c               |    1 +
>  drivers/power/supply/ab8500_btemp.c                |    1 +
>  drivers/power/supply/ab8500_charger.c              |    1 +
>  drivers/power/supply/ab8500_fg.c                   |    1 +
>  drivers/power/supply/axp20x_ac_power.c             |    1 +
>  drivers/power/supply/axp20x_battery.c              |    1 +
>  drivers/power/supply/axp20x_usb_power.c            |    1 +
>  drivers/power/supply/axp288_fuel_gauge.c           |    1 +
>  drivers/power/supply/cpcap-battery.c               |    1 +
>  drivers/power/supply/cpcap-charger.c               |    1 +
>  drivers/power/supply/da9150-charger.c              |    1 +
>  drivers/power/supply/generic-adc-battery.c         |    1 +
>  drivers/power/supply/ingenic-battery.c             |    1 +
>  drivers/power/supply/intel_dc_ti_battery.c         |    1 +
>  drivers/power/supply/lego_ev3_battery.c            |    1 +
>  drivers/power/supply/lp8788-charger.c              |    1 +
>  drivers/power/supply/max17040_battery.c            |    1 +
>  drivers/power/supply/mp2629_charger.c              |    1 +
>  drivers/power/supply/mt6370-charger.c              |    1 +
>  drivers/power/supply/qcom_smbx.c                   |    1 +
>  drivers/power/supply/rn5t618_power.c               |    1 +
>  drivers/power/supply/rx51_battery.c                |    1 +
>  drivers/power/supply/sc27xx_fuel_gauge.c           |    1 +
>  drivers/power/supply/twl4030_charger.c             |    1 +
>  drivers/power/supply/twl4030_madc_battery.c        |    1 +
>  drivers/power/supply/twl6030_charger.c             |    1 +
>  drivers/staging/iio/adc/ad7816.c                   |    6 +-
>  drivers/staging/iio/addac/adt7316-spi.c            |   13 +-
>  drivers/staging/iio/addac/adt7316.c                |    5 +-
>  drivers/staging/iio/frequency/ad9832.c             |   24 +-
>  drivers/staging/iio/frequency/ad9834.c             |   30 +-
>  drivers/staging/iio/frequency/dds.h                |   50 +-
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |    1 +
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |    1 +
>  drivers/thermal/renesas/rzg3s_thermal.c            |    1 +
>  drivers/thermal/thermal-generic-adc.c              |    1 +
>  .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |   24 +
>  include/linux/iio/common/inv_sensors_timestamp.h   |   40 +-
>  include/linux/iio/types.h                          |   21 +
>  include/linux/kstrtox.h                            |    3 +
>  include/linux/math64.h                             |   18 +
>  include/uapi/linux/iio/types.h                     |    1 +
>  lib/kstrtox.c                                      |  115 +-
>  lib/kstrtox.h                                      |   17 +-
>  lib/math/div64.c                                   |   15 +
>  lib/math/test_mul_u64_u64_div_u64.c                |    1 +
>  lib/test-kstrtox.c                                 |  182 +++
>  lib/vsprintf.c                                     |    2 +-
>  sound/soc/codecs/audio-iio-aux.c                   |    1 +
>  sound/soc/samsung/aries_wm8994.c                   |    1 +
>  sound/soc/samsung/midas_wm1811.c                   |    1 +
>  sound/soc/stm/stm32_adfsdm.c                       |    1 +
>  tools/iio/iio_event_monitor.c                      |    2 +
>  437 files changed, 15104 insertions(+), 2563 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378=
.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads112c1=
4.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal=
-sysmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,m=
cp47a1.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,=
slf3s.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
df41513.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qs=
tcorp,qmc5883l.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qs=
tcorp,qmc6308.yaml
>  create mode 100644 Documentation/iio/adf41513.rst
>  create mode 100644 drivers/iio/adc/ltc2378.c
>  create mode 100644 drivers/iio/adc/mt6323-auxadc.c
>  create mode 100644 drivers/iio/adc/ti-ads112c14.c
>  create mode 100644 drivers/iio/adc/versal-sysmon-core.c
>  create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
>  create mode 100644 drivers/iio/adc/versal-sysmon.c
>  create mode 100644 drivers/iio/adc/versal-sysmon.h
>  create mode 100644 drivers/iio/dac/mcf54415_dac.c
>  create mode 100644 drivers/iio/dac/mcp47a1.c
>  create mode 100644 drivers/iio/flow/Kconfig
>  create mode 100644 drivers/iio/flow/Makefile
>  create mode 100644 drivers/iio/flow/slf3s.c
>  create mode 100644 drivers/iio/frequency/adf41513.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
>  create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
>  create mode 100644 drivers/iio/magnetometer/qmc5883l.c
>  create mode 100644 drivers/iio/magnetometer/qmc6308.c
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
>=20

