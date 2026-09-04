Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740B47887E;
	Fri,  4 Sep 2026 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560494; cv=none; b=NgaD47ymna2HShVr53SpGKJQOsE8sE44+Qmnwf4WDP1VHqNDmWcIBnAFjU2EScjrrJFDw4uMyLzAKfberXPwkKeLnCNryjpcoJcvBVgJIQtUnRzP6SuaWWuAVrmaQkgMdIn9Nm7DZ+p6E6sAU6o9N3wCx+q/BSab34mKsR+oO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560494; c=relaxed/simple;
	bh=I1+DlDXXZMKXVxWFcR3HcrMpIS3F/JxDgU5beXboqBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AILJ+GQpyQEG8iEarGFu6oZHm3vGDxGBCmt7kX2PG6j+ICAA2s61aeLVEYTAyP8jmRQLLnYWz42wUU8Dk+Wa2VrzVNyeSHn+go1TY6+Cya0pY65yW0lU2Ma08XL0YuGyc40hXLn+dfHDS8prYvh/yQ9PnRKIeF9sS2OlflbLrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jinurUqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jinurUqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D791F00A3D;
	Fri,  4 Sep 2026 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560484;
	bh=Q2lLPA0/RY7sYTvVQwJN5wkIUDKkohZsu8pi8u9FSDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jinurUqmztEnowGbjLE0CXx111Ok8dRVX51tDuGIkL8wdmawLXA1I9dKkAAEJUbSH
	 MPM7+pQRtv0lIouNA5BBEUUnhiuW1WCKHLNfCHd8Tj/wysdxY+JK6lmyTjml6bXUFC
	 MvBPlllcCr3PAAD4k7dRXFTrFo3N/XY38AQ7wqg7rnGmoYy2R28RPmUe6cThRFc2gm
	 BTyWxYKeLLoN9oBPute9QzcFv8YxMt0i7ghHm7C/ZSH+QTDxzHh+c+e8T7y6UjhrXG
	 JxQi7MUqSO742boEE3uwPb8g6R4RX2HIdiVZCmICIMh2kOITT7VSJe64KNzB8StBvp
	 vrKhSGh6fCmkw==
Date: Fri, 4 Sep 2026 23:21:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Amiitesh TSP <tspamiitesh@gmail.com>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos in drivers/staging/iio
Message-ID: <20260904232120.63ece599@jic23-huawei>
In-Reply-To: <20260904165115.228990-1-tspamiitesh@gmail.com>
References: <20260904165115.228990-1-tspamiitesh@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 22:21:15 +0530
Amiitesh TSP <tspamiitesh@gmail.com> wrote:

> Fix typo error in iio staging documentation from none zero to non-zero
> 
> Signed-off-by: Amiitesh TSP <tspamiitesh@gmail.com>
Hi Amiitesh,

So I'm kind of assuming Amiitesh TSP isn't a legal name (which is
anyway no longer a requirement for a SoB).  A bit of googling shows
you've at been using it in various other forums, so I think that
meets the requirement of a known ID.

So with that in mind,

Applied, thanks!

Jonathan

> ---
>  drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
> index 863d3856718a..d19db00acd1d 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
> @@ -4,7 +4,7 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Writing 1 enables the cell balance output switch corresponding
>  		to input Y. Writing 0 disables it. If the inY-inZ_balance_timer
> -		is set to a none zero value, the corresponding switch will
> +		is set to a non-zero value, the corresponding switch will
>  		enable for the programmed amount of time, before it
>  		automatically disables.
>  

