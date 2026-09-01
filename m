Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E346D0AB
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249324; cv=pass; b=tKPtM7Vofdfj6iuso6CMjKIZBDYjhCvAcLIJx16JXZwEj98TTS3RvDs5a0glMXiX69Ab/exENms/rLer7excV3ZrhAODgXW+rZJ4rBkFzi1BkEgcAxFz4lSx5HIEsPOQ7RqToknUTrofjiFSIKBFtBWIs6TjC6qWS/HVK20dAp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249324; c=relaxed/simple;
	bh=eiCDUNOLP2PcC71+PodqMcYpwQ1zh+hYyVvpJK4a6Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+zrFmULgs7tupJPlFQOMRFVhTf1qaV28jvPYj95peD9EGM09exKwiaxzCM3IkefAJ+a+AXIcuqAT78draC692upTw42kRdkgetzBQ7cVfFjfZ4gJe0W25CeWcBRihc5wI/SouTl7C8vl+2jl8RXotnzncixnmEgaXi5qNLnrIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZibetIGs; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZibetIGs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482e257a23aso2559577f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 00:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788249322; cv=none;
        d=google.com; s=arc-20260327;
        b=NNdL82mHZGnr1KFBspzPEpJNVckuLM23LTGeS1rQdleybDdlPL8ME/LmUUpwlQfu5Y
         0zEJVqkK/mLmj6gouxpZMlqZODPPrnH5uLY8gYI4z6RQNyAdv4x/kp6DYnW44M3L2vac
         Cvn+KNbeK4Yj7HWlMmyDwW0G2wKN3vPfAuSBiVUq98CfGkApMWm40cgHS35P0WYV7pyd
         FdJmw8Loj4SISpVeQYnfoYHjQAmrHppjdH5K47SPKauMxm6iZ1IuWuQT/03OJErcztPk
         yym2S842L0L3aYCu04CN3hUbRPFa4t5EkkwFR9+Jeox8yNocCK9c80fL8zKY8aQazcsZ
         BO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P/ouvMaa3eZm+FiWEavsB/WOAoUnVISK70nX0nRCcCg=;
        fh=2L017JiJL7tB0U98xU8GT4+pJLDwKP7gVvV9ibZ+xS0=;
        b=JI/eFYEfFB2tPLOMBdEhPW3Rn4jvie/0qgifVSgB5Sk/FBLHCSBFHMPbdM0HyBd9G8
         /OYt7X0GS5VpRl5wlyswEUsPpEyiXQ/uVYOiPiAFhLDHFVV3e5ez6aThVopUjsyOyw+B
         QMo9VLiYXNtthJQCBlxgP1CzXgbVUY2blOO6kVK7dvMIbd7uvgiV5slgSoAEndQuGwZ2
         PctB+F+2IewXODBzYySfJVeR4DuVmEEXRAs6YHl0A31nweWuvuWEYlN+ZlHTvbX15ggR
         PYt+FtpUoLOWUuH5GsDwnqN/WgY5F+lgo95PMcuKs8xI1NJUnR8gOJA72y4TUnyLSX00
         91IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788249322; x=1788854122; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/ouvMaa3eZm+FiWEavsB/WOAoUnVISK70nX0nRCcCg=;
        b=ZibetIGs7hAVSEPvXHGkAGrYwyNbnKZEM7HPomGkvaWE+z7cGw62u6JN+hPU21Dcgm
         OLjSSJjTNGEx1KdguvQI6/BaU6JCDiK54dN6R1+2eC2BrPJ+FBrm/zNCPy+0opAxvVG1
         vB1zzQcKbsaWUAC5C/JXBSl/HK4TMmHpAyVC5hOTjr3DNPEAPSF2uBll82FpHUrUapkJ
         rTInBS/p2wcljbcOkMQzteBnZwIOUZxko8esFV1Xz+RYpChmXljiAFlC1JMVgOJx6UxW
         dMgIJz5i0ikbcYknxoAacvf7w1T+sz1hhy2GNeKRI79NwgCB3LeQ8iWUiy9dYGc79cL0
         BShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249322; x=1788854122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P/ouvMaa3eZm+FiWEavsB/WOAoUnVISK70nX0nRCcCg=;
        b=qq2tqWN+CnxrN+suJxZ8I3VDrHVFTHnrUKUE8Zay+I3W3o/M6pbDUEqLE4DdkrIhqM
         XlOhX654iFEFNWqi76HTEpxXZxlgw7YYWteys2kiJDlpQ3wCdUWo2kmlF/ofwHSMSKa0
         f6fQuPFcwYKUfJMqbYwtoxcx+vyL0y+WuNynezwpvkvBj/nxczbaG0a6MV/A34zjbQIq
         41ixhIaNU6v9I+ZhthsHbtVy8/Ojl7MxAOqmTvVu8lc9oyjFTIZhlWV1VOq4YO1MXKCH
         aHPSqY/jZs1uAmBBmZaeFxZ50Qa7sYo8JQZ0lNf01ALv5C2ZIIopYkVcryEiuDHenXfK
         3Qpw==
