Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F45390217
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088689; cv=none; b=ttrLlk6JwroNfFd25rnCRf4xAEjx/TbeJhZeoLFvE7Z0oaQIybHkY9umHlZQeHlKNQaYLVR8v8nmdl43se503NQu40O4RwvHLdTaMczFTktKVQxgEZGEbIWhcRFWSgWTXUkdJaWeUtZ6WWASxl0zjX3IiOIZqz9A+DOz+gWZVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088689; c=relaxed/simple;
	bh=LrLOuQYhDP2Ne/W+JeHh4CJPqiqfcs2r7c7X9Agrpxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glCcDMmxR/qbLF5fA4Z0dImhKuHPWFIB9/Sx6MUjx4kiadoFMUc71nd+VQWTkH1+gKw6zWV+dDrsTGStSgaKETA0UutaF4pu6snJAHk7qCuO11d8PNOuc35bY0gWObSwlX8YKOQQ0+zqLTn+xSZITS5ZSMlr7Ys6Lr7KEiv7Jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd9fMKFe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd9fMKFe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48442ea8f59so454376f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088686; x=1790693486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rT1fhUzJtHd03dawKmOOn/5b9mAH6VMNLTAZxkWOibw=;
        b=gd9fMKFeXVr6c95ElUxMrEOTLahf+JiLtQ21BTpcc6S9qWmDr8I8V2tdvlzU0YLTnM
         ZMbwd/6UIzpqKoBY7pc97mItnKoqA36M5etTdlbLBKMTUQRM80Mg5y9hEe0P4vDG2G3H
         cMKsjgg+IAtCVb8O6SHXH7P+wKlC36vAupHkrVYWEXRXxx0bDvXDi6c/1Aiqe34qWkwO
         kTHHeP1SALC4CfQKAOOZ+bBhgVyaEQVzaOGaQ0rmbWC6BoMDaAofNmQlA3jm5aTO4st6
         RlSpVjzmjvYfhqGZTPJX+wjcmuUHStD672LU2GnTpsIx8aWT7uE3KOigSOcor9s6JQwi
         b7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088686; x=1790693486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rT1fhUzJtHd03dawKmOOn/5b9mAH6VMNLTAZxkWOibw=;
        b=cleHCAj1H1nNfuIqkmgTlr+ndTeN9xGh1W0mBHV7f6r4+Og+uRqFS9B6w6n4Z8sGEe
         cZQkriY1P+Q61/8au+o92JbSdjLU6yE47wJTEuZCFj5tG0ixunx6GWxwhhXgKPd0x860
         RsnXw3sbHDNjxh/H4nb2J7egrfQ9f8/TjK7H3DXkiDry85jgS2ybjfWUcxtFSOIRrkNU
         YpKmK2tba0AUguNNn65zsZX5W0KwklGLyCjeCLtPrr51S2Thv32XC9vtfUT3dEoe+yk+
         aJ6uH2dVCPVAlMObH7XoERXb2UkHTaTYu0VlzA/MpgxqhhwdaikLZkcrf7fmY/GjEBQp
         I8jg==
X-Forwarded-Encrypted: i=1; AKwUvBwARSNO0WIQS1c8NEwS1PeLr68Li3fS9p8wrBpiIZC3/7fRDP5fwOIT/UHMgY+WhU8QXCS0lkB8j40=@vger.kernel.org
X-Gm-Message-State: AFuF++lx1UwImwVi/uKP/wufQNgSpEw7HNpo7ywm3yr1p69HX9166H3d
	+sLTH6kZBmWRlGFb2Fr2QbQW2taKOePVwjH+BgwYHIhwi0r2mjAe86jD
X-Gm-Gg: AYBFou1aTGDTSRUPOUsut8tLMN8LmeaZ+Jmpw5VXq0oG0yKGhq7rwE13vg7f6zplEpu
	VLUpMsJ3BgLUP8bdwvcHAuWCxHnGnWe1k3NbOUnenzQgCH55ZmkJpm6ahymO9JquRCenq+2w0RV
	/I70z6RD8RpSoxDTp6KM6WOvSypfPbGN3ZBy0dYfAjDbTXvRpQVaSxgPk2PDY39pw7Jg8oZuPIg
	uKXOhZ3LW6Ff+x52MApbVcGhQAfAS4Pw9HLz3+Ok6a7qdFRzga/xaNKYRMJnK9kcwvur6sNw0Kz
	tGDqG/FTkbeBq3Ncct+x3d/aSakvq3E3cXW0gwxGLNhLfhavzXtVmdymAjU3wosUJqhxNZBimID
	ue0UdWyOdDGs9XrZP19HvQYdiJQECRwGRhQRh2bSMIPGPujBum33sWb2+ahVhNvhWdWv+uGEmZy
	rpRpSprq4hHbptMPepKIj9p+C0N1jfn2SO+i3QmgrAvWcZhjBjWbvevn72LdbxFKu6Q6dnbTdf8
	MrKBX9Laqb1IZgKF1vh9kyVT+trk/0Adbk50Lg5mRIay3pDbQN5FqjRlyKDdJxysX5gBjIs+an7
	8/zzWqdTsWzUoDvI79I3zGH2dfzKuFOZy3qhxL+xGpF4m2RxIRYHt9WmEqGjZbBT2UZ4rw9SXDP
	yiS3zmgLFYcoPHeC2eLW5/DSMX2L2RjqWd77XMzpKItNsFcvt3BMWeuGjC/nun637YK6thiRvaG
	8hbwPZ5HNe9Ntj7Rrh
X-Received: by 2002:a05:6000:41f8:b0:485:8226:c69e with SMTP id ffacd0b85a97d-48861021808mr4195142f8f.29.1790088685667;
        Tue, 22 Sep 2026 07:51:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862793792sm6814839f8f.31.2026.09.22.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:51:25 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:51:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260922165124.0000132f@gmail.com>
In-Reply-To: <arD2UjzKu2k8elgM@nsa>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
	<20260818090652.000020bc@gmail.com>
	<arD2UjzKu2k8elgM@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 10:28:24 +0100
Nuno S=E1 <nuno.sa@analog.com> wrote:
> > I'd propose 2 documents:
> > - entry profile - documenting the review cycle, patchwork, point people=
 over to
> >   Sashiko, relevant git tree etc.
> > - code style - the TODO is fine for existing problems in the subsystem =
but doesn't
> >   point out idioms we have in IIO, i.e. not using (the awful) kernel.h,=
 preferring
> >   devm_* functions, not failing on a mismatched ID to ensure fallback e=
tc. This is
> >   stuff that appears a lot in patches. =20
>=20
> Personally I do think we have some things (not just coding style)  that a=
re very
> specific to IIO. But maybe another docs file is not the question. Or at l=
east one
> for humans to read :)?! Have you evaluate just having an IIO entry for
> sashiko? That way, hopefully the bot would take care about the subsystem
> specifics and preferences.
>=20
> I wanted to do this myself at some point but I'm always pulled for
> something else so if this is feels like something you agree and would
> like to get done, please go ahead :)
>=20
> [1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem
>=20
> My 2 cents!
> - Nuno S=E1

There was a thread about adding Sashiko reviews to IIO but it died out :(
I proposed adding an IIO-specific prompt. Any ideas on what it should conta=
in?

As Krzysztof says, there isn't really a point in making a new doc as people
just don't read docs (I know I didn't when I was starting out, but perhaps
just consulting with an LLM was a mistake :) )

--=20
Kind regards,
Joshua Crofts
