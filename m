Return-Path: <SRS0=W7u2=LY=huawei.com=zhongjiang@kernel.org>
Message-ID: <5B967653.1030007@huawei.com>
Date: Mon, 10 Sep 2018 21:49:07 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Himanshu Jha <himanshujha199640@gmail.com>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in am2315_trigger_handler
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com> <20180908122913.GA4445@himanshu-Vostro-3559> <20180908151751.20e7396f@archlinux>
In-Reply-To: <20180908151751.20e7396f@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 2018/9/8 22:17, Jonathan Cameron wrote:
> On Sat, 8 Sep 2018 17:59:13 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>
>> On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
>>> The iterator in for_each_set_bit is never null, therefore, remove
>>> the redundant conditional judgment.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/iio/humidity/am2315.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
>>> index 7d8669d..dc12e37 100644
>>> --- a/drivers/iio/humidity/am2315.c
>>> +++ b/drivers/iio/humidity/am2315.c
>>> @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>>>  		i = 0;
>>>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>>>  				 indio_dev->masklength) {
>>> -			data->buffer[i] = (bit ? sensor_data.temp_data :
>>> -						 sensor_data.hum_data);
>>> +			data->buffer[i] = sensor_data.temp_data;  
>> No, this seems wrong!
>>
>> We have buffer support to either take both readings(temp & humid)
>> simultaneously, or only single channel using specified scan mask.
> Key think is that bit most definitely can be 0 if the 0th bit is set.
> This isn't a null check at all.
>
> I'm curious, was this a by inspection case or did some script throw
> this one up?
 Hi,  Jonathan

 bit is a iterator that find the non-zero bit in indio_dev->active_scan_mask. if  all bit is
 zero ,  it should return the masklength.

 Yep.  I find the issue with the help of Coccinelle.

 Thanks
zhong jiang
> Thanks,
>
> Jonathan
>
>> Patch title should be:
>>
>> "iio: humidity: am2315: .... .. "
>>
>>
>> Thanks
>
> .
>
