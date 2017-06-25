Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37308 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdFYQUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 12:20:48 -0400
Date: Sun, 25 Jun 2017 17:20:45 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of new device support, cleanups etc for IIO
 in the 4.13 cycle.
Message-ID: <20170625172045.76f28fe7@jic23.retrosnub.co.uk>
In-Reply-To: <20170620171217.6f8dd834@kernel.org>
References: <20170620171217.6f8dd834@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

A polite nudge. I'd normally just assume this was buried in your inbox, but
as we are rather tight on the possible earliest date for the merge window
to open, I just wanted to check this wasn't buried too deep.

I've been rather snowed under with travel this cycle, so been running a bit
late with everything. Sorry about that!

Thanks,

Jonathan

On Tue, 20 Jun 2017 17:12:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 57d14635f976404fac165047389ff0dbe83bcd5b:
> 
>   staging: vchiq_core: Replace remaining BUG_ON with WARN_ON (2017-05-29 17:04:13 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.13b
> 
> for you to fetch changes up to 881b556f6cf22d37be9340f293f2db10ce7ae8bf:
> 
>   iio: imu: inv_mpu6050: test whoami first and against all known values (2017-06-13 21:18:17 +0100)
> 
> ----------------------------------------------------------------
> Second set of IIO new device support, features and cleanups for the 4.13 cycle.
> 
> A few reverts here. One was a general failure to notice a device was already
> supported by another driver.  The second is due to a review comment pointing
> out that the original patch was a bad idea and would break existing systems.
> 
> Reverts
> * bma180
>   - Revert addition of support for the BMA250E it is already supported by
>     the bmc150-accel and better supported at that. Oops.
> * hi8435
>   - The fix for cleanup of the reset gpio stuff isn't a good way to go.  It
>     breaks systems where an inverting level convertor is used.  The right fix
>     is to make the original devicetree correct - even if it involves patching
>     the devicetree in kernel.
> 
> New Device Support
> * stm32-adc
>   - STM32H7 support and bindings.
> 
> Features
> * core
>   - add a hardware triggered operating mode for systems in which the actual
>     trigger is never seen by the kernel.  This is typically only used when
>     a device 'can' use other triggers, but if a particular magic one is
>     enabled the interrupt is effectively handled in hardware and we never see
>     it.
> * st-lsm6dsx
>   - support active low interrupts.
> * stm32-adc
>   - Make the core adc clock optional as not all hardware supported requires it.
>   - Make the bus clock optional in the per instance driver as it may be shared
>     by all instances of the ADC and is handled by the core.
>   - Rework to have a data structure representing the device type specific
>     elements.
> * stm32-trigger (and counter)
>   - Use the INDIO_HARDWARE_TRIGGERED_MODE where appropriate.
>   - Add an attribute to configure device modes for quadrature counting etc.
> 
> Clean ups and minor fixes
> * IIO core.
>   - use __sysfs_match_string() helper rather than open coding the same.
> * ad7791
>   - use sysfs_match_string() helper rather than open coding the same.
> * aspeed-adc
>   - handle return value of clk_prepare_enable
> * cpcap
>   - Fix default register values and ensure the battery thermistor is enabled
>     correctly.
>   - Fix the reported die temperature where we can - docs are lacking.
>   - Remove the hung interrupt quirk as no longer happens due to fix in the
>     mfd driver.
> * hi8435
>   - Remove &s from hi8435_info definition as unneeded and inconsistent.
> * hid-sensor-trgger
>   - Add kconfig depends on IIO_BUFFER (fixes patch in previous series)
> * ina2xx
>   - Make the use of iio_info_mask* elements consistent for all channels.
>     This doesn't have any visible effect, but acts as clear documentation of
>     which channels various resulting attributes apply to.
> * lpc32xx
>   - handle the return value of clk_prepare_enable.
> * meson-saradc
>   - NULL instead of 0 for pointer.
> * mma9551
>   - use NULL for GPIO connection ID to aid implementation fo ACPI support.
>     Here the connection ID doesn't actually tell us anything and it is much
>     easier to deal with the driver if it's not there.
> * mpu6050
>   - Fix lock issues through use of a local mux.
>   - Replace sprintf with scnprintf as appropriate.
>   - Check whoami against all known values.  This allows for a small number of
>     boards where we are really fishing for the part not being present at all.
>     It is unfortunately common to have undescribed changes to use newer chips.
>     We paper over this but just emitting a warning for those cases as long as
>     we know about.
> * mxs-lradc
>   - Fix some non static warnings.
> * rcar-adc
>   - Part of making the naming for this part consistent across the kernel.
> * st_accel
>   - drop some spi_device_id entries for variants with no SPI support
> * st_magn
>   - drop some spi_device_id entries for variants with no SPI support.
> * sx9500
>   - Use devm_gpiod_get instead of indexed value with an index of 0 on all
>     occasions.
> * twl4030
>   - Drop unused twl4030_get_madc_conversion as callers removed now throughout
>     kernel.
>   - Unexport twl4030_madc_conversion() as no used only within this driver.
>   - Drop twl4030_madc_user_params as not used now.
>   - Drop twl4030_madc_request.func_cb as not used now.
>   - Fold the twl4030-madc.h header into the driver as no longer used anywhere
>     else in the kernel.
> * xilinx
>   - Handle the return value of clk_prepare_enable
> 
> ----------------------------------------------------------------
> Alexander Wuerstlein (1):
>       iio hid-sensor-trigger: add Kconfig depends on IIO_BUFFER
> 
> Andy Shevchenko (4):
>       iio: proximity: sx9500: Use devm_gpiod_get()
>       iio: core: Use __sysfs_match_string() helper
>       iio: adc: ad7791: Use sysfs_match_string() helper
>       iio: accel: mma9551: use NULL for GPIO connection ID
> 
> Arvind Yadav (3):
>       iio: adc: xilinx: Handle return value of clk_prepare_enable
>       iio:adc:lpc32xx Handle return value of clk_prepare_enable
>       iio: Aspeed ADC - Handle return value of clk_prepare_enable
> 
> Benjamin Gaignard (2):
>       iio: add hardware triggered operating mode
>       iio: make stm32 trigger driver use INDIO_HARDWARE_TRIGGERED mode
> 
> Fabrice Gasnier (5):
>       dt-bindings: iio: stm32-adc: add support for STM32H7
>       iio: adc: stm32: make core adc clock optional by default
>       iio: adc: stm32: introduce compatible data cfg
>       iio: adc: stm32: make per instance bus clock optional
>       iio: adc: stm32: add support for STM32H7
> 
> Hans de Goede (2):
>       Revert "iio: accel: bma180: Add ACPI enumeration support for BMA250E"
>       Revert "iio: accel: bma180: Add support for BMA250E"
> 
> Jean-Baptiste Maneyrol (3):
>       iio: imu: inv_mpu6050: fix lock issues by using our own mutex
>       iio: imu: inv_mpu6050: replace sprintf with scnprintf
>       iio: imu: inv_mpu6050: test whoami first and against all known values
> 
> Jonathan Cameron (1):
>       Revert "iio: hi8435: cleanup reset gpio"
> 
> Lorenzo Bianconi (4):
>       iio: imu: st_lsm6dsx: support active-low interrupts
>       dt-bindings: iio: imu: st_lsm6dsx: support active-low interrupts
>       iio: accel: st_accel_spi: fix spi_device_id table
>       iio: magnetometer: st_magn_spi: fix spi_device_id table
> 
> Nikita Yushchenko (1):
>       iio: hi8435: remote ampersands from hi8435_info definition
> 
> Paolo Cretaro (2):
>       iio: adc: mxs-lradc: fix non-static symbol warnings
>       iio: adc: meson-saradc: use NULL instead of 0 for pointer
> 
> Sebastian Reichel (5):
>       iio: adc: twl4030: Drop twl4030_get_madc_conversion()
>       iio: adc: twl4030: Unexport twl4030_madc_conversion()
>       iio: adc: twl4030: Drop struct twl4030_madc_user_parms
>       iio: adc: twl4030: Remove twl4030_madc_request.func_cb
>       iio: adc: twl4030: Fold twl4030-madc.h into driver
> 
> Stefan Brüns (2):
>       iio: adc: ina2xx: Make use of attribute flags consistent on all channels
>       iio: adc: Fix integration time/averaging for INA219/220
> 
> Tony Lindgren (3):
>       iio: adc: cpcap: Fix default register values and battery temperature
>       iio: adc: cpcap: Fix die temperature
>       iio: adc: cpcap: Remove hung interrupt quirk
> 
> Wolfram Sang (1):
>       iio: use proper name for the R-Car SoC
> 
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  15 +
>  .../bindings/iio/adc/renesas,gyroadc.txt           |   2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  28 +-
>  .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   3 +-
>  drivers/iio/accel/bma180.c                         |  45 +-
>  drivers/iio/accel/mma9551.c                        |   4 +-
>  drivers/iio/accel/st_accel_spi.c                   |   4 -
>  drivers/iio/adc/ad7791.c                           |   8 +-
>  drivers/iio/adc/aspeed_adc.c                       |   6 +-
>  drivers/iio/adc/cpcap-adc.c                        | 108 ++-
>  drivers/iio/adc/hi8435.c                           |  20 +-
>  drivers/iio/adc/ina2xx-adc.c                       | 206 +++++-
>  drivers/iio/adc/lpc32xx_adc.c                      |   8 +-
>  drivers/iio/adc/meson_saradc.c                     |   2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                    |  32 +-
>  drivers/iio/adc/stm32-adc-core.c                   | 269 +++++++-
>  drivers/iio/adc/stm32-adc-core.h                   |   2 +
>  drivers/iio/adc/stm32-adc.c                        | 762 +++++++++++++++++++--
>  drivers/iio/adc/twl4030-madc.c                     | 209 +++---
>  drivers/iio/adc/xilinx-xadc-core.c                 |   5 +-
>  drivers/iio/common/hid-sensors/Kconfig             |   2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 183 +++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   8 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  11 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  14 +
>  drivers/iio/industrialio-core.c                    |  17 +-
>  drivers/iio/magnetometer/st_magn_spi.c             |   2 -
>  drivers/iio/proximity/sx9500.c                     |   3 +-
>  drivers/iio/trigger/stm32-timer-trigger.c          |  61 ++
>  include/linux/i2c/twl4030-madc.h                   | 147 ----
>  include/linux/iio/iio.h                            |   6 +
>  33 files changed, 1631 insertions(+), 572 deletions(-)
>  delete mode 100644 include/linux/i2c/twl4030-madc.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

