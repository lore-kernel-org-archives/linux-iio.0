Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49902 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab2DYKEH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 06:04:07 -0400
Message-ID: <4F97CC11.8010006@cam.ac.uk>
Date: Wed, 25 Apr 2012 11:04:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14] IIO: Move from staging to drivers/iio
References: <1335096819-19565-1-git-send-email-jic23@kernel.org> <4F97BD2E.40706@metafoo.de>
In-Reply-To: <4F97BD2E.40706@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/25/2012 10:00 AM, Lars-Peter Clausen wrote:
> On 04/22/2012 02:13 PM, Jonathan Cameron wrote:
>> Hi All,
>>
>> This series is mostly what was discussed in
>> IIO: move out of staging plan.
>>
>> It sits on top of the series
>> Staging:iio: Cleanup and refactor pre multibuffer.
>> which has gone to Greg already.
>>
>> However, a few things I'd neglected there came up and occur
>> before the final 3 patches that actually do the main movement.
>> Basically if we had just done the move we would have introduced
>> selection of elements not in staging by driver in staging.  This
>> breaks the rule that code in staging should not effect any that
>> isn't.  Hence I've flipped all the selects to the equivalent
>> depends on lines.
> I think the rule is that non-staging code should not depend on staging code,
> but I haven't heard yet that staging code shouldn't select non-staging.
Look around there are quite a few drivers already selecting elements 
that aren't
in staging so I guess it's not an issue.  Will revert this change.
>
> E.g. there is a lot of infrastructure and helper code which is not user
> selectable. Not allowing this to be selected by staging drivers would make
> those helper functions inaccessible to it. Most of lib/ for example.
>
> And I think at least the buffer implementations falls into this category.
> There is no point of including them in the kernel image, if we have no
> driver using them. And in fact all except one driver do select them instead
> of depending on them. I think the best is to make them non user selectable
> and let drivers which need them depend on them.
Take into account that we don't actually want to go out of our way to stop
people building drivers out of tree.  So I'd rather keep these user 
selectable if
nothing needs them.
> Triggers are a bit of a different story here. While all drivers select them
> instead of depending on them there is also a different group which depends
> on the trigger infrastructure. Namely the standalone trigger implementations.
>
> But with a dependency like 'depends on !IIO_BUFFER || IIO_TRIGGER' the
> driver will be available without IIO_BUFFER being select or when both
> IIO_BUFFER and IIO_TRIGGER are selected, but not if IIO_BUFFER is selected
> and not IIO_TRIGGER. This is a bit confusing in my opinion.
>
> One way to solve this would be to make IIO_BUFFER and IIO_TRIGGER more
> tightly coupled. In reality we never really use one without the other, so
> there is not much gain from making them selectable independently and may
> even cause some confusion.
We do use the separately in all hardware buffers.  There triggers often 
don't have
any meaning (or at least we can't get to them so no point in exposing 
userspace interfaces).
>
> But for now we can just make the buffer implementation of drivers which have
> optional buffer support depend on both IIO_BUFFER and IIO_TRIGGER.
>
> i.e. 's/#ifdef CONFIG_IIO_BUFFER/if defined(CONFIG_IIO_BUFFER)&&
> defined(CONFIG_IIO_TRIGGER)'
>
> I can take care of this if you want to.
That would indeed be cleaner than the current stack of selects.  Would 
be great if
you can do this.

So I'll drop my select->depends patches and move on with the rest of the 
move.
Clearly the change you suggest can stand separately anyway.

