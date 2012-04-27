Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:42362 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab2D0IZ2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Apr 2012 04:25:28 -0400
Message-ID: <4F9A57F1.5080308@cam.ac.uk>
Date: Fri, 27 Apr 2012 09:25:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 4/4] iio: core: iio_chan_spec_ext_info: Add private handle
References: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com> <1335443643-20439-4-git-send-email-michael.hennerich@analog.com> <544AC56F16B56944AEC3BD4E3D5917714E7965FA71@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714E7965FA71@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/27/2012 8:55 AM, Hennerich, Michael wrote:
> michael.hennerich@analog.com wrote on 2012-04-26:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> There is currently no user, but we might need it in future.
>> So better add it now, before we have to convert drivers afterwards.
> Hi Jonathan,
>
> Do you Ack this one as well?
>
> This patch is really meant to avoid code duplication,
> in case you have multiple ext_info entries which could share the same
> call[back] functions. This way we set private with dedicated value,
> which then helps to differentiate the actions.
>
> I made private type uintptr_t, in order to also hold a pointer if
> required.
No problem with this. Sorry, got called away and forgot about it!

I'm not entirely sure these ext_info bits are the best way to do things, but
there are far more important bits of the subsystem to work on for now
and I don't have a better idea!
>
> -Michael
>
>
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>   drivers/iio/industrialio-core.c  |    5 +++--
>>   drivers/staging/iio/dac/ad5064.c |   12 +++++++-----
>>   drivers/staging/iio/dac/ad5446.c |    6 +++++-
>>   include/linux/iio/iio.h          |   11 +++++++----
>>   4 files changed, 22 insertions(+), 12 deletions(-)
>> diff --git a/drivers/iio/industrialio-core.c
>> b/drivers/iio/industrialio-core.c index 1c55d2b..8f72ab8 100644 ---
>> a/drivers/iio/industrialio-core.c +++ b/drivers/iio/industrialio-core.c
>> @@ -281,7 +281,7 @@ static ssize_t iio_read_channel_ext_info(struct
>> device *dev,
>>
>>        ext_info =&this_attr->c->ext_info[this_attr->address];
>> -     return ext_info->read(indio_dev, this_attr->c, buf);
>> +     return ext_info->read(indio_dev, ext_info->private, this_attr->c,
>> buf);
>>   }
>>
>>   static ssize_t iio_write_channel_ext_info(struct device *dev,
>> @@ -295,7 +295,8 @@ static ssize_t iio_write_channel_ext_info(struct
>> device *dev,
>>
>>        ext_info =&this_attr->c->ext_info[this_attr->address];
>> -     return ext_info->write(indio_dev, this_attr->c, buf, len);
>> +     return ext_info->write(indio_dev, ext_info->private,
>> +                            this_attr->c, buf, len);
>>   }
>>
>>   static ssize_t iio_read_channel_info(struct device *dev,
>> diff --git a/drivers/staging/iio/dac/ad5064.c
>> b/drivers/staging/iio/dac/ad5064.c index c0fad4f..e06f1d1 100644 ---
>> a/drivers/staging/iio/dac/ad5064.c +++
>> b/drivers/staging/iio/dac/ad5064.c @@ -144,14 +144,14 @@ static const
>> char ad5064_powerdown_modes[][15] = {
>>   };
>>
>>   static ssize_t ad5064_read_powerdown_mode_available(struct iio_dev
>> *indio_dev,
>> -     const struct iio_chan_spec *chan, char *buf)
>> +     uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>>   {
>>        return sprintf(buf, "%s %s %s\n", ad5064_powerdown_modes[1],
>>                ad5064_powerdown_modes[2], ad5064_powerdown_modes[3]);
>>   }
>>
>>   static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
>> -     const struct iio_chan_spec *chan, char *buf)
>> +     uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>>   {
>>        struct ad5064_state *st = iio_priv(indio_dev);
>> @@ -160,7 +160,8 @@ static ssize_t ad5064_read_powerdown_mode(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5064_write_powerdown_mode(struct iio_dev *indio_dev,
>> -     const struct iio_chan_spec *chan, const char *buf, size_t len)
>> +     uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
>> +     size_t len)
>>   {
>>        struct ad5064_state *st = iio_priv(indio_dev);
>>        unsigned int mode, i;
>> @@ -187,7 +188,7 @@ static ssize_t ad5064_write_powerdown_mode(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
>> -     const struct iio_chan_spec *chan, char *buf)
>> +     uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>>   {
>>        struct ad5064_state *st = iio_priv(indio_dev);
>> @@ -195,7 +196,8 @@ static ssize_t ad5064_read_dac_powerdown(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
>> -     const struct iio_chan_spec *chan, const char *buf, size_t len) +
>> uintptr_t private, const struct iio_chan_spec *chan, const char *buf, +
>> size_t len)
>>   {
>>        struct ad5064_state *st = iio_priv(indio_dev);
>>        bool pwr_down;
>> diff --git a/drivers/staging/iio/dac/ad5446.c
>> b/drivers/staging/iio/dac/ad5446.c index 62ad1d5..55e34d4 100644 ---
>> a/drivers/staging/iio/dac/ad5446.c +++
>> b/drivers/staging/iio/dac/ad5446.c @@ -46,13 +46,14 @@ static const char
>> * const ad5446_powerdown_modes[] = {
>>   };
>>
>>   static ssize_t ad5446_read_powerdown_mode_available(struct iio_dev
>> *indio_dev,
>> -     const struct iio_chan_spec *chan, char *buf)
>> +     uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>>   {
>>        return sprintf(buf, "%s %s %s\n", ad5446_powerdown_modes[1],
>>                ad5446_powerdown_modes[2], ad5446_powerdown_modes[3]);
>>   }
>>
>>   static ssize_t ad5446_write_powerdown_mode(struct iio_dev *indio_dev,
>>   +                                        uintptr_t private,                                      const struct iio_chan_spec *chan,
>>                                            const char *buf, size_t len) {
>> @@ -73,6 +74,7 @@ static ssize_t ad5446_write_powerdown_mode(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5446_read_powerdown_mode(struct iio_dev *indio_dev,
>>   +                                       uintptr_t private,                                      const struct iio_chan_spec *chan,
>>                                           char *buf) {
>> @@ -82,6 +84,7 @@ static ssize_t ad5446_read_powerdown_mode(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
>>   +                                       uintptr_t private,                                      const struct iio_chan_spec *chan,
>>                                           char *buf) {
>> @@ -91,6 +94,7 @@ static ssize_t ad5446_read_dac_powerdown(struct
>> iio_dev *indio_dev,
>>   }
>>
>>   static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
>>   +                                        uintptr_t private,                                      const struct iio_chan_spec *chan,
>>                                            const char *buf, size_t len) {
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 0e826af..263b430 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -111,14 +111,17 @@ struct iio_dev;
>>    * @shared:  Whether this attribute is shared between all channels. *
>>    @read:      Read callback for this info attribute, may be NULL. *
>>    @write:     Write callback for this info attribute, may be NULL. + *
>>    @private:   Data private to the driver. */
>>   struct iio_chan_spec_ext_info {
>>        const char *name;
>>        bool shared;
>> -     ssize_t (*read)(struct iio_dev *, struct iio_chan_spec const *,
>> -                     char *buf);
>> -     ssize_t (*write)(struct iio_dev *, struct iio_chan_spec const *,
>> -                     const char *buf, size_t len);
>> +     ssize_t (*read)(struct iio_dev *, uintptr_t private,
>> +                     struct iio_chan_spec const *, char *buf);
>> +     ssize_t (*write)(struct iio_dev *, uintptr_t private,
>> +                      struct iio_chan_spec const *, const char *buf,
>> +                      size_t len);
>> +     uintptr_t private;
>>   };
>>
>>   /**
> Greetings,
> Michael
>
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

