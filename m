Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46604 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdBYQlL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:41:11 -0500
Subject: Re: [PATCH v2] iio: adc: xilinx: Fix error handling
To: Lars-Peter Clausen <lars@metafoo.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com
References: <20170221063400.2984-1-christophe.jaillet@wanadoo.fr>
 <2c05b3bd-b5b4-e322-5d92-cd1c65d84ff5@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <902ad8ee-c7f8-582c-fd58-3a69605fc0e0@kernel.org>
Date: Sat, 25 Feb 2017 16:41:07 +0000
MIME-Version: 1.0
In-Reply-To: <2c05b3bd-b5b4-e322-5d92-cd1c65d84ff5@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/17 11:55, Lars-Peter Clausen wrote:
> On 02/21/2017 07:34 AM, Christophe JAILLET wrote:
>> Reorder error handling labels in order to match the way resources have
>> been allocated.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan
> 
>> ---
>> v2: update goto label if 'xadc->ops->setup()' fails
>> ---
>>  drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index 0a6beb3d99cb..515b91963db5 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -1206,11 +1206,11 @@ static int xadc_probe(struct platform_device *pdev)
>>  	}
>>  	clk_prepare_enable(xadc->clk);
>>  
>>  	ret = xadc->ops->setup(pdev, indio_dev, irq);
>>  	if (ret)
>> -		goto err_free_samplerate_trigger;
>> +		goto err_clk_disable_unprepare;
>>  
>>  	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
>>  			dev_name(&pdev->dev), indio_dev);
>>  	if (ret)
>>  		goto err_clk_disable_unprepare;
>> @@ -1268,6 +1268,8 @@ static int xadc_probe(struct platform_device *pdev)
>>  
>>  err_free_irq:
>>  	free_irq(irq, indio_dev);
>> +err_clk_disable_unprepare:
>> +	clk_disable_unprepare(xadc->clk);
>>  err_free_samplerate_trigger:
>>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>>  		iio_trigger_free(xadc->samplerate_trigger);
>> @@ -1277,8 +1279,6 @@ static int xadc_probe(struct platform_device *pdev)
>>  err_triggered_buffer_cleanup:
>>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>>  		iio_triggered_buffer_cleanup(indio_dev);
>> -err_clk_disable_unprepare:
>> -	clk_disable_unprepare(xadc->clk);
>>  err_device_free:
>>  	kfree(indio_dev->channels);
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

