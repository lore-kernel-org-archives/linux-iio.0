Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793290786;
	b=FySYcXZC1gitP3K7vvNCAGy4k02stIMKBev1JXG/fhiFeXRifnEikqZ0f2/nu8pxsuFX
	 PJpFBWSJwiw+7DGPDsPqmMufKFaVG/r7jI+kTn3EBrBmbkxvj90RxNyMvPykKOb6rSG7+
	 HHcde18yX2W6qqY/In3TaMIbI0+/MkOfOp9J9q6HS7Pug/gM7q17biTavR0LaGv0SJ+yF
	 Td5N0Cj++MUDo4TOHJ8hxh6/+WHvNlqYA2Poi7Jiu20cSC8P7v81GBnvT2UfVQxTDh9Yn
	 kJ0/EbQ5VQhDQb5XqTlvBKIwSXSBpS07WUXRxz8zIq0rgC7f7B4zAaxGpb/e34/+gxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZrLXGPOeZtKb/0Qmj4iU0Alw7tw3rFlIHiedf/XCtcE=;
	b=C8iLzDYF6aG6HLrY9SDoNZvAp9iKw3zhUZK3QifcVD3btcIqviWty+SnmI3nJDSzArYU
	 sEoSEN5xKhbVkFCGNu1wGaBKadsFP599wnk/2YrDbZD8r50PPY/CiiCTpk3YUciW0fgmk
	 liwXuMK6MSYwRjSuV6SLGz+KO0a1J+Kl2qU4uC76faQjWAbG8qNS6lKiUpq+g4NE/nQVV
	 +Dib54+LhyyCBMD9cHzaC+ktpnTFOOFSADoGke+ZGBANnVyuTIyrNTlX1GQ9d/JjMxUsm
	 sdOEZjzvMhCRVRUhTX4MjuzSRl8yt5Tf0ilSo94n3SukAidlhnsgg2o/20Fc4uTAT2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tJCNqvxi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D1606A321
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 16:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A44D1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tJCNqvxi
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c169ae1cb26so151936666b.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 09:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793290784; cv=none;
        d=google.com; s=arc-20260327;
        b=LrqkC/CRd7VCylzjsKnapL8I6xKtRADV3qDtgSR8nt53TbPL/l7G8t6fNWp193X22c
         qjKXY+//QYJPNM+fLXrnJGcOeXAYtTvWOd/nomtlTdxV6PtXyyTIdV8lMIoEtS7kSaaO
         5NHRhEUALjFJ2CqI4h3IVVlF0kHR/dIe0eCJyN3GPwAty8cCq9dGKNBdWoi5XLU+EBiN
         ZiNqHdQTFYgBpwkNKSDAltXZ2VzRwGh8bMcdbudF4E8RGbRjJj0shk11vk5d5Wf+u4ds
         AnvTXopvdYWuEQOCkhVy2wuOPf2APnH/0DEUvQ5CW6smC1iFWxYjaQ1tXE5AriJ71DwT
         NDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrLXGPOeZtKb/0Qmj4iU0Alw7tw3rFlIHiedf/XCtcE=;
        fh=PHxpW2NtUoQ1rh+iJKTxTXXTnO4ZPK2p8syPzZjloeQ=;
        b=L7LgszslE49WXLgWwleyqo0yyNuQD4pD9BWfmpwWg2618229vNhjHkr26NJXTL5SYj
         UKk45CqZf9ioB8+jPY1Vs9LTB3Gw0f7xsSAC9w+RQ31JrjzHe12aLq1bV1h+IzHtT4/F
         Iaum5VR0vMn3J9S1AElJFXcmB+/zAmrjOreJr0t2W0cA2OdwIF9GKZHw4mRF4crLy1hc
         jbDdp8K3Nopby4L1WhkChEWqKvhRoxlQ7HcCYsGIWAvJSyFXr0z8yjtROp47fpGmcHfS
         VyrDPRuA6eTOhQ6nr+/Ju0HnJPbsIiGYbjlW8shnMaUeeScQnk6eBnNOPtygj8yhR9Ke
         zx3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290784; x=1793895584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZrLXGPOeZtKb/0Qmj4iU0Alw7tw3rFlIHiedf/XCtcE=;
        b=tJCNqvxiSy3QxAKlEFW90cKUFyyBgpoSeP/Y5ousN6wPGZSrolLGcLaPbCYXA1fxRu
         hyVsewX0wFmTmBY8TlvUBE4oSRdUuvso9BOhMBlz92LV/gs0YdGdUPu/SeSx7yKSEgae
         DtK5weghFzRSq07QuSregfqRkrGn/HYN/qGVPOgb0V9un5TOuBcJn+HH3XRz6Qjb5Ymc
         h0a6dkLjD8hKH+4gxpX/7mtBpFAWTESYYmgPzoV9mN4JS+7JztM2c1PCNt/nj6uvIrHD
         pmt2E1fEsdla3c4dbYIo+nrE3KwsGfTJXjoEixBJJpLcsOlyR70ckXgO3VHTl+Le1l7x
         +gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290784; x=1793895584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrLXGPOeZtKb/0Qmj4iU0Alw7tw3rFlIHiedf/XCtcE=;
        b=ZrgsFbB9dX7Vt3HPlvpD2mfeWCCYD6ECawLHaIXIE5g6bHg6SktUDbbwXT8kHHfCE0
         RY/h7RseFmlNbZRohpnst2gXvJc3mhE35GTF75D/3JyDi3SvIbcC+I1x82eCXdVaWq0g
         zaf9m8m19F+QDJGX4W1YERBqtBtGXSCL+HEy4Ut2IFpPGYY3F6d3yn4WfO9mICz3xGb5
         IAcFoR9gWseMnvgubIpUmTy+QqN3Bc56wLqd+xtrV/4iNTcVSndRe5tmyYknqdc0ONgP
         QwwFxomoJpDmI0w4hFDVdy6oM0hj9eO2d/hCJPv38M3ZP0VYkDeMfw5rUt1QRSuhiCBK
         AgbA==
