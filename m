Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7C39A049
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360510; cv=pass; b=H/m7HEAg7bL8B6AFBtT4j8GbBYXJInBT3qgqk38ZQ5fD8mRHHcTXu7gKOQQdp1z4gsz0xWlmLQU6SYLv2I6TX4WteayS915Vw9OgvUg5/CxNyGJ2lTUaVisR0CuJ5Nhn295MwPUAzEDhxkMsd0bCo4g3YCJqVBIab1rPS6Hk24w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360510; c=relaxed/simple;
	bh=+vNIotOINNZBFREY4qZDuDXFnAS73nidgBRWSj4Uplw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwV7dUzvbP8kMq3rPPdulL0x2v4TeDSs8PWa8RM/hKysag5dI5/OFhA9ATyyymj1Fe8QYDWLYlnzKY9E9yLM0Sdz/8IaQrSKRSTiwyMZqfMHL8+8tyB3kURDYIezzbhBYrP3Q2/kRr6IitPwSFlrGQSYkfihUzW1gu2/KvTWRNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScaJBjzQ; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScaJBjzQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso5403218f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777360507; cv=none;
        d=google.com; s=arc-20240605;
        b=DfifvNLOFttmziNKnAe15EdXi02W+/rFyQAz7JbOYZy87lJStTawS8tblJ27dKt8M4
         NwjLCkQywgNpVpeLdXBTyBYqyINX8pyp33DzOCCKjTmjadugJ9cYNLi7VIRdol1El2sr
         QO4Y79dtoquRNVNcw2yk4Pn39GfklWqVvOdoTesQMyQGdKPTDjb9/MoWv608BfhsLpR8
         NHY9UKtTZMwU1gCvNUjuxydbjRlxcvvDPpGaAEXltyMOII9VlSb2DiMebgfw2JdwfPv7
         C+3EXakxRej9pJBG0A+JDT0KIEez9mJUOySrSMeZmzrSh0QbigJWt70AP5AhyqU5ej1y
         z9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PY6SGKd21N41BtioFK1r6ALJlLkaL3kUs1cS5UL/IEo=;
        fh=Dg5zoWqUx76h3UPcxsppTHY72IFDoZZoazTlpye19aI=;
        b=JbVZtVjgx+kaloUDwhYFjuVXTjm39Se4vBYL50CwSrkMznafc1HycFzg6qqufIcvGE
         nNhcz4lNEi4BWqRtTAM6Vhs7CPq0YGtaVTjz8r+3otqBOzXh31y4yQWFD9wwtvc4fx50
         hk5C41JLyJ08DNsGcZZP+KlE/kwQ98rDyd2sjKEGd/+iHEeIzYabXTf8rxne4gIspNVg
         5jvFiC1FGKzcelyyuW2p3SqUGuk0R/yYlA5JgKid4da409b5REvsaNo+e+K/ez+Xw6mg
         fT/SLJsW8/veQ/MV/j2ZRE7ceyVnjr2xcZIa1cgRKb/Vsv8phOsJEQrfK+XIJ/LF5jof
         4Sqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360507; x=1777965307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PY6SGKd21N41BtioFK1r6ALJlLkaL3kUs1cS5UL/IEo=;
        b=ScaJBjzQ9TRddsy4DSTdyG+inf02KyyKwucCTti1BXBzteKpwepEL9wTDPdwcjas+y
         vWZxVbYS32TwT9Wrd6bmSBkDFWF1aLLuJGg2fSGL7t1EUlcamB5YdWXIrnE02q47U5rm
         Tb7jKnkKD59SfktxMsW3T0/ucEeOwl0hWOkFbUe3o2FhqLKrXogHu4Mf1pITSYMCKQ1L
         yHXOkASt5cF5EiMu93IVbV2VagPq2FMxke5pnGSOm6fvbrg5+EAB7Ti5lneTdRdqaDcq
         n0pYaUym/WvHG1qNDyDHaFdWI2W5xyj7qsiWt5n+KpMEXREtea38z8+/EwQs/9ZyNfcz
         6blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360507; x=1777965307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY6SGKd21N41BtioFK1r6ALJlLkaL3kUs1cS5UL/IEo=;
        b=DrFruDW17MJxbmPchBYYy+oCRHxZ5pGEKlyE6d5XBV9MSYk0lMO083ZVz+Or1zwl3D
         GKs0AiMogaxE9yEeMS6ibBw+0+/QFjUi0zfYX8usOxT64WVyiq7tMkWtvqpRN506zMdF
         GV0otEHxvMyGNlnH30/axiHuRlEtrufb5wTDR/r8+8dJ+cYQm5jxC4+5sYM38V/lmBD9
         5lz2oYyYWL7whzMPPvC9yTduT9laI73y31/LQ7lNqJxub1keIdT22XGhJpwTbt7bRG2L
         DeYD4pjro8BjHd4JWfsfNq73TXAHJ/XR9z5X1fylI6Z4KNpsxUDjB1WW23IY0s/wO2UZ
         QTrg==
