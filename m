Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8F1C695;
	Sat, 14 Feb 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081828; cv=none; b=FVR12qLieu969kfif+fKJre8YsE78tbpyf2kgthK4SaKWHTOnS/70JLca3Mba+xLAMHc/YR4oIrK6SG39TYkFqva20U4D0ibtu9NBjnfTxBWJEYocWGXOGoybD4lcLv0f2gZwsSj05syE/LTLU/+vMcMrx/FuvbEQaOGjR0RPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081828; c=relaxed/simple;
	bh=sauex7qREAMEGQ7+s3OhzlrdMH/yZ9ZWuu/AO/AL8z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cd55wwjOHThbjmfeejFPWpu/62OQzETLfu0I5uF/BiB6KG+H/w9PuSsIA88b/AAdgYXa1JXx2Y32Yv7kFfY6lDd8AuxLK1VYS26DxMJbWvbGshdHK3QtQjCUbQHTRy325m4vML6P6irPZWD6dIqmIDXaZl1Uhk67M7ijiZtoxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQz/QJ/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQz/QJ/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A6C16AAE;
	Sat, 14 Feb 2026 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771081828;
	bh=sauex7qREAMEGQ7+s3OhzlrdMH/yZ9ZWuu/AO/AL8z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQz/QJ/E8QiWAX0WsNJL22R3VnLgfp9x/1cOM+jTXWY5YROo3m2zBLm5gG67FX3xe
	 mKO9kVT91nwKAwBjd4xcVWuFKy6sEf+zcKhwCUJjr4B27yRKiXRM1pmUhIe12BvJXz
	 cf9v9ie6Der/5ghwH991lphT9lqNpfAJTKbOc7VNKSxHgaa1MSgv8fd3RRU3LpMhXD
	 iBtltmUAJhZ1IfTxxOJvJ5TDHNY7PS/NBsxvv4V2gWgUfh/jA6b5jdwYOpVIU9O2Oo
	 d48xqqXms3VcMPOIa/p68yQIKx+FwT+t0KhKEN9MOs4pTuZgjofkblizndLhnXez3D
	 C5BZlSbJKM8fA==
Date: Sat, 14 Feb 2026 15:10:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: imu: st_lsm6dsx: Set buffer sampling
 frequency for accelerometer only
Message-ID: <20260214151020.4b708f85@jic23-huawei>
In-Reply-To: <2cedd8f292b893f0e82aacf03c0989b17bfbf69b.camel@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	<20260122162335.2020006-3-flavra@baylibre.com>
	<2cedd8f292b893f0e82aacf03c0989b17bfbf69b.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Feb 2026 09:02:43 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Thu, 2026-01-22 at 17:23 +0100, Francesco Lavra wrote:
> > The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> > userspace
> > writes the buffer sampling frequency sysfs attribute, calls
> > st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> > `sensor->id`; since this array is only 2 entries long, an access for any
> > sensor type other than accelerometer or gyroscope is an out-of-bounds
> > access.
> > 
> > The motivation for being able to set a buffer frequency different from
> > the
> > sensor sampling frequency is to support use cases that need accurate
> > event
> > detection (which requires a high sampling frequency) while retrieving
> > sensor data at low frequency. Since all the supported event types are
> > generated from acceleration data only, do not create the buffer sampling
> > frequency attribute for sensor types other than the accelerometer.
> > 
> > Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
> > batch data rate")  
> 
> This patch didn't make it to 6.19. Would it still be OK to merge this in
> the next release cycle? It technically changes userspace, but I think this
> change can be put in the "no one will notice" category.
> 

I think it should be fine in 7.0 (though I've been wrong before!)

Thanks,

Jonathan

