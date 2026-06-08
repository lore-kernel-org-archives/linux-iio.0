Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D03859C3
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900673; cv=pass; b=W8IuBoQPH+SabqIelblLtRK+X6o9aTUXMij3u24Tib4tw7u/JrupckQPfpeupqwOUarlveb+MRB9qb+fVETwCuZGXi//CcnyOEul1R0gzzpeWMd+32pu8tWBCuSVfokUSpdY7DZXzNX5BWxm+u7THA9T2kZLfVy6WLKaXZ81Sno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900673; c=relaxed/simple;
	bh=d+7HRtyYqdFzBtS1neiX9IXySF06zJJr+dw8DDKfF3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/xn6pKcOuZ8Sl7uLNh2Ij2De4VKZ9NEbaoQQiq7pVnL6ju7B6dFfTMrAYbpZvMIFWON1C0oeSM2IGOZ8ae32lspJxWowy9xpG/c85sDsHgF3LvhiazlnR0Wu3QUtYx1tgRCAvmJU0r85ZrsFwCeokXpLfOl0+qNhvzfwweK4l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=habRMzhe; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="habRMzhe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so2979596f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 23:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900669; cv=none;
        d=google.com; s=arc-20240605;
        b=B6huGRXA3+A2m8aJeIvn7o5LK7aGGCODH1QfpT8tIZRPpLmCh7BRkDk0RvL7oUaUf0
         EUrupxGwKaM2dmnyy0AeCDmo2Ax8h52R14Oj1ljnSH3LX4FHfSyfTQYtxFeDW2xj8+rx
         8p7UB1TuWcCW0pX0uiUtZZc2ATRmP9qpy/Plos3//V2cbnXX5HtF+KvBSoE4SchX/6d3
         rvRXmFBu2ivDkxMD2AIzFXq0/nyWy5cB7zqLEPTY+BQrehSPfqhNM2LfJ91LD8A/C3GC
         aiWLto4PHkCyFxZdJN8jOEdLVWuJFx5D4UFNsvxrQbIIjQepYR7pCCJea6OBiWn2cC9P
         p1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        fh=3B5Phc3MyeTpDvUyuYWvgbWOmY6YvdVeDVCCtIUmjNg=;
        b=aL6SiOzVLkp3/ei2B05FweRArY9nCI+7df9ciZ2gFLsuSxSJksG1XwS4BS8K5x5ZW0
         Aso8ZvUDkTbkKp983i4Cgpp1V750DyyyAtTIjGlxubEAouvOvchUGR03tCmY8Cymrg4n
         5i5T2LCSs/CrdLKJQLoqohl/NH7mkaFcLerHC4IqfKGZp//p2Q9mfQkGAt7kFW53aNCo
         HhllNSIhm6tvchuDrdfWtcJaqhahjW0k1irWvETPNgqNT9t2iz9ItKkGQNakekDihV6H
         oa8TjM7zUEgijmy7jUYPcE+QQFzvYQOeKxQWemOUAqM8CXsTOXB7NbU7HCB9NCxt7c+2
         MY+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900669; x=1781505469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        b=habRMzhedKIOMTWtRlhcn2bO6lpJ5XAhCg0USEDq8eCC1ONO+eqgbHLT77fQ6+TeJx
         t4yQPjxcr78KLICddqMTG6p+vjEkXYyaHKYx1jM2yc1s49m36ILYgCuUhG4chZW7GnAj
         iXnlIuHgiW5FCJqpj4Yq+fHxTW1Zc6sOt1wwJBSJq2LOiUUppOtlpWPjH1lKaojflNQ1
         Um2sH0nuypWgHrqr4zzLe6ZWsENsKiwn4eRipwj9GWvoWqNt5ZcoAV1qbTpHVJb4U5zw
         OGEjGxiqK0Qk0fPKEfabeM7Z5gQYYBJqcCaXCZDt9FQ1BC7VgcaOJiWg3syOEhrwLYen
         fMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900669; x=1781505469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bsD5XzkqH9HS6v4E56vm71811Zbo3EsaNP+B6BGR60=;
        b=b0va7T4bIbVN+4y1j/XCfJvsACx8vUVYqLAALM+zTLJvqHkSBD8OP8DYURc0kspD7u
         ks3gHp1EX5GzEVcp3L66vMwsNQO/05PexQJX7vl7ATyturhGei9n2rQPRu0xAevkDq8i
         vZIzMAGESjT/08KOMiOG7ZTqzf5IgVf8fLTyKMhWZb0xqFCTZwoMA0r8KnPDB9P69psJ
         rDvrFlX03WRoow8VLkszmPG/1iW3x+/KLmscF328/s677QCzXQIuYZ3aT+P5PeV/9I9V
         UJi83pqkLtcn9hxEle2U6wxsuxvp7On2Fso6B2thQLNxSz0JnWHKvP1zeJJxOZUfG2DW
         j4Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9qapWcLE4n4op3VSTp1PtBXlrraF0qBqtM6QcQDMP6fcg2xELWNeSnbQnuElrrSKC+/H0BK0nPHc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMg4grSMIVJSzDFjKKWWylZpep7GsgLvbBXHwzyl7F+6ZYZopb
	4ynABzDg6xHWfIpnSk/D9MmVfTEagXf830etZlMDkWI/NgtNoDlCFovV0KRfJ3KJ57Pk8zOf0Ht
	gguxrvli12SZTxjl0wEPP64jJlW0fQJM=
