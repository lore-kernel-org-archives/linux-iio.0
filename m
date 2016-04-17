Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52823 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbcDQKIh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 06:08:37 -0400
Subject: Re: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
To: Marek Vasut <marex@denx.de>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com>
 <570FF70F.3000501@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571360A3.3060809@kernel.org>
Date: Sun, 17 Apr 2016 11:08:35 +0100
MIME-Version: 1.0
In-Reply-To: <570FF70F.3000501@denx.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 21:01, Marek Vasut wrote:
> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>> After successful touchscreen registration the input device was
>> never freed. So fix this issue by using devm_input_allocate_device().
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/iio/adc/mxs-lradc.c |    8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>> index 33051b8..0576953 100644
>> --- a/drivers/iio/adc/mxs-lradc.c
>> +++ b/drivers/iio/adc/mxs-lradc.c
>> @@ -1109,12 +1109,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>  {
>>  	struct input_dev *input;
>>  	struct device *dev = lradc->dev;
>> -	int ret;
>>  
>>  	if (!lradc->use_touchscreen)
>>  		return 0;
>>  
>> -	input = input_allocate_device();
>> +	input = devm_input_allocate_device(dev);
>>  	if (!input)
>>  		return -ENOMEM;
>>  
>> @@ -1134,11 +1133,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>  
>>  	lradc->ts_input = input;
>>  	input_set_drvdata(input, lradc);
>> -	ret = input_register_device(input);
>> -	if (ret)
>> -		input_free_device(lradc->ts_input);
>>  
>> -	return ret;
>> +	return input_register_device(input);
>>  }
>>  
>>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>>
> 
> Nice find.
> 
> Looks like at91_adc.c and exynos_adc.c suffer from the exact same issue.
> The leak looks a bit more severe on exynos even, exynos_adc_ts_init()
> could use a proper fail path. Do you want to send patches or shall I ?
> 
As this has been there a long time I'm not going to rush it in as a fix.
I suspect no platform is probing and removing it enough to get a significant
amount of memory leaked.

Good to clear it up though!

Applied to the togreg branch of iio.git, initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
