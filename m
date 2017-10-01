Return-Path: <SRS0=S1Wp=BA=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170903175210.231b90a8@archlinux>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com> <20170903175210.231b90a8@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 1 Oct 2017 15:15:26 +0200
Message-ID: <CAA2SeNKaUhLvLV6iUoirotMtz+nitW5LzLS0una3=BH9v7=0qA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support to LIS2DW12 accel sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Wed, 30 Aug 2017 13:50:38 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Modify management of drdy line and status register in order to support
>> LIS2DW12 device
>>
>> Changes since v2:
>> - swap status register patch (3rd in v2) with irq{1,2} definition one
>>   (1st in v2)
>> - patchset rebased onto 'fix drdy line configuration for LIS3MDL' patch
>> Changes since v1:
>> - remove drdy_irq parameter from LPS001WP settings since the sensor
>> does not support data-ready interrupts
>>
>> Lorenzo Bianconi (5):
>>   iio: st_sensors: add register mask for status register
>>   iio: st_sensors: decouple irq1 configuration parameters from the irq2
>>     ones
>>   iio: st_sensors: do not always write enable_axis register
>>   iio: accel: add support to LIS2DW12
>>   dt-bindings: iio: accel: add LIS2DW12 sensor device binding
>>
>>  .../devicetree/bindings/iio/st-sensors.txt         |   1 +
>>  drivers/iio/accel/st_accel.h                       |   2 +
>>  drivers/iio/accel/st_accel_core.c                  | 180 +++++++++++++++++----
>>  drivers/iio/accel/st_accel_i2c.c                   |   5 +
>>  drivers/iio/accel/st_accel_spi.c                   |   5 +
>>  drivers/iio/common/st_sensors/st_sensors_core.c    |  35 ++--
>>  drivers/iio/common/st_sensors/st_sensors_trigger.c |  16 +-
>>  drivers/iio/gyro/st_gyro_core.c                    |  33 ++--
>>  drivers/iio/magnetometer/st_magn_core.c            |  16 +-
>>  drivers/iio/pressure/st_pressure_core.c            |  46 ++++--
>>  include/linux/iio/common/st_sensors.h              |  23 ++-
>>  11 files changed, 270 insertions(+), 92 deletions(-)
>>
>
> I'm happy with the whole series, however it doesn't currently apply
> due to various fixes working their way through the fixes branches
> of the iio git tree.  I'll try to pick it up once those have unwound.
> There is too much going on with this code at the moment to do this
> cleanly now.
>
> Give me a bump if I look like I have forgotten it once it will
> apply cleanly to the togreg branch of iio.git.
>
> If I was being really fussy  this should have had a dependency list
> for everything it was dependant on that wasn't currently in mainline.
>
> Jonathan

Hi Jonathan,

what about that patchset?
Regards,

Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
