Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93724B28;
	Sat,  7 Feb 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770482940; cv=none; b=Z6XZf8KLAE+8ZVK+qhBq9cfL9+XnTOwPKaGW59+mly859wjvYJm/REb98NeiyiDDP0ZarsBDVKq9EEzXJe0WMb6vnVfT5PQTJOny4P2Xdmx0N9Poo5J3C2rDqcqFpAJi8GhwjdhvPXRIori/EvdAQE8nyfBID6P+cEx40Vh+8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770482940; c=relaxed/simple;
	bh=EJLQ4IxsvNkED8xXgE6aiw+sELs7n9mKJub8UTDorKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/EO+GpnXfu2tPp9A2OqbXkt28szJqvsWb2ZcAO/CslgcWgV2vBnbqjFk2oyOavIaQhic9BZ21CDXF8PhBFv+yPJ4r5puhxukgYJf/bhvl5FzEJLFzDg0mVa3A/Hfy5jf9EJRsXZd3exilk8Ruk81g/kPaGNgvxsv12arE5ocl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0AF7W4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0AF7W4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC004C116D0;
	Sat,  7 Feb 2026 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770482940;
	bh=EJLQ4IxsvNkED8xXgE6aiw+sELs7n9mKJub8UTDorKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0AF7W4cZa2bE2xm/i15DIoSYsdn7PtpnKzTdpbkB6T3RPLKrC7SeptryThSrj6j7
	 CUjuUHK0wULiMlC62sNbC84Z1ei/+6h2yHxKeHLtzGLvx/gfDbQaMPLs5/2olgazUc
	 f/L3euCn+pvVPj5Szdk9YkFRGrx7GVmU4nITJvu8bzGzt5xgpi154BYS0NRBzQtfu2
	 eaEL+mA/y5Ei5VwxzsxZiYU06BLl5Gq28MlA5zLLqDNilDyo5uj78QdfVCDHCvRRNp
	 vVA6wNA1CrFS2pV+4vZ55h7ViW2pF3oENuyYpj2z2kKI0imhxMEdiq7rT2GHEtTwZf
	 q+FBHabYoGajw==
Date: Sat, 7 Feb 2026 16:48:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ad7768-1: fix one-shot mode data
 acquisition
Message-ID: <20260207164851.51874c46@jic23-huawei>
In-Reply-To: <c4af45393ec299d0fbf853fa8ec224f475e5901e.1769889074.git.Jonathan.Santos@analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
	<c4af45393ec299d0fbf853fa8ec224f475e5901e.1769889074.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Jan 2026 22:35:20 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> According to the datasheet, one-shot mode requires a SYNC_IN pulse to
> trigger a new sample conversion. In the current implementation, No sync
> pulse was sent after switching to one-shot mode and reinit_completion()
> was called before mode switching, creating a race condition where spurious
> interrupts during mode change could trigger completion prematurely.
> 
> Fix by sending a sync pulse after configuring one-shot mode and moving
> reinit_completion() after the pulse to ensure it only waits for the
> actual conversion completion.
That smells like a race...

What stops us taking a long break between ending that sync pulse and
the reinit_completition() such that we have initialized if before the
complete()?

You always have to do it before what ever ultimately makes the complete()
happen. Have you seen an sign of the spurious interrupts or is that
more a conjecture of what might happen? 

Jonathan

> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index fcd8aea7152e..8d39b71703ae 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int readval, ret;
>  
> -	reinit_completion(&st->completion);
> -
>  	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
>  	if (ret < 0)
>  		return ret;
>  
> +	/* One-shot mode requires a SYNC pulse to generate a new sample */
> +	ret = ad7768_send_sync_pulse(st);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +
>  	ret = wait_for_completion_timeout(&st->completion,
>  					  msecs_to_jiffies(1000));
>  	if (!ret)

