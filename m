Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786443A5E92
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579344; cv=pass; b=Ysw6Cd910/RvVZa0OaIsimr1LzwN+1CEGc885p/vBaqU5Kca8xC3IhjcgQ5yd7RIL942sm8qkRK5LvId2H/hXFaNHrVKD7POxiYFcBT2UisW1EtZlorUCqoL21aEOiq5RMPeGEMgnFrXBHBPRHK0Ecz7HbCBKdwTCybbVgccvhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579344; c=relaxed/simple;
	bh=YTEkKn2pHMbnMctAbEdfZ+gvaSugIbCXfZFSLaJv2ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjNkciwYICAAdS3XkZQl00ecLOTNqWqaL/VCjj5CzrcgqOvh/i6r6kgCp9DtsdPuNBVVgCInTRruyykOAD7XnA8Qmzzqc0z2t8Y+l8xRh+ymWrylIrj5pBzVGjhwRI9UVwKVl4dA5165oz7q0xQQh0tCB4ZIj03cwrKOmkUdZT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je0GPBSx; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je0GPBSx"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66058b880e9so778062d50.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 06:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780579342; cv=none;
        d=google.com; s=arc-20240605;
        b=jd4UrCVzYHcf77dwATj49GZ4ZzIsoyGvCqgHqoHTbuSzuB0Sy/BxvBdOCrHsreaJBs
         NsxwjiY43TqCGzxEcuD0NFyRsjcasYyEm3ZLM9cncNlQJhFQ3fgD/H/wcjT6Wjbb3Ee4
         DEYUz88S2kqG1h7bdCCR3GbRFze+9PxG/VS7PGnYjy8nkBPSgetei6JVv8bdPq8v4Tbe
         XQmnpDNq8attRPeiKyJRLwiAElLKQn2Y9Pk8FVhMqcS1/iTk+qxAqVoY7R3NNsZgxW/1
         sVOgIqFEWbWTYN3imFMlMhagG8cwIHEdyT3TBbM6el+4etutKEtUyKY3RseFxrTzJsEX
         5VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vV1c9pBMALMCMOylS/YIr12CaKvzqV2iMSBOuVTKPo0=;
        fh=8xeAONYkR36tVSrNqmglMH3GlJ4TrvTDfUwnFMQgvng=;
        b=P6h7kYTfjLt6qQxMjW0uOl1khIazUILh1mEtSJoOPYqOhML+S4BLlINcW5f3+e+YfI
         hPehif9pAn8Mh60KGud+ox30wk0XHkqeSiQrFp882py3wTR02EaYdnsFDA4nLiq9w4g1
         HCrTbHnfHpfzTLVVtrvunvb199QHaIfiP7uG+hvgudNg6AOiwRuTP7SeEMaS4ZpWKGWy
         JCOSxu+oPK/dfDvepz1zYYHi1QFZz5kbi/A0Qj2iJw9SeUoITKJIVBXK6kgTm2zvL4cN
         9ktOmIBnyTKOWm1AohPLqWj246hMgaAUx8A40ehqTL+kgwY2ZgmRfpDuAojaKSGC8/3y
         5oMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579342; x=1781184142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV1c9pBMALMCMOylS/YIr12CaKvzqV2iMSBOuVTKPo0=;
        b=Je0GPBSxiwdCGIkqfmytiQrJWItyJ8drRwlgQAJaFzcEht4f6xMa8sIeXzmpx/SZr8
         ReCX+kG+UKxJC1ybUukNn8NnTRa/3v4c+6zgobgTlnWTDVBH4JW2fvmUaJnXO7o1T5th
         SxG6C5Z7W66dfFbBiajwP+VnJOXoElB8+vdtfLKq1g46Ay9BjZM5D/50wFAHccyn5GIq
         BCQV6llNQiO2DPC01/9jMgBep8+IHoitPy0nGHsAND2u2nxis7N183UGc24cvtuPhzOI
         nNV3psxsL+DRgZ1oM3Na7sn8VLRTVXAMQtDud0mjf5sh7nBGhO6kuOQXXfsvgIsCEWze
         dTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579342; x=1781184142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vV1c9pBMALMCMOylS/YIr12CaKvzqV2iMSBOuVTKPo0=;
        b=BMYoX7As5xMZ/svE9ne9WaNoMRjbdOCY2EjZj6B/XWuDNiq6JT5jrktai2xB9Aao0w
         5gSBJ7yzrnGDg4H09JxlQkyP+YEe5l8wHMKMx226xR6tOwcnVrPrJvX4+rV+KaNoTcqi
         7hKrYR5EoZIq5XVJlzO+ZoljFKuuGA4VqWSveun5mMO2ptt3G7T8nWm7tMx+/o+TQZNU
         lMlwHiBMPvNk00kiqUaatp7WSq0TYvw8N+E/XloydbWd+sK+K1MPFUdiYBCnzJgZqKFi
         sSTuVP/gcoTtkueFQtYHgsAI1nIei5tQieAbAaY9S0lmv5i3q13JbD8iQ+7yvMRsZyAN
         vZkQ==
