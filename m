Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE033E9C38;
	Wed, 27 May 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877674; cv=none; b=fl72gpvwl4hrzvkP5iPB3ocoum6T7o809SEAtEmrPjAPxgJsBIl9yyrR1DliIMtpVi0VoOuTUJWiMWifNF2tggHfLMVOVZZOOXRrWM0LPZzIylczc2vQP+m+8xdUIS4nMWjVzSOwt/Bh2TxTqk6DvBhqxE6YJakz/2o90YcH2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877674; c=relaxed/simple;
	bh=F4wVIxodkwd3BDJN1yma/HjBc76+oHtuE3dWS53Epkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0kJtbnJ/Or/eTyHk5oRO2ft/dt9UNyvM9XiCOJoT/S298sNLCnofancVkm/ND+spe+OQ5iR6gwUmfIUbAjx4bCZ1NrOMYza+UDU0BdpCmg9drag2mvLj1PSzOoOtOdxwVlH1ukvTnKHhh/uFPBK0EoDhpvbac0o+3+kxXzTU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLRcR6mH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLRcR6mH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E38D1F000E9;
	Wed, 27 May 2026 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877671;
	bh=X68sVb0OjR+rk7GZhmjXM0j8cdufoVXiBvdjmFnMMe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SLRcR6mH5Ox1wqgo2thV4mPWfsO8wAbI98Ge9oikATZBk2+0aPFOulrM0zW91M3fx
	 A9n/vJqIXg+Dozpl3WuvHibsswcc1E+jcC8pFoeKUlFZKFpZxWbzVa9xoK543zTXfN
	 MD4M9ZHxb9DKWQ6hBzxtz2bAzMOhgnyim6QqOwTErfJs9xenL+BIjaQlBhiOeKpPd/
	 EZUM10CmujVjbixhW2xea5GqngGTQRYFnoSywlxkR6hjSSoO1CvzBThZ7RuMBi1PfS
	 iKy5Ljh/y5rZG517ttwzgWHoJC1/qI7c/2o9SG2bXGxOF8mN8G1OoYpPoMaUiu1zZu
	 GxA6K5mWr22DA==
Date: Wed, 27 May 2026 11:27:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: sashiko <sashiko-bot@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] iio: chemical: scd30: Cleanup initializations and
 fix sign-extension bug
Message-ID: <20260527112743.6ac97834@jic23-huawei>
In-Reply-To: <20260526225524.119001-2-m32285159@gmail.com>
References: <20260526225524.119001-2-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 17:55:24 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Include linux/bitfield.h for FIELD_GET().
> 
> Create new macros for bit manipulation in combination with manual bit
> manipulation being replaced with FIELD_GET().
> 
> The current variable declaration and initializations are barely readable
> and use comma separations across multiple lines. Refactor the
> initializations so that mantissa and exp have separate declarations and
> sign gets initialized later.
> 
> In addition (and due to the nature of the cleanup), fix a sign-extension
> bug where, float32 would get bitwise anded with ~BIT(31)
> (which is 0xFFFFFFFF7FFFFFFF) which corrupted the exponent.
> 
> Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.com
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

I've applied this to the fixes-togreg branch of iio.git and marked
it for stable. 

For the record I also messed around in compiler explorer and it seems
that for at least some values sashiko was correct in that the current
code doesn't give the same intermediate values on 32bit and 64bit
(I tested x86 but should apply elsewhere).  

In at least some cases it was actually fine (via undefined behaviour
from a massive shift getting masked) so this may well not have been
visible in testing. We should not be relying on that though so good
to have the fix in place.  Note I only checked a few values, so it was
not exhaustive.

Thanks,

Jonathan 
> ---
> v2:
>  - Added new floating point macro constants per Jonathan's suggestion.
>  - Included linux/bitfield.h to use FIELD_GET() since Jonathan also
>    recommended its use.
> v3:
>  - Added fixes, reported-by, and closes tags per Jonathan's suggestion.
>  - Added explaination for fix per Jonathan's suggestion.
>  - Removed unneeded comment.
>  - Changed commit subject.
> 
>  drivers/iio/chemical/scd30_core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index a665fcb78806..79124f4d7b9b 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -4,6 +4,8 @@
>   *
>   * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
>   */
> +
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
> @@ -43,6 +45,11 @@
>  #define SCD30_TEMP_OFFSET_MAX 655360
>  #define SCD30_EXTRA_TIMEOUT_PER_S 250
>  
> +/* Floating point arithmetic macros */
> +#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
> +#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
> +#define SCD30_FLOAT_SIGN_MSK BIT(31)
> +
>  enum {
>  	SCD30_CONC,
>  	SCD30_TEMP,
> @@ -89,10 +96,14 @@ static int scd30_reset(struct scd30_state *state)
>  /* simplified float to fixed point conversion with a scaling factor of 0.01 */
>  static int scd30_float_to_fp(int float32)
>  {
> -	int fraction, shift,
> -	    mantissa = float32 & GENMASK(22, 0),
> -	    sign = (float32 & BIT(31)) ? -1 : 1,
> -	    exp = (float32 & ~BIT(31)) >> 23;
> +	int fraction, shift, sign;
> +	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
> +	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
> +
> +	if (float32 & SCD30_FLOAT_SIGN_MSK)
> +		sign = -1;
> +	else
> +		sign = 1;
>  
>  	/* special case 0 */
>  	if (!exp && !mantissa)

