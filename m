Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50C3EDAC6
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296062; cv=pass; b=E62Hw5dhMv4olJ5EKxR8sAmiv5hjHZxEWou3PbaZLAzxGJUZz9c3ksVpKyL7a5bdVknyJUR3fBwzPRw/HbuDxAcxoAl8gs4ygAh+ktyYr/EGQhP7iBGIQyoIZJ/fWDL92N/vbvlV6+3SkuxZsuyiZqX6lscFwyOi8bn7ZdEiQ2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296062; c=relaxed/simple;
	bh=K19rBt/eH95YRdsee0UXy9o+MxGzvrklTahRBB0u/C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN7U8ijqwxcPxsGl/0dVD8AaiXgbFt2xoDOncttKi1d4wDOgsqJ8coUAPpSqkhnvzfUgeerrNZIZQ1h6c/oY+3yXMNHmh9wNWzMDWSJwLBX88MPnqQPVR/2TLi0BIZhncD2bzkNY8Wy83t+l5pO9VinwInvf+hxHThVidpkGXXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXpH0cRT; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXpH0cRT"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c21049dafso4552578d50.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 09:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779296060; cv=none;
        d=google.com; s=arc-20240605;
        b=aAVDdbOKD4XFWBxlIwE3ZIG2zBA3O4wa5lSKSvHno15PeDB7/fdt8i+w0asg4z8WCE
         GXLTLQKOd/IOjvq3OGOJY9/6oFdB5lGYMllUQZ5ANlYi8xxVL4S1rKKzm4+FE+6OLpmM
         Ohp/JgPKNEKsPEQomEpapH/imYiRoM/GKPo972ELWkGwSA9s2V02V+Ebhl0S2n7aWtV2
         nSOPJUuMDnxojMqrmnygzUIA+SFry1VlPQrNQkWSZXnWPY1WCwzj71bPQQBOmZD4VE7l
         Vp9PZp/fZVEe2J9SRbFCLlHWPafnXdwfeIf8c1nZjYXkXus14BWYK/3E7kY8qPLAFSgJ
         hYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZQo0WZO+VD70ZUmL23PDv5v/FwowYXdPD6P8/VZy+o=;
        fh=e8ayNHkf6jPDCacubH9GsRzGQzRfAly7Y/v7MCc5MAM=;
        b=iBUfdGVviWxSNBPApWCqxpFnjnPs6Gl7k97ijY1dc1Dwun1PxsBWjH73NfyLoPdL9c
         eBarh25Qjr/l3gm5YSHHSwGVhpedyToebEcHtnO21iqYcqk9Sjv1ih+7LEnPJ/R9ouPh
         t0k8t1NtP1XBdGASiv6/i4c4Vf7BUVuMV8itYdmNlBvKkgzMwBGL+/fhg6/EStaJiYY9
         grWXiIAhFjviLJRw7kLs+d+YeMDbVWSiPgy3siL0SKdI5/l47CsVwGlqke6SCfsH7GLX
         rmmcn6KsMlJ255QUbqE6f2WmF0EOs7YKsI7CeTRpJjo9yF+5akXVxKZeM+p1WwGimqAz
         K6+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296060; x=1779900860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZQo0WZO+VD70ZUmL23PDv5v/FwowYXdPD6P8/VZy+o=;
        b=kXpH0cRTgdTj15ZNi21L1H33lFp5SORu/t+NO0B6mjBq7MbCyrYrhlZI3xREadVsXO
         /n+R77t7RK2STAdu9KgVPk+5KSuxL4Nh4i7+aWL+u1doX5N/nvSM4ojs2iNcI62FOlgC
         KVU8dcKRvgeBFSMkMUpj4UNG5woboc5a1wP88Ujule9h3EKo3QE7z3FopEAK0f2izyJN
         pnWTAkP5gH4BmzttQbq2xYKQnV8ZSV7AXp1RwgkWIkzytNHrEvxb4AIPOEYl8sudC4XD
         qD8zVAm8aXc8aHa0TNpHJ0MrAKMET/cqQ0lTochhhaZw9tdrIflLcmI4IyuL/mMd+Wyk
         zFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296060; x=1779900860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZQo0WZO+VD70ZUmL23PDv5v/FwowYXdPD6P8/VZy+o=;
        b=VtiC2XkD4sx0kYNrRvLLSW4jSRfOyd2iT31ZGHNSVuihI9v8qT8VuoJTQCcMusf0h5
         FeLx97Z3/5RnNDDaNlasunldCVdH5bLQmq02hE0OdvB5S0eMLXUOCsWovMvMNDqoFwrp
         yKZxkEf+klpEAoKQ96IpAclqvqekyTDF3s9LM2YrBsjOAy3HRIktS1li56zi7nuwL3pZ
         h6eOfAgbMxvgII1PdBw2RDTuPn5pvdAJWA5pXhz6qQoozSP/WW/eEwsmPZj3CgmRlEG1
         Wj0GR9I+zBFnTidQ2Rxa4qYwGTub4EcbpjRGjjsw3Pux6AGeQoYlM076BSdiy+Bvfq8x
         GwUQ==
