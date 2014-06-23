Return-Path: <jan@arkub.com>
Message-ID: <53A80840.5050906@telliq.com>
Date: Mon, 23 Jun 2014 12:58:08 +0200
From: Jan Kardell <jan.kardell@telliq.com>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
 Rachna Patil <rachna@ti.com>,
 "Zubair Lutfullah: zubair.lutfullah"@gmail.com
Subject: Re: [PATCH] iio: ti_am335x_adc: Use same step id at FIFOs both ends
References: <1402521498-11535-1-git-send-email-jan.kardell@telliq.com> <53A555A7.7070800@kernel.org> <20140621102658.GA5177@gmail.com>
In-Reply-To: <20140621102658.GA5177@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Zubair Lutfullah : skriver:
> On Sat, Jun 21, 2014 at 10:51:35AM +0100, Jonathan Cameron wrote:
>> On 11/06/14 22:18, Jan Kardell wrote:
>>> Since AI lines could be selected at will (linux-3.11) the sending
>>> and receiving ends of the FIFO does not agree about what step is used
>>> for a line. It only works if the last lines are used, like 5,6,7,
>>> and fails if ie 2,4,6 is selected in DT.
>>>
>>> Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
>> I'd like an ack / review from someone more familiar with this part than I
>> am. I have cc'd a few people who might offer a view.
> Been a while since I've seen this driver.
> I'll try a bit..
>
>> Thanks,
>>
>> Jonathan (IIO maintainer)
>>> ---
>>>   drivers/iio/adc/ti_am335x_adc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>>> index a4db302..d5dc4c6 100644
>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>> @@ -374,7 +374,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>>>   			return -EAGAIN;
>>>   		}
>>>   	}
>>> -	map_val = chan->channel + TOTAL_CHANNELS;
>>> +	map_val = adc_dev->channel_step[chan->scan_index];
> Looking at the code again.
> Could you tell me if using map_val = step_en will work?
>
> Checking TRM, the channel ID is written with step id.
> And if i am not mistaken, step id is already stored in step_en.
> That is the step we enable for sampling.
> Would make sense to check fifo for that step no?
step_en is is a bitmask of 16 bits intended for the STEPENABLE
register, one bit for each of the 16 possible steps, while stepid is a
four bit number, 0-15, indentifying the step used. So your suggestion
does not work.

//Jan

> something like
>
> @@ -324,7 +324,7 @@
>   		int *val, int *val2, long mask)
>   {
>   	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	int i, map_val;
> +	int i;
>   	unsigned int fifo1count, read, stepid;
>   	bool found = false;
>   	u32 step_en;
> @@ -342,7 +342,6 @@
>   		if (time_after(jiffies, timeout))
>   			return -EAGAIN;
>   		}
> -	map_val = chan->channel + TOTAL_CHANNELS;
>   
>   	/*
>   	 * When the sub-system is first enabled,
> @@ -361,7 +360,7 @@
>   		stepid = read & FIFOREAD_CHNLID_MASK;
>   		stepid = stepid >> 0x10;
>   
> -		if (stepid == map_val) {
> +		if (stepid == step_en) {
>   			read = read & FIFOREAD_DATA_MASK;
>   			found = true;
>   			*val = (u16) read;
>
>
> Cheers
> ZubairLK
>
>
>
>>>   	/*
>>>   	 * We check the complete FIFO. We programmed just one entry but in case
>>>
