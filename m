Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD1AAFB.2050302@cam.ac.uk>
Date: Fri, 08 Jun 2012 08:34:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add mcp4725 I2C DAC driver
References: <1339057809-17345-1-git-send-email-pmeerw@pmeerw.net> <4FD0D1CB.4000004@kernel.org> <alpine.DEB.2.01.1206080909380.26184@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206080909380.26184@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/8/2012 8:12 AM, Peter Meerwald wrote:
> Hello Jonathan,
>
>> from reading the code. Anyhow few things came up via sparse and and
>> my arm toolchain... (not sure which version off the top of my head)..
>
>>    CHECK   drivers/iio/dac/mcp4725.c
>> drivers/iio/dac/mcp4725.c:45:53: warning: incorrect type in argument 2
>> (different base types)
>> drivers/iio/dac/mcp4725.c:45:53:    expected char const *buf
>> drivers/iio/dac/mcp4725.c:45:53:    got unsigned char [usertype] (
>> *<noident>  )[2]
>> drivers/iio/dac/mcp4725.c:58:53: warning: incorrect type in argument 2
>> (different base types)
>> drivers/iio/dac/mcp4725.c:58:53:    expected char const *buf
>> drivers/iio/dac/mcp4725.c:58:53:    got unsigned char [usertype] (
>> *<noident>  )[2]
>>    CC [M]  drivers/iio/dac/mcp4725.o
>
> I did not know about sparse
>
> compiling out-of-tree with my toolchain did not yield above warnings,
> sorry for the extra review cycle
That's quite all right!  I've done plenty of similar things myself
and had others poitn them out.
>
> regards, p.
>
