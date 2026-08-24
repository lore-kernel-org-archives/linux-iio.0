Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087C23B638
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558771; cv=pass; b=UHrIuW+7vgyH+FfqBotpBYpguK1XMeH8zA+6uAjSsmGkLTkbcOHQ0vQ/c6K8+opxB/0JbIEkIYmL9ghu26SWLT2POUlfWVawxifIBb+o9qJFA7IKsOo3c2KyIuyhiZioJM593/S8aHkoY+k9TyLyZ8bTcYCNql053trsZdo45y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558771; c=relaxed/simple;
	bh=VmpChf6xXFcaUUTODb0Ytp/g261rckBfcDFq0PJcnOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neTjdm7j+l4ZEURww61/lsAfWiPGW85hUr+6Sz4tNXPdZRq88VTEmkETQS1hkWdtXGq28y7Fo5kREIqAto4kSzLDLum03rdr0h0MW7dBkEGU4bhL28yced8PvYqj43US2wcqzVkcBfIKGcP+UuWFe03teOel/bmXIkNWKjMrTa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQBd7vj7; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQBd7vj7"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so2748860e87.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 01:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787558768; cv=none;
        d=google.com; s=arc-20260327;
        b=rya+ml75Cz/ywZPni4gyNs31M5YG1V3Dft7JYRHzB8nA8USBQmkpKGMdmuUX8IOHXC
         1WonxVsKWi6vggfuTWuotpU1SHrhfgoyzs1KCj2GQgzMPOAOcO2IPVT9noSQ7HKw9VDQ
         HJnNR0Z4l9Y29sgR3Z87wevkIFxIL1XcAGiRp8Ayw3Rp7E4wAWmmvyAR9ujHoi6wyi2a
         lH3BNElGy4ygq3H+iO50+0SQRtqEV/niAz3U3hcD/2uIJz+wCCGmP02m2coewte6+7t/
         dIQ7RvMZZOkBLyQKbW8IeGs1xH4tAVY21pCgsa4lfZpYc/pHQb0r/wQizjku2HifPvaB
         m6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H1zokSLfOVJ4mDolTI4j0A98Cqj+A69UP0Nzinjm7sU=;
        fh=C85JVIm3J2Y+TSbzRLy/bxJxBnaHjYY4EbwsU18TEqE=;
        b=pZsMaG7e2wYjK3XcLrVYO9Redapd7NAR/sP5TiVIP71uPqCgxCyngY94j3Bf5zhoha
         Xq2xL6IbSkZmDELSakjE1wlDbQyRS5vsfBWZ0SkuthBbtagC/KAR00eMRlBsFgFqFh3w
         820u6mzJAJiVGL3XSq6C9eBTYvyf09hUA37Q3o1mFjdBSvSYNS0BrMs4ESnB8PZ1xbMD
         l2jv+6XOR5t9bhK0C7fMfnmIplOJ2ccZT8i1kjzVsWrsh8cKlcUzhDIbp7Y0TRCv1nC1
         6iGkReEmMk2E1ClZVE+SfyTft7YmNKGOyeU7dCD28CgatGOR3p/yDUJ1cTsqe9asozIw
         /OMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787558768; x=1788163568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H1zokSLfOVJ4mDolTI4j0A98Cqj+A69UP0Nzinjm7sU=;
        b=UQBd7vj7J3kE3hXjc6jHLB6bkc6WO3M//ROGAeB/9jvpbdioEsO0F0x3JWNP7egR4n
         yCqiiWzWgakNwafj9bRp6AxU+oSK71mhFUjEBVE+clRqZ++7j36/cvJyNOfVFNNlgzqe
         s0EhErrAzCyDON7OXPlndYzUoocBO4vWD81YSQiaPVc2dBflVt7IU889aH1T1/QoB9e+
         daNSGa9aBakoaKlVNtVfqbXFN2jk2YDbhwdwPrdP6MMYxFNn8roQIQa++YVobEb9qd6y
         8vtX0eF82idmIztgK3DF7G9OmeUP6spzQxmA7YlWdsBNLHbyxLYoV2A/rEeH/ZH/po8s
         G0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558768; x=1788163568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1zokSLfOVJ4mDolTI4j0A98Cqj+A69UP0Nzinjm7sU=;
        b=E/lZPtlw3v8K2uB0HHR+yLfVA94usuM5gMbeM0rhficDD4WFrzcMMDcS16pbWXVfeK
         vFs294aa1ir7bQMg4n2//rR/y1wXWPNDKIWrXv/uf4dQsTto05bgkHUs1tuTvH59mfaO
         u2t4IIVFjSZblWyY+rFluOKlEmH/yCo2622beKTg1u9xfxUvT4B9PVEV+cBFmpVU0oSu
         JPuFQn4wUq1EcoqAiGsc+BcotilNbvK9EQVp+tRdThEc18Feve+NzYAL29WWLgvVLmCc
         D5XechjO+DvuyCelqgBfUzSsXwk4ahf+xw6TCuaCOATz0kAB+PNYNJRkrDSPFxmKYKKr
         okqw==
