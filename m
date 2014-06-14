Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43638 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbaFNOgI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 10:36:08 -0400
Message-ID: <539C5E4A.3080005@kernel.org>
Date: Sat, 14 Jun 2014 15:38:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
CC: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Josh Wu <josh.wu@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Thomas Meyer <thomas@m3y3r.de>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] iio: adc: at91: signedness bug in at91_adc_get_trigger_value_by_name()
References: <53980711.5030604@bfs.de> <20140611081317.GA29444@mwanda> <20140611144141.GH3429@piout.net>
In-Reply-To: <20140611144141.GH3429@piout.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/14 15:41, Alexandre Belloni wrote:
> On 11/06/2014 at 11:13:17 +0300, Dan Carpenter wrote :
>> at91_adc_get_trigger_value_by_name() was returning -ENOMEM truncated to
>> a positive u8 and that doesn't work.  I've changed it to int and
>> refactored it to preserve the error code.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> Also, tested on an at91sam9g45ek.
I've added a tested-by as in many ways that has more weight than an
Ack (and can sit alongside it just fine)

Dan, thanks as ever!

Applied to the fixes-togreg branch of iio.git and cc'd to stable.

Jonathan

>
>> ---
>> I'm not able to compile this code.
Me neither - which makes that tested by rather handy ;)
>>
>> v2:  Preserve the -ENOMEM
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 3b5bacd..2b6a9ce 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -510,12 +510,11 @@ static int at91_adc_channel_init(struct iio_dev *idev)
>>   	return idev->num_channels;
>>   }
>>
>> -static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
>> +static int at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
>>   					     struct at91_adc_trigger *triggers,
>>   					     const char *trigger_name)
>>   {
>>   	struct at91_adc_state *st = iio_priv(idev);
>> -	u8 value = 0;
>>   	int i;
>>
>>   	for (i = 0; i < st->trigger_number; i++) {
>> @@ -528,15 +527,16 @@ static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
>>   			return -ENOMEM;
>>
>>   		if (strcmp(trigger_name, name) == 0) {
>> -			value = triggers[i].value;
>>   			kfree(name);
>> -			break;
>> +			if (triggers[i].value == 0)
>> +				return -EINVAL;
>> +			return triggers[i].value;
>>   		}
>>
>>   		kfree(name);
>>   	}
>>
>> -	return value;
>> +	return -EINVAL;
>>   }
>>
>>   static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>> @@ -546,14 +546,14 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>>   	struct iio_buffer *buffer = idev->buffer;
>>   	struct at91_adc_reg_desc *reg = st->registers;
>>   	u32 status = at91_adc_readl(st, reg->trigger_register);
>> -	u8 value;
>> +	int value;
>>   	u8 bit;
>>
>>   	value = at91_adc_get_trigger_value_by_name(idev,
>>   						   st->trigger_list,
>>   						   idev->trig->name);
>> -	if (value == 0)
>> -		return -EINVAL;
>> +	if (value < 0)
>> +		return value;
>>
>>   	if (state) {
>>   		st->buffer = kmalloc(idev->scan_bytes, GFP_KERNEL);
>

