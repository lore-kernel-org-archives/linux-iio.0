Return-Path: <alexandre.belloni@free-electrons.com>
Message-ID: <51D2CC68.1080808@free-electrons.com>
Date: Tue, 02 Jul 2013 14:49:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, otavio@ossystems.com.br,
 Jonathan Cameron <jic23@kernel.org>,
 Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
References: <1372723722-13902-1-git-send-email-marex@denx.de> <51D2BCE5.8060602@free-electrons.com> <201307021403.57543.marex@denx.de>
In-Reply-To: <201307021403.57543.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/07/2013 14:03, Marek Vasut wrote:
> Dear Alexandre Belloni,
> 
>> Dear Marek,
>>
>> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
>> how to reproduce it ?
> 
> The check is just redundant, it's not a bug.
> 

Ok, that's what I understood first but then got confused by reports of
it solving a bug.

Thanks !


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