X-Forwarded-Encrypted: i=1; AHgh+RoYGvI2YeVwHN0AxT4UUZ55Ja/pUsXzJbCFn4j/Z7z7ayeNHCXT9cWWXoWbYWG6zysAXPOX2ut25ic=@vger.kernel.org
X-Gm-Message-State: AFuF++meKOwxLC1JBjwEF5mzX1JErx/20lIt0H4vAyuPvvNyhc8yf/aL
	l9xGkHJVBVdpOoMfh+gukV8yAOtUbuYMxvFjHaiSVvDSwDyMW/pkm2leOWLZYj1AWPuIs5vqt5z
	zArzY8xq/AkjrcIJ5tUVGH0WngdpHFpY=
X-Gm-Gg: AR+sD13APD7S23XoVcAcqOENFQ98rSJPrUP2HuHjpX+AdSHWLsI7AhPqkUt7ceVF8IJ
	W7Pl9k4cAYB7WgDnjBQ0maGgcJVU6P8ETzxGCK+zqV5L3L8/5ByCUrDgQ0dqwniOevENfnckTnE
	57Fmrn6kXMSMP5XP4ffQkVnd6Ce4jSa/o3ipJxepvR4ArxXMUpeGGloXFBMCWNG9e7TB5uNw36y
	ELA+rEBiHca2+T5DqkHp8urXctrgC4LuM9EYyvqy6YQuxTSmmLKePOLAqR3jPgJo8P3HbP6DIRW
	tbkZtYcDFqi9KAF4NXVyVSTZa39de4S2JOJt6tsGxlxN5ggiPH7/jBm0
X-Received: by 2002:a05:6512:3b88:b0:5b3:e52:a005 with SMTP id
 2adb3069b0e04-5b48b67cab5mr4058802e87.4.1787558768410; Mon, 24 Aug 2026
 01:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
 <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com> <aogvjsjOatTpiw7j@ashevche-desk.local>
In-Reply-To: <aogvjsjOatTpiw7j@ashevche-desk.local>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 24 Aug 2026 16:09:14 +0800
X-Gm-Features: AcwNN1WezVQNnJHyOg-HarQoHcYwKFS3qCgBfN5CCDwYLE4-Bd2IUFhx73q-H8s
Message-ID: <CAF7HswOMH2FGEZR+ZASDrSQjgi_YCd=6ZUoxTdTBfwsec3Y5YA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Aug 20, 2026 at 03:51:52PM +0800, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> >
> > The driver implements:
> > - Single-shot conversions using the IIO raw read interface.
> > - Dynamic parsing of single-ended and differential channels from
> >   device tree child nodes.
> > - Hardware interrupt support via the DRDY pin, falling back to
> >   software polling if no IRQ is provided.
> > - Per-channel reference source selection (internal 2.048V, external
> >   REFP/REFN, or AVDD) via the reference-sources device tree property.
> >   refn-supply is not yet supported.
> > - Hardware reset via the reset controller framework, falling back to
> >   the RESET command when no reset controller is present.
>
> LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!
>
> ...
>
> > +     /*
> > +      * Datasheet: td(RSSTA), the delay from the RESET rising edge to =
the
> > +      * first I2C START, is 100ns minimum.
>
> This is order of magnitude delay. Do you mean 100 =E7=9B=9C? (Actually wo=
uld be good to
> use Greek letter in the units, looks much cleaner in the comments.)
>
> > +      */
> > +     fsleep(1 * USEC_PER_MSEC);
>
> Otherwise this should be simply 1 (no multiplier).
The datasheet says 100ns minimum, so the comment was right but the delay
was far longer than needed. Changed to fsleep(1) and used =C2=B5s in the
comment.

Thanks,
Kyle
