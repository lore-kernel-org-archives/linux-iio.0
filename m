Return-Path: <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFT 4/5] iio: mxs-lradc: disable only mapped channels in
 mxs_lradc_hw_stop
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Marek Vasut <marex@denx.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-5-git-send-email-stefan.wahren@i2se.com>
 <571369AA.8060106@kernel.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
 linux-iio@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Torokhov <dmitry.torokhov@gmail.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <57148080.4010200@i2se.com>
Date: Mon, 18 Apr 2016 08:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <571369AA.8060106@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Am 17.04.2016 um 12:47 schrieb Jonathan Cameron:
> On 14/04/16 16:48, Stefan Wahren wrote:
>> Disabling of the touchscreen IRQs is already done in
>> mxs_lradc_disable_ts. There is no need to disable them in
>> mxs_lradc_hw_stop again.
> We could do with a little more documentation in the driver on
> which bits in this register are doing what.
>
> The disable_ts deals with bits 22-24... 
> The only other bit I think is ever used by the driver currently is
> 16 (channel 0).  
>
> So whilst this change probably works, I'm not sure of the logic behind it.
> As far as I can tell your new clear is fine but in reality you could
> just clear (0x3f << 16) and get the same result (which would be clearer
> to my mind).
>
> The key think here is that we don't support the higher bits on i.mx28
> yet... Which are for button detection and threshold detection.
>
> Have I understood this correctly?

Yes, you are. I've have looked to long in the reference manual instead
of the code.
I've missed the point that virtual channel 6 and 7 are used in case of a
connected touchscreen.

I should use the member buffer_vchans for masking the enable IRQs.

Regards
Stefan

>
> Jonathan
>  So we only need to care of the
