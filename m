Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4853C1413;
	Fri, 29 May 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051330; cv=none; b=T7GIvTUsg3LBbC3S9LZwSjLxsDBshpa9S+iUdTWR1Z9GoBVUzYzdJ54NfT4Wy5mO23oEAGaMDWHe+M0O1KR69/6I496wi5187IHRj0pOFK8UqNKWgWynfuU14igvJUND8np9AFI2E9UVi6Hney3nCQpIJZewidXoCDUzcccCI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051330; c=relaxed/simple;
	bh=Pydm/KqUfaaRm/g5YdTFd3EG9LfbJ0MD/sV0S06DwPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxIU5ZRDR7UHbilYzYCvPr6gDEJdmGrFZI+Ddd09WhO7GXyB4W3dnJUm91vDPbOB+oLpmYe0Xsdtfp5cL3r+ngRxmfKpzLxKSlgX6UYSV7ufdaHBRIjFAZAFLFb8xCmV0aDNHG6NIuL87UYysjBOL+aE5ckMzXLYs7ixmQ8EB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkTaACHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkTaACHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F3A1F00893;
	Fri, 29 May 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780051329;
	bh=lKhDvAtjj6+GIVLyAh7HOny5HfcgNNMwzvBtD/CeGmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QkTaACHbEioba4Cd0JM9VMyZ7q7pB6qM1Y6Cue58rUiMGH+K25rk72Fcq0FZ9521x
	 V6q2LtJS8LDgUkS1ImaaV+J7gmQComAHxRT+gjAGWAkP+TxWO0YqzhvXKLPj1BfIFP
	 BUc/4dwxYS/uWDNr5kHNAnO1PKZ4Uqro5WWOJx6wfmFNQ6G9zkPt5wv7XrBUd/jx/8
	 P5sz+0Z0Hd9t1zOFM30y3l535Glqisp1ETJDJlsXXH7swk/cdQKlZHiJPlDFUBZ+IG
	 TerU2ZyIoxAuhY2xX4mdbJG/2jUNGVuqTvzld+90wxT9SzspdGD9wXx/PUlVjt0UCh
	 GC5MoeaIuZOnQ==
Date: Fri, 29 May 2026 11:42:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v5] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260529114201.4025eeb2@jic23-huawei>
In-Reply-To: <20260528222906.61561-1-m32285159@gmail.com>
References: <20260528222906.61561-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 17:29:06 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> Add new helper function scd30_trigger_handler_helper() containing
> the critical section for scd30_trigger_handler().
> 
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Looks like you sent a version that won't build.
> +static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int *scan_data,
> +					size_t scan_data_size)
> +{
> +	struct scd30_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	if (!iio_trigger_using_own(indio_dev))
> +		ret = scd30_read_poll(state);
> +	else
> +		ret = scd30_read_meas(state);
> +	memcpy(scan_data, state->meas, scan_data_size);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t scd30_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct scd30_state *state = iio_priv(indio_dev);
>  	struct {
>  		int data[SCD30_MEAS_COUNT];
>  		aligned_s64 ts;
>  	} scan = { };
>  	int ret;
>  
> -	mutex_lock(&state->lock);
> -	if (!iio_trigger_using_own(indio_dev))
> -		ret = scd30_read_poll(state);
> -	else
> -		ret = scd30_read_meas(state);
> -	memcpy(scan.data, state->meas, sizeof(state->meas));
> -	mutex_unlock(&state->lock);
> +	ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
The call needs an update t the new naming.

>  	if (ret)
>  		goto out;
>  