X-Forwarded-Encrypted: i=1; AFNElJ84NBPBLgAcjn5sXs4bKQKjSPQoerHMjZR8KfIy6kROTmSJrIMCfs80z8b3GEYOx1pwP1pQEnLR4Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5giFo0e6bN21cK9KCnXLpNYOyoT/qniHFy1idzYBd458eQe6
	RYBGc0TBjEuhS1PmdJIwY+RtyuVO1KBLPHtwmlnzAAsATf4vjcck2uuZMtWZUlcqADMH/YNE0Xw
	h4Ux8f1+DCDZ+QEXDf6Isv7BIojC4s2M=
X-Gm-Gg: Acq92OGTG66tiqxum1fEkd5Cm4ErZbRmCaViBHuQATv7U+CZj3eBvXPpirshhDzuCTQ
	AgH5Nzrm4wSLcrjBWoLFCLiggQsILt1LCDlTVq8w6udet2Px1NAMXVRpomtOsBWfMvkQjFrzfQa
	PNVIQoLFrnsj3uykjpNNxOkM+pq4rQASkRJPJjSHDwqoMdyj31YcrGWzbhRKeMAQ2m681LoEBzm
	xQg/uh6BBEaQaBpS6nL3RQRZQ1JMII/C7ESvRriDWArl0askC+tjXRNvRx9XdmqzMj7oknBpqs7
	o8KYBMnU+dKgi654LQ==
X-Received: by 2002:a05:690c:64c1:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-7ea4987b86cmr77571927b3.29.1780579342520; Thu, 04 Jun 2026
 06:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603145134.58956-1-m32285159@gmail.com> <20260603174447.63a181d5@jic23-huawei>
 <CAKqfh0G4xDUh7ZR=f760yOAqYqjSLhWGw4UP8KiRM=nnZhg6BQ@mail.gmail.com> <aiEsnl1cwLRXrUq8@ashevche-desk.local>
In-Reply-To: <aiEsnl1cwLRXrUq8@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 4 Jun 2026 08:20:25 -0500
X-Gm-Features: AVVi8CcYtDXdRBg2RqLsh3OMSm7XV8tP5L0TCQY7IYH5JO9pLnpaMD9BDFN5-Ng
Message-ID: <CAKqfh0E-N0QWGkQwBknr9sV8Ryakzo+jxAMPE=ee+CQbLMjwVA@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_init()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 03, 2026 at 12:27:18PM -0500, Maxwell Doose wrote:
> > On Wed, Jun 3, 2026 at 11:44=E2=80=AFAM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > > On Wed,  3 Jun 2026 09:51:33 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
>
> ...
>
> > > > +     ret =3D devm_mutex_init(dev, &state->lock);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret, "Failed to init mutex\=
n");
> > > The only thing it can return is -ENOMEM I think. Which doesn't print =
anything
> > > so
> > >         if (ret)
> > >                 return ret;
> > >
> > > is enough.
> >
> > If I'm not wrong (and after a quick google search), I think it also
> > may return -EINVAL but then that means the device struct is invalid.
>
> What?!
>

Then I was either misled or I'm just stupid :(

> > Still may be worth doing dev_err_probe(dev, ret, "Failed to init mutex
> > with error %d", ret); or something along those lines. If you want I
> > can get this out today or I can also wait for more reviewer feedback,
> > but your recommended changes seem pretty simple. TBH though I'd still
> > argue for the case of either dev_err_probe() or dev_warn() since not
> > having an initialized mutex is certainly an error.
>
> I am on the side of dropping the message altogether. Invalid dev here is
> nonsense. Just read the code.
>

All of these changes have been made in v2.

--=20
best regards,
max
