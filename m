Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097Ab3ANTMm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jan 2013 14:12:42 -0500
Message-ID: <50F458A7.7090904@kernel.org>
Date: Mon, 14 Jan 2013 19:12:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [PATCH V4] Invensense MPU6050 Device Driver.
References: <1354670655-21946-1-git-send-email-ggao@invensense.com> <50BF407C.7020709@metafoo.de> <126d7591e6a837d8ff163685716e7f4b@mail.gmail.com> <50C0FCF3.3020207@metafoo.de> <50C10BC2.4000704@kernel.org> <d57096712cb8f081022668d4751f12fd@mail.gmail.com>
In-Reply-To: <d57096712cb8f081022668d4751f12fd@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2013 06:40 PM, Ge Gao wrote:
> Dear Jonanthan,
> 
>         I submitted another version of driver for Invensense MPU6050last week. It basically fixed everything you said in
> the comments. It also removed the inv_mpu_misc file, which is not useful while taking too much spaces.However, only one
> thing I am not surewhat to do with your comments.In the trigger part, as the red part shown below, what that mean and
> what I am supposed to do to make a“callback”. Thanks.

see validate_trigger in struct iio_info and how it's used in say
drivers/iio/adc/ad_sigma_delta.c to enforce the use of a trigger by the device
that created it.  Note there is also a validate_device callback in the
struct iio_trigger_ops to handle the opposite.

Sometimes a particular device will only work with the trigger in question
(say a data ready signal) but nothing prevents other devices from using
that trigger.  In other cases the trigger may only be used by a particular
device.

So to enforce one trigger to one device you would need both.  Not sure
what enforcing you need here (can't remember from when I last looked
at your code and don't have enough time to take a close look today).

It might be a few days before I get round to another review of your
driver as have a few other bits that hit me earlier to catch up with.
(and it's big so you get jumped by the trivial stuff ;)

Jonathan
> 
> Best Regards,
> 
> Ge GAO
> 
>> +static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
> 
>> +                                             bool state)
> 
>> +{
> 
>> +     struct iio_dev *indio_dev = trig->private_data;
> 
>> +
> 
>> +     return set_inv_enable(indio_dev, state);
> 
> Combine the above into one line.
> 
>> +}
> 
>> +
> 
>> +static const struct iio_trigger_ops inv_mpu_trigger_ops = {
> 
>> +     .owner = THIS_MODULE,
> 
>> +     .set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
> 
> You need some callbacks to prevent this being attached to another
> 
> trigger...
> 
>> +};
> 
>> +
> 
>> +int inv_mpu_probe_trigger(struct iio_dev *indio_dev)
> 
>> +{
> 
>> +     int ret;
> 
>> +     struct inv_mpu_iio_s *st = iio_priv(indio_dev);
> 
>> +
> 
>> +     st->trig = iio_trigger_alloc("%s-dev%d",
> 
