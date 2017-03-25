Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43970 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdCYSEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 14:04:07 -0400
Subject: Re: [PATCH] iio: core: Fix IIO_VAL_FRACTIONAL_LOG2 for negative
 values
To: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1490359311-21042-1-git-send-email-nikolaus.schulz@avionic-design.de>
Cc: stable@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c2b4855d-f7cb-2dd8-39ed-0cf8e6a21428@kernel.org>
Date: Sat, 25 Mar 2017 18:03:36 +0000
MIME-Version: 1.0
In-Reply-To: <1490359311-21042-1-git-send-email-nikolaus.schulz@avionic-design.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 12:41, Nikolaus Schulz wrote:
> Fix formatting of negative values of type IIO_VAL_FRACTIONAL_LOG2 by
> switching from do_div(), which can't handle negative numbers, to
> div_s64_rem().  Also use shift_right for shifting, which is safe with
> negative values.
> 
> Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> Cc: stable@vger.kernel.org
Looks sane to me, but I'd like to give others time to comment on this
just in case there is some odd condition neither of us has thought of!

Give me a poke if we get nothing else for a few weeks.

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d18ded4..3ff91e0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -610,10 +610,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
>  		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
> -		tmp1 = do_div(tmp, 1000000000LL);
> -		tmp0 = tmp;
> -		return snprintf(buf, len, "%d.%09u", tmp0, tmp1);
> +		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> +		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> +		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_INT_MULTIPLE:
>  	{
>  		int i;
> 

