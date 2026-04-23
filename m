Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F02737F9
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971770; cv=pass; b=lWe+bzYML0JpFLoCD24iZMebyvNqKA45gSasxHSpvwtpVTJ3bvsZMJ9PSuQui/HSgOGi+sUo90FagUl+pSyx+eoZNlWhIJ0NDgAMPr9IYYDn4SkfgQPLqgdvNyDDLoogZTPV8JU1obColVj2dSQ2r3HCJpDJuNqIAo6kcLN+n1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971770; c=relaxed/simple;
	bh=MKhulYEgFTHvPD2QXL5QCt9OQeVVDUfrot+j7lHqO+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt6fxRjc7M4/G+nXPFWemK1UEY8L0UrsIhfGujmJd1rmhBjyT6ep0iskI2let9IGl/E5PB9EwXXEQpN+h8dzbIDvJWOPmcFEUEN5FRLtl61c0yp2N8nkp6Qa0958Rh5Wg/E5VfK18lpcaFyrybgve8uTOd/0lBFS5A9pyaLD34A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=OZ1QqfEh; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="OZ1QqfEh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so5603839a12.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 12:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776971765; cv=none;
        d=google.com; s=arc-20240605;
        b=RIRYQhnV6xCQrl8D2jPToAe9n5EW+hwMXKAMZeDNNEYV5GskavMQNUYBPSfBUWTTsr
         evHAnzRDw/po509fEf0DxeMExxSpo46W+4juUnhE3B4gEe99HoBRny0ijbYWWRste1ez
         sdMsD3nzFjy7JKxg0UYRp+2tmJV+i3+atjmSTeZPWvoFBqBkw9qWcXJ5NtWy00ccfM+g
         kQouTQHU3sdRb4pflPP3BpwX5KaVoRzIPkmrQjwzLoFzM4wRuv190A4yX+O+8T6/YsNl
         MJIsV3fzm0cpfcl/Fb6wszp1xD7YnA37r8SS+BZq+A5qBaYzTuJP0VI7bhXT+7JqY04a
         IEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+OwFwXILla4Bmz88+Po4DQbi1rj0xGA0OG7tNHA6rA=;
        fh=FJIjbU8zdWBkMK0xiEEX5TXzAu/KgviZyWFRH/RlhCA=;
        b=XVDSTQikplHpICg38Ycpe7DUBSl3Bc0c5Q3TSIIETawez2v6WpyWLuY3gEgz+ADwO7
         Cg95I3iFKXkjQw0wub3TW7S9ez0GxZEEuGmMkBLe+Qk+tJiOJpvw2qRNml1a0kUIaD5k
         TxLCVq1pxoBwZt+/U2g9xhCywJRqYuzC4Id7+GlcAf6X7dc9aJT9dFYztBZcBDrETazQ
         2TK1hwp1XykYcJfdBwVePPkDnvweBdPHitNfehYUOREhehpJnwyDMon0hpFQUpX7ewuq
         gBXMSPbs7nNaKJMx56SZFyi8BwMuppV1b1S7U9pGto/TcrCEuvNCJlO029xhWAdGuOrp
         hclQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776971765; x=1777576565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+OwFwXILla4Bmz88+Po4DQbi1rj0xGA0OG7tNHA6rA=;
        b=OZ1QqfEh9MS0zqMqm4wFHlFbX9gzEm5w2gRPSDCrfFLc+zJbf1PaRKqb64YFy/7itL
         S8kGsNmdnA0KARn+vg62HvGslhmN77u+4fUpLw7I82pomXWgTltgZGHxguP9ocfytcUl
         TiMqMF7u0F1vtiwXxSdrkcVK/3rAy0geZy/TcbhiO4wY72JCc1LyUPtbpG8a3rKy9O26
         r+CTb7aoaqYLv9O9HAHn+Lun5qXRDhIpLVAmM8u3h54z1UnPfhlXQlJT5GQnTivZVH+M
         VIUMMQVQg3L5tp+H7eYMJEgeBudmTEhIJXCFAeIylclpRad0Zkcvcsgx420uklz6P4//
         ggPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776971765; x=1777576565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+OwFwXILla4Bmz88+Po4DQbi1rj0xGA0OG7tNHA6rA=;
        b=ebg0Au8oZA85wvUqldIvIZrQZO7ZMm+ZX7ZS5R4YVUumQGClFtfDepkmFQK1X09Aor
         7llaPlYiKGrHkKR5i1CaWcibbjzJpi4fLv3RetHPKqhB52voYxEIjjO1H98hA1h42Mh7
         uBU75EIKLQ/g2DJakSUBy6BsxUsyEy/7XRtu8KxAW871t51i97fq/F8noMucvP1jOBWI
         wiL0yZeNAvVeWfna38HIYS6DeDA5HUDw80FcDMV5ud58Y2xEs7lXJQChOUfiOtQZD4QV
         OSLGiB8/sRgUen7OW/40meydxFr3krAEgc01chj9fgbQTAU+Bi+GsRl5srDaFJsXAKOW
         CS2A==
