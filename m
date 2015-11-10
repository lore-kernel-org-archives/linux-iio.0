Return-Path: <lars@metafoo.de>
Message-ID: <56423613.6090403@metafoo.de>
Date: Tue, 10 Nov 2015 19:23:15 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marc Titinger <mtitinger@baylibre.com>, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, bcousson@baylibre.com, ptitiano@baylibre.com
Subject: Re: [RFC 4/4] iio: ina2xx: add SOFTWARE buffer mode using an iio
 kfifo.
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com> <1447171653-12756-5-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1447171653-12756-5-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/10/2015 05:07 PM, Marc Titinger wrote:
> Capture the active scan_elements into a kfifo.
> The capture thread will compute the remaining time until the next capture
> tick, and do an active wait (udelay).
> 
> This will produce a stream of up to fours channels plus a 64bits
> timestamps (ns).
> 
> # iio_readdev ina226 |  od -x
> WARNING: High-speed mode not enabled
> 0000000 042f 0d5a 002e 010c 4be8 4eb4 0013 0000
> 0000020 0430 0d5a 002e 010c a704 4f3e 0013 0000
> 0000040 0430 0d5a 002e 010c b477 4fc7 0013 0000
> 0000060 042f 0d5b 002e 010c 8052 5050 0013 0000
> 0000100 042f 0d5b 002e 010c 5d92 50d8 0013 0000
> 0000120 0430 0d5a 002e 010c fa59 515e 0013 0000
> 0000140 0430 0d5b 002e 010c 95d2 51e5 0013 0000
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>

Interesting approach. I think if we are going to due this we want to make
this kind of emulation generic. Have you seen the software trigger and
configfs support patches[1] from Daniel? It kind of achieves the same as you
do, but using hrtimers.

> 
> ---
> Ina2xx does not support auto-increment, hence the capture threads sticks
> with single register reads instead of regmap_bulk_read.
> 
> The proper scales must be applied to those raw register
> values, I'm in favor of doing the conversion in userland in a client plugin

Yes, conversion should not be done in kernel space, we don't want to impose
the performance penalty on users which don't need it and you can typically
do it faster in userspace anyway where you have floats and SSE and what not.

> for instance a sigrok

Slightly OT, but do you already have some Sigrok IIO support? I have this
scheduled for end of the month, maybe we can align our strategies here and
avoid duplicated work.

- Lars

[1] https://lkml.org/lkml/2015/8/10/877
