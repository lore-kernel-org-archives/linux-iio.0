Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44869 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdISLsw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2017 07:48:52 -0400
Subject: Re: [PATCH v2] staging: iio: Replace bit shifting with BIT macro
To: Haneen Mohammed <hamohammed.sa@gmail.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
References: <20170919015651.GA4554@Haneen>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b699803e-febf-7b9b-f2d7-e778d0b993ae@metafoo.de>
Date: Tue, 19 Sep 2017 13:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170919015651.GA4554@Haneen>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/2017 03:56 AM, Haneen Mohammed wrote:
> This patch replace bit shifting on 1, and 3 with BIT(x) macro.
> Issue resolved with the following Coccinelle script:

Can you explain why this is an issue and why using the BIT() macro is better
in this case?

These kind of changes need to make semantic sense, the goal should generally
be to improve the legibility of the code, so somebody looking at the code
easier understands what the intention of the code is.

E.g. we can easily write "x *= BIT(2) | BIT(3)" instead of "x *= 12", both
have the same effect. But the later is much easier to understand for the
casual reader.

The intended semantics for BIT() are that we are talking about a single bit
field. There were a few of those in version 1 of your patch, were using the
BIT() macro makes sense. But in my opinion none of the changes in this patch
fall in this category. I mean, what is the meaning of multiplying by
BIT(27)? Maybe we need a POW2() macro for places where we are semantically
speaking are talking about a number that is a power of two.

> @@ -229,7 +229,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>  		u8 d8[4];
>  	} dat;
>  
> -	freqreg = (u64) freq * (u64) (1 << 27);
> +	freqreg = (u64)freq * (u64)BIT(27);
>  	do_div(freqreg, st->mclk_hz / 4);
>  
>  	switch (reg) {
> @@ -318,7 +318,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
>  	freqreg = be32_to_cpu(dat.d32) & 0xFFFFFF;
>  
>  	freqreg = (u64)freqreg * (u64)(st->mclk_hz / 4);
> -	do_div(freqreg, 1 << 27);
> +	do_div(freqreg, BIT(27));
>  
>  	return sprintf(buf, "%d\n", (int)freqreg);
>  }
> @@ -452,9 +452,9 @@ static ssize_t ad5933_store(struct device *dev,
>  
>  		/* 2x, 4x handling, see datasheet */
>  		if (val > 1022)
> -			val = (val >> 2) | (3 << 9);
> +			val = (val >> 2) | BIT(10) | BIT(9);
>  		else if (val > 511)
> -			val = (val >> 1) | (1 << 9);
> +			val = (val >> 1) | BIT(9);
>  
>  		dat = cpu_to_be16(val);
>  		ret = ad5933_i2c_write(st->client,
> 

