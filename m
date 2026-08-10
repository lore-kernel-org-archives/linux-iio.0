Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EC3E5A2F
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380669; cv=pass; b=Py/Faz7f+UKTrnQoOjXjGQdth1XkDDLu6FWPmzgYM1+m1JuwJzA0UZ1ohJ+u0VtL4PJ7+U9ugM+LuCvZgBFbssNbO8kNdNR23TNMl+U6Ui9QxLN5e2eRaMGSRlcGqIJ3mhosFZ5BMSMKCegUBQ/8we6NndvFvMlgmmqC20Gucss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380669; c=relaxed/simple;
	bh=u2MWxqYNrh4/Efx+gzbzk1/uU+WHjYvGL8Eybq1qJtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWFgApTg+fPeecuOyx3v1XYx4bzf36oYzbYxCzPJV8WefruyRET6Xrvj5wYQwj18lv6JkIIQTmgAxktBvbi6K439+wdoUOHrWLAgyHdE3QFtBoZV5qZHP1wdGwW19tjM2paBN1ShgzFmeefgng2UwKuft64ZuYJae/DDdzxzAeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5PHqjsX; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5PHqjsX"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ff017d420so1328067b3.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380666; cv=none;
        d=google.com; s=arc-20260327;
        b=FZlQa3UawOaIYcimez4v7hwGf2KqGMeKVkjlRMndLivRdoFMsjAAq+CuttgYsSHia7
         o7bX2UnvtIWMjacMrxUW6jbg7kqDtaK7vhyG4e0ibJKq3WACBMeOZbAZhUmNUw9F6mKP
         kS/sDeXwlw83h2fAX0WV7Kt6KEnyXnLVRoh4+hexr+eZtBWO5gtUt6vRSc2NQ8OvRrZD
         BBTrJ0a95MzW4dlAha6gYOH5qIo5uytP7m8SWreh7Cle1TIqocK52z4JbNCzXHrszL+t
         PPFsY98gAopgry3dlTpT/puSpv0Lap6iO4C6yomMRMe0U7pV0dmM6OKduQdQc/87/pOA
         /CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u2MWxqYNrh4/Efx+gzbzk1/uU+WHjYvGL8Eybq1qJtw=;
        fh=SrEadgIjqmlbSnhq+2GuQQgC4lnBhyfai4OnKCq+jEI=;
        b=iTeSLFpYpK8s6XXxljuoLz9faopvc3EPhRLTq1PX03CaOL+Zlmeasn/z+wv+47BHvL
         7oEiJ5OAvADaYLM9VapN7ViQdI922GBUSbzzjzJqOIYGCbxc0ejCZbQXkcI154tJ6KnN
         +t0xD4MKqcrSvSWhbcf2EHgSt1Ptek7vNWKEEafYGua02lc8ann6BySaue1sazb8PJy4
         OWy9D/yAJAKgrnnRfbnG9qoxLLLKJPtWQBSKybEsO3UaLKBJ2FQmRwGLKnbm2lbdh6we
         DZwB1Kt4oUgkU359cvYAxRtkX+JGGGGRDVo4RCQZzqUSlfks/OPCxYoPNeaYpU/hzpzC
         F8rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380666; x=1786985466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u2MWxqYNrh4/Efx+gzbzk1/uU+WHjYvGL8Eybq1qJtw=;
        b=m5PHqjsXajkm22D0xbvDUXQohfa2VdEG7im9QPANs4MVx4v96u+HzByxus+qIq4fU+
         0721FX1KSOqIZ/fB/Dwd59bmBaxE236wU5BoCVNE56dwUo7SYGw+Q++hLkMP0g5OuoXN
         qlgZW+VqyluhQBO0cNqbfFEFrSmR0QF4+7bo3i8dZiqO6hatynCgyZuMajbKHdga8ddM
         MQ3ox46Y3fm/S+ZqabmlB22MkeEKSOg0aebGikgb6vOYMdDI5MFlvg3+HLciWACyo1tg
         CLFEst8Pzqkrc0ydQIiHQbrlAIw3eX7hJmoqUUBRRRSvZLF/R6QaCxeYtOB+zXI5MSPO
         bRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380666; x=1786985466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2MWxqYNrh4/Efx+gzbzk1/uU+WHjYvGL8Eybq1qJtw=;
        b=EAnehtvX9C1OmqW8ffr8K0IWf32S6GUbR6n0J5y/UQMm5D2Om9bDJdcQ+9q25q1GTM
         itFThWmiz+sQz8ePnHuISWeMzK4Qmd2/3y5+i4aP68r70fWl13jBtKa0ogo+Nr0nsj4g
         Qz7wogbcmfZkpYNkQ1fc6ebnp/6VgTrKkv7nWeCmgXK0NwFHwqL3/Z7iBX68QuF6+NT3
         32pUehSyExkIt2fw8DtQ4KyhfYYfcr3UgaLkgIpankO3ycO/U/13pPtrDYMpgrl1fM/o
         uyMYNbbw7KQwScSUP9N/CnaxTfjbZXWY9VK8qD+ypLqAHaE84/jg7QjxHg/C+X7N8nuo
         /snQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3DVtbsKFmZDtjzy8shfrQEkmSgcP8AiGKoqlDhbHLTX3htuqIOYCXh+gql6m2qqQnK00zzh9G3QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6c1x9Ko1vuNJqWPgUak+JvQcg4Dn+qwFadxtvWj+jaGDAGBJf
	PQSsyMbhjw22XgSKsCNomQVAskHU21c56S2LwC0Vbi9f9GrT+OCJOFDuKIT/bV9/Vie+s0yKxRR
	D3YrHZUqsH1tGcIQfrqv58ZB3ob4Dbsg=
