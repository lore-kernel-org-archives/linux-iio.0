Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8B3624A5;
	Sun, 12 Apr 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018970; cv=none; b=d40SkumqkU+GahGv9uQ1wvhxFICjpafLqDDHbLzo2OjGaWuGdGlYj8zYfRaaavmJrhkgmIqaVMb994slOromR+Bvp73OXNp2N3QOcAO4CnPUiOK8urKQP43zdenLnMURjwDuEJHiFwRVGJVftCbIPnGq3b8nnus8HR6x+BLRD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018970; c=relaxed/simple;
	bh=dz6V0e4JpNJzDFVq7/5SeSkNCXQUPiFFpl7tha+hRwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muz5hBQmIbAfWKOt4hauDJhAxstK3cvxsBG4Skrk5HyrQTU1+8OOvZDLrZM4SVPNawjq3Cw7F5agHc+TXasMXmrhYTNCoQzSlInYZXulyy+iomZ+0aozmkWaqy5PYCDaHJNG5gt+WiPp8p3i6Q76tLvXp1Bj+eho4ggG88kK5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePmApdGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePmApdGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C5C19424;
	Sun, 12 Apr 2026 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018970;
	bh=dz6V0e4JpNJzDFVq7/5SeSkNCXQUPiFFpl7tha+hRwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePmApdGRJk3Cgips/Vy5lAYwJh4c8zC3OwrTaSZ4CeVjDnbMewgBpdDMf/SSRkfMT
	 0gqDzkp/xGNCNwB68/uFUzI8nW5Pb9dLhhg7vUxmJXzOsRCCgI3yU92Fx7GPsoBFZC
	 zsd5xxa0dFYgllCEoNeJV8yrORkc3XVqvnrgMAdXuB8HvMAVUDBT6UXktzkDmh/aS1
	 y8BX/A87WRxQ8R1ULtt80Lcsag/iqbqwicWlOVT2HyzumiSLXyz8wKH56PConBC4mH
	 +vP6czESQyyDMBGDB7ivQdAHDe7/ujo4wDk/afoGeRdf9PWSxDd2RGJgcfHc5/AhQa
	 H7sX/pHqyLyMg==
Date: Sun, 12 Apr 2026 19:36:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v4 1/4] iio: adc: ti-ads7950: switch to using guard()
 notation
Message-ID: <20260412193600.5b5b7e5e@jic23-huawei>
In-Reply-To: <CAMRc=MfpjTwAfoApOW0qGK0ww3MB5+xFDMQW6NCgOeNy-X_v6Q@mail.gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
	<20260329-ti-ads7950-facelift-v4-1-c568c508c49a@gmail.com>
	<CAMRc=Mc0hMh2vL1qPo2SdKqvOKDEJaXm6rGKYeuA6mc8va2FWA@mail.gmail.com>
	<0A3A1E2F-0A03-46C1-A7B8-A56B4610359D@gmail.com>
	<CAMRc=MfpjTwAfoApOW0qGK0ww3MB5+xFDMQW6NCgOeNy-X_v6Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 05:21:25 -0400
Bartosz Golaszewski <brgl@kernel.org> wrote:

> On Mon, 30 Mar 2026 11:18:14 +0200, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> said:
> > On March 30, 2026 2:15:42 AM PDT, Bartosz Golaszewski <brgl@kernel.org> wrote:  
> >>On Mon, 30 Mar 2026 00:47:06 +0200, Dmitry Torokhov
> >><dmitry.torokhov@gmail.com> said:  
> >>> guard() notation allows early returns when encountering errors, making
> >>> control flow more obvious. Use it.
> >>>
> >>> Reviewed-by: David Lechner <dlechner@baylibre.com>
> >>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> ---
> >>>  drivers/iio/adc/ti-ads7950.c | 83 +++++++++++++++++---------------------------
> >>>  1 file changed, 31 insertions(+), 52 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> >>> index 028acd42741f..6e9ea9cc33bf 100644
> >>> --- a/drivers/iio/adc/ti-ads7950.c
> >>> +++ b/drivers/iio/adc/ti-ads7950.c
> >>> @@ -299,18 +299,19 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
> >>>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> >>>  	int ret;
> >>>
> >>> -	mutex_lock(&st->slock);
> >>> -	ret = spi_sync(st->spi, &st->ring_msg);
> >>> -	if (ret < 0)
> >>> -		goto out;
> >>> -
> >>> -	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
> >>> -					      sizeof(*st->rx_buf) *
> >>> -					      TI_ADS7950_MAX_CHAN,
> >>> -					      iio_get_time_ns(indio_dev));
> >>> -
> >>> -out:
> >>> -	mutex_unlock(&st->slock);
> >>> +	do {
> >>> +		guard(mutex)(&st->slock);  
> >>
> >>Am I missing something? Why isn't it just a:
> >>
> >>	scoped_guard(mutex, &st->slock) {
> >>		...
> >>	}  
> >
> > Maintainer's preference. It was a scoped guard in the first iteration.
> >  
> 
> Fair enough, though I don't really understand that. It looks less readable this
> way IMO.

The reasoning is the subtle nature of what a break means in scoped_guard().
Perhaps one day we'll get used to treating those as loops (which they are
under the hood).  The do {} while() pattern makes the loop visible.

Jonathan

> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 

