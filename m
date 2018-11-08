Return-Path: <SRS0=04kl=NT=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	preid@electromag.com.au,
	himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v6 0/3] Add support for PNI RM3100 magnetometer
Date: Thu,  8 Nov 2018 17:27:46 +0800
Message-Id: <20181108092749.12167-1-songqiang1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

The next 3 patches do the following:
 - The first patch adds PNI Sensor Corporation to the vendor prefix list.
 - The second patch adds devicetree binding for RM3100 magnetometer.
 - The third patch adds the driver for RM3100 magnetometer.

 -- Song Qiang

Changes in v6:
 - Add data shift for case BIT(0) | BIT(2) in irq handler.
 - Use different memcpy for different cases.
 - Move init_completion before devm_request_threaded_irq to prevent
   using completion before init.
 - Fix some style issues.

Changes in v5:
 - Fix a bug about checking if completion is timed out. Used to check if
   ret < 0.
 - Add INDIO_BUFFER_TRIGGERED to indio_dev->modes.
 - Add init mode 'INDIO_DIRECT_MODE'. 
 - Remove case 0 in trigger handler.
 - store scale value directly instead of store cycle_count_index and search for scale value.
 - Fix the bug of restarting all channels in rm3100_set_sample_freq.
 - Replace 4 in rm3100_buffer_preenable with define 'RM3100_CMM_AXIS_SHIFT'
 - Replace timestamp of trigger_hanlder to use iio_pollfunc_store_time.
 - Remove rm3100_remove.
 - Replace 3 seconds timeout time with double conversions time.
 - Read all 3 axis in case BIT(0) | BIT(2) instead of reading each of them independently.
 - Remove i2c_check_functionality since regmap_get_i2c_bus already checks it.

Changes in v4:
 - Fix a bug about regmap_range configurations.
 - Add DRDY trigger support.
 - Change DRDY interrupt trigger source from RISING to HIGH.
 - Add a thread function to clear the interrupt.
 - Change the logic of one-shot read from waiting next continuous ends to
   writing to POLL register and waiting conversion ends.
 - Add iio_buffer_setup_ops to enable continuous conversion only when
   buffer is enabled.
 - Add active_scan_mask check in continuous conversions.
 - Remove *wait_measurement() in *trigger_handler().

Changes in v3:
 - Change PNI to PNI Sensor Corporation in vendor-prefix.txt.
 - Sort header files in alpabetical order.
 - Add more specific doc for the mutex.
 - Fix the bug in the rm3100_set_cycle_count() where we always set the
   cycle count value to 100 no matter what val is.
 - Change some multiple else if to switch.
 - Remove iio_device_release_direct_mode() in the case claim direct mode
   fails.
 - Use the same buffer in rm3100_trigger_handler().
 - Add space around some operators.
 - Add manually unwind functions in case devm_add_action() fails.
 - Move devm_add_action before the devm_iio_device_register().
 - Move register defines and rm3100_data struct to *-core.c. 
 - Change some storage variable type of regmap from int to unsigned int.
 - Change 10e4 to 10^4.
 - Remove explicit cast of data pointer in rm3100_remove().
 - Remve dev in rm3100_data and use regmap_get_device() to obtain device
   pointer instead.
 - Change register bits alignment in defines.
 - Move RM3100_SCAN_BYTES to the top.
 - Change Channel endieness from LE to BE.
 - Adjust the place of comment about the 3 second wait time.
 - Some spell check.

Changes in v2:
	- Add scale channel.
	- Add EXPORT_SYMBOL_GPL() to export regmap confuguration structures.
	- Add sampling frequency available attribute.
	- Clean up headers and License declarations.
	- Change axis number to 3.
	- Remove bus specific part in compatible string.
	- Remove le32_to_cpu().
	- Check cycle count registers at *_probe().
	- Format comments.
	- Spell check.
	- Change prefix from RM_* to RM3100_*.
	- Check all error return paths.
	- Add devm_add_action() to avoid race condition when remove.

Song Qiang (3):
  dt-bindings: Add PNI to the vendor prefixes
  iio: magnetometer: Add DT support for PNI RM3100
  iio: magnetometer: Add driver support for PNI RM3100

 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  29 +
 drivers/iio/magnetometer/Makefile             |   4 +
 drivers/iio/magnetometer/rm3100-core.c        | 616 ++++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c         |  54 ++
 drivers/iio/magnetometer/rm3100-spi.c         |  64 ++
 drivers/iio/magnetometer/rm3100.h             |  17 +
 9 files changed, 812 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h

-- 
2.17.1