X-Gm-Gg: AR+sD13yrQJHb9z1LR/JICDThEzEsjcWJN/tmMi+XG1HMf2Yb+8IxqRkJO/Xbh2hr+A
	FSNx1s4gmiRbJjedigrvCmo1Jmr3ITikbi0KGu4lxP6ZBuC5Ky7wsUyBU89jHBFtIbnOb9pfEG+
	hUzzdTuq7bHbnaz5xU2+EcvfggT9xJn/vwlaQvdQB6doKt32KOmSSqiC8XBaWjp7OaKfv5G/Ezj
	eCH/UC0S42t6RDStYe8y9WJYW630TZXGIFbob+2bEN4gEOCiP/OHu4QSpAJ4i549QsWj28bIc0e
	T7ELZHaThbJZErmOAc/t83vBRQX+68aGLlTprEOgOpxttvsLcO/BmCg=
X-Received: by 2002:a05:690c:6287:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-825ed9d05d7mr118852567b3.12.1786380666546; Mon, 10 Aug 2026
 09:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810064234.1850833-1-congnt264@gmail.com> <CAHp75Vfzb6cyrpfadfr3-UkNKVqNP1jsLMkmnozG9uqizt=thQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfzb6cyrpfadfr3-UkNKVqNP1jsLMkmnozG9uqizt=thQ@mail.gmail.com>
From: =?UTF-8?B?Tmd1eeG7hW4gQ8O0bmc=?= <congnt264@gmail.com>
Date: Mon, 10 Aug 2026 23:50:53 +0700
X-Gm-Features: AUfX_mxNuc4EcmUo0Gy3XL4db9AagN22xmPrjM8iUo83a4Qk8_QZe0MApayZXJI
Message-ID: <CAJpJ=GvyZLEwbAS_iZ1sU8tR_cu=uSRZPwsWqXSKFhHauy4nmw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max1363: sign-extend bipolar differential
 channel reads
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:45=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 10, 2026 at 9:42=E2=80=AFAM Cong Nguyen <congnt264@gmail.com>=
 wrote:
> >
> > The MAX1363 differential channels are bipolar (scan_type.sign =3D 's') =
and
> > the device returns those samples in two's complement. However
> > max1363_read_single_chan() masks the raw value to the ADC resolution an=
d
> > stores it as-is, without sign extension. A negative differential readin=
g
> > is therefore reported to userspace as a large positive value (for a 12-=
bit
> > part, -1 reads back as 4095).
>
> Try to make it more compact (remove unneeded or duplicative details,
> do not blindly rely on AI).

Done in v2 - trimmed both paragraphs down to the bug, one example, and
the fix.

>
> > These channels expose only IIO_CHAN_INFO_RAW (no offset), so the raw sy=
sfs
> > value is expected to be the signed result. Sign-extend the masked value
> > from the resolution bit for differential channels before returning it.
> > Single-ended channels are unipolar (sign =3D 'u') and are left unchange=
d.
>
> Same here.
>
> > Fixes: 168c9d95a940 ("iio:adc:max1363 move from staging.")
>
> This is a wrong reference in case the driver existed before (and that
> is suggested by the commit description).
>
> --
> With Best Regards,
> Andy Shevchenko

Right, the bug predates the move. The driver was added in 2010 by
d1325cf45077 ("Staging: IIO: max1363 ADC driver"), which already reads
differential channels with an unsigned mask, so v2 uses that as the
Fixes: tag.
Thanks for the review.
Cong
