Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FC3148C9
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701727; cv=pass; b=kf0yUoLO42BO5mUzwvBrcM2GLZRKS/G/gdP/qpPZivAeAIYn2VYbSBuro9jRuxsuGVqXEMksitomRF24CisQXs39fInhGnZx4ejph1q0IIB53yx0eqb05L/NpcgBZDcg0wASVQblr2wXNjsJBquoAzmQICuCQ+5PrjAq4n0shqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701727; c=relaxed/simple;
	bh=tMjGtxVrMKPLCSltBy9Y5iHzDFlby1ddMmYjQnJkNgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTKyV/fLaWluH43Ag5xmsPphH2RGEfEsZMqFjShR6QYuXz6BZQQKD2ueEPeUPwX4/fVj1fiv3LzC823qLOGpTUmA8S+szA/lctXgdHlcPBZRdsVDpln1OFNRHekIYl1IapGCC+AoBwVaK/mOqpVmEtaO66ihae6rKb+jJ8M/jxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAe0uMKf; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAe0uMKf"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a40bcc8d69so66048b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 16:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787701725; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2d7W3oyvY/uHCVh0oK5nI41c1YLfDp0rOvQrBKlZaW2RHK+1glpkv0uBZTkp0HoiX
         iU5iRFnp8JTYiUMEFQv88hIWnScD3m+Et32Ri+pG8PwHA/P66melawsRue1oAFhbSBCN
         nQ5faGh4J4V88aHGtbFCA4FsMysnkG0kXEOcqmtFj/fkEknnhIj/1gR1tiEw/q0S3oji
         qotDKgL/mfUUhJf6WWUFFgLJHCF/HtbEi6nfRpEfNHPNGhy6qWh9cip+H6g9mSy1vQhX
         neBu5gW49DFwrrEc4AiBcavGb2w9e/H6BnWEF68M8nuBbNa3ZpzbsjePm59xc162tdeQ
         BcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xmJBH5qFbGfvbjdwZk1KaBZC4LgUPcxnSY/yfNH034M=;
        fh=y6A3VYZkWI2AJgDh1nRPm7blmoYQrTtsVhbZVKQErGk=;
        b=hXqPkZssy0prnZFOdZ/GNHAQ4h2H7jHGYaBsvVtIkRGmyohr13N3IeOtO+n8KypNKO
         wlMVOXG+nFi8xFjdw26LgHKlaPCy01hlEC/Gpdl5/NQJnSwBDRdd3utj35h8q2PMcNjE
         pBV1WVTtmycabCfB1z7Cdw/0eXXaUMbSE23Bbb5w9S666lxneB6bStq0SpJ8kGnStNsf
         47kpGW/KHLa5H9ZWzuRXWE+M18vzak0iANaG0RFCqJpa91sZoRb1y6hrPCr/2BJctObe
         327s6i6xA1hS85g+tRqQeTNnIHw3s2iKXaUAw67TgVLEOGVYk/ikuffRpU4Ll98/TXfh
         TAsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787701725; x=1788306525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmJBH5qFbGfvbjdwZk1KaBZC4LgUPcxnSY/yfNH034M=;
        b=gAe0uMKfzCVhozb909eE+C59DMJevZFZsndRK1CnohoghJDPctzCgmeKBqbTvdgmnp
         ZgBRkg9pUVQSO9tkw2A4gWsqSZ/yNNvbl4OYMKpslIrcHtXwR2m69iaydIoZpOQaiLAA
         her3ByEl44wianuKuC7NNZvOMNNzyaM9Nca5/cI3XJ9TNV+XEzXgsXfjnXHv0xdJ6yZr
         YXLhESJpLAdIc//U5UI6+z1Sq6lkkNPUSqd0vwGg/4LrzYeUskQ8qqHovBlDuGouqayA
         uK1IvfquME5UvK9Qr+Xm/RkRrn65n7Jhhh15qzutOAsXdWp9lFXdbSi1ktrDteH2Gqe6
         kNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787701725; x=1788306525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmJBH5qFbGfvbjdwZk1KaBZC4LgUPcxnSY/yfNH034M=;
        b=nLwklgUyDuvExOTw38Q42efHBEYo+5qAZCx6A7CBVZtZueJH6nsaHe4mhJfkzwsVHu
         rkw9EaBaup5tjjQ7nRVb1fr2jVbhQq0QqlBS9rTiCsG1mhPCHPTGDkcvZrKOgrBGX8IJ
         Zw4Lrc/0v+GriN5v3RklGCoyEAJC0PH+DOog/ZhAT2Y9F9ZXf6czhGnVV/H8ctU54geK
         9IWitUqEBe9IzuGZx3OwfxSRjvBdE1Sc0F2OEerFLUfQtqZmy9Gi3Ac6jOvKJxRXZMsO
         KnBQLLxjPOaal5pwKKkZPGGjIiPUFiRYWHTb8qcA1xpOIB7GahCJF3UZVMqrt1bt6kXC
         f0mA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/AQpvFs6pAtsy2S90fOyivMNi/k4SUx3yMK80sR0yH1kVJ0jOPRaebsp5jsQUfSCYrf2oYVgW9Ro=@vger.kernel.org
