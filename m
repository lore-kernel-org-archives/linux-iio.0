Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60330 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcBUUKc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:10:32 -0500
Subject: Re: [PATCH v2 1/1] iio:core: timestamping clock selection support
To: Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
References: <cover.1455892204.git.gregor.boirie@parrot.com>
 <2acb6f5baaf83ef9f05af970d0169f1fbc89cc02.1455892204.git.gregor.boirie@parrot.com>
 <56C73634.3000804@intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Crt Mori <cmo@melexis.com>,
	Masanari Iida <standby24x7@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA19B5.20903@kernel.org>
Date: Sun, 21 Feb 2016 20:10:29 +0000
MIME-Version: 1.0
In-Reply-To: <56C73634.3000804@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/16 15:35, Daniel Baluta wrote:
> 
> 
> On 19.02.2016 16:52, Gregor Boirie wrote:
>> Adds a new per-device sysfs attribute "timestamp_clock" to allow userspace
>> to select a particular POSIX clock for buffered samples and events
>> timestamping.
>>
>> Following clocks, as listed in clock_gettime(2), are supported:
>> CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW,
>> CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and
>> CLOCK_TAI.
> 
> Please run ./scripts/checkpatch.pl --strict, on your patch. There are some
> style fixes that you need to resolve :).
> 
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-iio           |   7 +
>>   Documentation/DocBook/iio.tmpl                    |   2 +-
>>   drivers/iio/accel/bma180.c                        |   2 +-
>>   drivers/iio/accel/bmc150-accel-core.c             |   4 +-
>>   drivers/iio/accel/kxcjk-1013.c                    |   2 +-
>>   drivers/iio/accel/mma7455_core.c                  |   3 +-
>>   drivers/iio/accel/mma8452.c                       |   4 +-
>>   drivers/iio/accel/mma9551.c                       |   2 +-
>>   drivers/iio/accel/mma9553.c                       |   2 +-
>>   drivers/iio/adc/ad7291.c                          |   2 +-
>>   drivers/iio/adc/ad7298.c                          |   2 +-
>>   drivers/iio/adc/ad7476.c                          |   2 +-
>>   drivers/iio/adc/ad7887.c                          |   2 +-
>>   drivers/iio/adc/ad7923.c                          |   2 +-
>>   drivers/iio/adc/ad799x.c                          |   4 +-
>>   drivers/iio/adc/cc10001_adc.c                     |   2 +-
>>   drivers/iio/adc/hi8435.c                          |   2 +-
>>   drivers/iio/adc/ina2xx-adc.c                      |   6 +-
>>   drivers/iio/adc/max1363.c                         |   5 +-
>>   drivers/iio/adc/ti-ads1015.c                      |   3 +-
>>   drivers/iio/adc/vf610_adc.c                       |   3 +-
>>   drivers/iio/adc/xilinx-xadc-events.c              |   4 +-
>>   drivers/iio/chemical/atlas-ph-sensor.c            |   2 +-
>>   drivers/iio/dac/ad5421.c                          |   6 +-
>>   drivers/iio/dac/ad5504.c                          |   2 +-
>>   drivers/iio/dummy/iio_simple_dummy_buffer.c       |   3 +-
>>   drivers/iio/dummy/iio_simple_dummy_events.c       |   2 +-
>>   drivers/iio/gyro/bmg160_core.c                    |  30 ++--
>>   drivers/iio/humidity/dht11.c                      |  16 +-
>>   drivers/iio/iio_core.h                            |   3 +
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        |   2 +-
>>   drivers/iio/industrialio-core.c                   | 179 +++++++++++++++++++++-
>>   drivers/iio/industrialio-event.c                  |  19 ++-
>>   drivers/iio/industrialio-trigger.c                |   2 +-
>>   drivers/iio/light/acpi-als.c                      |   2 +-
>>   drivers/iio/light/adjd_s311.c                     |   2 +-
>>   drivers/iio/light/apds9300.c                      |   2 +-
>>   drivers/iio/light/apds9960.c                      |   4 +-
>>   drivers/iio/light/cm36651.c                       |   2 +-
>>   drivers/iio/light/gp2ap020a00f.c                  |   8 +-
>>   drivers/iio/light/isl29125.c                      |   2 +-
>>   drivers/iio/light/lm3533-als.c                    |   2 +-
>>   drivers/iio/light/ltr501.c                        |   7 +-
>>   drivers/iio/light/opt3001.c                       |   4 +-
>>   drivers/iio/light/stk3310.c                       |   2 +-
>>   drivers/iio/light/tcs3414.c                       |   2 +-
>>   drivers/iio/light/tcs3472.c                       |   2 +-
>>   drivers/iio/light/tsl2563.c                       |   2 +-
>>   drivers/iio/light/us5182d.c                       |   2 +-
>>   drivers/iio/magnetometer/mag3110.c                |   2 +-
>>   drivers/iio/pressure/mpl3115.c                    |   2 +-
>>   drivers/iio/pressure/ms5611_core.c                |   3 +-
>>   drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |   2 +-
>>   drivers/iio/proximity/sx9500.c                    |   4 +-
>>   drivers/staging/iio/accel/lis3l02dq_core.c        |   2 +-
>>   drivers/staging/iio/accel/sca3000_core.c          |   2 +-
>>   drivers/staging/iio/adc/ad7280a.c                 |   8 +-
>>   drivers/staging/iio/adc/ad7606_ring.c             |   2 +-
>>   drivers/staging/iio/adc/ad7816.c                  |   3 +-
>>   drivers/staging/iio/addac/adt7316.c               |   4 +-
>>   drivers/staging/iio/cdc/ad7150.c                  |   2 +-
>>   drivers/staging/iio/light/tsl2x7x_core.c          |   2 +-
>>   drivers/staging/iio/magnetometer/hmc5843_core.c   |   2 +-
>>   include/linux/iio/iio.h                           |  20 ++-
>>   64 files changed, 324 insertions(+), 114 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 3c66248..c374b21 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -32,6 +32,13 @@ Description:
>>           Description of the physical chip / device for device X.
>>           Typically a part number.
>>   +What:        /sys/bus/iio/devices/iio:deviceX/timestamp_clock
> Do we need an attribute listing available timestamp clocks?
> If so, name timestamp_clock to current_timestamp_clock would make sense.
> 
> <snip>
>>   +/**
>> + * iio_get_time_ns() - utility function to get a time stamp for events etc
>> + * @indio_dev: device
>> + */
>> +s64 iio_get_time_ns(const struct iio_dev* indio_dev)
>> +{
>> +    struct timespec tp;
>> +
>> +    switch (iio_device_get_clock(indio_dev)) {
>> +    case CLOCK_REALTIME:
>> +        ktime_get_real_ts(&tp);
>> +        break;
>> +    case CLOCK_MONOTONIC:
>> +        ktime_get_ts(&tp);
>> +        break;
>> +    case CLOCK_MONOTONIC_RAW:
>> +        getrawmonotonic(&tp);
>> +        break;
>> +    case CLOCK_REALTIME_COARSE:
>> +        tp = current_kernel_time();
>> +        break;
>> +    case CLOCK_MONOTONIC_COARSE:
>> +        tp = get_monotonic_coarse();
>> +        break;
>> +    case CLOCK_BOOTTIME:
>> +        get_monotonic_boottime(&tp);
>> +        break;
>> +    case CLOCK_TAI:
>> +        timekeeping_clocktai(&tp);
>> +        break;
>> +    default:
>> +        BUG();
>> +    }
>> +
>> +    return timespec_to_ns(&tp);
>> +}
>> +EXPORT_SYMBOL(iio_get_time_ns);
>> +
>> +/**
>> + * iio_get_time_res() - utility function to get time stamp clock resolution in
>> + *                      nano seconds.
>> + * @indio_dev: device
>> + */
>> +unsigned int iio_get_time_res(const struct iio_dev* indio_dev)
>> +{
>> +    switch (iio_device_get_clock(indio_dev)) {
>> +    case CLOCK_REALTIME:
>> +    case CLOCK_MONOTONIC:
>> +    case CLOCK_MONOTONIC_RAW:
>> +    case CLOCK_BOOTTIME:
>> +    case CLOCK_TAI:
>> +        return hrtimer_resolution;
>> +    case CLOCK_REALTIME_COARSE:
>> +    case CLOCK_MONOTONIC_COARSE:
>> +        return LOW_RES_NSEC;
>> +    default:
>> +        BUG();
>> +    }
>> +}
>> +EXPORT_SYMBOL(iio_get_time_res);
>> +
>>   static int __init iio_init(void)
>>   {
>>       int ret;
>> @@ -904,11 +984,91 @@ static ssize_t iio_show_dev_name(struct device *dev,
>>     static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>>   +static ssize_t iio_show_timestamp_clock(struct device *dev,
>> +                                        struct device_attribute *attr,
>> +                                        char *buf)
>> +{
>> +    const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    const clockid_t clk = iio_device_get_clock(indio_dev);
>> +    const char* name;
>> +    ssize_t sz;
>> +
>> +    switch (clk) {
>> +    case CLOCK_REALTIME:
>> +        name = "CLOCK_REALTIME\n";
>> +        sz = sizeof("CLOCK_REALTIME\n");
>> +        break;
>> +    case CLOCK_MONOTONIC:
>> +        name = "CLOCK_MONOTONIC\n";
>> +        sz = sizeof("CLOCK_MONOTONIC\n");
>> +        break;
>> +    case CLOCK_MONOTONIC_RAW:
>> +        name = "CLOCK_MONOTONIC_RAW\n";
>> +        sz = sizeof("CLOCK_MONOTONIC_RAW\n");
>> +        break;
>> +    case CLOCK_REALTIME_COARSE:
>> +        name = "CLOCK_REALTIME_COARSE\n";
>> +        sz = sizeof("CLOCK_REALTIME_COARSE\n");
>> +        break;
>> +    case CLOCK_MONOTONIC_COARSE:
>> +        name = "CLOCK_MONOTONIC_COARSE\n";
>> +        sz = sizeof("CLOCK_MONOTONIC_COARSE\n");
>> +        break;
>> +    case CLOCK_BOOTTIME:
>> +        name = "CLOCK_BOOTTIME\n";
>> +        sz = sizeof("CLOCK_BOOTTIME\n");
>> +        break;
>> +    case CLOCK_TAI:
>> +        name = "CLOCK_TAI\n";
>> +        sz = sizeof("CLOCK_TAI\n");
>> +        break;
> I would have expected here to see lowercase clock ids. E.g
> "realtime monotonic monotonic_raw ..." etc.
I agree.
>> +    default:
>> +        BUG();
>> +    }
>> +
>> +    memcpy(buf, name, sz);
>> +    return sz;
>> +}
>> +
>>
> 
> thanks,
> Daniel.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

