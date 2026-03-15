Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D321D590;
	Sun, 15 Mar 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579665; cv=none; b=NWhNpVTJLds483G0MdIjEiHkv1aHolR0NAWZ5Dvqqx4P99EVp0JfsN4bPdlwN5vxTs53KgE7UfEmh/x1cBuf/ZE/Ecuiq576Doq+hbnhV3Wcfu5ahdEGRrJrjs5lvEhKWswuy8G8YEZMiEVAE56OkYoFd8RSE3kFA1QqzB2c/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579665; c=relaxed/simple;
	bh=cg5SYFDLvAGyZVFjzjr93a4a/MJ45i0Wtf1tcGYLJZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/b+iHduvPgCxAclBculBjw2zi6eV+UalMmFwGuBPAFEWSN6OlmLmPXnIdMO9KgcxKavXBi1irb7rcLeQfM4voP/C1jCqkdtWDCiId+02bzqRgr0KfP8X3gl3LLH5RoJorMMsZAu3o4ZXzqnWm1YbgxIT6pkpd9PVmY9hk2bZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mop0q72r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mop0q72r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABCDC4CEF7;
	Sun, 15 Mar 2026 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773579664;
	bh=cg5SYFDLvAGyZVFjzjr93a4a/MJ45i0Wtf1tcGYLJZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mop0q72r5oToUM5vIe9wgAuJybCRUtyj1NvhRnRtIcT8ZiDqutrISUuVXrDbpjgWP
	 ibFOmh7YB1CpjM8gj4fJSsfnoJgzjr3lnMOM71ElCL1qzTx4mDqCHABHBXH5MjHqlu
	 br32GtToB9hKbigFI0RtnaeoS7PhlaqJiuRQdGzw/pTRkrJwrnUDN3Zppc+vcx1qwK
	 kb1W3n6obxHEuCZfAcPgLq3yc3sbOPlCBuMdG6UseUAitP7WRczoZ7LrD7aQM3ZWkB
	 ObaM5J+eNXNYyZT2nj2Qxxhp0x9spY9vN0siB/z6U0zhTds3ov9Bx+JV7EkH8A7DGE
	 6mdEnSNU4HoHg==
Date: Sun, 15 Mar 2026 13:00:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with
 fls_long()
Message-ID: <20260315130029.128aabb4@jic23-huawei>
In-Reply-To: <20260314172006.69744-1-neelb2403@gmail.com>
References: <20260311020115.56321-1-neelb2403@gmail.com>
	<20260314172006.69744-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 13:20:06 -0400
Neel Bullywon <neelb2403@gmail.com> wrote:

> Address the TODO in adf4350_set_freq() by replacing the iterative
> power-of-2 shift loop with a constant-time bitwise calculation.
> 
> By comparing the highest set bits of the target constant and freq
> using fls_long(), we can calculate the required RF divider selection
> in a single step without relying on expensive 64-bit division.
> 
> This ensures freq is properly shifted to meet or exceed the minimum
> VCO frequency.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
Hi Neel,

I'll wait for Andy to comment on the new implementation.
In meantime a process comment.  Don't send a new version
in reply to old one. It tends to end up with deeply nested
messy email threads. I'm not entirely sure where people doing this
comes from. Maybe there is some part of the kernel where this style
is requested?  Or it's coming from other projects.

If you want to associate a new patch with an old one, put a link
to lore after the change log.

No need to resend this time though!


Jonathan
> ---
> Changes in v2:
>   - Use fls_long() instead of order_base_2(DIV_ROUND_UP_ULL()) to avoid
>     unnecessary 64-bit division (Andy Shevchenko)
>   - Add correction check for mantissa edge case
>   - Adjust whitespace per review feedback
> 
>  drivers/iio/frequency/adf4350.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index ed1741165f55..2183deec179d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/gcd.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/bitops.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> @@ -151,17 +152,14 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>  
>  	st->r4_rf_div_sel = 0;
>  
> -	/*
> -	 * !\TODO: The below computation is making sure we get a power of 2
> -	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
> -	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
> -	 * and friends.
> -	 */
> -	while (freq < ADF4350_MIN_VCO_FREQ) {
> -		freq <<= 1;
> -		st->r4_rf_div_sel++;
> +	if (freq < ADF4350_MIN_VCO_FREQ) {
> +		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
> +		if ((freq << st->r4_rf_div_sel) < ADF4350_MIN_VCO_FREQ)
> +			st->r4_rf_div_sel++;
>  	}
>  
> +	freq <<= st->r4_rf_div_sel;
> +
>  	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
>  		prescaler = ADF4350_REG1_PRESCALER;
>  		mdiv = 75;

