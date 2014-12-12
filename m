Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47380 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965873AbaLLLtA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 06:49:00 -0500
Message-ID: <548AD62A.2040505@kernel.org>
Date: Fri, 12 Dec 2014 11:48:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: dummy: set scan_index for unbuffered channels
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>	<1416919687-14271-2-git-send-email-vlad.dogaru@intel.com> <CAEnQRZAeNkAp1=iCfaY02h_BaEVFueNA=wyf=NUOZe1_3PyTNw@mail.gmail.com>
In-Reply-To: <CAEnQRZAeNkAp1=iCfaY02h_BaEVFueNA=wyf=NUOZe1_3PyTNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/11/14 16:11, Daniel Baluta wrote:
> On Tue, Nov 25, 2014 at 2:48 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
>> If we do not set scan_index explicitly it will default to 0, causing
>> more than one channel to have the same scan_index.  This does not make
>> sense, as scan_index is used to order values in a buffer sample.
>>
>> Set the activity and voltage output channels to unbuffered
>> (scan_index = -1) to fix this.
>>
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
An equivalent change was in Lars' buffer cleanup patches.

You did there first, but his was doing lots of other things as well
so I've applied Lars' version.

Thanks

Jonathan
> 
>> ---
>>  drivers/staging/iio/iio_simple_dummy.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
>> index 10a9e08..2948900 100644
>> --- a/drivers/staging/iio/iio_simple_dummy.c
>> +++ b/drivers/staging/iio/iio_simple_dummy.c
>> @@ -242,6 +242,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .output = 1,
>>                 .indexed = 1,
>>                 .channel = 0,
>> +               .scan_index = -1,
>>         },
>>         {
>>                 .type = IIO_STEPS,
>> @@ -259,6 +260,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .modified = 1,
>>                 .channel2 = IIO_MOD_RUNNING,
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +               .scan_index = -1,
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>                 .event_spec = &iio_running_event,
>>                 .num_event_specs = 1,
>> @@ -269,6 +271,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>>                 .modified = 1,
>>                 .channel2 = IIO_MOD_WALKING,
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +               .scan_index = -1,
>>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>                 .event_spec = &iio_walking_event,
>>                 .num_event_specs = 1,
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

