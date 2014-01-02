Return-Path: <alexandre.belloni@free-electrons.com>
Message-ID: <52C52592.1020101@free-electrons.com>
Date: Thu, 02 Jan 2014 09:38:42 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Jonathan Cameron <jic23@kernel.org>
CC: lars@metafoo.de, harald@ccbib.org, hector.palacios@digi.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 RESEND 4/4] iio: mxs-lradc: convert is_divided to a
 bitmap
References: <1387820884-28140-1-git-send-email-alexandre.belloni@free-electrons.com> <1387820884-28140-5-git-send-email-alexandre.belloni@free-electrons.com> <52C426C7.8090706@kernel.org> <201401012031.52593.marex@denx.de>
In-Reply-To: <201401012031.52593.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/01/2014 20:31, Marek Vasut wrote:
> On Wednesday, January 01, 2014 at 03:31:35 PM, Jonathan Cameron wrote:
>> On 23/12/13 17:48, Alexandre Belloni wrote:
>>> mxs_lradc.is_divided was an unsigned long array. Convert it to a bitmap
>>> to save some memory.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> Hi Alexandre,
>>
>> I've applied this patch, but would have prefered that you post this one
>> in separate series. It is a perfectly valid cleanup, but introducing it
>> late in a series leads to uneven reviewing.  Anyhow, as it's trivial and
>> I doubt Marek will mind, I've applied it anyway in a new years burst of
>> trying to clear the outstanding stuff in my in box ;)
>>
>> Applied to the togreg branch of iio.git
>>
>> Thanks,
> 
> I dont mind, thanks for geting these in. And happy new year to you guys :)

Thanks Jonathan !

I wish everyone the best for this new year !



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
