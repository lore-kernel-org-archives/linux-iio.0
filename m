Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39237 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdAGRCu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 12:02:50 -0500
Subject: Re: [PATCH] iio:trigger: Fix coding style in iio-trig-bfin-timer.c by
 removing a waring flagged by checkpatch.pl
To: rishabh hardas <rishabheudyptula@gmail.com>, pmeerw@pmeerw.net
References: <CAEnQRZCgiUXEZX8iwJV3MU00KoywaPsNFy32QkuEGRui_itgJw>
 <1483786296-7849-1-git-send-email-rishabheudyptula@gmail.com>
 <22695534-79ba-2e0d-648d-392889f6c03c@kernel.org>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <18ef4ca5-9ad1-41b7-713e-fb8c52e1f7e3@kernel.org>
Date: Sat, 7 Jan 2017 12:02:48 -0500
MIME-Version: 1.0
In-Reply-To: <22695534-79ba-2e0d-648d-392889f6c03c@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/17 11:59, Jonathan Cameron wrote:
> On 07/01/17 05:51, rishabh hardas wrote:
>> Signed-off-by: rishabh hardas <rishabheudyptula@gmail.com>
> Ideally you'd have had a bit more description above the sign off and perhaps a shorter title.
> I'd have left the 'how' element of the patch to this extra description and not put it in the title.
> 
> Also, minor typo waring-> warning.
> 
> I'll fix that up.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> from the pharma cleanroomwhere I have surprisingly good internet
> access!

Or not pushed out as something is blocking my connection.  Might be a day or two
before I get on a sensible connection!

Jonathan
> Jonathan
>> ---
>>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> index 38dca69..9658f20 100644
>> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> @@ -133,7 +133,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
>>  	return sprintf(buf, "%lu\n", val);
>>  }
>>  
>> -static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
>> +static DEVICE_ATTR(frequency, 0644, iio_bfin_tmr_frequency_show,
>>  		   iio_bfin_tmr_frequency_store);
>>  
>>  static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

