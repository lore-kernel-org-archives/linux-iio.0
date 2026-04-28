Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E771450905;
	Tue, 28 Apr 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398744; cv=none; b=h0pGAgBqs4PXq9ipPmXQ0zrSauvccG+IxkGp4PaK57TlRU0BEZM+1yrJbCwwcGd/Pm8hK07gRRMke4Xc2/OeQQd9msuOHt03LDZe0uQP1MsME2L0MnGOI3blHkefGWQ7gRETIjFkTAhIgeZMiGVaaO/37gzRXW0vzTvWq8hu8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398744; c=relaxed/simple;
	bh=BCnGCV3lYa8sRMdfqQAOB2HhDp00KAq4oFhPRX9ceYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro98aIag4IgR2j53I09qAtBVndeMiFNua8HDaKVqoi8Gink4Fo2b/Jb0tzTU0SKxgyFPYttKskgE6k8RSQHWIk+pwOW7babyko1xkLQ4AVXPXTrkUKc3bxAJfpPE/PXJTDBNSr3pkp6tiLNGk2D9KcMx7Aizmsz7MsCMpKr7F7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXhK+Tju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXhK+Tju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FFC2BCB5;
	Tue, 28 Apr 2026 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398743;
	bh=BCnGCV3lYa8sRMdfqQAOB2HhDp00KAq4oFhPRX9ceYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXhK+TjuOH3YYy8/tx/6Y8Zc+d4gxv7tDZAKU1xPbu0FCiupSuIrDosSv+vJPmdtT
	 Iq+6FWbt/IYvrJQYYufQL0q6jK41NHmPkyMRRlVM1jFx9mC5ohks9S4XIidKDWz/u3
	 JVdbGcse0lP4F7di3FXWaeZcRjxPNuH1a+Vyk5Lf+BpRSheOUQwcOybVFVYyP+eXfC
	 lYusB2UtWozw8C6qd0ldCinhJFDIuiMeTJGaFiehtCVnPoEGiLPkSCQbbPoIeMVdYv
	 O2ok3qvcap0/5ht3fpA0ElPJ4INdrDYaabYB3mGzbjnWKLvgMh1JTlFwUx5UKSKgJo
	 h3zo3F06KuLPw==
Date: Tue, 28 Apr 2026 18:52:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <20260428185212.5c02bb21@jic23-huawei>
In-Reply-To: <CAMB+xkZQS4qZTafrqJBkZZWR=M4W_L1+1WezgL=Wq8yrXL7W1w@mail.gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
	<20260427100950.33936-3-piyushpatle228@gmail.com>
	<ae9sZonxK7HTXsUT@ashevche-desk.local>
	<CAMB+xkZQS4qZTafrqJBkZZWR=M4W_L1+1WezgL=Wq8yrXL7W1w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 04:08:26 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Mon, Apr 27, 2026 at 7:32=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 03:39:33PM +0530, Piyush Patle wrote: =20
> > > The gain-to-scale table hx711_gain_to_scale[] is a global array whose
> > > .scale fields are overwritten in hx711_probe() using the AVDD voltage
> > > read at probe time. When two HX711 sensors are connected to supplies =
at
> > > different voltages, the second probe call overwrites the scale values
> > > computed for the first sensor, silently corrupting its readings.
> > >
> > > Fix this by removing the .scale field from the global table, making t=
he
> > > table const, and adding a per-instance gain_scale[] array to hx711_da=
ta.
> > > Populate gain_scale[] in hx711_probe() using the device's own AVDD
> > > regulator voltage. Update hx711_get_gain_to_scale() and
> > > hx711_get_scale_to_gain() to take the per-instance array as a paramet=
er,
> > > and update hx711_scale_available_show() to retrieve it via iio_priv().
> > >
> > > No functional change for single-sensor configurations. =20
> >
> > ...
Hi Pisyush

A small process thing.  Whilst it may seem less polite than you'd like
to be, we are all drowning in email!  So don't send a reply if you
agree with all the feedback.  Feel free to acknowledge the reviewer
when you list the changes in the changelog for v5.

Not almost everyone falls into this overreplying trap when they
start out so I send this email a lot!

Jonathan
