Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39891 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab3BFTaU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Feb 2013 14:30:20 -0500
Message-ID: <5112AF49.6090100@kernel.org>
Date: Wed, 06 Feb 2013 19:30:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Chanwoo Choi <cw00.choi@samsung.com>
CC: Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iio: Update iio_channel_get API to use consumer device
 pointer as argument
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net> <1360009566-26347-2-git-send-email-linux@roeck-us.net> <51104AE7.2020909@samsung.com>
In-Reply-To: <51104AE7.2020909@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/2013 11:57 PM, Chanwoo Choi wrote:
> On 02/05/2013 05:26 AM, Guenter Roeck wrote:
>> For iio_channel_get to work with OF based configurations, it needs the
>> consumer device pointer instead of the consumer device name as argument.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of iio.git.

Thanks all.

I'll hold off on taking the actual device tree patch (2 of this series)
for a day or two to give more time for comments on that.
>> ---
>>   drivers/extcon/extcon-adc-jack.c    |    3 +--
>>   drivers/iio/inkern.c                |   11 ++++++++++-
>>   drivers/power/generic-adc-battery.c |    4 ++--
>>   drivers/power/lp8788-charger.c      |    8 ++++----
>>   include/linux/iio/consumer.h        |    5 +++--
>>   5 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
>> index eda2a1a..d0233cd 100644
>> --- a/drivers/extcon/extcon-adc-jack.c
>> +++ b/drivers/extcon/extcon-adc-jack.c
>> @@ -135,8 +135,7 @@ static int adc_jack_probe(struct platform_device *pdev)
>>           ;
>>       data->num_conditions = i;
>>   -    data->chan = iio_channel_get(dev_name(&pdev->dev),
>> -            pdata->consumer_channel);
>> +    data->chan = iio_channel_get(&pdev->dev, pdata->consumer_channel);
>>       if (IS_ERR(data->chan)) {
>>           err = PTR_ERR(data->chan);
>>           goto out;
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index c42aba6..b289915 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -93,7 +93,8 @@ static const struct iio_chan_spec
> Ack for drivers/extcon .
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Thanks,
> Chanwoo Choi
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
