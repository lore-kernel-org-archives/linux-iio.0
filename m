Return-Path: <lars@metafoo.de>
Message-ID: <54C20CAF.3010901@metafoo.de>
Date: Fri, 23 Jan 2015 09:56:15 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad2s1200: Fix sign extension
References: <1421968196-17193-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1421968196-17193-1-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/23/2015 12:09 AM, Rasmus Villemoes wrote:
> The line above makes vel a 12-bit quantity (st->rx[] is u8). The
> intention is to sign-extend vel using bit 11 as the sign bit. But
> because of C's promotion rules "vel = (vel << 4) >> 4;" is actually a
> no-op, since vel is promoted to int before the inner
> shift. sign_extend32 works equally well for 8 and 16 bits types, so
> use that.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
