Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A543ABC;
	Sun, 22 Feb 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779701; cv=none; b=GdsAUheWiL6C4y4wNOFz6cTFSB+19pD/Qj8T+uhoP5aro3gqkqlKQ8ADRwjdjzGfTPOJCwfMNuJ7m6Niw5GTNqgflBhbz1WwNPq3VT/2Fz9mFAMTdKvAg8hoXMjeoiLxVSmxmrA3uZR/068Sbj3loPU1me4bhDCqVGHz4Pqav9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779701; c=relaxed/simple;
	bh=0NeVMiisNLR4UwCJzwtnI23kyKDUoOJlCj2yQ3llZfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFqJ6lI7Hum4kVkLTcHMdN0WWS8suMeuMF8qCzZICnrxe6zYBUT6kXbtuO3BKV4nMk+H79PIRIx6iumhWQSV+oGJs+v6ay4yYkFoOJa09PvzNhGUnvbf+O7VWuFZM/pwz9hLis4noHfYg7QNIW2O+VzGnofWHOXsrAv6eBxodR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXhQaYWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXhQaYWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F037C116D0;
	Sun, 22 Feb 2026 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771779701;
	bh=0NeVMiisNLR4UwCJzwtnI23kyKDUoOJlCj2yQ3llZfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BXhQaYWZp7U4zbHniYf+Qb6Nmeteomf6edZX3Pyzg96e71VrYtl10KCIxBFPyCvTp
	 5ZY7w/ewuzAuMTSRMdZHiJZI+eVNYqbwV8jjMlUwa4RpQ86ln3ADQ6d2YRnekiM7oj
	 mmI7NWVnwAV2lkUcVSVcf+x0AZ65gW/gMb1i0Du/EnmdbrRPFlf35j/olyy+Fs+lYv
	 ElT+ciLZtQBCXUQGe+4M9QlbVVkKY4KoX0Nx0fz5F65Ofqge8s4LT8yLYbJpVZjKxT
	 t1flPptJ8sVq6oqfM+DYgMqRjCQBBN713FctyGU4Qnwmy+i3+whmEQZv2ECv+s3+ZG
	 apoJL5MUyuITA==
Date: Sun, 22 Feb 2026 17:01:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] iio: adc: ade9000: use dev_err_probe in probe path
Message-ID: <20260222170132.57f3e160@jic23-huawei>
In-Reply-To: <20260220131151.74329-6-antoniu.miclaus@analog.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
	<20260220131151.74329-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 15:11:43 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Replace dev_err() + return with dev_err_probe() in ade9000_reset(),
> which is called during probe. This simplifies error handling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied this one, but tweaked title to include dev_err_probe()
(added the brackets)

I think Andy's feedback applies to all the rest of the series so I'll wait for
v2 for those.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ade9000.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index db085dc5e526..5dcc26a08970 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -1589,10 +1589,9 @@ static int ade9000_reset(struct ade9000_state *st)
>  	/* Only wait for completion if IRQ1 is available to signal reset done */
>  	if (fwnode_irq_get_byname(dev_fwnode(dev), "irq1") >= 0) {
>  		if (!wait_for_completion_timeout(&st->reset_completion,
> -						 msecs_to_jiffies(1000))) {
> -			dev_err(dev, "Reset timeout after 1s\n");
> -			return -ETIMEDOUT;
> -		}
> +						 msecs_to_jiffies(1000)))
> +			return dev_err_probe(dev, -ETIMEDOUT,
> +					     "Reset timeout after 1s\n");
>  	}
>  	/* If no IRQ available, reset is already complete after the 50ms delay above */
>  

