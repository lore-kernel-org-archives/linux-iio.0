Return-Path: <mail@alexanderkoch.net>
Subject: Re: [PATCH 2/2] iio: light: opt3001: enable operation w/o IRQ
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1452622180-12728-1-git-send-email-mail@alexanderkoch.net>
 <1452622180-12728-3-git-send-email-mail@alexanderkoch.net>
 <alpine.DEB.2.02.1601122024340.10606@pmeerw.net>
From: Alexander Koch <mail@alexanderkoch.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <56955F43.90705@alexanderkoch.net>
Date: Tue, 12 Jan 2016 21:17:07 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601122024340.10606@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 12.01.2016 um 20:27 schrieb Peter Meerwald-Stadler:
> On Tue, 12 Jan 2016, Alexander Koch wrote:
> 
>> Enable operation of the TI OPT3001 light sensor without having an
>> interrupt line available to connect the INT pin to.
>>
>> In this operation mode, we issue a conversion request and simply wait
>> for the conversion time available as timeout value, determined from
>> integration time configuration and the worst-case time given in the data
>> sheet (sect. 6.5, table on p. 5):
>>
>>   short integration time (100ms): 110ms + 3ms = 113ms
>>    long integration time (800ms): 880ms + 3ms = 883ms
>>
>> This change is transparent as behaviour defaults to using the interrupt
>> method if an interrupt no. is configured via device tree. Interrupt-less
>> operation mode is performed when no valid interrupt no. is given.
> 
> looks good, I'd rather use a bool for use_irq and the msecs_to_jiffies() 
> call moved from the #define to the code (which is not strictly necessary 
> for the patch) -- matter of taste

Thanks - actually this is my first patch, so positive feedback much
appreciated!

Concerning the bool for 'use_irq': I first had it that way but then
opted for the bit field of length 1 as I wasn't sure whether bool would
get optimized to the same level by the compiler.

I'm a bit irritated by your comment concerning the msecs_to_jiffies()
call, as my patch indeed moves this call from the #define to the code.
Did you mean it the other way round, then?
My reason to move it was that I need to work with microseconds for the
IRQ-less operation mode, and jiffies are only required in one place for
the IRQ mode.


Best regards

lynix
