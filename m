Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BA2264B0
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586642; cv=pass; b=L7vjj1CtMrn1Edk2w3MjvPIUErGnYR+RgnJRI6aZX8hHQ5g4YJz4f/axbibMSvSeM+920c8Tja30ClwYF/VsvLiOEYxqYUkw5+4AeigN5Gm79at8xy4leqcXA6kwKx/vunWjstsN6dpwehPKxhBE2UznB3Uh+eFoBx0PxQ4nMck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586642; c=relaxed/simple;
	bh=0gcp2Kh2vkB+bn8vLSfGrDjnK1YOMNrlzs2nZ54UV8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx5OhkUiFTRY8ZkJW+o7avDRRPXyqrPfDLjSJSJd5dFmO0ZrQAU8Sbzb0LsyNXRXC6ZOZ9wukBJIDaWnPb7tpkZQ1dbo/rNEIN7bt8D7/4+Wc0JhVzvJf5U68CY1viJNa8HjxmIjcxakdS6qKiTKarwpkv4H5J79eMRwirZ+y/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Gu1Ihor4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Gu1Ihor4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso1610396a12.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 15:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777586637; cv=none;
        d=google.com; s=arc-20240605;
        b=bSb1HE4iJbZRjPejsw26325TY4+wJhTq0/TfubhpuPxDPuP5b02Sl3Qi9PTha7LVMi
         fJL6pE7KpmxyUUD/xwJ56YKeJo0JSoSMDL9Z1ywNH/+4caZtlkAIgOlPAdsuWVnXOkAX
         2FYzHVR/SsVJ/RJtkE98ySOqGmdXn6Z0FVzxtDg7QMztRQyldP7AR+sNwu+tZolZ6/C1
         gJXMdcX201llFfORdP/mxgDtbB5WKDzO044AG2x34F45Gjzxpo9iq6p1HovW9X2jInlR
         8IdG903poEu2Z06SyBbFVfUheUhtYcM3Pl3cak5+pA1tkqitPhAgyAzx3R0qBhWyMpUs
         T+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=edxZ7rYbwQ1tkUb55t84u1KAvF5OwpsV+pYcpIo4yEY=;
        fh=/TUKgVvuTpHprPPKrSs0q1IfGrPw0eQuytM25Xm+G+4=;
        b=T9cgTHQgq/MKe3uyAySCq58iTxxmTLw2oSJ4gpKp0ge/Bgdwr+fr4xWXMh/CUiB/iD
         OgIW5Y4SZoXqVCa13dYAQznKwGEenYTEbJuOgNcHChVCQIiIsKSmA2pderpQqZ55uOvr
         ExXJPCVvt8D399+9zLjjNbvITuDDAH1QT0AqQBIc9bDxID+RZuKkZcTb7hv/k2I0bth1
         XQKBRx2MaclM4msYycu/p9SDdjdZdaINFSKezjXTPEZYv9mwrkyjPoWQn9NPfYkgpUrP
         8U4Twxfd4NSFaP2uokhgPcMp4DD1tPpZczFHhiyby103Zeo1sLz5CDDvPC938zbt80Eq
         qiAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777586637; x=1778191437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edxZ7rYbwQ1tkUb55t84u1KAvF5OwpsV+pYcpIo4yEY=;
        b=Gu1Ihor4TR4d4FiJhsRQuvy1XbQsZsoWrQSBKeDkkrgh28+Z8WbX7Fs0nW81TiyiNs
         I0BB6y4gpK7RWjC5dLcVqR6c94uMPi8yoxlPdgpSSpMXX8OQ54IG2xCMnLNQwaqK/gPC
         lXxC5ERUY03B3njNxPN0Js26wup4D/eCxrNAWDJqTKUJVbnn4aeFcveVUCEZZM1WW0Rn
         +UJ6F39lg5ybHZKQRstUstSXBIKlmUcBMrYTYcrPiXRGKMj26eq52BeTGXSbpAwdYoI/
         sEBI8IoYn8vEOEtktLYw/DmemlsSLxD+ofSLy65CN/jZ0OOHryLqnYCiYZavpokrY+fy
         9ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586637; x=1778191437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edxZ7rYbwQ1tkUb55t84u1KAvF5OwpsV+pYcpIo4yEY=;
        b=RVT5LM2H8edo8q9zvF2ZNKYfPIGvlOPlWWdSCx7f6JAbX7jCGiIXBK3JE8XUZtoFMs
         WlXGTw1KOUOh2W8qCpAkkfIdcOZpdEAB8nYoR/XTglwHmIg7c+9piV9lirxxsqjj8Uyq
         yVPutU7wJLG1Ikcq5FdoolpePz9+Y8jU0zQ8knR1/7u/r0mFh/l1gwi56np/0Cmva8WS
         IuypbqC5aKOIy5F6gFgt1tGn21FS0WoQMePXrOny1z/WxvRYdu30K6M4j9VJhQV9QmBc
         29wb+yFXr+uZRmwR11i2XtcWb+w6y2+xGaCspd4LXCgZ8j5XlGvAmq+fmXOU+cFFT3hD
         p09w==
