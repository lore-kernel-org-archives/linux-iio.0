Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795508310;
	b=5JhgmocXNNcfKAnLUXKzgrl60JvWJEuAZDN5v/mn9MmkQoAO3pRRZHOcwYkbkeVqn4fY
	 JkfJHQN8CAsA8EGXsJlK+8+FAivI+OrwnBWn9O5UtiWAiNGRFt7lWOPQ6LH3agiPnYwMG
	 tkx5Yu2ngFONgAeOYTTx75v/lSy+olfQ4yQdGwmrbkct4F+nI8opQkQ8ObxCFfD6ehtTK
	 3QesAgjfTpd92KzZqS4HRq/K7jllYr3dXQ1QVwpTf1ghCbkg7DyKxaW/j45TXWL1Pr/lL
	 Q0QHBVofZRQwXrZROowqPbC1otwd/1VhMWNnkzAQ7fgtLMMxFLRuHi8Rhrw/SXuUIow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
	b=SuUU5xHPEIdrjoUDcIdgxuI4/dfCNvEvOMVuzQGqGOrEcelVlcZqMezx4R03Ju4YYr4q
	 aYGZd/yf/fRaAOlGy1Hduf/qvAmxsP+zLIwxuDG6rs5XjJMbJ7X/8whWep6Wvn84lGxfb
	 OYYwB5IvIH76ltqRjecfl4NqT6zUsTaXDvB1kVS7+tbBL2UyWxGzhyxiwWYqqJUwTX35k
	 QYiGn81wsAlfWoyvCCS5+UtCW5HfAH7bLuLJ/bBjeUpZL54iymmYyBEFaFaT5ly5moZzp
	 3G8CGbTomWzZfGJKl0Yumsy+mcp/+1sn0A8LCuztpkpB5fTKKbaxjNB9tBCP/oGaxVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ll7ATE9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B082606A32D
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 08:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B082606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ll7ATE9C
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4d6981c67so26154047b3.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 00:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795508309; cv=none;
        d=google.com; s=arc-20260327;
        b=UmKbNqmxTJINP40a5qs0upyygTba8X2+JdYrCWclg0odrj0n9Hd2Ybg05SrVZUw/TR
         srl6lTa3isENH1Pp14mCzqIpDCuGcj+gJ/g29CejJq4Dogfop6BRxxfu46Heg66fcNJv
         3arouM93ifQ/vUSOUxjUcI8sOEJ8/GEii4+SynsI74WzqVz1AtN40p5p+6/DFTkQe4Jv
         SlhJn8Wfl1SbSgjA+H/Y0t3gtYT5K1FPsImbXcO8OG/JDyi3RPcoVnzY/5/tV09Q8MmK
         6tJNtdcxHbtTr6DViUDDgll8cSPHah1uiPylaJAPoPKhEpNfxorQhy3k3diXhQtliBvc
         qapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        fh=EFHCHrXDZkNRhYzH8dRrNmQBPuTMtmrBjOVOppH8jvg=;
        b=OdCciwsHv9OosbRE4fAZkOmV0dnsRpQGrFOilg2x4Uj5hX0muM0enLypSSV9R5qEPF
         8nirnqbMrmZr3vWYElfVEIcNuRt9kGxYgWxsSK9FhNE1O/BLw/ChRVJ0XWH+w+20MTfz
         Gog5L1EoZlpwMSjT8Psix9s3BvvDGs/aS9byYASISlwM6sO1PlwHVrRxGciaLIdfZzL2
         FoBPocPDmBTNWHv5AoX7UaUH8SjvCysl4a9JAYKhwFjaTG3jY03ah1Q/OxRIsXeb8Ij6
         OoF6rndtC3VNZ4rYHFmnO30U4d4BujMwdUyEinw9X5w3217LJPirpvoPXXz+WbUp5bj3
         EMow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795508309; x=1796113109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        b=ll7ATE9CKmIrwUX3g3Zv2JC7GAtNOZPkvnuuZRvuDOQVJHCfRZS42uyl8Ousr70zpo
         E+JUXVypDwOOTGzcQpXv5AfZBKFGfeLzBF8+2RNAVgngMOQcHa1vmynvstej+4s9Mgzj
         SX+TCBB1uf1lgyrZsPzNDT9hxJMfHhmuuSPgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795508309; x=1796113109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        b=qdhKw3uqRdVMY416TO2v0uV2L0n8jOL2loJ9Chc+HfitlqV6LUfUMGCVDm1HMFSfjM
         NKzpHJsGsI9E4i8FvEZAYPjl2kZV0Vbd37fEZtWb2pwnq9+J297ruMZkvnACUl2jtcrY
         OJ89kv0L+O/E/7YPxgi8qElt24WZXZXtn3hsWUiuncWBLQuYq0r8KV/5aPStaYQ3vCWK
         tOJPM7Rls1q2jAMzcoiMq7kstTaVjcLSZ4R3sv6CyUJ0puq2MhxTYLNjWXPbeQIqHIp4
         MTiBc3fnJlD7gM371wWLa3FJocw2+dZ5jJqM7EMvxEXeDyZVEX80JES75lJZPysOgQ8Y
         99BA==
X-Forwarded-Encrypted: i=1; AL+hErG4tacmjMUwcKgxFKqZpG8jO+z072bQ8mzKMzAQVenoZUk45KMMapuC/s+F5pyLj2tSkHlepUMk1Ms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rh35oj2/XllMnrwkEG+uN9CYL2jro9YH/izokyLobPzZIKBjC
	ceIKREMeTOhOZID3rUqKkYAglhlPCkNenfQzwGwEGjgW+6uOE4/8jYSMHhSvgJwZJ4vGUt5FRhX
	j0EQ1H5wz6U4+6k9c+nw61zElc47AC2WWAajZD1Dk
