Return-Path: <Josh.wu@atmel.com>
Message-ID: <51F0D3C3.5090201@atmel.com>
Date: Thu, 25 Jul 2013 15:29:07 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>, <jic23@cam.ac.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<plagnioj@jcrosoft.com>, <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-5-git-send-email-josh.wu@atmel.com> <20130715130610.GD2962@lukather> <51E4FC70.3050207@atmel.com> <20130716103014.GB3125@lukather> <51E52B9B.5030407@metafoo.de>
In-Reply-To: <51E52B9B.5030407@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 7/16/2013 7:16 PM, Lars-Peter Clausen wrote:
> On 07/16/2013 12:30 PM, Maxime Ripard wrote:
> [...]
>>> After a further thinking of this, maybe remove the adc_op_clk is
>>> better since it is a fake clock, and only used to specify the clock
>>> rate.
>>> To specify the clock rate use a dt property or platform data
>>> parameter is better.
>> No, to specify *any* clock, the common clock framework is the better
>> solution.
> Yep, this patch is not the right approach. It's trying to work around the
> limitations of the platforms clock API implementation. Please fix the at91
> clock implementation instead (e.g. by switching to the common clock framework).

Thank you and Maxime for the clarify. I will drop this patch in next 
version.
Just FYI. The at91 clock common framework is in implementation by Boris 
Brezillion.

>
> - Lars
>

Best Regards,
Josh Wu
