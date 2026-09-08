Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321656B863
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882565; cv=none; b=po6y3eigH9Qhg8rQcIYdysxUL9YUJMYHsijvCbu2EBjmeFZlVK/hkN7Va/03RVUIFivsOl4OY22QNPCbAbxjlfyqW3IMqa50dmU4FnZK0ApWFvzi/O+IBxhoUAaIYaDdwmOjD84PJVx9VlFz7IFl+Tfa4cSC6vJ+p6usf/m1FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882565; c=relaxed/simple;
	bh=NvXaLJ8XX12qjNKy10UGOlJMw5CJBdQbfWQAZkF63Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhmPWSUgLhg5+H1j+UmUsLgn1M3hsKH6PRFWTsUj3X20bqfMGEhk2hrrgrskr2t9LAGOob9t2qtC/va4RNlsnLl7wjOUuNapvAve+EwWAaIQiWDVtuMLCtngT2ZCDizVf7wJ4LU95YHoenpeSQQLKZ4Oyi8xOLMX51gHjG7cF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Hz9AgQz2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Hz9AgQz2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b8687630fso40973615e9.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788882560; x=1789487360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NvXaLJ8XX12qjNKy10UGOlJMw5CJBdQbfWQAZkF63Rk=;
        b=Hz9AgQz2Y1ogAqZvvy8CP8nnh0trgkKhisN4Votf9DyD58GRkKs1NFp4TpJrQvBOda
         WVO5pj4k/DwRQQQFH6RU4YH5poeON48jO1m4or5+WlzJM7NRb63bWabxdlW7+iRh6//E
         ikbxNTGDuRst+RspsrsBjEIkuxadf4+BJy/IYuj5lKLz44dqvtD5fDtwP4y8824Pr549
         +3045seFsjFLeg7tcj3JMIjhLMx0ibwfin7ppnmfOy8gpT9p50T4jT1awk9hc3RS4Pr2
         FQbPcZiUcXQh0K5iQPHDWcrzWBuQINUIbgqoC3Oto4AgkF9J22JQ80hS++zZ3C3tOj7S
         3E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882560; x=1789487360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NvXaLJ8XX12qjNKy10UGOlJMw5CJBdQbfWQAZkF63Rk=;
        b=njZYhWr2rRtIXwDnr14KBIwWiHOJxdBgMD0OdLq+NdJbNFf7SdnOiFFenNxpF5UWZ6
         WCKEckjLCT984daT+tf50uPTyf2+J6ubd2Ho1Xt75v8lRfbYqAiTtpMDKW6tx84dJT6T
         jJzfZqwk/XIHPntZPoJZ7zRwIeAjFT7snzoVBd3TfAXa0TopxZgmIzpYIL4ZWJxYOPI6
         FvvcNx/nfsHn3Y1yrHuxQuriBzaO7NsZg8dfyqTgmS/x+ifmpgs9Hx/uMhZkyzUufnn0
         o2dYUYklLz766WJBQzGhas7jByOkW3kNk2K2fIAJfRiR0wgXWRJbMxmHOazorN0EptRB
         skJg==
X-Forwarded-Encrypted: i=1; AKwUvByhOuxT0luBSIwVbMOWQadjw1u3bxfmipf+CL5/JYgD0AlEYS+KiE/lBTyW4ZZyNO9m3z6GWuJZCcw=@vger.kernel.org
X-Gm-Message-State: AFuF++kxtdR9TNAOi8N2GdGydxBOvkRANk/2Pmh5yinBGlEWUd66gQ48
	5Kn4IFXfltBuOQm1S9lAAsNIbByD7kWTu5ndvLqyCN7GWGAziGTQkx4ztFSsWYrvcDo=