X-Gm-Gg: AZFdTZeNzzSTg8ZxAKaoPViPAROtFO8JN+PdKc3BdB8zl+k64himPFslylffkKgeq1w
	sGQv2Am9KX0+ZgbdHLwGLpFJHH5p9WeRgD0wB7pGTAr2SeW5YPfh0oxUU15Y+pN5BTjlSaI1r8Y
	T2xK0atxAF8IEg8AWO8qErR9p0RKpuneXXkFz2RPmOOVeRIHu4yqQpWfW8e5Iv5XI8vD5cve+J5
	jWwSoLvZALmzO78AOiP2GF32HZLZwnjIhH65s8WApgpCYwfdsNmkV6NVZPUrlZHzzlizUPb0/Qk
	YA9i5qfoBbQTrT3bM5dQ3KB3gQ4RQhlKg/oyP2ScU2DoUw1W+GujCj5fTMcvvWu/MXDBz97CiHi
	tI3vS/542MGzQUvl0stAZMIBK2siHpZr4EZmvGpdaUcJYbJC5OxHsmLHGFWadkNHhZdQ=
X-Received: by 2002:a05:690c:998b:b0:8b0:9f2c:cfa0 with SMTP id
 00721157ae682-8b5204d651cmr57190517b3.44.1795508309300; Tue, 24 Nov 2026
 00:18:29 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123113755.3033436-1-wenst@chromium.org> <20261123113755.3033436-2-wenst@chromium.org>
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com> <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 16:18:17 +0800
X-Gm-Features: Aa3M54qAJz3E4lCBf4pR4hRw8s7Agur21vfzxnOB4r_CYaJwBGfQ8glnAjpqec0
Message-ID: <CAGXv+5HmXyVn6dY3Ve6ot28p=08giJ00SoXmpfcaSLoZVgbCyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 4:00=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Chen-Yu Tsai,
>
> > -----Original Message-----
> > From: Chen-Yu Tsai <wenst@chromium.org>
> > Sent: 24 November 2026 06:20
> > Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in enable=
/disable stub functions
> >
> > On Mon, Nov 23, 2026 at 8:36=E2=80=AFPM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > >
> > > Hi Chen-Yu Tsai,
> > >
> > > > -----Original Message-----
> > > > From: Chen-Yu Tsai <wenst@chromium.org>
> > > > Sent: 23 November 2026 11:38
> > > > Subject: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in
> > > > enable/disable stub functions
> > > >
> > > > The non-stub versions of pwrseq_{enable,disable}() are no-ops when
> > > > the descriptor is NULL; however the stub versions always return -EN=
OSYS.
> > > >
> > > > This would require more code to deal with on the consumer side if
> > > > the power sequencer is only needed for a subset of the supported de=
vices.
> > > > One such example is the rzt2h_adc driver. Only one of its two
> > > > supported hardware blocks requires a power sequencer. The driver
> > > > could be built without power sequencing support and the other suppo=
rted hardware block would still
> > work (provided the Kconfig dependencies are changed).
> > > >
> > > > Align the pwrseq_{enable,disable}() stub functions so that they als=
o
> > > > return success on NULL descriptors, acting as no-ops like their non=
-stub counterparts.
> > >
> > > Could this make debugging harder? If someone disables the pwrseq
> > > Kconfig option, the stub returns success, so the power sequence is si=
lently skipped.
> > > The resulting failure (e.g. card not detected) would then look like a=
 problem elsewhere.
> > >  Should the stub return an error such as -ENOSYS instead?
> >
> > I think it depends on your code? The (devm_)pwrseq_get() stub still ret=
urns ERR_PTR(-ENOSYS), and if
> > you pass that to any of the other stub functions, they also return -ENO=
SYS.
> >
> > This change specifically targets code that expects pwrseq_enable(NULL) =
to succeed.
>
> Can you please point me to a driver which expects stubbed version of
> pwrseq_enable(NULL) to succeed?

It should be the case if the power sequencer is optional, or rather only
needed for a subset of devices supported by a driver.

The rzt2h_adc driver binding to "renesas,r9a09g077-adc" does not request
a power sequencer, and thus calls pwrseq_enable(NULL) in its runtime PM
callbacks. I'm arguing that it *should* work with stubbed pwrseq_enable(NUL=
L).
Obviously, when bound to "renesas,r9a09g057-adc" nothing is going to work,
because stubbed devm_pwrseq_get() returns ERR_PTR(-ENOSYS). But that is
expected.

The rzg2l_mipi_dsi could be another example, except it works around it
by putting the pwrseq_enable() call together with the pwrseq_get() call,
and both are gated by a hardware feature flag. And the driver never calls
pwrseq_disable(), instead probably relying on the implicit disable when
the descriptor is released.

A third example would be my USB pwrseq integration [1]. Power sequencing
support is optional, and the pwrseq_enable() call is currently gated by

    if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
            return 0;

which would not be needed if the stubs are no-ops when desc =3D=3D NULL.

And there's also reset-rzg2l-usbphy-ctrl, which has:

        if (priv->pwrseq) {
                ret =3D pwrseq_enable(priv->pwrseq);
                if (ret)
                        return ret;
        }


Besides making consumer code easier to write, I think another point is
to align stub and non-stub no-op behavior. If "desc =3D=3D NULL" makes the
call a no-op, thus implying the descriptor is optional, then it should
be a no-op for the stub version. Different behavior just makes it harder
for users to write code around it, or making POWER_SEQUENCING a hard
dependency and not dealing with it.


ChenYu
