Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46902 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759337AbaLLKbA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:31:00 -0500
Message-ID: <548AC3E2.4090805@kernel.org>
Date: Fri, 12 Dec 2014 10:30:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 05/11] staging:iio:dummy: Register same channels for device
 and buffer
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>	<1417024517-7564-6-git-send-email-lars@metafoo.de> <CAEnQRZDwOT1q=gKXg8Lh37GF8RX-UJfX-Jt+LVKoe3nMO6ztHA@mail.gmail.com>
In-Reply-To: <CAEnQRZDwOT1q=gKXg8Lh37GF8RX-UJfX-Jt+LVKoe3nMO6ztHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/14 14:27, Daniel Baluta wrote:
> On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> In preparation for moving the buffer registration to the core make sure to
>> register the same channel array for the device and the buffer. Currently the
>> output voltage and the activity channels are not registered for the buffer,
>> setting its scan index to -1 will make sure that it is skipped for the
>> buffer.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/staging/iio/iio_simple_dummy.c        | 13 +++++--------
>>  drivers/staging/iio/iio_simple_dummy.h        |  3 +--
>>  drivers/staging/iio/iio_simple_dummy_buffer.c |  6 +++---
>>  3 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
>> index 10a9e08..0b8611a 100644
>> --- a/drivers/staging/iio/iio_simple_dummy.c
>> +++ b/drivers/staging/iio/iio_simple_dummy.c
>> @@ -239,6 +239,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>         {
>>                 .type = IIO_VOLTAGE,
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +               .scan_index = -1, /* No buffer support */
>>                 .output = 1,
>>                 .indexed = 1,
>>                 .channel = 0,
>> @@ -248,7 +249,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_ENABLE) |
>>                         BIT(IIO_CHAN_INFO_CALIBHEIGHT),
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> -               .scan_index = -1,
>> +               .scan_index = -1, /* No buffer support */
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>                 .event_spec = &step_detect_event,
>>                 .num_event_specs = 1,
>> @@ -259,6 +260,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .modified = 1,
>>                 .channel2 = IIO_MOD_RUNNING,
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +               .scan_index = -1, /* No buffer support */
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>                 .event_spec = &iio_running_event,
>>                 .num_event_specs = 1,
>> @@ -269,6 +271,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .modified = 1,
>>                 .channel2 = IIO_MOD_WALKING,
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +               .scan_index = -1, /* No buffer support */
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>                 .event_spec = &iio_walking_event,
>>                 .num_event_specs = 1,
>> @@ -638,13 +641,7 @@ static int iio_dummy_probe(int index)
>>         if (ret < 0)
>>                 goto error_free_device;
>>
>> -       /*
>> -        * Configure buffered capture support and register the channels with the
>> -        * buffer, but avoid the output channel being registered by reducing the
>> -        * number of channels by 1.
>> -        */
>> -       ret = iio_simple_dummy_configure_buffer(indio_dev,
>> -                                               iio_dummy_channels, 5);
>> +       ret = iio_simple_dummy_configure_buffer(indio_dev);
>>         if (ret < 0)
>>                 goto error_unregister_events;
>>
>> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
>> index 3b714b4..af70126 100644
>> --- a/drivers/staging/iio/iio_simple_dummy.h
>> +++ b/drivers/staging/iio/iio_simple_dummy.h
>> @@ -114,8 +114,7 @@ enum iio_simple_dummy_scan_elements {
>>  };
>>
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
>> -int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
>> -       const struct iio_chan_spec *channels, unsigned int num_channels);
>> +int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
>>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
>>  #else
>>  static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
>> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
>> index fd74f91..35d60d5 100644
>> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
>> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
>> @@ -115,8 +115,7 @@ static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
>>         .predisable = &iio_triggered_buffer_predisable,
>>  };
>>
>> -int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
>> -       const struct iio_chan_spec *channels, unsigned int num_channels)
>> +int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
>>  {
>>         int ret;
>>         struct iio_buffer *buffer;
>> @@ -173,7 +172,8 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
>>          */
>>         indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>>
>> -       ret = iio_buffer_register(indio_dev, channels, num_channels);
>> +       ret = iio_buffer_register(indio_dev, indio_dev->channels,
>> +                                 indio_dev->num_channels);
>>         if (ret)
>>                 goto error_dealloc_pollfunc;
>>
> 
> Looks good. I guess this can replace the following patch:
> 
> iio: dummy: set scan_index for unbuffered channels
> 
> http://marc.info/?l=linux-iio&m=141693190013582&w=2
Thanks for pointing that out.  Applied this one to the togreg
branch of iio.git.


> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

