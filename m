Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54956 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbcDSLaq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2016 07:30:46 -0400
Message-ID: <57160937.6000903@denx.de>
Date: Tue, 19 Apr 2016 12:32:23 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com> <570FF70F.3000501@denx.de> <571360A3.3060809@kernel.org> <57151652.4020709@denx.de> <5715D12D.1020303@i2se.com>
In-Reply-To: <5715D12D.1020303@i2se.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/2016 08:33 AM, Stefan Wahren wrote:
> Hi Marek,
> 
> Am 18.04.2016 um 19:16 schrieb Marek Vasut:
>> On 04/17/2016 12:08 PM, Jonathan Cameron wrote:
>>> On 14/04/16 21:01, Marek Vasut wrote:
>>>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>>>> After successful touchscreen registration the input device was
>>>>> never freed. So fix this issue by using devm_input_allocate_device().
>>>>>
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> ---
>>>>>  drivers/iio/adc/mxs-lradc.c |    8 ++------
>>>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>>>>> index 33051b8..0576953 100644
>>>>> --- a/drivers/iio/adc/mxs-lradc.c
>>>>> +++ b/drivers/iio/adc/mxs-lradc.c
>>>>> @@ -1109,12 +1109,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>>>>  {
>>>>>  	struct input_dev *input;
>>>>>  	struct device *dev = lradc->dev;
>>>>> -	int ret;
>>>>>  
>>>>>  	if (!lradc->use_touchscreen)
>>>>>  		return 0;
>>>>>  
>>>>> -	input = input_allocate_device();
>>>>> +	input = devm_input_allocate_device(dev);
>>>>>  	if (!input)
>>>>>  		return -ENOMEM;
>>>>>  
>>>>> @@ -1134,11 +1133,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>>>>  
>>>>>  	lradc->ts_input = input;
>>>>>  	input_set_drvdata(input, lradc);
>>>>> -	ret = input_register_device(input);
>>>>> -	if (ret)
>>>>> -		input_free_device(lradc->ts_input);
>>>>>  
>>>>> -	return ret;
>>>>> +	return input_register_device(input);
>>>>>  }
>>>>>  
>>>>>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>>>>>
>>>> Nice find.
>>>>
>>>> Looks like at91_adc.c and exynos_adc.c suffer from the exact same issue.
>>>> The leak looks a bit more severe on exynos even, exynos_adc_ts_init()
>>>> could use a proper fail path. Do you want to send patches or shall I ?
>>>>
>>> As this has been there a long time I'm not going to rush it in as a fix.
>> I did take a proper look today and it seems they do the right thing
>> afterall. I checked them with kmemleak too to be sure.
> 
> thanks, input_unregister_device already free the memory.
> 
> Sorry for the mess :-(
> 
> I think it would be the best to remove / revert this patch.

This one? Why exactly? Please elaborate some more, so it's possible to
understand the reasoning :)


-- 
Best regards,
Marek Vasut
