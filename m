Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeIJUwl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2018 16:52:41 -0400
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in
 am2315_trigger_handler
To: Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc: zhong jiang <zhongjiang@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
 <20180908122913.GA4445@himanshu-Vostro-3559>
 <20180908151751.20e7396f@archlinux>
From: David Frey <dpfrey@gmail.com>
Message-ID: <a721fd9e-b845-ee1c-0b8b-e763ab182330@gmail.com>
Date: Mon, 10 Sep 2018 08:57:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180908151751.20e7396f@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 9/8/2018 7:17 AM, Jonathan Cameron wrote:
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
>>
>> No, this seems wrong!
>>
>> We have buffer support to either take both readings(temp & humid)
>> simultaneously, or only single channel using specified scan mask.
> 
> Key think is that bit most definitely can be 0 if the 0th bit is set.
> This isn't a null check at all.
> 
> I'm curious, was this a by inspection case or did some script throw
> this one up?

Firstly, +1 on the patch in this thread being an incorrect change.
While inspecting the surrounding code,  I noticed that there's a bit of
questionable code in this area.  I believe this whole chunk:

	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
		data->buffer[0] = sensor_data.hum_data;
		data->buffer[1] = sensor_data.temp_data;
	} else {
		i = 0;
		for_each_set_bit(bit, indio_dev->active_scan_mask,
				 indio_dev->masklength) {
			data->buffer[i] = (bit ? sensor_data.temp_data :
						 sensor_data.hum_data);
			i++;
		}
	}

could be reduced to this:

	for_each_set_bit(bit, indio_dev->active_scan_mask,
			 indio_dev->masklength)
		data->buffer[bit] = (bit ? sensor_data.temp_data :
					   sensor_data.hum_data);

The if/else structure seems like an unnecessary optimization.

Thoughts?