Jonathan
>
> - Lars
>
>
>> Whilst doing this for ADC's I noticed that two had apparent
>> configurable elementst that really were not (one of these
>> was entirely my fault for being lazy a long time ago!).  Anyhow
>> I cleaned those up along the way by dropping the 'false' option
>> of not having buffers for the max1363 and ad799x drivers.
>>
>> The other little change I made was to pull two elements,
>> ac_excitation_en and bridge_switch_en out of the generic docs
>> as they are only used by one driver.  They can go back in
>> at a later date if appropriate.
>>
>> Final 3 patches do the actual move.
>> For now I've just moved the main sysfs ABI doc. Others should follow
>> fairly soon.
>>
>> I've posted this to the list rather than just getting on with it
>> so people can confirm I didn't mess up the non move changes.
>> Please look at this asap as we want this to be in linux-next
>> for as long as possible before the merge window opens.
>> Obviously if I messed up the move changes, please do point that
>> out!
>>
>> Jonathan
>>
>> Jonathan Cameron (14):
>>    staging:iio:accel switch select kconfig elements to depends.
>>    staging:iio:adc:max1363 remove false option to disable ring in
>>      kconfig.
>>    staging:iio:ad799x remove false option for ring buffer.
>>    staging:iio:adc switch select kconfig elements to depends.
>>    staging:iio:gyro switch select kconfig elements to depends.
>>    staging:iio:impedance-analyzer switch select kconfig elements to
>>      depends.
>>    staging:iio:imu switch select kconfig elements to depends.
>>    staging:iio:meter switch select kconfig elements to depends.
>>    staging:iio:buffers switch select kconfig elements to depends.
>>    staging:iio:documentation pull a few sysfs entries out of main docs.
>>    staging:iio:Documentation Trivial typo fixes.
>>    IIO: Move core headers to include/linux/iio
>>    IIO: Move the core files to drivers/iio
>>    IIO: Move the core abi documentation from staging
>>
>>   .../ABI/testing}/sysfs-bus-iio                     |   27 ++---------
>>   drivers/Kconfig                                    |    2 +
>>   drivers/Makefile                                   |    1 +
>>   drivers/iio/Kconfig                                |   51 ++++++++++++++++++++
>>   drivers/iio/Makefile                               |   10 ++++
>>   drivers/{staging =>  }/iio/iio_core.h               |    0
>>   drivers/{staging =>  }/iio/iio_core_trigger.h       |    0
>>   drivers/{staging =>  }/iio/industrialio-buffer.c    |    6 +--
>>   drivers/{staging =>  }/iio/industrialio-core.c      |    6 +--
>>   drivers/{staging =>  }/iio/industrialio-event.c     |    6 +--
>>   drivers/{staging =>  }/iio/industrialio-trigger.c   |    6 +--
>>   drivers/{staging =>  }/iio/inkern.c                 |    8 +--
>>   drivers/{staging =>  }/iio/kfifo_buf.c              |    3 +-
>>   .../staging/iio/Documentation/iio_event_monitor.c  |    2 +-
>>   .../staging/iio/Documentation/sysfs-bus-iio-ad7192 |   20 ++++++++
>>   drivers/staging/iio/Kconfig                        |   46 ++----------------
>>   drivers/staging/iio/Makefile                       |    6 ---
>>   drivers/staging/iio/accel/Kconfig                  |   18 +++----
>>   drivers/staging/iio/accel/adis16201_core.c         |    6 +--
>>   drivers/staging/iio/accel/adis16201_ring.c         |    4 +-
>>   drivers/staging/iio/accel/adis16201_trigger.c      |    4 +-
>>   drivers/staging/iio/accel/adis16203_core.c         |    6 +--
>>   drivers/staging/iio/accel/adis16203_ring.c         |    4 +-
>>   drivers/staging/iio/accel/adis16203_trigger.c      |    4 +-
>>   drivers/staging/iio/accel/adis16204_core.c         |    6 +--
>>   drivers/staging/iio/accel/adis16204_ring.c         |    4 +-
>>   drivers/staging/iio/accel/adis16204_trigger.c      |    4 +-
>>   drivers/staging/iio/accel/adis16209_core.c         |    6 +--
>>   drivers/staging/iio/accel/adis16209_ring.c         |    4 +-
>>   drivers/staging/iio/accel/adis16209_trigger.c      |    4 +-
>>   drivers/staging/iio/accel/adis16220_core.c         |    4 +-
>>   drivers/staging/iio/accel/adis16240_core.c         |    6 +--
>>   drivers/staging/iio/accel/adis16240_ring.c         |    4 +-
>>   drivers/staging/iio/accel/adis16240_trigger.c      |    4 +-
>>   drivers/staging/iio/accel/kxsd9.c                  |    4 +-
>>   drivers/staging/iio/accel/lis3l02dq_core.c         |    8 +--
>>   drivers/staging/iio/accel/lis3l02dq_ring.c         |    8 +--
>>   drivers/staging/iio/accel/sca3000_core.c           |    8 +--
>>   drivers/staging/iio/accel/sca3000_ring.c           |    6 +--
>>   drivers/staging/iio/adc/Kconfig                    |   46 +++---------------
>>   drivers/staging/iio/adc/Makefile                   |    7 +--
>>   drivers/staging/iio/adc/ad7192.c                   |   10 ++--
>>   drivers/staging/iio/adc/ad7280a.c                  |    6 +--
>>   drivers/staging/iio/adc/ad7291.c                   |    6 +--
>>   drivers/staging/iio/adc/ad7298_core.c              |    6 +--
>>   drivers/staging/iio/adc/ad7298_ring.c              |    6 +--
>>   drivers/staging/iio/adc/ad7476_core.c              |    6 +--
>>   drivers/staging/iio/adc/ad7476_ring.c              |    6 +--
>>   drivers/staging/iio/adc/ad7606_core.c              |    6 +--
>>   drivers/staging/iio/adc/ad7606_par.c               |    2 +-
>>   drivers/staging/iio/adc/ad7606_ring.c              |    6 +--
>>   drivers/staging/iio/adc/ad7606_spi.c               |    2 +-
>>   drivers/staging/iio/adc/ad7780.c                   |    4 +-
>>   drivers/staging/iio/adc/ad7793.c                   |   10 ++--
>>   drivers/staging/iio/adc/ad7816.c                   |    6 +--
>>   drivers/staging/iio/adc/ad7887_core.c              |    6 +--
>>   drivers/staging/iio/adc/ad7887_ring.c              |    6 +--
>>   drivers/staging/iio/adc/ad799x.h                   |   14 +-----
>>   drivers/staging/iio/adc/ad799x_core.c              |    8 +--
>>   drivers/staging/iio/adc/ad799x_ring.c              |    6 +--
>>   drivers/staging/iio/adc/adt7310.c                  |    6 +--
>>   drivers/staging/iio/adc/adt7410.c                  |    6 +--
>>   drivers/staging/iio/adc/lpc32xx_adc.c              |    4 +-
>>   drivers/staging/iio/adc/max1363.h                  |   18 -------
>>   drivers/staging/iio/adc/max1363_core.c             |   10 ++--
>>   drivers/staging/iio/adc/max1363_ring.c             |    6 +--
>>   drivers/staging/iio/adc/spear_adc.c                |    4 +-
>>   drivers/staging/iio/addac/adt7316.c                |    6 +--
>>   drivers/staging/iio/cdc/ad7150.c                   |    6 +--
>>   drivers/staging/iio/cdc/ad7152.c                   |    4 +-
>>   drivers/staging/iio/cdc/ad7746.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5064.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5360.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5380.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5421.c                   |    6 +--
>>   drivers/staging/iio/dac/ad5446.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5504.c                   |    6 +--
>>   drivers/staging/iio/dac/ad5624r_spi.c              |    4 +-
>>   drivers/staging/iio/dac/ad5686.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5764.c                   |    4 +-
>>   drivers/staging/iio/dac/ad5791.c                   |    4 +-
>>   drivers/staging/iio/dac/max517.c                   |    4 +-
>>   drivers/staging/iio/dds/ad5930.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9832.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9834.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9850.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9852.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9910.c                   |    4 +-
>>   drivers/staging/iio/dds/ad9951.c                   |    4 +-
>>   drivers/staging/iio/gyro/Kconfig                   |    3 +-
>>   drivers/staging/iio/gyro/adis16060_core.c          |    4 +-
>>   drivers/staging/iio/gyro/adis16080_core.c          |    4 +-
>>   drivers/staging/iio/gyro/adis16130_core.c          |    4 +-
>>   drivers/staging/iio/gyro/adis16260_core.c          |    6 +--
>>   drivers/staging/iio/gyro/adis16260_ring.c          |    4 +-
>>   drivers/staging/iio/gyro/adis16260_trigger.c       |    4 +-
>>   drivers/staging/iio/gyro/adxrs450_core.c           |    4 +-
>>   drivers/staging/iio/iio_dummy_evgen.c              |    4 +-
>>   drivers/staging/iio/iio_hwmon.c                    |    4 +-
>>   drivers/staging/iio/iio_simple_dummy.c             |    8 +--
>>   drivers/staging/iio/iio_simple_dummy_buffer.c      |    6 +--
>>   drivers/staging/iio/iio_simple_dummy_events.c      |    6 +--
>>   drivers/staging/iio/impedance-analyzer/Kconfig     |    3 +-
>>   drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +--
>>   drivers/staging/iio/imu/Kconfig                    |    3 +-
>>   drivers/staging/iio/imu/adis16400_core.c           |    6 +--
>>   drivers/staging/iio/imu/adis16400_ring.c           |    4 +-
>>   drivers/staging/iio/imu/adis16400_trigger.c        |    4 +-
>>   drivers/staging/iio/light/isl29018.c               |    4 +-
>>   drivers/staging/iio/light/isl29028.c               |    4 +-
>>   drivers/staging/iio/light/tsl2563.c                |    6 +--
>>   drivers/staging/iio/light/tsl2583.c                |    2 +-
>>   drivers/staging/iio/magnetometer/ak8975.c          |    4 +-
>>   drivers/staging/iio/magnetometer/hmc5843.c         |    4 +-
>>   drivers/staging/iio/meter/Kconfig                  |    3 +-
>>   drivers/staging/iio/meter/ade7753.c                |    4 +-
>>   drivers/staging/iio/meter/ade7754.c                |    4 +-
>>   drivers/staging/iio/meter/ade7758_core.c           |    6 +--
>>   drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
>>   drivers/staging/iio/meter/ade7758_trigger.c        |    4 +-
>>   drivers/staging/iio/meter/ade7759.c                |    4 +-
>>   drivers/staging/iio/meter/ade7854-i2c.c            |    2 +-
>>   drivers/staging/iio/meter/ade7854-spi.c            |    2 +-
>>   drivers/staging/iio/meter/ade7854.c                |    4 +-
>>   drivers/staging/iio/meter/meter.h                  |    2 +-
>>   drivers/staging/iio/resolver/ad2s1200.c            |    4 +-
>>   drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
>>   drivers/staging/iio/resolver/ad2s90.c              |    4 +-
>>   drivers/staging/iio/ring_sw.c                      |    2 +-
>>   drivers/staging/iio/ring_sw.h                      |    2 +-
>>   drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    4 +-
>>   drivers/staging/iio/trigger/iio-trig-gpio.c        |    4 +-
>>   .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 +-
>>   drivers/staging/iio/trigger/iio-trig-sysfs.c       |    4 +-
>>   {drivers/staging =>  include/linux}/iio/buffer.h    |    2 +-
>>   {drivers/staging =>  include/linux}/iio/consumer.h  |    2 +-
>>   {drivers/staging =>  include/linux}/iio/driver.h    |    0
>>   {drivers/staging =>  include/linux}/iio/events.h    |    2 +-
>>   {drivers/staging =>  include/linux}/iio/iio.h       |    2 +-
>>   {drivers/staging =>  include/linux}/iio/kfifo_buf.h |    4 +-
>>   {drivers/staging =>  include/linux}/iio/machine.h   |    0
>>   {drivers/staging =>  include/linux}/iio/sysfs.h     |    0
>>   {drivers/staging =>  include/linux}/iio/trigger.h   |    0
>>   .../linux}/iio/trigger_consumer.h                  |    0
>>   {drivers/staging =>  include/linux}/iio/types.h     |    0
>>   145 files changed, 395 insertions(+), 450 deletions(-)
>>   rename {drivers/staging/iio/Documentation =>  Documentation/ABI/testing}/sysfs-bus-iio (97%)
>>   create mode 100644 drivers/iio/Kconfig
>>   create mode 100644 drivers/iio/Makefile
>>   rename drivers/{staging =>  }/iio/iio_core.h (100%)
>>   rename drivers/{staging =>  }/iio/iio_core_trigger.h (100%)
>>   rename drivers/{staging =>  }/iio/industrialio-buffer.c (99%)
>>   rename drivers/{staging =>  }/iio/industrialio-core.c (99%)
>>   rename drivers/{staging =>  }/iio/industrialio-event.c (99%)
>>   rename drivers/{staging =>  }/iio/industrialio-trigger.c (99%)
>>   rename drivers/{staging =>  }/iio/inkern.c (98%)
>>   rename drivers/{staging =>  }/iio/kfifo_buf.c (99%)
>>   create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
>>   rename {drivers/staging =>  include/linux}/iio/buffer.h (99%)
>>   rename {drivers/staging =>  include/linux}/iio/consumer.h (99%)
>>   rename {drivers/staging =>  include/linux}/iio/driver.h (100%)
>>   rename {drivers/staging =>  include/linux}/iio/events.h (99%)
>>   rename {drivers/staging =>  include/linux}/iio/iio.h (99%)
>>   rename {drivers/staging =>  include/linux}/iio/kfifo_buf.h (70%)
>>   rename {drivers/staging =>  include/linux}/iio/machine.h (100%)
>>   rename {drivers/staging =>  include/linux}/iio/sysfs.h (100%)
>>   rename {drivers/staging =>  include/linux}/iio/trigger.h (100%)
>>   rename {drivers/staging =>  include/linux}/iio/trigger_consumer.h (100%)
>>   rename {drivers/staging =>  include/linux}/iio/types.h (100%)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

