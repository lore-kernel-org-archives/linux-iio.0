Return-Path: <lars@metafoo.de>
Message-ID: <54C20CA5.7050204@metafoo.de>
Date: Fri, 23 Jan 2015 09:56:05 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16400: Fix sign extension
References: <1421969642-18167-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1421969642-18167-1-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/23/2015 12:34 AM, Rasmus Villemoes wrote:
> The intention is obviously to sign-extend a 12 bit quantity. But
> because of C's promotion rules, the assignment is equivalent to "val16
> &= 0xfff;". Use the proper API for this.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
