Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034036492A;
	Mon,  8 Jun 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940365; cv=none; b=nCTETHoLLvYDmlCdYMwGe5WQzsQ0IoHkANynwd8FXIsuPv9PEH4ggo2krwu2yrXR/sdc3TNhTiMqUAXi96FZux/WUQwwFexr9fvcVQFwXRP9+BY3OxaT0azMqmyZxJKRS2cFkYkoHN30gLdxfw5f06NX16/P77TZHi30/hNs9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940365; c=relaxed/simple;
	bh=b8eY+BSVSeBuw7KGOYv00i5OS4O0NZ4ysKNbDmo5xrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOJMdOCcNpbY5pkNlb+middZsWNwZXUc5wGs7RWKH6LdIko0ad0JIVm9OXJ866CHYsPHRVVFvVJ6YEjwMEF7N1wo/BpXV2Zf6i+Suomw7Ae8zUIU09zwd0TNBe+604AuSFc7y6p58JEC2LjA7Rr+sBpZb8HOHlR2eGtLnvKRCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HosGNDMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HosGNDMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624531F00893;
	Mon,  8 Jun 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940364;
	bh=b8eY+BSVSeBuw7KGOYv00i5OS4O0NZ4ysKNbDmo5xrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HosGNDMT5RFP7QVIsqZcFQ5p5Wd1vMxl13X+hOmcjYcLUIQV6+9SRz6AZXsZWVn1r
	 TDVva0lmnEhMDxfDBPK3o/VIQTR/71mLLUYUToU4xSmhWpacaKmEOuIqOeDV0oF58I
	 m9sT8kUsQFfB6e9NpxGy107K+pVNMlGH+yz4/Fle9njs0UpkK/pMvcM6YgCUDcn9NZ
	 ZS5DamyvLgDI8JQKhG3I4S5BubbWNh+/6xG6Eis+5vTq2Jqk0jzUAw3tUfvPLHj6jj
	 swtdAU3ff5Loyb0LH8KWJOFDhgJtHmNiD2HzeGAi4SNngHOBFKrIjErLLftZrqQzPx
	 6QmexlKAswhbA==
Date: Mon, 8 Jun 2026 18:39:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sirat <email@sirat.me>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <20260608183916.11877e0c@jic23-huawei>
In-Reply-To: <CANn+LWJkOnWoXrjjqECMJgJuXOcXPUbH2U6TV1T2A=tMBCe=xw@mail.gmail.com>
References: <20260608033218.26514-1-email@sirat.me>
	<20260608033218.26514-2-email@sirat.me>
	<aiaqAEMj4mX9un--@ashevche-desk.local>
	<CANn+LWJkOnWoXrjjqECMJgJuXOcXPUbH2U6TV1T2A=tMBCe=xw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 18:15:17 +0600
Sirat <email@sirat.me> wrote:

> On Mon, Jun 8, 2026 at 5:39=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Jun 08, 2026 at 09:32:06AM +0600, Siratul Islam wrote: =20
> > > - Sort register defines list
> > > - Extract vl53l1x_wait_data_ready() polling logic
> > > - Logically split regmap_read_poll_timeout() =20
> >
> > You may want to rephrase the commit message as in the current form it f=
eels
> > like it has to be split to a few patches. In practice, it's basically o=
ne with
> > small amendments in the code that may or may not be split depending on =
the
> > Jonathan's preferences.
> > =20
> I will rephrase the commit message to be simpler. It is very small
> change and I don't think it needs to be multiple commits.
> >
> > Also, you don't need a cover letter for a single patch. The cover lette=
r makes
> > sense for the series and rarely for a single patch.
> > =20
> I will remember that.
> >
> > =20
> Thanks
> Sirat
Hi Sirat

I'd suggest slowing down. Generally, even for a small patch wait a few days
to allow for multiple reviews (and I'd have expressed my preference to
split this up saving us both a little time)

thanks,

Jonathan
