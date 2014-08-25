Return-Path: <sricharan.chalasani@gmail.com>
MIME-Version: 1.0
Date: Mon, 25 Aug 2014 09:36:18 +0530
Message-ID: <CABLc4a_SoUktjQ=27w3=z2p65rgdDY8EKD8mTKZvo7ub6165Cg@mail.gmail.com>
Subject: help - pushing data to kernel buffers at unequal intervals for
 different ADC channels
From: Sricharan Chalasani <sricharan.chalasani@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan and all,

I have 4 channels on my Analog to digital converter. I like to enable
all the 4 channels with the following set of commands

Setting up channels in use

# echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en
# echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage1_en
# echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage2_en
# echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage3_en


Setting up the trigger

# echo "my_periodic_timer_trigger" >
/sys/bus/iio/devices/iio:device0/trigger/current_trigger

Setting up buffer length

# echo 100 > /sys/bus/iio/devices/iio:device0/buffer/length

Enable the buffer

# echo 1 > /sys/bus/iio/devices/iio:device0/buffer/enable


Now in my IIO ADC driver data is available at unequal intervals
meaning that ... (assuming that my ADC trigger handler is called once
in every 1 milli second)

1. After 1 milli seconds data is available on channel1 only ...
2. After 2 millli seconds new data is available on channel0 and channel2
3. After 3 milli seconds new data is available on channel0, channel2
and channel3
4. After 4 milli seconds new data is available on channel 2 and channel channel3
5. After 5 milli seconds new data is available on channel0. channel1,
chanel2, channel3

and it goes on like this ..... and my IIO ADC driver knows that on
which channels data is available at any given point of time ....


The idea is to push data to IIO buffer as and when data is available
on one or more channels. But, I understand that, the following
function expects that data (second argument to the function) be
available on all the 4 enabled channels before the function is called.

static inline int iio_push_to_buffers_with_timestamp(struct iio_dev
*indio_dev, void *data, int64_t timestamp)

Assuming that all the 4 channels are enabled from the user space for
buffered capture:

1. I understand that IIO supports pushing data to buffer if data is
available on all the enabled channels.

2. Please let me know if it is possible for me to push data to buffer
from my IIO ADC driver whenever data is available on any of the
channels.



Thanks and regards,
Sricharan.