X-Gm-Message-State: AFuF++k4TKedjyUVWy83DgJeZ7mnjATiFsJgcrvxPAt0mtX9RrbGDcyV
	zkKg7kes1un0o6ekQCWEZnzzOM1ga3aQ1cma+rAwJlgUf6tvPHB5iM8SCGZDPNR/OSUs13Z1YIc
	N+sFgG/kJtXnRt1vlPTS8dVWOyDDbdxY=
X-Gm-Gg: AYBFou0nJZ3B7rDgosEpMVmW+TBUYEJlUIa0PpdHbT9ZwIByZG0cDIOObNvdL267N4F
	/CWr1rdCAi2wB5FuaZjNmKjx8tsSlp8Ud64Au0D8Hx+mNP/kW3/0uWLMVFxq4/BCAoQByDwURIm
	Qc9PySZLjd7sAgVkAAUZM8wOf9n6QrKO5ecWHV54uhveU47RFaz9iPnnxhbXP3HWYPtlMD5SAGf
	0czKlMYMKT61JXE6NDtPSzusG9dGYcAIj3RFECNcbKMaJM7N/kjJAHbRgzjTQ75qB9LyGuCUCNr
	bsOMtm78rYD1qlNjrzFm/siwT01Jpp/i7cBC445w0rlE1whUAQk3dmXTIvIKnuVU8FSbbViri44
	7j1WJZgeDhDp5WNOISMmjXK3Oqa6iSguNRemJt7p9VDM1S2lIJKmbGiUJtrypJsw65HT/IFACEH
	z22/UWLAaOfxdl3gYIq7EJiEp8hoRZLP3g/D0AvuK+Mk0t1I0Z9UQ05iwJ/cgkT1bVjTRWwt+qW
	ESwjrmL/YuMGrQ=
X-Received: by 2002:adf:e191:0:b0:482:e6b5:61c with SMTP id
 ffacd0b85a97d-482f7983567mr52568449f8f.8.1788249321552; Tue, 01 Sep 2026
 00:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com> <CALoEA-wDkFkKVLCkQOvntnw-cD76Gz=MVW6qNJL21Obn+s-wEQ@mail.gmail.com>
In-Reply-To: <CALoEA-wDkFkKVLCkQOvntnw-cD76Gz=MVW6qNJL21Obn+s-wEQ@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 1 Sep 2026 09:55:09 +0200
X-Gm-Features: AcwNN1Xim3XzXhdKDFVY5okNIhEsjRoz6FlvhoOPuqBSbFbmb7lfh0gC590-9Kg
Message-ID: <CALoEA-yK8kP6DbPuzh_BnNUnxOU_meAcWWFURMvO6svGBZo2-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] iio: temperature: make headers conform to IWYU
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 07:09, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > Changes in v2:
> > - Add missing headers pointed out by Sashiko.
> > - Swap <asm/div64.h> for <linux/math64.h> (Jonathan, Andy).
> > - Squash small reordering patches with iwyu changes.
> > - Link to v1: https://lore.kernel.org/r/20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com
> >
> > ---
> > Joshua Crofts (11):
> >       iio: temperature: iqs620at-temp: make headers conform to IWYU
> >       iio: temperature: ltc2983: reorder headers
> >       iio: temperature: ltc2983: make headers conform to IWYU
> >       iio: temperature: mlx90632: make headers conform to IWYU
> >       iio: temperature: mlx90635: make headers conform to IWYU
> >       iio: temperature: tmp117: sort headers alphabetically
> >       iio: temperature: tmp117: make headers conform to IWYU
> >       iio: temperature: tsys01: reorder headers
> >       iio: temperature: tsys01: make headers conform to IWYU
> >       iio: temperature: tsys02d: reorder headers
> >       iio: temperature: tsys02d: make headers conform to IWYU
> >
> >  drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
> >  drivers/iio/temperature/ltc2983.c       | 19 +++++++++++++++----
> >  drivers/iio/temperature/mlx90632.c      | 10 +++++++---
> >  drivers/iio/temperature/mlx90635.c      | 11 +++++++----
> >  drivers/iio/temperature/tmp117.c        |  9 +++++----
> >  drivers/iio/temperature/tsys01.c        | 17 +++++++++++------
> >  drivers/iio/temperature/tsys02d.c       | 12 +++++++++---
> >  7 files changed, 61 insertions(+), 26 deletions(-)
> > ---
>
> I seem to be having b4 issues as this sent v2 again with the same
> mistakes?

Okay, never mind. b4 did send the right series but forgot to bump the version
number up.

Anyway, some Sashiko remarks - just commit message issues (forgot to update
some headers under the ---) + one remark about me including slab.h for
GFP_KERNEL, but I suppose I could change this to gfp_types.h instead.

-- 
Kind regards,
Joshua Crofts