X-Forwarded-Encrypted: i=1; AKwUvBzSEdpnDZoYUIJ1N7uN8+YLI3ivpFkeX1ED0/2ZFuiXffD2f3w2lMN5QpW2gbWzAn1we5lafLzC0VQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgyYs2ur9FcXfVuvKzPhWTqXQDoUY5CHwmcTlmk+t6gUqtzfAB
	PjaNPM5f0x49VEpdYPvFb3UCPTaNswDh3+r7RzGMjBFbjAXLBfVbr7VvE71nFPbbGSLCMlcYRf5
	tMNdaSF3Hi02zzMTQQB5e0AwBHonfVcM=
X-Gm-Gg: AYBFou32ronjiWyITYjrmdyFDIiC+OwMHMPiswa02WmmndMq/SgUToFztL5CMw/G8ne
	BTOEgvqrsV/nkg9LOOVpaZJDmRBObwwT+rz+AkytiLPyWUQ+p0Cj7nJua58VbOp3wVze12E+ulu
	f72vudVG9FyyOJieKkzgc0SVGr9lq28a/YRU33j5CrceRThxAWLjXEoes/8hVJ4S2lBMfjGNs73
	N23FS9Z/4QambIZW1JnO11KYcqYq0by58IvFBu9aVM3W2h5R9ZHvzzuFbTs/p0fDGKJD9z3h5e+
	wPlKUEAEzYjsnPAtf8aiWygw3A0BJbbAeTZsHwyTrk1LB03C2QLuSPl9V4ZEZoee6g2Eh1mBA+Y
	FBO6HUc1GS8rEJEKOY2S5f7/D/IuF8a+OQgy6qGq+PSvGlqrrUxI9OC1B+nR6kftNCNh5o8F2kq
	y57SdIYXD8P+VB8GoT
X-Received: by 2002:a17:907:d489:b0:c41:4512:a3b4 with SMTP id
 a640c23a62f3a-c49d13b6aa3mr277245466b.20.1793290783798; Thu, 29 Oct 2026
 09:19:43 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260831151235.64076-1-notmissinge@gmail.com> <20260831232157.27037a5e@systembl0wer>
 <20260904042215.0e21cf29@jic23-huawei> <0d584595-4479-4116-a52b-710e01f20bb3@gmail.com>
In-Reply-To: <0d584595-4479-4116-a52b-710e01f20bb3@gmail.com>
From: Not More <notmissinge@gmail.com>
Date: Thu, 29 Oct 2026 21:49:30 +0530
X-Gm-Features: AclHuK-5tg4KowTUoVyHp9syWpuH0yweez4JYRJMVbYb4pI6PQlKfsVZtbaG4Ig
Message-ID: <CANU2TT4bTZYouZs=WWrYU=g70VcnjiBxBZRTh1fT3bqkbhz=BA@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
To: Lukasz Kulga <lukasz.kulga@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	Andreas Klinger <ak@it-klinger.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

Thanks for reaching out.

> I'd like to pick up SGP41 support, taking the approach Jonathan
> suggested above and extending the sgp40 driver rather than adding
> a separate one.

I have a v2 nearly ready (binding as a trivial-devices entry with
vdd-supply, plus a separate driver). Hardware testing on my SGP41
board is still remaining, so I expect to post it within the next 2
weeks.

I kept it separate because SGP41 has different commands, CRC-protected
two-word results, a NOx channel and a 10 s conditioning phase that
sgp40 lacks. I'll explain this in the cover letter as Jonathan asked,
and I'm happy to rework it as an sgp40 extension if he prefers.

I'll Cc you on v2. Testing on your boards would be very welcome.

Thanks,
Akshat


On Wed, 28 Oct, 2026, 6:43=E2=80=AFpm Lukasz Kulga, <lukasz.kulga@gmail.com=
> wrote:
>
> On 9/4/26 05:22, Jonathan Cameron wrote:
> > Whilst it should be a separate patch, the route here to use
> > trivial-devices might make sense.  Only thing that might be
> > worth documenting would be vdd-supply.
> >
> > I'm would be looking for description in the cover letter of how this
> > is different from, and not suited to extension of another drive
> > such as the sgp40 (obviously there are more channels on one than
> > the other so it isn't trivial!)
> >
> > Jonathan
>
> Hi Akshat,
>
> I'd like to pick up SGP41 support, taking the approach Jonathan
> suggested above and extending the sgp40 driver rather than adding
> a separate one. I have SGP40 and SGP41 boards on the way for
> testing.
>
> Unless you already have a v2 close to ready, I plan to post a
> series in the next few weeks and will Cc you on it. Your review
> and testing would be very welcome.
>
> Thanks,
> Lukasz Kulga
