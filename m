Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53064 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbcDRLMq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 07:12:46 -0400
Message-ID: <5714BAAD.3020009@denx.de>
Date: Mon, 18 Apr 2016 12:45:01 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com> <570FF70F.3000501@denx.de> <57147C64.8030504@i2se.com>
In-Reply-To: <57147C64.8030504@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/2016 08:19 AM, Stefan Wahren wrote:
> Hi Marek,
> 
> Am 14.04.2016 um 22:01 schrieb Marek Vasut:
>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>> After successful touchscreen registration the input device was
>>> never freed. So fix this issue by using devm_input_allocate_device().
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>  drivers/iio/adc/mxs-lradc.c |    8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>>> index 33051b8..0576953 100644
>>> --- a/drivers/iio/adc/mxs-lradc.c
>>> +++ b/drivers/iio/adc/mxs-lradc.c
>>> @@ -1109,12 +1109,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>>  {
>>>  	struct input_dev *input;
>>>  	struct device *dev = lradc->dev;
>>> -	int ret;
>>>  
>>>  	if (!lradc->use_touchscreen)
>>>  		return 0;
>>>  
>>> -	input = input_allocate_device();
>>> +	input = devm_input_allocate_device(dev);
>>>  	if (!input)
>>>  		return -ENOMEM;
>>>  
>>> @@ -1134,11 +1133,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>>  
>>>  	lradc->ts_input = input;
>>>  	input_set_drvdata(input, lradc);
>>> -	ret = input_register_device(input);
>>> -	if (ret)
>>> -		input_free_device(lradc->ts_input);
>>>  
>>> -	return ret;
>>> +	return input_register_device(input);
>>>  }
>>>  
>>>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>>>
>> Nice find.
>>
>> Looks like at91_adc.c and exynos_adc.c suffer from the exact same issue.
>> The leak looks a bit more severe on exynos even, exynos_adc_ts_init()
>> could use a proper fail path. Do you want to send patches or shall I ?
>>
> 
> since you found them it would be better if you handle them.

Roger. Since Atmel was so kind to provide sama5d2 and I also have
sama5d4 board here, I will check the Atmel one at least.

-- 
Best regards,
Marek Vasut
