Return-Path: <bigeasy@linutronix.de>
Message-ID: <521EFEBF.30608@linutronix.de>
Date: Thu, 29 Aug 2013 09:56:47 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: "Zubair Lutfullah: zubair.lutfullah"@gmail.com, jic23@cam.ac.uk,
 lee.jones@linaro.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com> <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com> <20130828164308.GE14111@linutronix.de> <20130828181951.GA3580@gmail.com> <521E42F2.2090707@linutronix.de> <20130828185929.GF3777@gmail.com>
In-Reply-To: <20130828185929.GF3777@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 08/28/2013 08:59 PM, Zubair Lutfullah : wrote:
>>>>> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>>>>> +	iio_device_free(indio_dev);
> ...
>> Point me one driver please. Do they use devm_iio_device_alloc() like
>> you do or iio_device_alloc()? In case of the latter you need to
>> manually free the memory.
> Aah. So the devm_* stuff makes the difference.
> Thanks for pointing it out. Will remove it.

Yes, devm_* stuff. There is also matching kmalloc() version of it for
the very same purpose and a few others…

In future please post a bugfix (adding iio_device_free() to plug a
memory leak) as a separate patch. It has nothing todo with "continuous
sampling support" and it case it is valid it could be applied
independantly and ported back to earlier kernel if necessary. The way
you did here you just "silently" plugged a memory leak.

> 
> ZubairLK
> 

Sebastian
