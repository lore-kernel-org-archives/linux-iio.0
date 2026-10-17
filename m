Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD455347533;
	Sat, 17 Oct 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261882; cv=none; b=hnLir5MEg1l3SDDFejz5Ia/tYoTXG+hunGov1G6xx1rnM3SyMMQe/xYyNiBhCbxc6Mfnw4uP5bpL60KmjE7Utrf/mHaB6MYxl6txvuc8YovaaGfY0LGR4fmxlKMr4Pn++Gpl4mzEw/OjCGmtQBY6cLx9vrQrj0t1qUlQGzr1Alw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261882; c=relaxed/simple;
	bh=5MwvH6yXOWrWw954Zho6Vin04TWOYE30tOX1DrCbzU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOgJR94LWMcr0vDO3+Dky2c+FjRKGInlYnVdV654dkFcppcf/34wtE7iAW5I3p8bSHjy6fOrwwCoOptE6nDnw/uxETE0eSeSJvbEpfCatd+sfJZPJcNZAbQagwDXG1ga5TYnPc0loA1tIRHjhSrhme5eyyGPae5lrzF51PGYOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It133tOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It133tOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903151F000C4;
	Sat, 17 Oct 2026 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792261880;
	bh=31sZM63EOEAfwhJrcrA2P/23kgLtM+HNbtPomQJ6tkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=It133tOLnIkAgDNxl6oYfh2i4AegnUEw6W8DCsgU/zNYZ9RhQ5tax/q/pMR4YMTbM
	 5evKlkrcKDURlM8225b4THB7PtTyjF4IQh5F1cm21HGhQJOuo05q2nbA7Ie37/SPie
	 j1/X0hppwvLamU/5tlA78dYvbQ/P9X7OZu0eJ6Otx3f2b51/x1v0yz7S3he21Ay5D8
	 Ru8AUa44PPvd8e6pk5Q3e4aOm/DUc5dEdMTPJEhJSxo9w2wk5hywJAnKDU2UwRiA6R
	 r9eEo+Dy7+GXVHLYmGrNHIqP6QSQWTQPxwjR+kFXyTYUOLMHUWTIt+vu8vt+siUDjn
	 ELpSFJYm6VsIA==
Date: Sat, 17 Oct 2026 19:31:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 10/13] iio: adc: ad4134: Support SPI 4-wire mode
Message-ID: <20261017193117.04b71262@jic23-hlaptop>
In-Reply-To: <ar1lg7PMwP_RdzzO@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
	<c066072441fdba492c18c71d5332d84224379410.1790719425.git.marcelo.schmitt@analog.com>
	<20260929230830.A8F3A1F000FF@smtp.kernel.org>
	<ar1lg7PMwP_RdzzO@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +static int ad4134_buffer_predisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ad4134_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	ret = ad4134_release_sample_access(st);
> > > +
> > > +	mutex_unlock(&st->access_lock);  
> > 
> > [Severity: High]
> > Is it intentional to hold st->access_lock across system calls here? Returning
> > to user space with the mutex held violates lock ownership semantics and can
> > trigger lockdep splats. Furthermore, could this deadlock any subsequent sysfs
> > regmap accesses while the buffer is enabled?  
> 
> I'm not sure about this one. The intent is to prevent sysfs regmap access while
> the buffer is enabled. IIO direct/buffer mode locking should provide that, no?
> The rationale for the two mutexes is for access_lock to avoid concurrent updates
> to the external multiplexer and for sync_lock to protect read/modify/write
> sequences. Maybe IIO direct/buffer mode locking + sync_lock is enough?

Technically claiming mode would be enough and if the locking is only coupled
to "in buffered mode or not in buffered mode" I'm fine with that.
However, if you need to serialize for other reasons we probably need to
grow a more complex solution with a lock and a flag (similar to what the
IIO mode stuff is doing) so as to avoid holding a lock across syscalls
as this points out.

> 
> >   
> > > +
> > > +	return ret;
> > > +}  
> > [ ... ]  
> > > @@ -588,15 +768,69 @@ static int ad4134_probe(struct spi_device *spi)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	ret = devm_mutex_init(dev, &st->access_lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ad4134_regmap_config.lock_arg = st;
> > >  	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);  
> > 
> > [Severity: Medium]
> > Is it safe to modify the global ad4134_regmap_config structure during probe?
> > If multiple devices probe concurrently, could this cause a data race where one
> > device's lock_arg overwrites another's before devm_regmap_init() copies it?
> >   
> Not sure. Should it lock on a mutex before editing the regmap_config. Maybe
> I get rid of access_lock and make regmap_config const again.

Good catch here.

You shouldn't be modifying the global. The mutex solution works because
devm_regmap_init() doesn't keep any references to the config anyway but
I'd just use a local copy instead.  One on the stack should be fine.


Jonathan
