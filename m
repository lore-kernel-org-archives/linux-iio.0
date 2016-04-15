Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35057 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcDOOtx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2016 10:49:53 -0400
MIME-Version: 1.0
In-Reply-To: <570A64B1.7080303@kernel.org>
References: <1459954726-19553-1-git-send-email-daniel.baluta@intel.com>
	<570A64B1.7080303@kernel.org>
Date: Fri, 15 Apr 2016 17:49:51 +0300
Message-ID: <CAEnQRZAXufsHKLKNzv5DkuZJni=rMWXjKer6vw9Gey5tvrGFSw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: imu: Add initial support for Bosch BMI160
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 10, 2016 at 5:35 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 06/04/16 15:58, Daniel Baluta wrote:
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
> I'm still a little unconvinced abou the data handling in the trigger_handler.
> Sample should be __le16 I think which would make it all rather more
> obvious.

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
>> +             ret = regmap_bulk_read(data->regmap, base + i * sizeof(__le16),
>> +                                    &sample, sizeof(__le16));
> Shouldn't sample be an __le16 ideally?  Then you could use sizeof(sample)
> as well which would be more obviously right...

But will keep sizeof(__le16) similar with bmi160_get_data

>
>> +             if (ret < 0)
>> +                     goto done;
>> +             buf[j++] = sample;
> Probably makes sense to make buf __le16 buf[16] as well though that one isn't
> as important (and perhaps missleading in some ways)

Agree, will make sample an __le16 and keep s16 buf[16].

Daniel.
