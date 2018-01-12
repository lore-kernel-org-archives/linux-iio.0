Return-Path: <SRS0=o/kk=EH=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH -next] IIO: ADC: fix return value check in
 stm32_dfsdm_adc_probe()
To: "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Dan Carpenter
	<dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
References: <1515669161-125426-1-git-send-email-weiyongjun1@huawei.com>
 <20180111212837.minmnjkvhudstafs@mwanda>
 <6AADFAC011213A4C87B956458587ADB40132A0E3@dggemi507-mbx.china.huawei.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <bd342999-d205-51fc-6f3d-4a2e69bf6a6a@st.com>
Date: Fri, 12 Jan 2018 10:37:32 +0100
MIME-Version: 1.0
In-Reply-To: <6AADFAC011213A4C87B956458587ADB40132A0E3@dggemi507-mbx.china.huawei.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>



On 01/12/2018 02:37 AM, weiyongjun (A) wrote:
>>
>> On Thu, Jan 11, 2018 at 11:12:41AM +0000, Wei Yongjun wrote:
>>> In case of error, the function devm_iio_device_alloc() returns NULL
>>> pointer not ERR_PTR(). The IS_ERR() test in the return value check
>>> should be replaced with NULL test.
>>>
>>> Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC
>> support")
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>> ---
>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-
>> dfsdm-adc.c
>>> index e628d04..5e87140 100644
>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>> @@ -1100,9 +1100,9 @@ static int stm32_dfsdm_adc_probe(struct
>> platform_device *pdev)
>>>  	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
>>>
>>>  	iio = devm_iio_device_alloc(dev, sizeof(*adc));
>>> -	if (IS_ERR(iio)) {
>>> +	if (!iio) {
>>>  		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
>>> -		return PTR_ERR(iio);
>>> +		return -ENOMEM;
>>>  	}
>>>
>>>  	adc = iio_priv(iio);
>>         ^^^^^^^^^^^^^^^^^^
>> This one doesn't return an error pointer either.  The check causes a
>> static check warning for me.  (It can't actually fail, though so maybe
>> it will return an error pointer in the future?)
> 
> It seems that we can simply remove the check since 'adc' can never
> be an invalid address here.

Agree, i'm preparing patches for all issue you highlight,

Thanks for all your remarks
Arnaud
> 
> Regards,
> Yongjun Wei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
