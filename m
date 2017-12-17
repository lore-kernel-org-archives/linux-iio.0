Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdLQMlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 07:41:25 -0500
Date: Sun, 17 Dec 2017 12:41:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20171217124119.45e442b1@archlinux>
In-Reply-To: <20171213140039.18482-1-cmo@melexis.com>
References: <20171213140039.18482-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 13 Dec 2017 15:00:39 +0100
Crt Mori <cmo@melexis.com> wrote:

> There is no option to perform 64bit integer sqrt on 32bit platform.
> Added stronger typed int_sqrt64 enables the 64bit calculations to
> be performed on 32bit platforms. Although int_sqrt() is a rough
> approximation, the same algorithm is used in int_sqrt64() as good
> enough on 32bit platform.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>

It was my suggestion that we shoudn't really be doing this in an individual
driver. If people feel that it is not of general enough applicability then
let use know and we'll move it back into the driver code.

Thanks,

Jonathan

> ---
>  include/linux/kernel.h |  1 +
>  lib/int_sqrt.c         | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0ad4c3044cf9..09f53063f2c9 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -459,6 +459,7 @@ extern int kernel_text_address(unsigned long addr);
>  extern int func_ptr_is_kernel_text(void *ptr);
>  
>  unsigned long int_sqrt(unsigned long);
> +u64 int_sqrt64(u64 x);
>  
>  extern void bust_spinlocks(int yes);
>  extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> index 1ef4cc344977..de5836448ea3 100644
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -36,3 +36,29 @@ unsigned long int_sqrt(unsigned long x)
>  	return y;
>  }
>  EXPORT_SYMBOL(int_sqrt);
> +
> +/**
> + * int_sqrt64 - strongly typed int_sqrt function
> + * @x: 64bit integer of which to calculate the sqrt
> + */
> +u64 int_sqrt64(u64 x)
> +{
> +	u64 b, m, y = 0;
> +
> +	if (x <= 1)
> +		return x;
> +
> +	m = 1ULL << (64 - 2);
> +	while (m != 0) {
> +		b = y + m;
> +		y >>= 1;
> +
> +		if (x >= b) {
> +			x -= b;
> +			y += m;
> +		}
> +		m >>= 2;
> +	}
> +	return y;
> +}
> +EXPORT_SYMBOL(int_sqrt64);