X-Gm-Message-State: AFuF++nAEPlB9S8nZoEVwiYTOuHw0h2DB206IXe5gvlLGmSunG/wsSEZ
	6n19+7mQJIgXELcNq9IPpVgefSqGCCqcGIqQhHl+QRcJSae7bknLfBY7aJXmxP6pwoptAU+2N6R
	/5hMOL+IX83RiLKJ+IoQo9WVx0VXrbxw=
X-Gm-Gg: AR+sD13jaMDok0enRb76OwmHAzhPJz4HwHciK7AR599tG3MTXjkhzQHHqk+O7cn2RfD
	NEmMRkRAdh/o9NmvFyETYoUu+N/hzdYKWHusJoGgYyFrgKBAI3kNQ9dzgdMeT6mDCM65YaDN2q/
	Ma9tAmuDEuxUs/M+a2zwofJFnD1cECF8iLasCkmN1oh6onBOyOQJwQWZP9TEoch+KXZBOeRb1pZ
	fTghWJN6ofurJ2QCpgxhUqQ5bs366oxcpmZs2g676GRh0Efm/GVUlkvNaBGa7Z9FXtcTeB3rIKQ
	F0WVspEvrBaPIP8+AgIGlwsfY60IRY2BxGys+gbxQ2RGAleGVBUnCDkV/mqq2B2E2Gp0DebyKpH
	Y
X-Received: by 2002:a05:6808:15a7:b0:4a3:26e5:cc02 with SMTP id
 5614622812f47-4b366a06abfmr3415915b6e.10.1787701725293; Tue, 25 Aug 2026
 16:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
 <aowVI_n7s0VAmN3D@ashevche-desk.local> <20260824120503.00003500@gmail.com>
 <aoxZq7sc4ndMG-V8@ashevche-desk.local> <CALoEA-w8RMArm=STmnaGJJdyHpR7V-58uFz4m9U74aDe+QJe6Q@mail.gmail.com>
 <aoxicO-nya_zp9Aj@ashevche-desk.local>
In-Reply-To: <aoxicO-nya_zp9Aj@ashevche-desk.local>
From: Rishab M <rishab.madhugiri@gmail.com>
Date: Tue, 25 Aug 2026 16:48:33 -0700
X-Gm-Features: AcwNN1VFSMn9vBSRqA54f0tkl33NRR3JBzBZTyh743qxXU3-oMoUKoGz0Xy3ov0
Message-ID: <CANc32tOxxNHsoyTGMCZvS7LSVJ-AfurwsXvvXJq0Yvb_uaODxA@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, Andy, and Joshua,

Thank you for the feedback and for sharing the documentation reference.
I will incorporate the reference to the documentation in the v2 commit
message and update the default cases to use WARN_ON_ONCE(1) as
Jonathan suggested.

I will send the v2 patch shortly.

Best regards,
Rishab


On Mon, Aug 24, 2026 at 8:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Aug 24, 2026 at 05:06:24PM +0200, Joshua Crofts wrote:
> > On Mon, 24 Aug 2026 at 16:48, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Aug 24, 2026 at 12:05:03PM +0200, Joshua Crofts wrote:
> > > > On Mon, 24 Aug 2026 12:55:47 +0300
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> > > > > > Replace deprecated use of BUG() in default switch cases of
> > > > > > iio_get_time_ns() and current_timestamp_clock_show() with
> > > > > > WARN_ONCE() and return correct fallback or error codes.
> > > > >
> > > > > Why?!
> > > >
> > > > Because BUG() and BUG_ON() shouldn't be used anymore, no? Linus him=
self
> > > > said that he hates the macros.
> > >
> > > Why? Please, study the case. As for the above change, there are two q=
uestions
> > > (at least):
> > > - Why BUG() is deprecated? Where is it stated?
> >
> > https://docs.kernel.org/process/deprecated.html?hl=3Den-GB#bug-and-bug-=
on
>
> Thanks for sharing! So, this is a missing point in the commit message.
>
> > > - What will WARN*() gain us here? (Note some specific kernel command =
line
> > >   parameter that may convert WARN to BUG)
> >
> > As Jonathan mentioned earlier, the original BUG() was there to prevent =
the
> > compiler from complaining that all possible values weren't handled. So =
BUG()
> > or WARN*() here is a placeholder. Just removing the BUG() call should b=
e
> > valid since it's impossible to hit(?)
>
> Yeah, I was participated in several cases where the compiler made somethi=
ng
> strange when BUG() was absent (basically no reachable point which BUG()
> represents). Do we have no issues (anymore?) with the compiler with WARN*=
()?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
