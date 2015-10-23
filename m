Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49441 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbJWN7V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Oct 2015 09:59:21 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 0/2] Remove .owner from spi_drivers
Date: Fri, 23 Oct 2015 08:59:09 -0500
Message-ID: <1445608751-8432-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

This series adds a helper macro to the SPI core that assigns the owner
in spi_drivers so individual drivers do not have to do this, this is
similar to other subsystems like platform_driver and i2c_driver that
have made this change.

Andrew F. Davis (2):
  spi: Add THIS_MODULE to spi_driver in SPI core
  Drop owner assignment from spi_drivers

 arch/arm/mach-u300/dummyspichip.c                                 | 1 -
 arch/mips/txx9/generic/spi_eeprom.c                               | 1 -
 drivers/char/tpm/st33zp24/spi.c                                   | 1 -
 drivers/gpio/gpio-74x164.c                                        | 1 -
 drivers/gpio/gpio-max7301.c                                       | 1 -
 drivers/gpio/gpio-mc33880.c                                       | 1 -
 drivers/gpio/gpio-mcp23s08.c                                      | 2 --
 drivers/gpu/drm/panel/panel-lg-lg4573.c                           | 1 -
 drivers/gpu/drm/panel/panel-samsung-ld9040.c                      | 1 -
 drivers/hwmon/ad7314.c                                            | 1 -
 drivers/hwmon/adcxx.c                                             | 1 -
 drivers/hwmon/ads7871.c                                           | 1 -
 drivers/hwmon/adt7310.c                                           | 1 -
 drivers/hwmon/lm70.c                                              | 1 -
 drivers/hwmon/max1111.c                                           | 1 -
 drivers/iio/accel/kxsd9.c                                         | 1 -
 drivers/iio/accel/st_accel_spi.c                                  | 1 -
 drivers/iio/adc/ad7266.c                                          | 1 -
 drivers/iio/adc/ad7298.c                                          | 1 -
 drivers/iio/adc/ad7476.c                                          | 1 -
 drivers/iio/adc/ad7791.c                                          | 1 -
 drivers/iio/adc/ad7793.c                                          | 1 -
 drivers/iio/adc/ad7887.c                                          | 1 -
 drivers/iio/adc/ad7923.c                                          | 1 -
 drivers/iio/adc/max1027.c                                         | 1 -
 drivers/iio/adc/mcp320x.c                                         | 1 -
 drivers/iio/adc/ti-adc128s052.c                                   | 1 -
 drivers/iio/amplifiers/ad8366.c                                   | 1 -
 drivers/iio/common/ssp_sensors/ssp_dev.c                          | 1 -
 drivers/iio/dac/ad5064.c                                          | 1 -
 drivers/iio/dac/ad5360.c                                          | 1 -
 drivers/iio/dac/ad5380.c                                          | 1 -
 drivers/iio/dac/ad5421.c                                          | 1 -
 drivers/iio/dac/ad5446.c                                          | 1 -
 drivers/iio/dac/ad5449.c                                          | 1 -
 drivers/iio/dac/ad5504.c                                          | 1 -
 drivers/iio/dac/ad5624r_spi.c                                     | 1 -
 drivers/iio/dac/ad5686.c                                          | 1 -
 drivers/iio/dac/ad5755.c                                          | 1 -
 drivers/iio/dac/ad5764.c                                          | 1 -
 drivers/iio/dac/ad5791.c                                          | 1 -
 drivers/iio/dac/ad7303.c                                          | 1 -
 drivers/iio/dac/mcp4922.c                                         | 1 -
 drivers/iio/frequency/ad9523.c                                    | 1 -
 drivers/iio/frequency/adf4350.c                                   | 1 -
 drivers/iio/gyro/adis16080.c                                      | 1 -
 drivers/iio/gyro/adis16130.c                                      | 1 -
 drivers/iio/gyro/adis16136.c                                      | 1 -
 drivers/iio/gyro/adis16260.c                                      | 1 -
 drivers/iio/gyro/adxrs450.c                                       | 1 -
 drivers/iio/gyro/st_gyro_spi.c                                    | 1 -
 drivers/iio/imu/adis16400_core.c                                  | 1 -
 drivers/iio/imu/adis16480.c                                       | 1 -
 drivers/iio/magnetometer/st_magn_spi.c                            | 1 -
 drivers/iio/pressure/ms5611_spi.c                                 | 1 -
 drivers/iio/pressure/st_pressure_spi.c                            | 1 -
 drivers/iio/proximity/as3935.c                                    | 1 -
 drivers/input/misc/ad714x-spi.c                                   | 1 -
 drivers/input/misc/adxl34x-spi.c                                  | 1 -
 drivers/input/touchscreen/ad7877.c                                | 1 -
 drivers/input/touchscreen/ad7879-spi.c                            | 1 -
 drivers/input/touchscreen/ads7846.c                               | 1 -
 drivers/input/touchscreen/cyttsp4_spi.c                           | 1 -
 drivers/input/touchscreen/cyttsp_spi.c                            | 1 -
 drivers/input/touchscreen/tsc2005.c                               | 1 -
 drivers/leds/leds-dac124s085.c                                    | 1 -
 drivers/media/i2c/s5c73m3/s5c73m3-spi.c                           | 1 -
 drivers/media/tuners/msi001.c                                     | 1 -
 drivers/mfd/arizona-spi.c                                         | 1 -
 drivers/mfd/cros_ec_spi.c                                         | 1 -
 drivers/mfd/da9052-spi.c                                          | 1 -
 drivers/mfd/ezx-pcap.c                                            | 1 -
 drivers/mfd/mc13xxx-spi.c                                         | 1 -
 drivers/mfd/stmpe-spi.c                                           | 1 -
 drivers/mfd/tps65912-spi.c                                        | 1 -
 drivers/mfd/wm831x-spi.c                                          | 1 -
 drivers/misc/ad525x_dpot-spi.c                                    | 1 -
 drivers/misc/bmp085-spi.c                                         | 1 -
 drivers/misc/eeprom/at25.c                                        | 1 -
 drivers/misc/eeprom/eeprom_93xx46.c                               | 1 -
 drivers/misc/lattice-ecp3-config.c                                | 1 -
 drivers/misc/lis3lv02d/lis3lv02d_spi.c                            | 1 -
 drivers/misc/ti_dac7512.c                                         | 1 -
 drivers/mmc/host/mmc_spi.c                                        | 1 -
 drivers/mtd/devices/m25p80.c                                      | 1 -
 drivers/mtd/devices/mtd_dataflash.c                               | 1 -
 drivers/mtd/devices/sst25l.c                                      | 1 -
 drivers/net/can/spi/mcp251x.c                                     | 1 -
 drivers/net/ethernet/micrel/ks8851.c                              | 1 -
 drivers/net/ethernet/microchip/enc28j60.c                         | 1 -
 drivers/net/ethernet/qualcomm/qca_spi.c                           | 1 -
 drivers/net/ieee802154/at86rf230.c                                | 1 -
 drivers/net/ieee802154/cc2520.c                                   | 1 -
 drivers/net/ieee802154/mrf24j40.c                                 | 1 -
 drivers/net/phy/spi_ks8995.c                                      | 1 -
 drivers/net/wireless/cw1200/cw1200_spi.c                          | 1 -
 drivers/net/wireless/libertas/if_spi.c                            | 1 -
 drivers/net/wireless/p54/p54spi.c                                 | 1 -
 drivers/net/wireless/ti/wl1251/spi.c                              | 1 -
 drivers/net/wireless/ti/wlcore/spi.c                              | 1 -
 drivers/nfc/st-nci/spi.c                                          | 1 -
 drivers/nfc/trf7970a.c                                            | 1 -
 drivers/regulator/tps6524x-regulator.c                            | 1 -
 drivers/rtc/rtc-ds1305.c                                          | 1 -
 drivers/rtc/rtc-ds1343.c                                          | 1 -
 drivers/rtc/rtc-ds1347.c                                          | 1 -
 drivers/rtc/rtc-ds1390.c                                          | 1 -
 drivers/rtc/rtc-ds3234.c                                          | 1 -
 drivers/rtc/rtc-m41t93.c                                          | 1 -
 drivers/rtc/rtc-m41t94.c                                          | 1 -
 drivers/rtc/rtc-max6902.c                                         | 1 -
 drivers/rtc/rtc-mcp795.c                                          | 1 -
 drivers/rtc/rtc-pcf2123.c                                         | 1 -
 drivers/rtc/rtc-r9701.c                                           | 1 -
 drivers/rtc/rtc-rs5c348.c                                         | 1 -
 drivers/rtc/rtc-rx4581.c                                          | 1 -
 drivers/spi/spi-tle62x0.c                                         | 1 -
 drivers/spi/spi.c                                                 | 7 ++++---
 drivers/spi/spidev.c                                              | 1 -
 drivers/staging/fbtft/fbtft.h                                     | 1 -
 drivers/staging/fbtft/flexfb.c                                    | 1 -
 drivers/staging/iio/accel/adis16201_core.c                        | 1 -
 drivers/staging/iio/accel/adis16203_core.c                        | 1 -
 drivers/staging/iio/accel/adis16204_core.c                        | 1 -
 drivers/staging/iio/accel/adis16209_core.c                        | 1 -
 drivers/staging/iio/accel/adis16220_core.c                        | 1 -
 drivers/staging/iio/accel/adis16240_core.c                        | 1 -
 drivers/staging/iio/accel/lis3l02dq_core.c                        | 1 -
 drivers/staging/iio/accel/sca3000_core.c                          | 1 -
 drivers/staging/iio/adc/ad7192.c                                  | 1 -
 drivers/staging/iio/adc/ad7280a.c                                 | 1 -
 drivers/staging/iio/adc/ad7606_spi.c                              | 1 -
 drivers/staging/iio/adc/ad7780.c                                  | 1 -
 drivers/staging/iio/adc/ad7816.c                                  | 1 -
 drivers/staging/iio/addac/adt7316-spi.c                           | 1 -
 drivers/staging/iio/frequency/ad9832.c                            | 1 -
 drivers/staging/iio/frequency/ad9834.c                            | 1 -
 drivers/staging/iio/gyro/adis16060_core.c                         | 2 --
 drivers/staging/iio/magnetometer/hmc5843_spi.c                    | 1 -
 drivers/staging/iio/meter/ade7753.c                               | 1 -
 drivers/staging/iio/meter/ade7754.c                               | 1 -
 drivers/staging/iio/meter/ade7758_core.c                          | 1 -
 drivers/staging/iio/meter/ade7759.c                               | 1 -
 drivers/staging/iio/meter/ade7854-spi.c                           | 1 -
 drivers/staging/iio/resolver/ad2s1200.c                           | 1 -
 drivers/staging/iio/resolver/ad2s1210.c                           | 1 -
 drivers/staging/iio/resolver/ad2s90.c                             | 1 -
 drivers/staging/mt29f_spinand/mt29f_spinand.c                     | 1 -
 drivers/tty/serial/ifx6x60.c                                      | 2 +-
 drivers/tty/serial/max3100.c                                      | 1 -
 drivers/tty/serial/max310x.c                                      | 1 -
 drivers/tty/serial/sc16is7xx.c                                    | 1 -
 drivers/usb/host/max3421-hcd.c                                    | 1 -
 drivers/video/backlight/ams369fg06.c                              | 1 -
 drivers/video/backlight/corgi_lcd.c                               | 1 -
 drivers/video/backlight/ili922x.c                                 | 1 -
 drivers/video/backlight/l4f00242t03.c                             | 1 -
 drivers/video/backlight/ld9040.c                                  | 1 -
 drivers/video/backlight/lms283gf05.c                              | 1 -
 drivers/video/backlight/lms501kf03.c                              | 1 -
 drivers/video/backlight/ltv350qv.c                                | 1 -
 drivers/video/backlight/s6e63m0.c                                 | 1 -
 drivers/video/backlight/tdo24m.c                                  | 1 -
 drivers/video/backlight/tosa_lcd.c                                | 1 -
 drivers/video/backlight/vgg2432a4.c                               | 1 -
 drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c                   | 1 -
 drivers/video/fbdev/omap/lcd_mipid.c                              | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c     | 1 -
 include/linux/spi/spi.h                                           | 6 +++++-
 sound/soc/codecs/ad1836.c                                         | 1 -
 sound/soc/codecs/ad193x-spi.c                                     | 1 -
 sound/soc/codecs/adau1761-spi.c                                   | 1 -
 sound/soc/codecs/adau1781-spi.c                                   | 1 -
 sound/soc/codecs/adau1977-spi.c                                   | 1 -
 sound/soc/codecs/adav801.c                                        | 1 -
 sound/soc/codecs/ak4104.c                                         | 1 -
 sound/soc/codecs/cs4271-spi.c                                     | 1 -
 sound/soc/codecs/da7210.c                                         | 1 -
 sound/soc/codecs/pcm1792a.c                                       | 1 -
 sound/soc/codecs/pcm512x-spi.c                                    | 1 -
 sound/soc/codecs/rt5677-spi.c                                     | 1 -
 sound/soc/codecs/ssm2602-spi.c                                    | 1 -
 sound/soc/codecs/tlv320aic23-spi.c                                | 1 -
 sound/soc/codecs/tlv320aic26.c                                    | 1 -
 sound/soc/codecs/wm0010.c                                         | 1 -
 sound/soc/codecs/wm8510.c                                         | 1 -
 sound/soc/codecs/wm8711.c                                         | 1 -
 sound/soc/codecs/wm8728.c                                         | 1 -
 sound/soc/codecs/wm8731.c                                         | 1 -
 sound/soc/codecs/wm8737.c                                         | 1 -
 sound/soc/codecs/wm8741.c                                         | 1 -
 sound/soc/codecs/wm8750.c                                         | 1 -
 sound/soc/codecs/wm8753.c                                         | 1 -
 sound/soc/codecs/wm8770.c                                         | 1 -
 sound/soc/codecs/wm8776.c                                         | 1 -
 sound/soc/codecs/wm8804-spi.c                                     | 1 -
 sound/soc/codecs/wm8900.c                                         | 1 -
 sound/soc/codecs/wm8983.c                                         | 1 -
 sound/soc/codecs/wm8985.c                                         | 1 -
 sound/soc/codecs/wm8988.c                                         | 1 -
 sound/soc/codecs/wm8995.c                                         | 1 -
 205 files changed, 10 insertions(+), 209 deletions(-)

-- 
1.9.1

