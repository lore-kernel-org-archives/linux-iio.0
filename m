Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39206 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdAGQ4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 11:56:30 -0500
Subject: Re: [PATCH] Fixed a coding style issue as a part of Eudyptula
 Challenge
To: Daniel Baluta <daniel.baluta@gmail.com>,
        rishabh hardas <rishabheudyptula@gmail.com>
References: <1483695570-13082-1-git-send-email-rishabheudyptula@gmail.com>
 <CAEnQRZCgiUXEZX8iwJV3MU00KoywaPsNFy32QkuEGRui_itgJw@mail.gmail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <68d86566-07a0-c447-432b-e37dd2fe741e@kernel.org>
Date: Sat, 7 Jan 2017 11:56:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCgiUXEZX8iwJV3MU00KoywaPsNFy32QkuEGRui_itgJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/17 04:23, Daniel Baluta wrote:
> Hi rishabh,
> 
> Congrats on reaching that far on Eudyptula challenge.
> Anyhow, you should write a proper commit message to this patch.
> 
> The subject should briefly describe why the patch is needed.
> 
> E.g: iio:trigger: Fix coding style
> 
> What actually has been fixed and how did you find it. (I assume you
> used checkpatch.pl)
> 
> Daniel.
Thanks Daniel, just what I was going to say!

Can't take a patch with a title that doesn't summarize what it is doing.

Jonathan
> 
> 
> On Fri, Jan 6, 2017 at 11:39 AM, rishabh hardas
> <rishabheudyptula@gmail.com> wrote:
>> Signed-off-by: rishabh hardas <rishabheudyptula@gmail.com>
>> ---
>>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> index 38dca69..9658f20 100644
>> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> @@ -133,7 +133,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
>>         return sprintf(buf, "%lu\n", val);
>>  }
>>
>> -static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
>> +static DEVICE_ATTR(frequency, 0644, iio_bfin_tmr_frequency_show,
>>                    iio_bfin_tmr_frequency_store);
>>
>>  static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
>> --
>> 2.7.4
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

