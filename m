Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD63E3D83;
	Fri,  8 May 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247165; cv=none; b=dE6TignitpxJSNLimPFS5JmfbMNm4PUTXmEtSfV0vATFMcPgTv2PrCIRVNgM9hJMnKnT1DSF9gmeo6MhDAluhRRH6yVVjkBmkUUSVi560vEODuP0W4slIzqdXn+cNUvHPuGe/lehtN2UTtSxdJRB/q7/MQyKeV4X+ZBd0UE9BDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247165; c=relaxed/simple;
	bh=rQfokxhTdEoEMw4pLCGPHMFHRn89ZMpGLl3KF3J2u7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwOX4v1Dwwx0HvdGPrz9lgNjvj1AhHBiV09/054lmmQuojpypynDKShAyd0EoBPABxNzoqixBY0gcZ+cIwCdNP43m7NWG6gDxLPX+/afmBuo0q/TLteeskoA0ZGM9nOvuTYNaEY1XxY9iv+M+mlFLci9jNM9kwvwU9MvxLA0NxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWdNYqVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWdNYqVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA6C2BCB0;
	Fri,  8 May 2026 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778247163;
	bh=rQfokxhTdEoEMw4pLCGPHMFHRn89ZMpGLl3KF3J2u7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWdNYqVq4yFlton6t2SzE6/p26BLofB5XXuiU2mN7AOQdjv1A6mraaI0+w1xHd7/Y
	 vkV/JSrEqscuUcn2hZqXisqxRaMAOsYdwjEV259T796Z9+Gz6OtqFAT3AZ9MV8tND1
	 Y9VClT8oJdHmh5L+LecQigGe3MODUWFfmYJ2BUDWLe/SvOF9oUTQw930XH47ezMwD6
	 DHIImGMu9YFWS8sF+q784J8Z4XZU5i5tF0jkwfmVnrtGpqjNqa1suaoRcpAczv5P7q
	 lAzyO7wVhJ6gWSO/6GSvY9D3IUA2iZMqgrroSCqbzI0j7STPqvcjCHWrftJ74XVOQa
	 ozzY3muiI4jZw==
Date: Fri, 8 May 2026 14:32:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/3] iio: magnetometer: yamaha-yas530: Ad-hoc
 cleanups
Message-ID: <20260508143235.46f53a3d@jic23-huawei>
In-Reply-To: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
References: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 08:08:32 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Some small cleanups against yamaha-yas530 driver. I wanted to produce more
> but have had no time so far, hence just this mini-series.
Applied.

Thanks,

J
> 
> Andy Shevchenko (3):
>   iio: magnetometer: yamaha-yas530: Get rid of
>     i2c_client_get_device_id()
>   iio: magnetometer: yamaha-yas530: Use devm_mutex_init() for mutex
>     initialization
>   iio: magnetometer: yamaha-yas530: replace usleep_range() with fsleep()
> 
>  drivers/iio/magnetometer/yamaha-yas530.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 

