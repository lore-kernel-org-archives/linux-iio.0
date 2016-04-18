Return-Path: <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
To: Marek Vasut <marex@denx.de>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com>
 <570FF70F.3000501@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
 linux-iio@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <57147C64.8030504@i2se.com>
Date: Mon, 18 Apr 2016 08:19:16 +0200
MIME-Version: 1.0
In-Reply-To: <570FF70F.3000501@denx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi Marek,

Am 14.04.2016 um 22:01 schrieb Marek Vasut:
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
> Nice find.
>
> Looks like at91_adc.c and exynos_adc.c suffer from the exact same issue.
> The leak looks a bit more severe on exynos even, exynos_adc_ts_init()
> could use a proper fail path. Do you want to send patches or shall I ?
>

since you found them it would be better if you handle them.

Regards
Stefan