X-Forwarded-Encrypted: i=1; AFNElJ++syj4Y7R9kKgX3FfltO1qsPzaLCvCYzXhRsN4XO6x3C0HvyAcyzOeuw4E6dqXzqRTA28Q8w3ehdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhh1SDr8ycO+Spka7mNT5NAoOfAFHzUKl74xjxGugvajgQquuL
	osLT/dhmQ4HUubveJJMlhMqjiX1688B99xPtOtNnDdu4cR2j6l/b3r4MtGA/lnQYBDgJa1xjvKV
	LSZJj69l9dj9CSDa5JaCPKdNvO5njuo0=
X-Gm-Gg: Acq92OHKUB035liEM84PTvmUkQVNSapQSVkWL7mSQYJAA70HPaU0W9/tkzIhfQu2Spe
	ulgDOKzcL4IavzBNjGXPkgLb51fvUy7dqgR6PO6N0962xtRw+HrHXersFO/vzP90t4ZsOL6gRFQ
	aa2fdNTFDJA/AIlBf5pFX9n3CooEYdHYmuRL4+JV7BWk58o8+jnLjF/ejvkujRLgAFiYs5wrj6r
	RXeFOyqMs/qq7knjlkoB0J60JD0OY0S5/fjWUTxV7md+HdXq3/31JWuMW+8Q1gk2oI7JfxV4hqD
	ItaOUw==
X-Received: by 2002:a05:690c:f08:b0:7bd:882a:43ef with SMTP id
 00721157ae682-7c95b82774cmr260994167b3.26.1779296059408; Wed, 20 May 2026
 09:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519131944.25174-1-m32285159@gmail.com> <20260520132802.34d82ccd@jic23-huawei>
In-Reply-To: <20260520132802.34d82ccd@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 20 May 2026 11:52:48 -0500
X-Gm-Features: AVHnY4KfTfM0M0PjrEqeyOTAfReCPO_VFNyUeXim1966ay9y6FJCGgrZQHxesiE
Message-ID: <CAKqfh0H_v+47GJNr9eGuAPc4ywdogFcR1YVUkE4FyPF_X_9pvw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 7:28=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 May 2026 08:19:43 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability.
> >
> > Add new helper function scd30_trigger_handler_helper_locked() containin=
g
> > the critical section for scd30_trigger_handler().
> >
> > In addition, small refactor to replace "?:" operator with regular
> > if/else returns.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> Hi Maxwell
>
> One of those cases where it made us look at code for first time in a whil=
e.
> The original handling merrily copied garbage data.  Let's clean that up w=
hilst
> we are here.
>
> Thanks,
>
> Jonathan
> >  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > @@ -579,24 +587,34 @@ static irqreturn_t scd30_irq_thread_handler(int i=
rq, void *priv)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/* Meant ONLY for scd30_trigger_handler() */
> > +static int scd30_trigger_handler_helper_locked(struct iio_dev *indio_d=
ev,
> > +                                            int *scan_data, int arr_si=
ze)
> > +{
> > +     struct scd30_state *state =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     guard(mutex)(&state->lock);
> > +
> > +     if (!iio_trigger_using_own(indio_dev))
> > +             ret =3D scd30_read_poll(state);
> > +     else
> > +             ret =3D scd30_read_meas(state);
> > +     memcpy(scan_data, state->meas, arr_size);
>
> Why is that a good thing to do if we are in an error condition?
> I've have thought the data wasn't valid.
>
>         if (ret)
>                 return ret;
>
>         memcpy()..
>
>         return 0;
>
> Or is there something useful in that data?
> Looks like some less than ideal code in the original driver but
> I think it makes sense to clean that up now. Just make sure to put
> a note in the patch description.
>

That's likely a result of me being lazy and copy-pasting some of the
code and touching it up so we can make the stack frame leaner. TBH I
would say moving it may be out of scope for this patch? I don't know,
I think it may be worth leaving since the original code did this. I'll
still check the docs later to see if there is actually something
useful in the data.

best regards,
max

>
> > +     return ret;
> > +}
> > +
> >  static irqreturn_t scd30_trigger_handler(int irq, void *p)
> >  {
> >       struct iio_poll_func *pf =3D p;
> >       struct iio_dev *indio_dev =3D pf->indio_dev;
> > -     struct scd30_state *state =3D iio_priv(indio_dev);
> >       struct {
> >               int data[SCD30_MEAS_COUNT];
> >               aligned_s64 ts;
> >       } scan =3D { };
> >       int ret;
> >
> > -     mutex_lock(&state->lock);
> > -     if (!iio_trigger_using_own(indio_dev))
> > -             ret =3D scd30_read_poll(state);
> > -     else
> > -             ret =3D scd30_read_meas(state);
> > -     memcpy(scan.data, state->meas, sizeof(state->meas));
> > -     mutex_unlock(&state->lock);
> > +     ret =3D scd30_trigger_handler_helper_locked(indio_dev, scan.data,=
 sizeof(scan.data));
> >       if (ret)
> >               goto out;
> >
>