X-Gm-Gg: AYBFou3u1aNCPXQbz2A9Gf/xUhhGbhR9R7X4hP/seEspm3UGlzD+WzkbIYZfq5HpXgT
	xwsLVu0uirFGpjtilVRMr3VH3u8RfnStpm+FBDUiazIykASXyHmM85fwy1YbtTznf0z0uTeQg3Y
	HThOWBk2FoZOTnfI5IqlmG36N3f8oCV33bNpNlDSaCjPvzEq8qEkbgEMC5lRmwlPPJpm4MRGxju
	x3iyaBLX6fteF4ZeqWbFjLhv/iFvz6QLV0p5iTrXd1BetQPB0o/EaecUNsiEnve3nZd7BGmfK6B
	ArqTw7JpXfk8qyoE6Ug86m1eiR1KKAmAZFTV5hg8Sc+DL4J93nY4txb2KODzdHwjw6Lp5YL6Ecv
	nozJo2mAutt8h8BELeKkcXM0in5o1HLF3AVN6IcOUrXR6q1PJedvEChFnCf57EUKNfBmwvf6P6y
	Xdrs1Mp16TYxe0yE5VrJHYL+Rel507cOD8ceQfwzEixXy0oaKPwxq1GmKSddXoMMBM8dXE/Rnj6
	gO+CoxTCGnORtkciHRj2Q5RzNuZQMwBMfA2/HTDeBxUIwth+nQ=
X-Received: by 2002:a05:600c:6089:b0:49c:fa21:e73f with SMTP id 5b1f17b1804b1-49cfa21e8b9mr260172975e9.21.1788882559651;
        Tue, 08 Sep 2026 08:49:19 -0700 (PDT)
Received: from localhost (p200300f65f19a9042cc2680c1f1bf2f5.dip0.t-ipconnect.de. [2003:f6:5f19:a904:2cc2:680c:1f1b:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee6024a8sm509571355e9.6.2026.09.08.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:49:18 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:49:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleinxer <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <aqAtRgouK7DyDlpJ@monoceros>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
 <11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
 <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
 <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6b4jpeub6k6vc2an"
Content-Disposition: inline
In-Reply-To: <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>


--6b4jpeub6k6vc2an
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
MIME-Version: 1.0

On Tue, Sep 08, 2026 at 08:21:27AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 12:02:42PM +0200, Uwe Kleine-K=F6nig wrote:
> > While x86 usually goes through tip and none of the x86 maintainers
> > commented before Jonathan applied,
>=20
> You mean it is easy to spot every question to x86 maintainers in the aval=
ance
> of mails?

No, there was no hidden offence, I only meant what I wrote.

> > So I suggest to do the practical thing and pull Jonathan's branch into =
tip.
> > Technically that doesn't make a difference (apart from maybe branch vs =
tag
> > preferences).
>=20
> It does make a difference when the merge window comes and we have to
> synchronize when to send what. And we send tip stuff very early.

I don't see what you mean. If both the tip tree and the iio tree
contain the same commit (with or without a tag on it), it doesn't matter
who created that and when and in which repo it appeared first. The first
to send it to Linus makes it new for him and all later PRs using it only
introduce the follow-up commits. So if you pull Jonathan's branch you
still can send the branch/tag that contains it whenever you like
independant of when Jonathan sends out his PR.

Best regards
Uwe

--6b4jpeub6k6vc2an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqgLnsACgkQj4D7WH0S
/k6TZAf9EWeswDG88WfiHU0bRcF3TfKqDvtzBdrMBaWqBA/XdZPwMZ91rgV46awN
DSZfuf+GRJEkOETf/teIP66h1IcwJgTeZTs5qmNNoqrvR4l4T8NQcPJSzXYj7eHy
YfLEaH5Ty/wWn4YVd+IOxKztY8Wr52cGnYncjXlQJG8i1CCNuI9EZsS5JONlfE3+
i6/B+eX0xhS4BzlaNEZ3bOed5LEi1OZbmp8CvB8O5HWWTEE+nQ2Jp+EJLE/gPeSx
Uy/FHZox1F5V9SLGZ9LVAzSc9ko4/DWWte+PrnONJrAG6r/CzSQTE3/CS84oa3XI
aKbDejMthtfZHoVDYkFMYprzYk8CYg==
=lhmo
-----END PGP SIGNATURE-----

--6b4jpeub6k6vc2an--
