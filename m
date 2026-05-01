Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81803D092F
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659250; cv=pass; b=KU71+VgPmAukjMff8fH++Upi1fi7Hq1pjYLyAxPoPVdGEK1xxaYpCgOKbgxDCxUaC5lD/oNZdFL8DNsjeC19C09qeeOmk/T7e5w1fvwitPqariW+qVSE1zxAiju6l+qhX7VSp/xpQlZmy3N1B6Ibutc67+IYMbCErrEVZJ/E2Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659250; c=relaxed/simple;
	bh=rLTq75fWRsedv3RJs/A34xFSHQmc3UDBg+e/kJhzhmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6wEkn2EcwWn6PqN1p6NnbNeZaAhEH7C56SU7GPjN9Ded6iIjiIP86aqnPmNmrHqdDDq+8yJUJ51fWjCoSD6D8playpo/qd3TLn8QGm5VaLII0iCKoiavvpNt0gLzwWNzA+xAKH4hu2dZWkQp9u5pjH3uPn5g1/KHyXxowsbVvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG3v0knb; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG3v0knb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba67b332bbaso318000866b.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659246; cv=none;
        d=google.com; s=arc-20240605;
        b=J+Sxp49hZU7YILdXHzKSjoaaN6ki36gyHtghT8w1GjGAmSqyTZCo1iYctsGXpEkAsu
         tglSYNViu6zO4KLk84jTUZ06IHN6W5pk7DtbNv8wqnjeYnhm9ozRW5B2Lnnm//viu8GR
         gr7NkPG3H2wZPsMTMolMrQKMvXZ8K2dWJamAP4OGbUTSOuaG0K/OU0bZjAsauh5LBHXM
         KfXRRln2zl0lZe9t1tuz859bMNG1Us8usCxNwfk6VboGLu6WAsDlfBUMh9UweIez18dr
         q6tLlo0Jn77ECn0N79ADSRb7LGFErd+D9d9UjMl3o6XEn65HSC6XzgKR/fPdgX9ycuiw
         ubjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VuAuLUF9yqkB7SWz/PXl7WQfx1LhLuNvHCokNWzNl4=;
        fh=oTf/X13cuNRevZz2nkzCWDqn3S1pqT2EIeQIJ5edpHE=;
        b=Vlk2nvS6hxxssuN2KEjr1C3iBm6WIfti/c76UgCDubkc3WaFsijR/OeIEH0gbjXz0J
         2OYcyZ4kGMZ95ytq9lQKKeTI/ntl3QnO0Iu9WHeVo1sC3cCS3phZ5gQABCbVLhuzDuTv
         iEyNfCwqEk+f9VGqVIRMMiJAK19WhHjhJPnxzEmmEn4hPJRkxTPW4S3rT8u1vpLUALvs
         fW2Ye9fY5in/e6I0dZpBGXexnFM63spcq7Axop4T7vpYix0+imMFtog8IT9t5/kRHdZZ
         aUXIcaVSBQ/BrO+Ca0KB/Qc0LyL+2IaPj+0K8sVIdJuEcLWAG6lxLlrYp8JB11CONgEA
         xqJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659246; x=1778264046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VuAuLUF9yqkB7SWz/PXl7WQfx1LhLuNvHCokNWzNl4=;
        b=WG3v0knbjR4Uz3jtWmxLCUKfJ7J6vs+RBcrPC29KzKG1b6S93XplTW2oZdU0PmkyV5
         57uuPJMqE445rPQnqqdRbz5WNT9ywbwLH187j2XDkd8Vk7Lb57r2QvrdLfsHM3QgdpwX
         WyJ0LkqnoS0truIm0Iy5X9H/Vby5CIRhDxB0va53TrwPStPcIamo5JmM0Eq0TxyIW03m
         eFEDxvxGOGzdNGLD71tPAyZ9m2djpConnWp/XZ5Is0BBAEjaM1R1YG5hpa6Mzm6+VoUl
         BCX5LAAepMSyZl2DWGLfi9HSN9Q6R6ndzSUP5kIXDa2Wk2uJk/pzhBTBJP/ze6QFf/5u
         dnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659246; x=1778264046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VuAuLUF9yqkB7SWz/PXl7WQfx1LhLuNvHCokNWzNl4=;
        b=XJ9/U1UNECCb9JcqNRT3JbS5as8e61r0AX6v+az897f9qoFSmsvHOruALWk/El30bw
         P78NROa1BD/Z2MpH0jGpUkIgbzsHg1s8oGCZzt8fUZOyB6MenzHlq7Z9WZo8aUTFv1Je
         IiVoDM7GMXu1xlueCAIGN1qAXPNxklmGCAkf6YCnLvnQN28eIW22mM9S2kDubKqhVFz5
         Qk3VXhcnH61LAGOPXlpn9iMyDIkliQM3KJxybg0Y+KHsBt2rv3kKTqLIUpsGXjQzxI/G
         1/IYRy+EY7Qt3USCf8DQuTD8JNhOSPoSf95u9Fx2VNyTFVmZTl/DL2SGT7nFqv5r0hc6
         Q3Dg==
