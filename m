Return-Path: <jic23@cam.ac.uk>
Message-ID: <4F350007.3050305@cam.ac.uk>
Date: Fri, 10 Feb 2012 11:31:19 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marek.vasut@gmail.com>
CC: linux-iio@vger.kernel.org, jic23@kernel.org,
 Wolfgang Denk <wd@denx.de>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] [RFC] Add per-channel oversampling count
References: <1328853126-16578-1-git-send-email-marek.vasut@gmail.com> <201202101144.51719.marek.vasut@gmail.com> <4F34F94B.3070709@cam.ac.uk> <201202101219.44752.marek.vasut@gmail.com>
In-Reply-To: <201202101219.44752.marek.vasut@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 2/10/2012 11:19 AM, Marek Vasut wrote:
>> On 2/10/2012 10:44 AM, Marek Vasut wrote:
>>>> On 2/10/2012 5:52 AM, Marek Vasut wrote:
>>>>> This allows each channel to configure it's oversampling count.
>>>> Fine, but please also add documention in
>>>> staging/iio/Documentation/sysfs-bus-iio
>>> Understood. Is doing it this way OK with you?
>> Yup. Though as the other email states, it is going to be 'interesting'
>> handling this through the demux
>> that sends the right data to individual consumer drivers.
> The only consumer're gonna be temp and touchscreen I believe. And since the
> touchscreen stuff is quite tightly integrated with the LRADC, I might even end
> up exporting a few functions from the iio driver to bind the touchscreen.
We end up discussing how to do touchscreen drivers every time.   It 
always comes back to whether
we can generalize across enough different implementations to make it 
worth adding control hooks
to the IIO core, or as you say just add the support directly into the 
IIO device driver (basically
have it register an input device as well - or export enough stuff to 
allow that elsewhere.)

hwmon is easy, though I need to push out latest version of the code for 
that. Personally stalled on
testing whilst trying to nail a reason all the mfp config on my test 
board is throwing up errors right now.
The previous version I posted is find for development though as all 
changes are internal to the IIO core.
>
> Though I'll need to thing about it.
>
> M
>
>>>>> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
>>>>> Cc: Wolfgang Denk<wd@denx.de>
>>>>> Cc: Stefano Babic<sbabic@denx.de>
>>>>> Cc: Fabio Estevam<festevam@gmail.com>
>>>>> ---
>>>>>
>>>>>     drivers/staging/iio/iio.h               |    5 +++++
>>>>>     drivers/staging/iio/industrialio-core.c |    1 +
>>>>>     2 files changed, 6 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>>>>> index b3a1740..0b626ae 100644
>>>>> --- a/drivers/staging/iio/iio.h
>>>>> +++ b/drivers/staging/iio/iio.h
>>>>> @@ -36,6 +36,7 @@ enum iio_chan_info_enum {
>>>>>
>>>>>     	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
>>>>>     	IIO_CHAN_INFO_AVERAGE_RAW,
>>>>>     	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
>>>>>
>>>>> +	IIO_CHAN_INFO_OVERSAMPLE_COUNT,
>>>>>
>>>>>     };
>>>>>
>>>>>     #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
>>>>>
>>>>> @@ -81,6 +82,10 @@ enum iio_chan_info_enum {
>>>>>
>>>>>     #define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT \
>>>>>
>>>>>     	IIO_CHAN_INFO_SEPARATE_BIT(			       \
>>>>>     	
>>>>>     		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
>>>>>
>>>>> +#define IIO_CHAN_INFO_OVERSAMPLE_COUNT_SEPARATE_BIT		\
>>>>> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_OVERSAMPLE_COUNT)
>>>>> +#define IIO_CHAN_INFO_OVERSAMPLE_COUNT_SHARED_BIT		\
>>>>> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_OVERSAMPLE_COUNT)
>>>>>
>>>>>     enum iio_endian {
>>>>>
>>>>>     	IIO_CPU,
>>>>>
>>>>> diff --git a/drivers/staging/iio/industrialio-core.c
>>>>> b/drivers/staging/iio/industrialio-core.c index 9c41c83..05b6fdd 100644
>>>>> --- a/drivers/staging/iio/industrialio-core.c
>>>>> +++ b/drivers/staging/iio/industrialio-core.c
>>>>> @@ -87,6 +87,7 @@ static const char * const iio_chan_info_postfix[] = {
>>>>>
>>>>>     	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
>>>>>     	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>>>>>     	= "filter_low_pass_3db_frequency",
>>>>>
>>>>> +	[IIO_CHAN_INFO_OVERSAMPLE_COUNT] = "oversample_count",
>>>>>
>>>>>     };
>>>>>
>>>>>     const struct iio_chan_spec
