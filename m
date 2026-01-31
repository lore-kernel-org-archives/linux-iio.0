Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F5322B9F;
	Sat, 31 Jan 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769883967; cv=none; b=QAfFQOgRbb5rVc0iEbOYFhQBYysgEBbswrqFLE0dO6ueQfPh/I3h/wHEqvkub7+tdL6gTf3B6bJ0gfric6lPmaCwcpB873DbwpgRBPaJLWa7TYeyvNYMuBTbHH3YX1TX4QnJE2iQoOCEp54z3hqkJYiJ7rrbkHWBCLWxiqpQEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769883967; c=relaxed/simple;
	bh=zGpOUmhC1t8dp9mcAaXTnujlA/5G8EcJI+Dd6yBMCAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q74QSZV4TuSCrF5RecE1T0FUeN/33XE1xtCXbz44Z/9pu9CYCFl30+jHmsiz4tYqJOGYtn3s8QfThOAqPi3NaRyeOj0O5FnAw8qMghDaUetZU+X8PEVCvZPt+t1/dq32L9UH5t/T1z9VbV2KrlIdzJHeBCecQi1i0YBZl3iM+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC5r7yCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC5r7yCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C626CC4CEF1;
	Sat, 31 Jan 2026 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769883967;
	bh=zGpOUmhC1t8dp9mcAaXTnujlA/5G8EcJI+Dd6yBMCAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dC5r7yCgFd7t+6Qg1H+iIcEO/fwAHnB4veG5FihEVdcdj4oq/KlHw68jpB3lLLw3j
	 xy6DDBv9lSIPEpSmAfeQAGD5H1BQ5xu7AhLrT2go16dvrOPGby59cr2wdbsAhopF8o
	 FC8BjyHSebADNzYFVjm7WwB7EavwPHs6h+8ZyWXqvd5TLbodh03NWRDBCYw/Ro+e4h
	 XANOnYLf65JtW/pKpnci6oHkjwcfDs0cenQKbe3c+9LVUD59EsBnT/Ludd5xhmofZ7
	 iIdQu0Hgv2uHld07k0yq/uQCDc2bbBCQlodY7/9D/8bf1NnygZ5sOGgXnpP0kUmOWl
	 u8iRmwAN9h7Lw==
Date: Sat, 31 Jan 2026 18:25:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio:frequency:adf4377: Fix duplicated soft reset
 mask
Message-ID: <20260131182558.464e534e@jic23-huawei>
In-Reply-To: <20260123194758.15445-1-suunj1331@gmail.com>
References: <20260123194758.15445-1-suunj1331@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Jan 2026 04:47:58 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> twice instead of checking both SOFT_RESET_MSK (bit 0) and
> SOFT_RESET_R_MSK (bit 7). This causes an incomplete reset status check.
> 
> The code first sets both SOFT_RESET and SOFT_RESET_R bits to 1 via
> regmap_update_bits(), then polls for them to be cleared. Since we set
> both bits before polling, we should be waiting for both to clear.
> 
> Fix by using both masks as done in regmap_update_bits() above.
> 
> Fixes: eda549e2e524 ("iio:frequency:adf4377: add support for ADF4377")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
For now I've applied this to a local branch which I'll push out once
I have a suitable base (release, or rc1 depending on when I do it).

Given Antoniu and Andy's involvement in earlier discussion, still plenty of time
to add tags or indeed suggest I drop it again for a v4!

Thanks,

Jonathan

> ---
> v3:
>  - Summarize discussion about why both bits need to be checked
> 
> v2:
>  - Add Fixes tag
> 
>  drivers/iio/frequency/adf4377.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 08833b7035e4..48aa4b015a14 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -501,7 +501,7 @@ static int adf4377_soft_reset(struct adf4377_state *st)
>  		return ret;
>  
>  	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> -					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
> +					!(read_val & (ADF4377_0000_SOFT_RESET_MSK |
>  					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
>  }
>  

