Return-Path: <Josh.wu@atmel.com>
Message-ID: <5215E1D3.5090905@atmel.com>
Date: Thu, 22 Aug 2013 18:02:59 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<maxime.ripard@free-electrons.com>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>, Ludovic Desroches
	<ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 4/4] iio: at91: introduce touch screen support in iio
 adc driver
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com> <1376219071-29946-5-git-send-email-josh.wu@atmel.com> <20130812172453.GB31418@core.coreip.homeip.net> <520CAD07.1080709@kernel.org>
In-Reply-To: <520CAD07.1080709@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi, Jonathan

On 8/15/2013 6:27 PM, Jonathan Cameron wrote:
>
> On 08/12/13 18:24, Dmitry Torokhov wrote:
>> Hi Josh,
> Hi Dmitry,
>
> As you haven't raised it here, I am guessing you are fine with having this
> chunk of input related code in an IIO driver?  I wonder if it would be
> better to break this into an mfd core and child input and iio drivers.
> The two parts look fairly separable to me.
> Clearly that means adding some overhead, but the gain is that the input
> code ends up in input and the IIO code in IIO.
>
> What are your views on this?  I'm fairly flexible if you think it simply
> isn't worth the hassle of breaking this up.  I'm more worried about setting
> a precident than anything else.
>
> Jonathan

Since Dmitry has no feedback yet. I am not sure is it a right time to 
send out the next version for the IIO ad91 touch patch?

[snip...]

Best Regards,
Josh Wu
