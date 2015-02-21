Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34702 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbBUSP0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Feb 2015 13:15:26 -0500
Message-ID: <54E8CB3B.3060205@kernel.org>
Date: Sat, 21 Feb 2015 18:15:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Porquet <joel@porquet.org>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Catalina Mocanu <catalina.mocanu@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: trigger: iio-trig-periodic-rtc: Change
 frequency type to unsigned int
References: <1423419774-16753-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <54E8CA45.2010306@kernel.org>
In-Reply-To: <54E8CA45.2010306@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/15 18:11, Jonathan Cameron wrote:
> On 08/02/15 18:22, Rickard Strandqvist wrote:
>> Change struct iio_prtc_trigger_info frequency
>> type from int to unsigned int.
>> Since it is always treated as such in the driver
>> so they type should probably reflect this.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> The only argument against this is that the rtc_irq_set_freq function takes
> a signed int. Arguably that shouldn't perhaps, but whilst it does we should
> probably track it's type to avoid confusion.
hmm. Dug a bit deeper. drivers/rtc/interface.c states that it must be positive.
I'm guessing it is only signed for historical reasons.
So I will take this patch as it stands.

Applied to the togreg branch iio.git - initially to be pushed out as
testing for the autobuilders to play.

Jonathan
> 
> Jonathan
>> ---
>>  drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |   12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
>> index a24caf7..89df1d3 100644
>> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
>> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
>> @@ -24,7 +24,7 @@ static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
>>  
>>  struct iio_prtc_trigger_info {
>>  	struct rtc_device *rtc;
>> -	int frequency;
>> +	unsigned int frequency;
>>  	struct rtc_task task;
>>  	bool state;
>>  };
>> @@ -36,7 +36,7 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
>>  
>>  	if (trig_info->frequency == 0 && state)
>>  		return -EINVAL;
>> -	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %d\n",
>> +	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %u\n",
>>  			trig_info->frequency);
>>  	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
>>  	if (ret == 0)
>> @@ -62,10 +62,10 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>>  {
>>  	struct iio_trigger *trig = to_iio_trigger(dev);
>>  	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
>> -	int val;
>> +	unsigned int val;
>>  	int ret;
>>  
>> -	ret = kstrtoint(buf, 10, &val);
>> +	ret = kstrtouint(buf, 10, &val);
>>  	if (ret)
>>  		goto error_ret;
>>  
>> @@ -74,10 +74,8 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>>  		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
>>  			ret = rtc_irq_set_state(trig_info->rtc,
>>  						&trig_info->task, 1);
>> -	} else if (val == 0) {
>> -		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
>>  	} else
>> -		ret = -EINVAL;
>> +		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
>>  	if (ret)
>>  		goto error_ret;
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