X-Forwarded-Encrypted: i=1; AFNElJ+SbvDyr1Y75PCrpsvoLjjBCAjiRrEZs4CxVJo8RRnuixFeXN050yjIrQY336T0u1yHJZ+QB8hO+GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCZYUdOECkiasYJIF8+YIqUxvToDTK3mm5Tt503rsACPTfkic
	tzPuFOKKAo39JUuu5fg6Gv/EH0B6zY0dTgLrkOuuiPJWenBlS1y0HbGo+U8LMbWb3SJ/Rj1UgIq
	tJgWfJHAOzrZxN3J+t5GIFK2Ugxvhp/5ahbHpTsfm5w==
X-Gm-Gg: AeBDietUgK0KTdyQ+G1eZpMkqionJTgoXDjNQVrZ2aLfh/mJB/PqgbnoAwSt5j/02eL
	QYuL1/lWJPo6sL0GwaMmV/uD4lk624oPGcfJVVzBa45nuqM5Az79Z89iSNgKQytgqy1iAgW0x3t
	SUhv7X1olw0IwevoLxjh6vf69vQxCkXrZA+km757HCI2B74wOOTuZuh6QmSBbE73RObNALU02HB
	64v5Lmr+b5Hc91VPf9rF+wijd61lkgZmePI3XDZn3R7/WpsOM/XiLGPvbggGR953OF2XvYUF9zw
	mYt+jnyRScEmrSlz1omrkzpxbeK9KHSdDolklFJMjNSV/T+OKyukZJQPVstcRSrekqsgxOHETD7
	GxUdG
X-Received: by 2002:a17:907:8e0e:b0:bb7:dbd6:b401 with SMTP id
 a640c23a62f3a-bbac7298ef3mr318754566b.31.1777586636657; Thu, 30 Apr 2026
 15:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422210537.12127-1-jplinaris@usp.br> <3ab73ef5-0a3a-66b4-a763-398f0921c289@linux.intel.com>
In-Reply-To: <3ab73ef5-0a3a-66b4-a763-398f0921c289@linux.intel.com>
From: Joao Paulo Menezes Linaris <jplinaris@usp.br>
Date: Thu, 30 Apr 2026 19:03:45 -0300
X-Gm-Features: AVHnY4I-MQN0kxoHWbkLdEvKaX6VzbdgYb4NFFTzc3TZTZw3otQ3zO_jrz8RwP8
Message-ID: <CABAASXN_FzGLqojm-Bq8qLC8fnbbKnjzPvtRi6Q_-_Wk3HmJUw@mail.gmail.com>
Subject: Re: [PATCH] counter: intel-qep: Replace manual mutex logic with lock guards
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: wbg@kernel.org, Guilherme Dias <guilhermeabreu200105@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello. Thanks for the suggestions!

