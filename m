Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:9604 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756914Ab2EGPRl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 May 2012 11:17:41 -0400
Message-ID: <4FA7E78E.6050406@analog.com>
Date: Mon, 7 May 2012 17:17:34 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: <michael.hennerich@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital Variable
 Gain Amplifier
References: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com> <4F6A2D2B.9050400@kernel.org> <4F6AE844.7020102@analog.com> <4F6AEC83.8010009@cam.ac.uk> <4FA7E373.2080704@analog.com>
In-Reply-To: <4FA7E373.2080704@analog.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/2012 05:00 PM, Michael Hennerich wrote:
> On 03/22/2012 10:10 AM, Jonathan Cameron wrote:
>> On 3/22/2012 8:52 AM, Michael Hennerich wrote:
>>> On 03/21/2012 08:34 PM, Jonathan Cameron wrote:
>>>> On 02/22/2012 12:36 PM, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>> Sorry for the slow response on this one. Been off sick...
>>>>
>>>> Anyhow, I'm still not sure what the right interface for this type
>>>> of device is.
>>>>
>>>> The obvious options are:
>>>>
>>>> 1) Make gain an IIO type (doesn't make much sense as gain is only 
>>>> going
>>>> to be of one particular existing type).
>>>> 2) Have it as an IIO_ALTVOLTAGE channel as you have here and use 
>>>> extend
>>>> name.  Any real reason for picking altvoltage rather than voltage?
>>> I'm open for advice. Since I made the amplifier being an OUT type 
>>> device
>>> I chose IIO_ALTVOLTAGE analogous to our DDS/PLL drivers.
>>> Some VGAs/PGAs work from DC, but typically VGAs are HF devices.
>> Hmm.. Don't suppose it really matters but we ought to aim for 
>> consistency
>> (by review) at least.  This particular part is DC through to 600MHz.
>>>> Clearly gain has the same meaning in either case (assuming it's 
>>>> linear).
>>>> 3) Make a change to core to allow a channel to have elements in
>>>> info_mask but not actually to have a raw access.  Not entirely sure
>>>> how we will do that cleanly.  Also it's not clear whether the gain
>>>> would be an IN or an OUT channel type!
>>> Well - having the ability for channels without raw access element
>>> would be of interest.
>> True enough.  Cleanest way to do this that I can think of is to make 
>> a tree
>> wide change to add the raw element to the info_mask.  We could allow for
>> a zero info_mask value actually being the equivalent of having only a 
>> raw
>> channel.  It's invasive but if we agreee it should be done now is
>> probably the
>> best time to do it (just post merge window etc).
> Hi Jonathan,
>
> Thanks for getting this in place.
>
>>
>> Whilst here, we clearly need way of destinguishing values in DB from 
>> linear
>> gains.  Could add a new return type for read_raw callbacks?
>
> Does something like this work for you?
> Also wondering if we should introduce IIO_CHAN_INFO_GAIN
> for amplifier type devices?

Thinking about it a bit more - why not have iio_chan_type:IIO_GAIN?

>
> From e62f3a3de86f2edde2137237531732cdf5fc2ed8 Mon Sep 17 00:00:00 2001
> From: Michael Hennerich <michael.hennerich@analog.com>
> Date: Mon, 7 May 2012 16:53:45 +0200
> Subject: [PATCH] iio: core: introduce dB scle: IIO_VAL_INT_PLUS_MICRO_DB
>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/iio/industrialio-core.c |   19 +++++++++++++------
>  include/linux/iio/types.h       |    1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c 
> b/drivers/iio/industrialio-core.c
> index 72e33b8..e436f6f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -306,26 +306,33 @@ static ssize_t iio_read_channel_info(struct 
> device *dev,
>      struct iio_dev *indio_dev = dev_get_drvdata(dev);
>      struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>      int val, val2;
> +    bool scale_db = false;
>      int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> &val, &val2, this_attr->address);
>
>      if (ret < 0)
>          return ret;
>
> -    if (ret == IIO_VAL_INT)
> +    switch (ret) {
> +    case IIO_VAL_INT:
>          return sprintf(buf, "%d\n", val);
> -    else if (ret == IIO_VAL_INT_PLUS_MICRO) {
> +    case IIO_VAL_INT_PLUS_MICRO_DB:
> +        scale_db = true;
> +    case IIO_VAL_INT_PLUS_MICRO:
>          if (val2 < 0)
> -            return sprintf(buf, "-%d.%06u\n", val, -val2);
> +            return sprintf(buf, "-%d.%06u%s\n", val, -val2,
> +                scale_db ? " db" : "");
>          else
> -            return sprintf(buf, "%d.%06u\n", val, val2);
> -    } else if (ret == IIO_VAL_INT_PLUS_NANO) {
> +            return sprintf(buf, "%d.%06u%s\n", val, val2,
> +                scale_db ? " db" : "");
> +    case IIO_VAL_INT_PLUS_NANO:
>          if (val2 < 0)
>              return sprintf(buf, "-%d.%09u\n", val, -val2);
>          else
>              return sprintf(buf, "%d.%09u\n", val, val2);
> -    } else
> +    default:
>          return 0;
> +    }
>  }
>
>  static ssize_t iio_write_channel_info(struct device *dev,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a471fd5..1b073b1 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -50,5 +50,6 @@ enum iio_modifier {
>  #define IIO_VAL_INT 1
>  #define IIO_VAL_INT_PLUS_MICRO 2
>  #define IIO_VAL_INT_PLUS_NANO 3
> +#define IIO_VAL_INT_PLUS_MICRO_DB 4
>
>  #endif /* _IIO_TYPES_H_ */


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


