Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:65295 "EHLO
	DVREDG02.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751778Ab3KAIcq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2013 04:32:46 -0400
Message-ID: <5273670D.7070705@atmel.com>
Date: Fri, 1 Nov 2013 16:32:13 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>, <jic23@kernel.org>,
	<grant.likely@linaro.org>, <rob.herring@calxeda.com>,
	<maxime.ripard@free-electrons.com>, <lars@metafoo.de>,
	<ludovic.desroches@atmel.com>
CC: <yongjun_wei@trendmicro.com.cn>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: at91: fix error return code in at91_adc_probe()
References: <CAPgLHd_whWvPuHTCGdQkZa2fbra=U1nRBvBCyd9azUzS8_XLNg@mail.gmail.com>
In-Reply-To: <CAPgLHd_whWvPuHTCGdQkZa2fbra=U1nRBvBCyd9azUzS8_XLNg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, Yongjun

On 10/30/2013 1:20 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fix to return -ENODEV instead of 0 if non-TSMR adc don't
> support, as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks and
Acked-by: Josh Wu <josh.wu@atmel.com>

Best Regards,
Josh Wu

> ---
>   drivers/iio/adc/at91_adc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 17df749..5b1aa02 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1047,6 +1047,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>   	} else {
>   		if (!st->caps->has_tsmr) {
>   			dev_err(&pdev->dev, "We don't support non-TSMR adc\n");
> +			ret = -ENODEV;
>   			goto error_disable_adc_clk;
>   		}
>   
>

