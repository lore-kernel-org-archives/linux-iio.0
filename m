Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608161557440.21709@pmeerw.net>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-12-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1608161557440.21709@pmeerw.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Aug 2016 09:21:37 +0200
Message-ID: <CACRpkdYLWZ9MZD1Mo8GUEz5aODH8-oC3S7Kb8zkZCRES-dE5Ew@mail.gmail.com>
Subject: Re: [PATCH 11/17] iio: accel: kxsd9: Fix up offset and scaling
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 16, 2016 at 3:58 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

>> - The code did not regard the fact that only the upper 12 bits of
>>   the accelerometer values are valid. Shift these
>>   down four bits to yield the real raw value.
>
> maybe can do without nval temporary variable

I could but I thought this code looks neater than the alternatives,
I tried the inlining way but thought it was hard to read.
Well let's see what Jonathan prefers, I can rewrite it for sure.

Yours,
Linus Walleij