X-Forwarded-Encrypted: i=1; AFNElJ+5xxsUVMtHdruWUIOn5pVOpqsncBvYZmuAUjWS519brlryUBSktY54z0f2vt0pvl224XLDN2hSopA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5Ll57yj1aVoLpL42S61r2HclDiT1iG1mWm6YGHJochE37ugJ
	JUZPh+LO6qbI2dEA0gLvDNDExnfEuncCren4jcpViXNjlSc7ALe8AEG8uS8jUBQpcypqfg5CvAZ
	D96CZjxqo/svURNwCQfuy9fUYlC1kEQA=
X-Gm-Gg: AeBDietGHbcf6C+wOODsKCiHIyzVnyt0TeLSXVK/vvH2aoHgAQgyZ94nNBg5SagpAnH
	c5C/vrLKfk4lDkONJJSK82ziMx1CcviLyJIxA53nHpBAeTLrD/F6FzOXBdCr4FCMBcmg8AR2pIU
	uCAdb8ynLc7EPXiZtnvDCGy/qg0I1S1d/lYpMj66BUbWj3xNHsBqg8THyE+PiIZI0Zj/xMEk4j9
	2Vvet2Tp/34b1AUaPJdBuR3+dk1KnSvJj2gguNd2wxWHlcV1mcKoQaEchRqaPa7ri/t8XhzavIu
	fgthxmVcRHd0V1+Q5ocLEF4kW2HnK8NPyIlazx5wkUjVegCiiBKR+VE77aCBKTXT9VlMa8BJ9QW
	S5Pm+tb5My42tiRFcQw==
X-Received: by 2002:a17:907:e8f:b0:ba5:a3a0:4a5f with SMTP id
 a640c23a62f3a-bbff8dc79c9mr8967166b.8.1777659245203; Fri, 01 May 2026
 11:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br> <CALoEA-woSsD3+oEo-4xWLY+pQt5B=SaaUX4xPFoB46WPnFbwrA@mail.gmail.com>
In-Reply-To: <CALoEA-woSsD3+oEo-4xWLY+pQt5B=SaaUX4xPFoB46WPnFbwrA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:13:28 +0300
X-Gm-Features: AVHnY4Knwys7JDoZUcVL_6lZMbWyZ0jMg8Mc92051GJb-joCZ7LkUpJyrmCP12E
Message-ID: <CAHp75Vc9nUsduW2Fzq6EqgmT7gjeFgrOrw9a-aUgy4fXddR7bg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nish.malpani25@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 12:23=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
> On Thu, 30 Apr 2026 at 22:05, Guilherme Dias
> <guilhermeabreu200105@usp.br> wrote:
> >
> > Use guard(mutex) to automatically release the lock on scope exit,
> > simplifying the error handling path and removing the need for
> > explicit unlock and goto-based cleanup.


> >         /* extract lower 12 bits temperature reading */
>
> Make sure that comments follow English grammar and punctuation.
> (Capital letters at beginning, dots at end etc.)

Actually there are two cases:
- multi-line comment (the style is unified in the whole kernel except
net subsystem)
- one-line comments

For the latter whatever style of the following is chosen it's fine,
the only requirement is that it has to be consistent:
- all small letters, no period
- Capital letter with a period.
- Capital letter without a period

(The "small letter with a period." seems wrong from the English perspective=
.)

Also note this was in the original code, the requested change is out
of the scope of this patch.

...

> Why is there a do-while loop with (0) as its condition? Are you
> trying to use the break statement as a pseudo-goto? You could
> still keep the goto even when using a guard(mutex)(). This can
> be implemented with a standard if statement, no?

Jonathan required this due to the nature of guard()() / scoped_guard()
cases. While implementation of the scoped_guard() is a loop, it should
not affect the callers (layering violation), so yes, the break inside
scoped_guard() while technically being correct looks and feels weird.
The  do {} while (0) is just a compromise. Note, this is idiomatic
scope for many macros (before the GCC expressions become a standard).

--=20
With Best Regards,
Andy Shevchenko
