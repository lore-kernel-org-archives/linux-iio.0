Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:56535 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1LLLKH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 06:10:07 -0500
Message-ID: <4EE5E104.3070206@free-electrons.com>
Date: Mon, 12 Dec 2011 12:09:56 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 5/6] AT91: IIO: cosmetic fixes, better error messages
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com> <1323282340-24475-6-git-send-email-maxime.ripard@free-electrons.com> <4EE3703A.1060703@kernel.org>
In-Reply-To: <4EE3703A.1060703@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Ok, I will merge this patch with the other patchset and resend a version
of the other patchset.

I suppose you also want the fourth patch merged ?

Maxime

On 10/12/2011 15:44, Jonathan Cameron wrote:
> All sensible but given I haven't merged anything (as being slow with
> both trees just now), I'd rather see these pushed down into the
> various places they were first created...
> 
> Jonathan
> 
> On 12/07/2011 06:25 PM, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/staging/iio/adc/at91_adc.c |   34 +++++++++++++++++++---------------
>>  1 files changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
>> index 4a0421e..9d6e351 100644
>> --- a/drivers/staging/iio/adc/at91_adc.c
>> +++ b/drivers/staging/iio/adc/at91_adc.c
>> @@ -42,16 +42,16 @@ struct at91_adc_desc {
>>  };
>>  
>>  struct at91_adc_state {
>> -	struct clk *clk;
>> -	bool done;
>> -	struct mutex lock;
>> -	int irq;
>> -	wait_queue_head_t wq_data_avail;
>> -	u16 last_value;
>> -	void __iomem *reg_base;
>> -	unsigned int vref_mv;
>> -	unsigned long channels_mask;
>> -	struct at91_adc_desc *desc;
>> +	u32			channels_mask;
>> +	struct clk		*clk;
>> +	bool			done;
>> +	struct at91_adc_desc	*desc;
>> +	int			irq;
>> +	u16			last_value;
>> +	struct mutex		lock;
>> +	void __iomem		*reg_base;
>> +	u32			vref_mv;
>> +	wait_queue_head_t	wq_data_avail;
>>  };
>>  
>>  static struct at91_adc_desc at91_adc_desc_sam9g20 = {
>> @@ -103,7 +103,7 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>  }
>>  
>>  static int at91_adc_channel_init(struct iio_dev *idev,
>> -				struct at91_adc_data *pdata)
>> +				 struct at91_adc_data *pdata)
>>  {
>>  	struct at91_adc_state *st = iio_priv(idev);
>>  	struct iio_chan_spec *chan_array;
>> @@ -139,8 +139,8 @@ static void at91_adc_channel_remove(struct iio_dev *idev)
>>  }
>>  
>>  static int at91_adc_read_raw(struct iio_dev *idev,
>> -			    struct iio_chan_spec const *chan,
>> -			    int *val, int *val2, long mask)
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long mask)
>>  {
>>  	struct at91_adc_state *st = iio_priv(idev);
>>  	int ret;
>> @@ -310,8 +310,10 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>>  
>>  	/* Setup the ADC channels available on the board */
>>  	ret = at91_adc_channel_init(idev, pdata);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
>>  		goto error_free_clk;
>> +	}
>>  
>>  	init_waitqueue_head(&st->wq_data_avail);
>>  	mutex_init(&st->lock);
>> @@ -320,8 +322,10 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>>  	st->channels_mask = pdata->channels_used;
>>  
>>  	ret = iio_device_register(idev);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
>>  		goto error_free_channels;
>> +	}
>>  
>>  	return 0;
>>  
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
