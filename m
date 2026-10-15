Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3746983E
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094772; cv=none; b=owuovaNid9AlXxvp3nE1+R/9Rayc2xQbw58DPzR9e8coSkKzqD+SgqUGBgih1+mKhPrls//z9ZPsqJlkscZF0kpcr/GxpNh2S3aKheNnioyxljUCha4s8O47sYdOi2kQE1bPzzs1FnoE+yINkN6rVtncpf4ww0VHJkkbZPUig1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094772; c=relaxed/simple;
	bh=ETkB9eRVciEJ5r6J2oMUPIOaoRp3Bl4yuA1gSHfcqV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obJRf7cAs7G8EyRK1MW9uNOBVVo0T1t9IL2J2deh0iaWgDQcOEebe9Pc3IWedv3Suh49FlZ+8u065puOseIdhdXFOTVTN/5k5BJlT2YoS6h4la8watlCLu74FBnbcvqFPHWrVq07lfjVs+Fzy8nL/R3vyV0P0BcjgzfftNCgznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qla1F7Df; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qla1F7Df"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso23769435e9.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094769; x=1792699569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd8Vgfqw5fBEpKq9DzmBZr+ZmWeBjt5IlpJ/9R33P+o=;
        b=Qla1F7DfLHVT2Oe8pGk4o1DMRRNYCBH3Y7f4frRzZTq522ng4uL4PF4NtTrY4iSpWn
         oChZsYCDDr7St47k0KxSiN8Hev1jg33mrt0iHhYtB582mWdDAY35NL7vD1juiL8djSZV
         ARn/3aPHbpIB0EJV90a3O31YX/XAsj3so0n+KqmEV+m982Dfc+c0uJGrymChngtYhlgU
         hIO0FfKHRLQPXuzBW5mWm61BVq1V2rT3chl07gv6pFbwrLWJ1cHeLkoWyZEymLRpsb3V
         rWjNVgLNKaJStF7jG35eTBk1yFfoS8XAza30xRUB5SKROXHEnDZc77O2qJj/TNiXtNSu
         0dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094769; x=1792699569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd8Vgfqw5fBEpKq9DzmBZr+ZmWeBjt5IlpJ/9R33P+o=;
        b=ZecdZ7ap7M0BzMIb9S8Tw1wNbW415p4aSLIVvGecFoMmNvmIe9GshCqaxeclBY+OEm
         049UQHN6G4Cq87QbZJhCATXpmIUNzI+j4VqeXdyK2jfKUAepwSbL9ml4qlWGU8cbcGEt
         2qVihcmC6N0lMyYgVueE7v4kJJJ0wDnihapfT8AFXDlDtDZYhPObr1+bwEwns0Da9Gjl
         YfUvVaggtHCoZjb3zyvA3GVZ11/csAB2hAYULcJlnNGA1sXPQBG3fe6dbxrb9LXiu0KJ
         xFE6LLcMAN0wO+KFfMZ+ljIZ1p1Fc5xwxtUIpozLNwT5mC5QXFp2KQ1Ag52VTJlgafVU
         10Ug==
X-Forwarded-Encrypted: i=1; AKwUvBydG6eL/NRUN2JWbIFbd6N95/Isbdo0DdbyKVwe//Xk6ojDPJ0ji/PeFEDS1eZHPl0qBYWM5BDjB8s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHjr3KbTQzcwM5RC++xJOQxIZtm9QdBZQmqOjtH88MsRUARieS
	VvTmDGze5UYIm5vuLKXAo9dGfZl8A+pR2YQQvuu8Ss9KuQkJepQvYH+E
X-Gm-Gg: AYBFou0+nrctgjEG9TKGmKXp0boFWRT/A5Ojn/4FxxVjpBWoNjMqu80E+/eM2pAOEMP
	+9NeyjCMsYai9HxpkuC72cXmb3B7L+48q2oW87V9szBUGZP0ZByvGd/sqi0ECMKR4AR9SNQk7y0
	ilFSknYQ4vu3ppATE9vmAma2t4AOy89grKlq/KufVF7wXDfHnzEL6KJB/AUzZI+hpUoxSRj48DY
	n1DTgFCCaZWFNNIuve7SOD0llOigghNlYn/WDG9TQlpiJAwAgWLT9Z198f81ISR7Zt8QWbUFajz
	pdstvh1ZMsLPt9PAf6KRtyCFgrzSEhUwWdoh1pSl7nuoKF3qE0gZV/0PhwjiV4tw7Xq0PY/ijjM
	2yZg9hzSxSlSVFzJU+RXLtU/O5l025BrbNdffLLU5NwqADoaPxv2eqiwQx9ls1xYGmvkzsOHv2/
	QBPwaJBM1JOeHGUkoTKoII3JDH9CJKwjKOpH3n76bOyzTPwNrHFxWXLkux57SdesLUia2Rhhesh
	kaXzpNMH1oQqdfHmp8Ilj/DQTD6B70+wKewpICEXhlI4VeS8Tbevj5yFPXIuJ9WrkWbo/+1//ri
	m16unL57cQZQIw8ex1nyaCwi4CKCsPtE9piTg0RAWmEFXtB8CPB0lIKjclHIkq8QBOG0IRoNf4p
	6j+FdlqcM6uwxfvoytmDmKWQf2UspAOw=
X-Received: by 2002:a05:600c:a016:b0:4a1:a44d:1d5 with SMTP id 5b1f17b1804b1-4a1a44d0221mr249515965e9.9.1792094769132;
        Thu, 15 Oct 2026 13:06:09 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c9a68c06sm1235745e9.3.2026.10.15.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:06:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:06:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015220606.70c95a4d@systembl0wer>
In-Reply-To: <as4jIPWKMKIo5Di2@nsa>
References: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
	<20261011191240.5a2ba4f7@systembl0wer>
	<as4jIPWKMKIo5Di2@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 13:30:32 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Sun, Oct 11, 2026 at 07:12:40PM +0200, Joshua Crofts wrote:
> > On Sun, 11 Oct 2026 17:53:01 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote: =20
> > >  drivers/iio/gyro/mpu3050-core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >  =20
> >=20
> > Sashiko review came back and the issue doesn't seem so
> > straight-forward. I'll probably introduce a local pointer
> > and then assign it to the mpu3050 data struct. =20
>=20
> Hmm the probe seems a mess of mixed devm with manual cleanup. Ideally we
> would move all of it managed resources (and that would fix the issue).
> Other than that, seems to me we have two things in play. First:
>=20
> if (irq) {
> 	ret =3D mpu3050_trigger_probe(indio_dev, irq);
> 	if (ret)
> 		dev_err(dev, "failed to register trigger\n");
> }
>=20
> Do we really want to ignore the error? I would say no...=20
> So, if we change the above to not ignore errors, we can assume that, on
> success, our trigger was registered. Which means that on the if (irq) at
> the errir patch we could unregister the trigger. Not that pretty but=20
> consistent with what we have :).

Ah well, I'm an idiot and pushed out a v2. This would make things
easier as the trigger would have been guaranteed to exist...

> If someone has the HW, moving this into devm would probably be the
> better approach (but even in that case, we might want the simple fix
> first for backporting).

I'd push the simple fix out, then move it to devm.

--=20
Kind regards,
Joshua Crofts
