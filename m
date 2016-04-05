Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34283 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbcDEI2t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2016 04:28:49 -0400
MIME-Version: 1.0
In-Reply-To: <5700D9FA.4020600@kernel.org>
References: <1459513870-3852-1-git-send-email-daniel.baluta@intel.com>
	<5700D9FA.4020600@kernel.org>
Date: Tue, 5 Apr 2016 11:28:46 +0300
Message-ID: <CAEnQRZC+rKpQvr4DBGa0K9C9qty5g33EuhOhpQbKB9uqKfc3Ow@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: Add initial support for Bosch BMI160
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 3, 2016 at 11:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/04/16 13:31, Daniel Baluta wrote:
>> BMI160 is an Inertial Measurement Unit (IMU) which provides acceleration
>> and angular rate measurement. It also offers a secondary I2C interface
>> for connecting a magnetometer sensor (usually BMM160).
>>
>> Current driver offers support for accelerometer and gyroscope readings
>> via sysfs or via buffer interface using an external trigger (e.g.
>> hrtimer). Data is retrieved from IMU via I2C or SPI interface.
>>
>> Datasheet is at:
>>       http://www.mouser.com/ds/2/783/BST-BMI160-DS000-07-786474.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> A few bits inline.  Mostly around the trigger handler...

Answers inline . Thanks a lot for review!

<snip>

>> +/* scan indexes follow DATA register order */
>> +enum bmi160_scan_axis {
>> +     BMI160_SCAN_EXT_MAGN_X = 0,
>> +     BMI160_SCAN_EXT_MAGN_Y,
>> +     BMI160_SCAN_EXT_MAGN_Z,
>> +     BMI160_SCAN_RHALL,
> Given the ordering in here is arbitary, why include the unsupported elements
> at this stage?  Don't suppose it does any harm though.

This is not exactly arbitrarily. The ordering of these elements matters
because this is the layout in memory for DATA registers. But I see
how removing the references for unsupported elements will still work
but the code it's more readable like that. So I prefer to keep them.

<snip>

>> +     reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * 2;
>> +
>> +     ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
> This looks better for sample than in the trigger handler below.

I'm not sure I understand this, but lets go to the trigger handler below :).


<snip>

>> +static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct bmi160_data *data = iio_priv(indio_dev);
>> +     s16 buf[16]; /* 3 sens x 3 axis x s16 + 3 x s16 pad + 4 x s16 tstamp */
>> +     int i, ret, sample, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>> +
>> +     for_each_set_bit(i, indio_dev->active_scan_mask,
>> +                      indio_dev->masklength) {
> Unless I'm missing something this could pass a stack variable into a
> dma transfer - where alignment needs to be right...
>
> Also, a fixed integer size would probably be wise for sample.
>
>> +             ret = regmap_bulk_read(data->regmap, base + 2 * i, &sample,
>> +                                    sizeof(sample));

Hmm, like sizeof(__le16) right instead of sizeof(sample)? Each call to
regmap_bulk_read
here should read one axis - 2 bytes, so I think I get it. Hopefully,
will see it in v2.


>> +     usleep_range(BMI160_SOFTRESET_SLEEP, BMI160_SOFTRESET_SLEEP + 1);
>> +
>> +     /* CS rising edge is needed before starting SPI, so do a dummy read */
> Is this documented?  Seems a little 'interesting'!

Yes, will add a reference to data sheet in v2.



>> +#define BMI160_I2C_DRV_NAME  "bmi160_i2c"
> Could just use it inline given the one location in which it's used.

Ok.

>> +
>> +static const struct regmap_config bmi160_regmap_config = {
>> +     .reg_bits = 8,
>> +     .val_bits = 8,
>> +};
> Could share the regmap config between the two drivers by moving it to the
> core..  Not sure it's worth bothering though.

Will fix. Also Peter mentioned this.

thanks,
Daniel.
