Return-Path: <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFT 2/5] iio: mxs-lradc: move TS config into suitable
 function
To: Jonathan Cameron <jic23@kernel.org>, Marek Vasut <marex@denx.de>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-3-git-send-email-stefan.wahren@i2se.com>
 <570FF737.4050606@denx.de> <571361DD.1090001@kernel.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
 linux-iio@vger.kernel.org, Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <57147E11.8020201@i2se.com>
Date: Mon, 18 Apr 2016 08:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <571361DD.1090001@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 17.04.2016 um 12:13 schrieb Jonathan Cameron:
> On 14/04/16 21:01, Marek Vasut wrote:
>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>> This patch moves the touchscreen type configuration into
>>> a more suitable function. Btw this simplifies PM ops later.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Looks OK
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> Please do CC Dmitry and linux-input on any patches 'touching' the
> touchscreen parts of the driver.  I'm happy this one is simple
> enough to apply anyway, but best to make sure everyone is in the
> loop.
>
> Something a little odd happened when applying the patch.  Automerging
> failed so I did it by hand. Not sure what had changed!
>
> Anyhow, please sanity check I haven't messed it up.

Everything is fine. There was a indention conflict between Ksenija's and
my patch.

>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.
>
> Thanks,
>
>
> Jonathan