X-Forwarded-Encrypted: i=1; AFNElJ+sJG4GRNCvCksNZvMyVxqmX+ccqBn6uKmSouZjeurOncOvySkYEGKmUmMfLJ9HQPobz5nWAqXMRPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2lckXSJFNnxYpA1aGLgFHkngEMbvF/klHD+dZ4w1ZhlN9fbw
	ccy48P+FcC7K3dxfirJH3c7OJH5ZeAV17NFYDndxsowdoNbuTsvhL2Uo5hAQle8MuKxuVztL5hE
	IdpqtL7b3d079Kynt9TqQ7UAIQQ/P/gQJAmKQ+RaURA==
X-Gm-Gg: AeBDietMW9IA8SkdU+MgDjzO/IL8flkhnw6r4xrDFwsVqxU7QhTj9LohaER1dgUQdNS
	ow0JojdiORAfeU1KgMsOm1j13Eb7Mgo0qI8Jn/de4kzB3xENbPWfWtBw9ZxO6y54AQuwApIptpy
	fZeWtLvWPYtP/v0yFrk5h5+Hjfb67Edyf0XcyWzKWXqnfFC+H173BteLVhM1sskcdj6Ks3kQ0YY
	k/DQVfl6mdYJJkjUU+rlirIJKULQSiibrYN8OruDCUr8PaiyeenLV3wbozbzJ5rOxkyOzXbBu+8
	eQEJ+UMkupLybeXp6isKuBiWtBWk
X-Received: by 2002:a17:907:3f1e:b0:ba5:60e1:2ef2 with SMTP id
 a640c23a62f3a-ba560e138c1mr1302959766b.22.1776971764666; Thu, 23 Apr 2026
 12:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420191455.529923-1-marcelomlage@usp.br> <20260420191455.529923-2-marcelomlage@usp.br>
 <20260421165452.76df9b7c@jic23-huawei>
In-Reply-To: <20260421165452.76df9b7c@jic23-huawei>
From: Marcelo Machado Lage <marcelomlage@usp.br>
Date: Thu, 23 Apr 2026 16:15:54 -0300
X-Gm-Features: AQROBzBF_nKXuL3SIqh8CfWmG7teX_o4me-yy6-4NGv4RuWgmEtAg_Xdq3r-I3A
Message-ID: <CAO=vGZrJjwsPtFeo+Nj1k8rKpHehsVUhwFCxzeTAeJinTL_ssw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3422: rewrite mask macros using
 bits.h macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	Vinicius Lira <vinilira@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan,
Thank you for your comments. We will correct the mistake in the commit
message in the next version of the patch.
Regarding the comments at
https://sashiko.dev/#/patchset/20260420191455.529923-1-marcelomlage%40usp.b=
r,
we appreciate the opportunity to learn about this resource. However,
after going through the content there, we do not feel confident to
address other pre-existing issues in the code at the moment.
Best regards,
Marcelo and Vin=C3=ADcius


Em ter., 21 de abr. de 2026 =C3=A0s 12:55, Jonathan Cameron
<jic23@kernel.org> escreveu:
>
> On Mon, 20 Apr 2026 16:14:54 -0300
> Marcelo Machado Lage <marcelomlage@usp.br> wrote:
>
> > Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
> > and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
> > bits.h.
> https://sashiko.dev/#/patchset/20260420191455.529923-1-marcelomlage%40usp=
.br
> pointed out repetition of PGA_MASK.
>
> The other comments are a mixed bag but it's worth taking a look to see
> if you think any of them matter.  They are all really about the existin
> code.
>
>
> >
> > The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
> > because they are also used as array indices.
> >
> > Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> > Co-developed-by: Vinicius Lira <vinilira@usp.br>
> > Signed-off-by: Vinicius Lira <vinilira@usp.br>