Em qui., 23 de abr. de 2026 =C3=A0s 08:42, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> escreveu:
>
> On Wed, 22 Apr 2026, Joao Paulo Menezes Linaris wrote:
>
> > Use scoped_guard() for handling mutex lock instead of locking and unloc=
king mutex explicitly. This improves readability by eliminating the need fo=
r gotos and by clearly indicating mutex will be locked only when execution =
is in scoped_guard() scope.
>
> Please fold the changelog text properly.
>
> >
> > Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
> > Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> > Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> > ---
> >  drivers/counter/intel-qep.c | 126 +++++++++++++++++-------------------
> >  1 file changed, 58 insertions(+), 68 deletions(-)
> >
> > diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> > index c49c17805..199a8d562 100644
> > --- a/drivers/counter/intel-qep.c
> > +++ b/drivers/counter/intel-qep.c
> > @@ -188,25 +188,22 @@ static int intel_qep_ceiling_write(struct counter=
_device *counter,
> >                                  struct counter_count *count, u64 max)
> >  {
> >       struct intel_qep *qep =3D counter_priv(counter);
> > -     int ret =3D 0;
> >
> >       /* Intel QEP ceiling configuration only supports 32-bit values */
> >       if (max !=3D (u32)max)
> >               return -ERANGE;
> >
> > -     mutex_lock(&qep->lock);
> > -     if (qep->enabled) {
> > -             ret =3D -EBUSY;
> > -             goto out;
> > -     }
> > +     /* Lock mutex while execution in scoped_guard() scope */
>
> Why add dead obvious comments like this. Please don't do it.
>
> > +     scoped_guard(mutex, &qep->lock){
> > +             if (qep->enabled)
> > +                     return -EBUSY;
> >
> > -     pm_runtime_get_sync(qep->dev);
> > -     intel_qep_writel(qep, INTEL_QEPMAX, max);
> > -     pm_runtime_put(qep->dev);
> > +             pm_runtime_get_sync(qep->dev);
> > +             intel_qep_writel(qep, INTEL_QEPMAX, max);
> > +             pm_runtime_put(qep->dev);
> > +     }
> >
> > -out:
> > -     mutex_unlock(&qep->lock);
> > -     return ret;
> > +     return 0;
>
> Why is using scoped variable of guard necessary in these cases??? Are
> you just making these changes using some tool without inspecting if the
> end result makes sense or not??
>
> Also, runtime PM also has guards support added (admittedly changing them
> doesn't remove gotos). But one of the cases seems non-pairing so that
> seems not convertable to guard.
>
Just to be sure I'm on the right page regarding this suggestion,
according to pm_runtime documentation, pm_runtim_get_sync and
pm_runtime_put, in the functions I changed, would be the pairs we are
talking about. And, therefore, if we have something like:

ret =3D pm_runtime_get_sync(dev);
if (ret < 0)
    // returns before the decrement of device's usage counter
    return ret;

pm_runtime_put(dev);

This would be considered a non-pairing case, which seems not
convertible to guard. Is that right? In the functions I implemented
the lock guards, I couldn't find any case in which the function could
return in between get/put calls. In this case, would it be correct to
keep all the added guards?

> >  }
> >
> >  static int intel_qep_enable_read(struct counter_device *counter,
> > @@ -226,28 +223,28 @@ static int intel_qep_enable_write(struct counter_=
device *counter,
> >       u32 reg;
> >       bool changed;
> >
> > -     mutex_lock(&qep->lock);
> > -     changed =3D val ^ qep->enabled;
> > -     if (!changed)
> > -             goto out;
> > -
> > -     pm_runtime_get_sync(qep->dev);
> > -     reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > -     if (val) {
> > -             /* Enable peripheral and keep runtime PM always on */
> > -             reg |=3D INTEL_QEPCON_EN;
> > -             pm_runtime_get_noresume(qep->dev);
> > -     } else {
> > -             /* Let runtime PM be idle and disable peripheral */
> > -             pm_runtime_put_noidle(qep->dev);
> > -             reg &=3D ~INTEL_QEPCON_EN;
> > +     /* Lock mutex while execution in scoped_guard() scope */
> > +     scoped_guard(mutex, &qep->lock){
> > +             changed =3D val ^ qep->enabled;
> > +             if (!changed)
> > +                     return 0;
> > +
> > +             pm_runtime_get_sync(qep->dev);
> > +             reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > +             if (val) {
> > +                     /* Enable peripheral and keep runtime PM always o=
n */
> > +                     reg |=3D INTEL_QEPCON_EN;
> > +                     pm_runtime_get_noresume(qep->dev);
> > +             } else {
> > +                     /* Let runtime PM be idle and disable peripheral =
*/
> > +                     pm_runtime_put_noidle(qep->dev);
> > +                     reg &=3D ~INTEL_QEPCON_EN;
> > +             }
> > +             intel_qep_writel(qep, INTEL_QEPCON, reg);
> > +             pm_runtime_put(qep->dev);
> > +             qep->enabled =3D val;
> >       }
> > -     intel_qep_writel(qep, INTEL_QEPCON, reg);
> > -     pm_runtime_put(qep->dev);
> > -     qep->enabled =3D val;
> >
> > -out:
> > -     mutex_unlock(&qep->lock);
> >       return 0;
> >  }
> >
> > @@ -279,7 +276,6 @@ static int intel_qep_spike_filter_ns_write(struct c=
ounter_device *counter,
> >       struct intel_qep *qep =3D counter_priv(counter);
> >       u32 reg;
> >       bool enable;
> > -     int ret =3D 0;
> >
> >       /*
> >        * Spike filter length is (MAX_COUNT + 2) clock periods.
> > @@ -300,25 +296,23 @@ static int intel_qep_spike_filter_ns_write(struct=
 counter_device *counter,
> >       if (length > INTEL_QEPFLT_MAX_COUNT(length))
> >               return -ERANGE;
> >
> > -     mutex_lock(&qep->lock);
> > -     if (qep->enabled) {
> > -             ret =3D -EBUSY;
> > -             goto out;
> > +     /* Lock mutex while execution in scoped_guard() scope */
> > +     scoped_guard(mutex, &qep->lock){
> > +             if (qep->enabled)
> > +                     return -EBUSY;
> > +
> > +             pm_runtime_get_sync(qep->dev);
> > +             reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > +             if (enable)
> > +                     reg |=3D INTEL_QEPCON_FLT_EN;
> > +             else
> > +                     reg &=3D ~INTEL_QEPCON_FLT_EN;
> > +             intel_qep_writel(qep, INTEL_QEPFLT, length);
> > +             intel_qep_writel(qep, INTEL_QEPCON, reg);
> > +             pm_runtime_put(qep->dev);
> >       }
> >
> > -     pm_runtime_get_sync(qep->dev);
> > -     reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > -     if (enable)
> > -             reg |=3D INTEL_QEPCON_FLT_EN;
> > -     else
> > -             reg &=3D ~INTEL_QEPCON_FLT_EN;
> > -     intel_qep_writel(qep, INTEL_QEPFLT, length);
> > -     intel_qep_writel(qep, INTEL_QEPCON, reg);
> > -     pm_runtime_put(qep->dev);
> > -
> > -out:
> > -     mutex_unlock(&qep->lock);
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static int intel_qep_preset_enable_read(struct counter_device *counter=
,
> > @@ -342,28 +336,24 @@ static int intel_qep_preset_enable_write(struct c=
ounter_device *counter,
> >  {
> >       struct intel_qep *qep =3D counter_priv(counter);
> >       u32 reg;
> > -     int ret =3D 0;
> > -
> > -     mutex_lock(&qep->lock);
> > -     if (qep->enabled) {
> > -             ret =3D -EBUSY;
> > -             goto out;
> > -     }
> >
> > -     pm_runtime_get_sync(qep->dev);
> > -     reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > -     if (val)
> > -             reg &=3D ~INTEL_QEPCON_COUNT_RST_MODE;
> > -     else
> > -             reg |=3D INTEL_QEPCON_COUNT_RST_MODE;
> > +     /* Lock mutex while execution in scoped_guard() scope */
> > +     scoped_guard(mutex, &qep->lock){
> > +             if (qep->enabled)
> > +                     return -EBUSY;
> >
> > -     intel_qep_writel(qep, INTEL_QEPCON, reg);
> > -     pm_runtime_put(qep->dev);
> > +             pm_runtime_get_sync(qep->dev);
> > +             reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> > +             if (val)
> > +                     reg &=3D ~INTEL_QEPCON_COUNT_RST_MODE;
> > +             else
> > +                     reg |=3D INTEL_QEPCON_COUNT_RST_MODE;
> >
> > -out:
> > -     mutex_unlock(&qep->lock);
> > +             intel_qep_writel(qep, INTEL_QEPCON, reg);
> > +             pm_runtime_put(qep->dev);
> > +     }
> >
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static struct counter_comp intel_qep_count_ext[] =3D {
> >
>
> --
>  i.
>
--
Best regards,
Joao Paulo Menezes Linaris
