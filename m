Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35302 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbBAKPD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Feb 2015 05:15:03 -0500
Message-ID: <54CDFCA3.5050203@kernel.org>
Date: Sun, 01 Feb 2015 10:14:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: pmeerw@pmeerw.net, robert.hodaszi@digi.com, knaack.h@gmx.de,
	lars@metafoo.de, alexandre.belloni@free-electrons.com,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	marex@denx.de
Subject: Re: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
References: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com> <54A91E2C.7070109@kernel.org> <1818754820.704464.1420371563334.JavaMail.open-xchange@oxbaltgw01.schlund.de>
In-Reply-To: <1818754820.704464.1420371563334.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/15 11:39, Stefan Wahren wrote:
> Hi Jonathan,
> 
>> Jonathan Cameron <jic23@kernel.org> hat am 4. Januar 2015 um 12:04
>> geschrieben:
>>
>>
>> On 03/01/15 20:34, Stefan Wahren wrote:
>>> Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
>>> from channel 8 and 9") with the removal of adc channel 9 there is
>>> no 1-1 mapping in the channel spec.
>>>
>>> All hwmon channel values above 9 are accessible via there index minus
>>> one. So add a hidden iio channel 9 to fix this issue.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> I'll have to hold this for a bit. I'm running rather behind with
>> pull requests so my fixes tree is still pre the last release and
>> hence doesn't have the patch that caused the problem yet...
>>
>> Should unwind that this week.
> 
> i forgot to mention this patch in version 2 is the solution of this old
> discussion:
> 
> https://lkml.org/lkml/2014/6/14/69
> 
> So the problem should be in your fixes tree. Sorry for the confusion.
> 
> Stefan
Being totally useless I seem to have forgotten to apply this.  Given
timing the fastest route now will be to send it out just after the coming
merge window marked for stable.  Applied to the fixes-togreg branch of
iio.git

Thanks and sorry for the delay,

Jonathan
> 
>>
>> Jonathan
>>> ---
>>> Changes in V2:
>>> - define hidden channel instead of a bogus one
>>>
>>> drivers/staging/iio/adc/mxs-lradc.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>>> b/drivers/staging/iio/adc/mxs-lradc.c
>>> index d9d6fad..594684d 100644
>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>> @@ -1413,6 +1413,13 @@ static const struct iio_chan_spec
>>> mxs_lradc_chan_spec[] = {
>>> .channel = 8,
>>> .scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
>>> },
>>> + /* Hidden channel to keep indexes */
>>> + {
>>> + .type = IIO_TEMP,
>>> + .indexed = 1,
>>> + .scan_index = -1,
>>> + .channel = 9,
>>> + },
>>> MXS_ADC_CHAN(10, IIO_VOLTAGE), /* VDDIO */
>>> MXS_ADC_CHAN(11, IIO_VOLTAGE), /* VTH */
>>> MXS_ADC_CHAN(12, IIO_VOLTAGE), /* VDDA */
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

