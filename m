Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51003 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754881AbcKEQds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:33:48 -0400
Subject: Re: [PATCH v2] iio: adc: at91: add suspend and resume callback
To: Wenyou Yang <wenyou.yang@atmel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Wenyou Yang <wenyou.yang@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>
References: <1478078508-24541-1-git-send-email-wenyou.yang@atmel.com>
 <20161103141654.7oitq25gxqcy7qna@rfolt0960.corp.atmel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f98d5357-d8ca-c0e6-8c3c-379d6dd147b1@kernel.org>
Date: Sat, 5 Nov 2016 16:33:45 +0000
MIME-Version: 1.0
In-Reply-To: <20161103141654.7oitq25gxqcy7qna@rfolt0960.corp.atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 14:16, Ludovic Desroches wrote:
> On Wed, Nov 02, 2016 at 05:21:48PM +0800, Wenyou Yang wrote:
>> Add suspend/resume callback, support the pinctrl sleep state when
>> the system suspend as well.
>>
>> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Thanks
> 
>> ---
>>
>> Changes in v2:
>>  - Use CONFIG_PM_SLEEP.
>>  - Use SIMPLE_DEV_PM_OPS macro.
>>
>>  drivers/iio/adc/at91_adc.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index bbdac07..34b928c 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/iio/trigger.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>> +#include <linux/pinctrl/consumer.h>
>>  
>>  /* Registers */
>>  #define AT91_ADC_CR		0x00		/* Control Register */
>> @@ -1347,6 +1348,32 @@ static int at91_adc_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM_SLEEP
>> +static int at91_adc_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +
>> +	pinctrl_pm_select_sleep_state(dev);
>> +	clk_disable_unprepare(st->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int at91_adc_resume(struct device *dev)
>> +{
>> +	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +
>> +	clk_prepare_enable(st->clk);
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
>> +
>>  static struct at91_adc_caps at91sam9260_caps = {
>>  	.calc_startup_ticks = calc_startup_ticks_9260,
>>  	.num_channels = 4,
>> @@ -1441,6 +1468,7 @@ static struct platform_driver at91_adc_driver = {
>>  	.driver = {
>>  		   .name = DRIVER_NAME,
>>  		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
>> +		   .pm = &at91_adc_pm_ops,
>>  	},
>>  };
>>  
>> -- 
>> 2.7.4
>>