X-Gm-Message-State: AOJu0Yzo5/okhIj+x+IApH6A2O9SmyE3JR9xUj8MAzYCgiaLB0xfGsjC
	vDEnvv2B6hmoTG3uUM+1h8CrNWXDsNcToJd7GUOk1xcSVGsaZ5l0VA4OA3t88JSnGJ7tUJZWI14
	rwnzIQP8BYZLGsbbJMONqM4pgN8fFtyD92mQ1
X-Gm-Gg: AeBDieucLpv7phXgI5nOnAfO+2cYr3kFkBA6hhligaUBVhh6xKCABu+j8vr9cR8xlfN
	uyY1sWh8qsgV2kzjsOyAfe0H4lE4DZIqTF1ldeE7PgAwJJnVg4B9jCEnPpDHT7g9XHHTshY8MYK
	xv5Napbu5t/OCe4DlOHAG9sesRqHNKuKbfrE8PQcxrbjg38BZQLdhaY/roI0Z2fXbk7oLlkCfjq
	5jQSlFVfbsQrDiFD3i+w+Vd44qRP7sFnlmOXGGAyZknSMJ7VySdqpCnnnIrEgN4kPD76SEWVk3i
	C2AtN5wUlSldnNFZR2hxNupZM+EBVSsBrJ65NK4PGA6PxYJYnNy2YHWMHlTcLZTKwTu4QVJBhet
	qIcj7uPdU4f2pF55bHRe/cvywnRiZ0vVWG6KMbn0jQPSgQDvweV73GxwkVQL3k+B1iHYkP81uR9
	EyjuhbnG2+LuTcsMQeTuKiovIYARE=
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id
 ffacd0b85a97d-4464a913403mr3247725f8f.33.1777360507164; Tue, 28 Apr 2026
 00:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com> <afBbylL3Ygt9GEYy@ashevche-desk.local>
In-Reply-To: <afBbylL3Ygt9GEYy@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 09:14:55 +0200
X-Gm-Features: AVHnY4L8HBwwUs0Lo8UgD5oiFNNzTeb6EGPiA9RW_il9rZ7Ph-yJpt7qOSVLHcA
Message-ID: <CALoEA-zLo1Neb=6xqwRyNcgsWBdpXPQox3mvJo9pEXs-Y0h__w@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 09:03, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 28, 2026 at 08:37:22AM +0200, Joshua Crofts wrote:
> > On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > This series is an attempt to make the driver less a rabbit hole.
> > > It's a continuation of what Joshua Crofts started doing. Hence
> > > it is based on his work and first three "patches" here are supposed
> > > to be folded to his series accordingly.
> > >
> > > I have compile-tested them, but I haven't done full double check of
> > > the correctness from functional point of view. Joshua, please do that
> > > before incorporating into your series. Yes, my patches are assumed to
> > > become the part of Joshua's whatever next version of the series, that's
> > > why mine is marked as v0.
> > >
> > > Should not be taken directly by the maintainers, but any comments, review
> > > are highly appreciated.
> >
> > When you said a few changes, I didn't expect an 11-part series :). I'll go over
> > them and am them to my branch. I might check out the guard()() and chip_info
> > changes.
>
> On top of that also one may consider to switching to use reset-gpio instead of
> poking "reset" GPIO directly. But this sounds like too many for one go, let's
> make this 17 patch series go (6 yours + 11 mine).

Fair enough, perhaps another time.

BTW, if I'm sending your patches to the list, I should also add a Signed-off-by
tag to the end, right?

-- 
Kind regards

CJD
