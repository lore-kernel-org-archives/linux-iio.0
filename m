Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Richard Weinberger <richard@nod.at>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
    pmeerw@pmeerw.net, sanjeev_sharma@mentor.com,
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: dht11 Updates
In-reply-to: <1417563176-31972-1-git-send-email-richard@nod.at>
References: <1417563176-31972-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 03 Dec 2014 13:18:15 +0100
Message-Id: <E1Xw8sp-0001B6-Ul@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-iio@vger.kernel.org>

Hi Richard,

thanks for all the work you put into this!

Richard Weinberger writes:
> Please see my current patches for your driver.
> As discussed in an earlier mail I'm testing with the DHT22 sensor only.
> With the IRQ changes I see 84 edges.

This still surprises me. With the IRQ changes I would expect the
preamble to be 2 edges only. I must be missing something. Can you
explain this to me?

I'll look into this as soon as I've time.

> I have also a question on your driver. Why you increment
> DHT11_DATA_BIT_LOW/timeres by one in the ambiguity check?
> 
>         threshold = DHT11_DATA_BIT_HIGH / timeres;
>         if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
>                 pr_err("dht11: WARNING: decoding ambiguous\n");

This is to take ambiguity of when the bit started relativ to the
clock ticks into account. For example with common 32kHz clocks:
DHT11_DATA_BIT_LOW / timeres = 0
DHT11_DATA_BIT_HIGH / timeres = 2
but since the bit might not start at a clock tick the actual t of
a low bit can be either 0 or 1 while the actual t of a high bit
can be either 2 or 3.

This case is fine.

But if we had a 38kHz clock:
DHT11_DATA_BIT_LOW / timeres = 1    t can be 1 or 2
DHT11_DATA_BIT_HIGH / timeres = 2   t can be 2 or 3
so we have an ambiguity. The ambiguity could be removed by a smarter
decoder, that looks at the t of other bits, but I'm not going to do
that unless somebody is promising to test it on affected hardware.

Feel free to add some comment about this to the code.

> [PATCH 1/4] iio: dht11: Add locking
> [PATCH 2/4] iio: dht11: IRQ fixes
> [PATCH 3/4] iio: dht11: Logging updates
> [PATCH 4/4] iio: dht11: Fix out-of-bounds read

You can add my Acked-by or Reviewed-by to 1/4 and 4/4 if you want to.
Maybe Jonathan wants the patches reordered so that fixes come first, but
then 4/4 should not cause any problems in practice, so perhaps it doesn't
matter.

I really have to understand this preamble length thing on 2/4 and I will
reply to 3/4 separately.

Thanks,
Harald
