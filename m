Return-Path: <SRS0=axIo=C4=gmail.com=arvind.yadav.cs@kernel.org>
Subject: Re: [PATCH 2/3] staging: irda: Handle return value of
 platform_get_irq
To: Greg KH <gregkh@linuxfoundation.org>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512056616-21065-3-git-send-email-arvind.yadav.cs@gmail.com>
 <20171130164124.GB17869@kroah.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, samuel@sortiz.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5A20359F.10508@gmail.com>
Date: Thu, 30 Nov 2017 22:15:19 +0530
MIME-Version: 1.0
In-Reply-To: <20171130164124.GB17869@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

On Thursday 30 November 2017 10:11 PM, Greg KH wrote:
> On Thu, Nov 30, 2017 at 09:13:35PM +0530, Arvind Yadav wrote:
>> platform_get_irq() can fail here and we must check its return value.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/staging/irda/drivers/pxaficp_ir.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> Did you read drivers/staging/irda/TODO?
Sorry, Now I have read it. :(
>
> thanks,
>
> greg k-h
Thanks,
~arvind
