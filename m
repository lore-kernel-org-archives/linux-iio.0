Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1B35A384;
	Tue, 28 Apr 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391943; cv=none; b=iT47NP6lvbizbJeHlN5VVy3kE50fDXfAAWkSBgOYj3TcAi0B5dsoA17rCEuhp9FuLwagyW56nqdnofeu4VDeeXNPtOLjWPV3P+LjFZG6dxHC3TFQJlS6tlhajZDBGtmZME7nxLUK4xZBCrywv8g+/zF9RZT3d96s+SNorrcZ8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391943; c=relaxed/simple;
	bh=wTD4+teFflZrLlsL8lJr1AHCBg/WdHRpiNH/MEoSGq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfLgqSt//Q/sdkDOKFudcahDGFc5LMk6i9kfE63ajvkldKYrWzZjD+2iPvAGVO5Vrsn399iBxnW8lGxWlfIyyzS19XLtoAtwnS+Qtmxirp21yAngbZwswikU2FN4+uez8xt4DPq3a6xo+Ppuc/vm52kKf7YX5W4odJn0hpnB9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY6TSboD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY6TSboD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FC5C2BCAF;
	Tue, 28 Apr 2026 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391943;
	bh=wTD4+teFflZrLlsL8lJr1AHCBg/WdHRpiNH/MEoSGq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XY6TSboDLKwnRiDYFp4hazKBteaU1WvNDmrNZtTH21CJIhZ7jmKLgMH4tvFVuX3YP
	 Gqro8kU2sRLayVevVACJKgCT/xMb79lGwbh2JNAsj9WJ689xApUP8ciYRpDHy0Il7D
	 /4W5jPEOTY19ujOxOtM2o1sh+kA+ozZv5Y9SEtD/mheUEw5t/A+tO5/nuuJ+g08z/x
	 kVSEuPbEieM2JDyRFzK9cIs9LDNmCy925LKGlG21XICBgxRGaw2RXokNyf5TY6Cu+Q
	 jWtlTdvdDMogdVNonJ5/U/v1t2xRfXjetFwZpXE9/RnpXk4ALerkid8FVUQ5JlIVXc
	 DTwiNDbkTMW2A==
Date: Tue, 28 Apr 2026 16:58:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: magnetometer: rm3100: Use guard(mutex)() in
 rm3100_read_mag()
Message-ID: <20260428165853.0f7a7b58@jic23-huawei>
In-Reply-To: <CAKqfh0G+PXj8sDaJATKJmywghesm+NOJoEff1bC_gsncHQxwnw@mail.gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
	<20260428124644.49707-2-m32285159@gmail.com>
	<afC1atIQYUaFBya3@ashevche-desk.local>
	<CAKqfh0G+PXj8sDaJATKJmywghesm+NOJoEff1bC_gsncHQxwnw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 09:59:55 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, Apr 28, 2026 at 8:26=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > Perhaps we need to also put a summary of the extended critical section,=
 so that
> > it will be clear that we thought about it and decided to cover that sma=
ll memory
> > access + some bitops.
> >
> > Otherwise LGTM.
> > =20
>=20
> Sounds good, but I'm going to wait 1 or 2 days to see if a maintainer
> wants to comment on whether or not we *need* the summary about the
> mutex scope. If they don't say anything I'll probably just send a v3
> with the summary added in the commit message.

Where scope changes, it is indeed good to add a brief note on what
ends up incorporated in the expanded scope and whether that is worth
thinking about or not when reviewing the patch.

Here I think it's easy to conclude we don't care.  The last patch not
so much!

J
>=20
> best regards,
> maxwell