X-Gm-Gg: Acq92OFoSQOasYUDGAPLeyPp566yEyKJxLVafcqZe6BuhDJ/yFTl5ZtIk12ZbZQ0WSH
	lh8ti1QTTYl9+CjoRhEd/3E6zc9XpphBOXfuw5sI14rPEX7LfL75OFsY9e44Etu4LHyNkIJ/7YE
	7IPxSbJD8DPwrNYIfQ65hdJdoUHruHSSsCuhOAvzg6R7R+swhMmdy0Nm2yAVVeQ/8nyj7+m0Y4L
	jJ1wfjEvaPhy48sSAdrZn6ENfsJy8t1P0BoTqQLO+6ZVOWWdtN+hxnPQ7w4kwqmIv/CkmQfcZQf
	x7lVbb2hJ5Zwj+nGSUNqteRvmHmhLmaFOfNNJBm1QsoOnlUyLX7oDFB+1w4V+HrUGsigtIl9pUC
	L7oR+FprMWEcLgQSFtW3p5a6fEVgIJT8M4diiyQ2Aipq70JkI+HBkiDo2mF620+46gdraqmhhwW
	cXwuZha5TYrqcqwJXPNfz23IJ+Yy0=
X-Received: by 2002:adf:f788:0:b0:460:e00:121b with SMTP id
 ffacd0b85a97d-460302e8136mr16260899f8f.15.1780900668795; Sun, 07 Jun 2026
 23:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com> <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
In-Reply-To: <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:37:38 +0200
X-Gm-Features: AVVi8CfkKlRFRJBh56MXA_FqtKn30QLFIKFh5-Mn8VxrGfwUQDE_y-9rmO4m1uc
Message-ID: <CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Maxwell Doose <m32285159@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2026 at 22:54, Maxwell Doose <m32285159@gmail.com> wrote:
>
> On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
> <sanjayembeddedse@gmail.com> wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > clarity and consistency with kernel style.
> >
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Do we *need* u32 though? Usually these types are for places where we
> require specific bit-widths for a reason (e.g., reading a hardware
> register) but I'm not sure that's the case here. I could be totally
> wrong, in that case please correct me but otherwise I unfortunately
> don't see much value in this. That's just my personal opinion though,
> Jonathan may think otherwise.

Aside from the array of usage ids that are u32 defined here:
https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/iio/light/hid-sens=
or-als.c#L46

there are additional structs used in the HID drivers that take u32 (I
had a similar
patch moving `unsigned` to `unsigned int`, but it was recommended to use th=
e
types that the structs use, hence u32).

--=20
Kind regards

CJD
