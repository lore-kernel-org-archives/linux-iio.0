Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17F2EC0B0;
	Wed,  6 May 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089051; cv=none; b=mehsjgu4eng82xAmxmRhVjmu1LbVIUGzJOTBRy3LOANEgc8UlDwnlGkntgQb3eBYcilDSWumplATdI5BWBrgPXtDn/Pd8+kARJgffeCJKn1eDaw6aXUn4cO1jvLZ3pmDlHuaeZXLJpolk8wkrzdmHjGXrCwslwJ3r46K8Hd4K68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089051; c=relaxed/simple;
	bh=wUv3lEGFOS+GyZObViG6EwLvvQMGqe3rbjxJQpJ6WSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoGkQqtUOWk8LWV2ns0mgzpT0CZz3Wuf9tY9SQsDaV+XbGB63oiJkewyxaD0aX/bbhWn2J1hmISUTnNiesI289ZAdN/0LIO8GKrAfJftsdLwGNp+EkYzez9L/F7wqjlCjO3eo6pYZWObBTV1cgQ1GgaFxQL98hVQxqpXRdF/9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld5Moh8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld5Moh8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A6C2BCB0;
	Wed,  6 May 2026 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778089051;
	bh=wUv3lEGFOS+GyZObViG6EwLvvQMGqe3rbjxJQpJ6WSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ld5Moh8m6+k/b5J8bNoYZnCdT9w2ToE36j59k5GWO2uhylGBsPK9qglxHZ5F64IsX
	 y+Q2xCHpc/Fx4fh/1bCXquk2tK6rM3NsE53n4teL8qLesKCc/fOzwCoKPSMknEpPhf
	 DHBVzKh9ERSqeDKSnR3Kado211Ejq1WfqSDSNBi6M3JRl54iwrpISVTgUUPoCKnS6+
	 UPAsz7oeOPAg6vQN1pJhngiyQkpoGNmTDWh+drK3eK4R/oI2FzHIKE4tSHz1izGW++
	 oZUyJLWgC+K62hjpuwunSljnFRNnO5KttHHVtffIji2lHPGndaCauI+srSW/dBBuD2
	 ZZa8m2k+cmsnw==
Date: Wed, 6 May 2026 18:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack
 location
Message-ID: <20260506183722.681a80e0@jic23-huawei>
In-Reply-To: <CA+XhMqy=_dwpTz9c+kZ9tNJz-dHDRuPyc6TsoXWKODKgxqBJ0A@mail.gmail.com>
References: <20260505133748.51355-1-devnexen@gmail.com>
	<afriNDbCrUsXwV2a@ashevche-desk.local>
	<CA+XhMqy=_dwpTz9c+kZ9tNJz-dHDRuPyc6TsoXWKODKgxqBJ0A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 08:08:24 +0100
David CARLIER <devnexen@gmail.com> wrote:

> On Wed, 6 May 2026 at 07:40, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Tue, May 05, 2026 at 02:37:48PM +0100, David Carlier wrote:  
> > > itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
> > > fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
> > > parameter (a pointer), `&buf' is the address of the local pointer
> > > slot on the stack of itg3200_read_all_channels(), not the address
> > > of the caller's scan buffer. The (char *) cast hides the type
> > > mismatch.
> > >
> > > i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
> > > = 8 bytes into the parameter's stack slot, which is discarded when
> > > the function returns. The caller's scan buffer in
> > > itg3200_trigger_handler() is never written to, so
> > > iio_push_to_buffers_with_timestamp() pushes uninitialised stack
> > > contents to userspace via /dev/iio:deviceX every scan -- both a
> > > functional bug (no actual gyroscope or temperature data is
> > > delivered through the triggered buffer) and an information leak.
> > >
> > > The non-buffered read_raw() path is unaffected: it goes through
> > > itg3200_read_reg_s16() which uses `&out' on a local s16 value,
> > > where that is correct.
> > >
> > > Drop the spurious `&' so the i2c read writes into the caller's
> > > buffer.  
> >
> > Very good catch! I'm puzzled if that code was ever tested. Do you have an HW
> > and that's how you enter to this bug?
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >  
> 
> Thanks! No HW on my side -- found by inspection. I had recently looked
>   at a similar `(char *)&buf' / `(char *)buf' mix-up in another
> driver,
>   so I went grepping for the same shape and itg3200 stood out. For
>   contrast, drivers/iio/humidity/hdc3020.c::hdc3020_read_bytes() has
> the
>   same signature (u8 *buf parameter) and assigns `.buf = buf'
> correctly.
> 
>   Compile-tested only; the analysis in the changelog is what I'm
> relying
>   on.
> 
> Cheers !

I was assuming the fixes tag was wrong and this was a result of
rework, but you are correct it goes all they way back!
Huh.  I guess last minute driver changes that didn't quite get
tested and clearly not a heavily used device!  13 years of
not working.

We could drop the driver, but it's possible it is in use
just not with buffered support (which is a separate CONFIG option)
Also drops don't get backported so we'd be leaving it broken and
stale.  So let's fix it now and consider a drop later.

Applied to the fixes-togreg branch of iio.git

Thanks,
Jonathan


