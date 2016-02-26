Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36369 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbcBZPwM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2016 10:52:12 -0500
MIME-Version: 1.0
In-Reply-To: <20160221231751.GC1386@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	<20160221231751.GC1386@katana>
Date: Fri, 26 Feb 2016 17:52:10 +0200
Message-ID: <CAEnQRZCKJuYTxckGzcFvyTfvonwBqQW37D7Y5RqyeBbd2iPkKA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] iio: Fix ABBA deadlock in inv-mpu6050
From: Daniel Baluta <daniel.baluta@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-i2c@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ge Gao <ggao@invensense.com>,
	Adriana Reus <adi.reus@gmail.com>, Crt Mori <cmo@melexis.com>,
	Michael Welling <mwelling@ieee.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 22, 2016 at 1:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Feb 18, 2016 at 05:53:05PM +0200, Daniel Baluta wrote:
>> Sending this as an RFC because I don't know if style fixes are appropriate
>> for this driver and also not sure if deadlock fix is the best solution.
>>
>> I2C people should only look at patches 8/9 and 9/9.
>>
>> The mpu6050 accel+gyro combo has an auxiliary I2C bus, allowing for
>> an auxiliary sensor to be connected (eg. a magnetometer).
>>
>> The mpu can either act as an I2C master (functionality not currently
>> implemented in the driver) or it can use a bypass multiplexer which
>> directly connects the auxiliary I2C bus pins to the main I2C bus pins [1]
>> Currently the driver implements the bypass mode via an I2C mux.
>>
>> This patchset fixes a deadlock in inv-mpu6050 IMU which happens when
>> magnetometer (on auxiliary I2C bus) runs in parallel with accel or gyro.
>>
>> First 7 patches do some cleanup in order to make INV MPU6050 code easier
>> to read.
>>
>> Patch number 8 allows passing NULL select callbacks to i2c_mux_master_xfer
>> and i2c_mux_smbus_xfer.
>>
>> Patch number 9 actually fixes the deadlock.
>
> We recently had a bigger patch series fixing locking problems related to
> muxes. I sadly didn't have the time to review it. Can you have a look if
> it helps your case?
>
> http://thread.gmane.org/gmane.linux.drivers.i2c/26169


Hi Wolfram,

Tested this and the deadlock is still there :(.

It can be easily reproduced with following patch which enlarges
the race window:

iff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index a3f5070..279d6e0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -232,6 +232,7 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
                ret = IIO_VAL_INT;
                result = 0;
                mutex_lock(&indio_dev->mlock);
+               msleep(12000);
                if (!st->chip_config.enable) {
                        result = inv_mpu6050_set_power_itg(st, true);
                        if (result)


using the following commands:

$ cat /sys/bus/iio/devices/iio:device0/in_accel_x_raw
$ cat /sys/bus/iio/devices/iio:device1/in_magn_x_raw

Off topic: I'm very curious why I didn't get a lockdep splat while running this,
might be because adapter lock is a rt_mutex.

thanks,
Daniel.
