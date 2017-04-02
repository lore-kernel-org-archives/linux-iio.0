Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47191 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdDBIoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:44:07 -0400
Subject: Re: [PATCH 2/3] staging: iio: frequency: Remove useless type
 conversion
To: simran singhal <singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
 <1490972930-15476-3-git-send-email-singhalsimran0@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4cfab900-7632-2f34-7bb8-bd432a75904d@kernel.org>
Date: Sun, 2 Apr 2017 09:44:05 +0100
MIME-Version: 1.0
In-Reply-To: <1490972930-15476-3-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 16:08, simran singhal wrote:
> Some type conversions like casting a pointer to a pointer of same type,
> casting to the original type using addressof(&) operator etc. are not
> needed. Therefore, remove them. Done using coccinelle:
> 
> @@
> type t;
> t *p;
> t a;
> @@
> (
> - (t)(a)
> + a
> |
> - (t *)(p)
> + p
> |
> - (t *)(&a)
> + &a
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
driver name in title please, plus a patch description rather more tailored
to the patch. 

> ---
>  drivers/staging/iio/frequency/ad9832.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 425b8ab..01bdf8e 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -119,7 +119,7 @@ struct ad9832_state {
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
> -				     (u64)((u64)1L << AD9832_FREQ_BITS);
> +				     (u64)1L << AD9832_FREQ_BITS;
>  	do_div(freqreg, mclk);
>  	return freqreg;
>  }
> 

