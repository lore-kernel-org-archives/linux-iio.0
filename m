Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:48890 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab0EFKLa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2010 06:11:30 -0400
Message-ID: <4BE29673.8030101@cam.ac.uk>
Date: Thu, 06 May 2010 11:14:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] staging:iio:imu remove unecessary empty defs for
 	event attributes.
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk> 	<1273098346-4184-7-git-send-email-jic23@cam.ac.uk> <t2z3c17e3571005052027i5d79afb3of2d16e49e47583fd@mail.gmail.com>
In-Reply-To: <t2z3c17e3571005052027i5d79afb3of2d16e49e47583fd@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/10 04:27, Barry Song wrote:
> Does this patch work in the newest tree? In our current tree, it will
> cause kernel panic in iio_register_interrupt_line() due to NULL
> pointer.
Yikes.  That's a bug if it does. If nothing else it should kick out an error
rather than a kernel panic as it is clearly something that might be the case
in half developed drivers.

Ah, I missed the fact you were calling iio_register_interrupt_line, which to
my mind makes no sense in this driver.  Here, you aren't actually using the
interrupt for any events.  I think some confusion has occured in the interaction
between the trigger and the event lines (due to some decidedly dubious function
names on my part!).

A trigger irq can be handled separately (as per iio-trig-gpio).
That would mean you weren't calling the iio_register_interrupt_line function
at all and is what I'd tend to expect for a line without additional events.

As it doesn't make sense to have an 'interrupt line' (which is actually an event line)
available unless there are actual events that might come down it, I didn't allow for
this in the code.

The question on these devices is whether to support the trigger and events sharing
a line, or whether we just assume that several of the available interrupt lines are
connected and the event comes down one of them?

The approach used in the lis3l02dq (where I think the approach used here probably
started) is necessary as it only has one interrupt line.  IIRC it is a mutually
exclusive line at that, you either get events or data rdy according to the settings.

Thanks for spotting this one.  Goes to show that even seemingly inocuous patches
can cause trouble!

Jonathan
> -barry
> 
> On Thu, May 6, 2010 at 6:25 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/imu/adis16300_core.c |   10 ----------
>>  drivers/staging/iio/imu/adis16400_core.c |   10 ----------
>>  2 files changed, 0 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
>> index 5a7e5ef..54e3e51 100644
>> --- a/drivers/staging/iio/imu/adis16300_core.c
>> +++ b/drivers/staging/iio/imu/adis16300_core.c
>> @@ -566,14 +566,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
>>
>>  static IIO_CONST_ATTR(name, "adis16300");
>>
>> -static struct attribute *adis16300_event_attributes[] = {
>> -       NULL
>> -};
>> -
>> -static struct attribute_group adis16300_event_attribute_group = {
>> -       .attrs = adis16300_event_attributes,
>> -};
>> -
>>  static struct attribute *adis16300_attributes[] = {
>>        &iio_dev_attr_accel_x_offset.dev_attr.attr,
>>        &iio_dev_attr_accel_y_offset.dev_attr.attr,
>> @@ -637,8 +629,6 @@ static int __devinit adis16300_probe(struct spi_device *spi)
>>        }
>>
>>        st->indio_dev->dev.parent = &spi->dev;
>> -       st->indio_dev->num_interrupt_lines = 1;
>> -       st->indio_dev->event_attrs = &adis16300_event_attribute_group;
>>        st->indio_dev->attrs = &adis16300_attribute_group;
>>        st->indio_dev->dev_data = (void *)(st);
>>        st->indio_dev->driver_module = THIS_MODULE;
>> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
>> index 2c10072..34c0ee5 100644
>> --- a/drivers/staging/iio/imu/adis16400_core.c
>> +++ b/drivers/staging/iio/imu/adis16400_core.c
>> @@ -595,14 +595,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
>>
>>  static IIO_CONST_ATTR(name, "adis16400");
>>
>> -static struct attribute *adis16400_event_attributes[] = {
>> -       NULL
>> -};
>> -
>> -static struct attribute_group adis16400_event_attribute_group = {
>> -       .attrs = adis16400_event_attributes,
>> -};
>> -
>>  static struct attribute *adis16400_attributes[] = {
>>        &iio_dev_attr_accel_x_offset.dev_attr.attr,
>>        &iio_dev_attr_accel_y_offset.dev_attr.attr,
>> @@ -669,8 +661,6 @@ static int __devinit adis16400_probe(struct spi_device *spi)
>>        }
>>
>>        st->indio_dev->dev.parent = &spi->dev;
>> -       st->indio_dev->num_interrupt_lines = 1;
>> -       st->indio_dev->event_attrs = &adis16400_event_attribute_group;
>>        st->indio_dev->attrs = &adis16400_attribute_group;
>>        st->indio_dev->dev_data = (void *)(st);
>>        st->indio_dev->driver_module = THIS_MODULE;
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

