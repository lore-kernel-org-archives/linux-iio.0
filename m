Return-Path: <lars@metafoo.de>
Message-ID: <52D26AB3.2060500@metafoo.de>
Date: Sun, 12 Jan 2014 11:13:07 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: Add Lite-On ltr501 ambient light / proximity
 sensor driver
References: <1389391305-9686-1-git-send-email-pmeerw@pmeerw.net> <52D130E9.4000508@kernel.org>
In-Reply-To: <52D130E9.4000508@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/11/2014 12:54 PM, Jonathan Cameron wrote:
> 
> 
> On 10/01/14 22:01, Peter Meerwald wrote:
>> combined ambient light (two channels) and proximity sensor with I2C
>> interface; the ALS channels are visible+IR and IR
>>
>> datasheet is here
>> http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/P_100_LTR-501ALS-01_PrelimDS_ver1.1.pdf
>>
>>
>> v3:
>> * fix use of sizeof in _read_als()
>> v2: (thanks to Lars-Peter Clausen)
>> * cannot use devm_iio_device_register() due to cleanup order in _remove()
>> * mutex around data wait/read
>> * turn info message in _probe() into check for part number
>> * change copyright year to 2014
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Lets pretend I noticed this email before replying to V2.
> I'll apply this one in a few days after Lars has had time to comment if he
> wants to!

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
