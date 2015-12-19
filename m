Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55668 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbbLSPCx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 10:02:53 -0500
Subject: Re: [PATCH] iio-light: Use a signed return type for
 ltr501_match_samp_freq()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <56755A4D.7000406@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56757198.6020001@kernel.org>
Date: Sat, 19 Dec 2015 15:02:48 +0000
MIME-Version: 1.0
In-Reply-To: <56755A4D.7000406@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/12/15 13:23, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 19 Dec 2015 14:14:54 +0100
> 
> The return type "unsigned int" was used by the ltr501_match_samp_freq()
> function despite of the aspect that it will eventually return a negative
> error code.
> Improve this implementation detail by deletion of the type modifier then.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Peter, I'll probably hold this locally for a few days anyway as Greg
hasn't picked up the previous pull request yet. So if you want
to add anything give me a shout.

Jonathan
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 809a961..6bf89d8 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -180,7 +180,7 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
>  			{500000, 2000000}
>  };
>  
> -static unsigned int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
> +static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
>  					   int len, int val, int val2)
>  {
>  	int i, freq;
> 

