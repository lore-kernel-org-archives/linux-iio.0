Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25870346E6C
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586515; cv=pass; b=T5ozSXk1u4f2xzrDhYNVAg/qcxO1+PfYO+Xzx51bt2ycpb7ynLgxbqx/GxGS0+9fJJ1zZGU32X/1bt6tXQbN/ThAwl4fptTpJ2FVwBpdbcs3C1CG/lhEUQQvjWf8tnz0iWBb53E8hKvBC69xIp2umsilJB2baakzRciXIO3xuO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586515; c=relaxed/simple;
	bh=8IGUaEQ+keIZ4TM5onHqG1U0qvZTaz0TvwMkHKDQzeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As+rvBIyaiWXcu0+pl5A5v4trGYZlsssOSbRzA9/YA2gvzMceha0R1x7gkpd1BHPGLbMFqd/4FFBRq80a0721uNa5cLsDAoG2v11atdRzWFAfuGKUAN+t/OA+DcxKsByjcQ/ZLJxvWqtgzlcW54sjMFOQ2bCwkJ+BvzyOpj+U2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnwdV1gp; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnwdV1gp"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd65714dcaso56807087b3.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778586513; cv=none;
        d=google.com; s=arc-20240605;
        b=cTQ1zEEC/mdNC2o36Oit59IGPh0mIeS9CTC5lDwsYhi6yXp4fuoy7zdOn7ddwnZnVh
         p+elxvLHcbhzfDNq8yXlUdXJzbLy84I5vC3RQRa3lEyTOiCBp1Raad/SVumk+6X9AjF+
         XHRtck0LuVESLMA+SOpRyugoI+0z6S6LGqhoalS0J0ptP/ImjxDCmMzYuXCvRy8K8yeA
         UXx5vww9ro8bzqY9XCn9dRG5M4wRwrXe2HfVzZIyEc9mJ20hx9np7zFEEb35JsbI/6nq
         8lM2JrqxPKTTMIT1TORhGSuGTnXL41lX6iwxV13JyPHr1BRlHYExzM04/ZVb/+5BHKu6
         TfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nRlqETVoazFEU9vYApN7ZFYUabXQDp+3hYGR99dIJlg=;
        fh=FHpkvdfO23AXkDPaexZVuR3LxMqlOjS2FeHTfoA2/g8=;
        b=bk+golPXZulMYcl8NsmPGMUDFf0kuBGC7SvrY6Iivb3qAJTDODX4um8lgA9tjP73D8
         BgGFj1pNqZcTOtGbm7vn+lO7obyQ5hffUZRCCVqogDLoZ7EVSX16VGQf5Tq+2ywRajhc
         ByTcYPfZzpT33W+XbeUXyOb0TOqOqX9rw9vBbhNGm7OZu4mRtmD23U2RQcDMuPVYLlVn
         nQKbz5hYRae0lzrB7WCYc9gcZlzREMC5712IdsU9l/x6d2kzUHGBOhdxer+UfAdK6WuL
         AhzGMu/dmgWhnU+2IWTkwp537HlT0kg3u5p80zDjvkucknPz0wN+3uDkfdX9k3qJ29J+
         mJaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778586513; x=1779191313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRlqETVoazFEU9vYApN7ZFYUabXQDp+3hYGR99dIJlg=;
        b=LnwdV1gpuB0Uc3NYSnGGG8SbTIAydbAb+S3pmXcKh8vvK3wKnO5NN0IMNgU4Kg69OG
         df92I5vBrHpcEecQc1YPJtn9PVwiypR0hTwZutCt/sC6mlR8c7oTv6fa+qUHr3cv2L1p
         m0Dizp9lBkjqjJ4b6y5YV8RdVkTyI17qvZ7CtXDfoSClaMyF6LvsRo7228tL1NvNQc8D
         QnSFdKX5f2uWJDh24kIrlA8mbu3KrwruxZkUpsqhvc6rNF0EmobpMFbr3BINwWJQs6X5
         A11k1DXBtCvhgo1OVGx+N1E+9ZTyeV4miSNgxfXUTqI/duNts0xF9Y9W40FgkbjIMLuA
         8QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778586513; x=1779191313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nRlqETVoazFEU9vYApN7ZFYUabXQDp+3hYGR99dIJlg=;
        b=maWeRmdPp4Is7n6Lk+ObrMBCHawLGlk8ck/mdJpme9VdZvzU1zucrL+i9Ce+tahMpE
         8UUdqQmwbOi92c2eK89ePfWmNsgmXdLTGVz3sidhTQm9GWbeJbMgyesiQ9HpRs5IXLzo
         lw3JlMHQ3TapWJnT3ut7mcf9gU0WLtSAK0oONZzqZqvD3cSNaYmi8FffS/2mVb+EiBEX
         AzLxv3yU9nTO7LoH37hO0uiN/aexzUJg0fuVsVBJFZCMALBx26RRd2ATieuXoW68iOa6
         JmeqIH+TC+esc+Fk3DAq7peRORu4URBO7nSfDBls/8G4SbF4BiudE52YsAV06EUAEn0a
         WdKg==
X-Forwarded-Encrypted: i=1; AFNElJ82YpaDD16Ff7cI+rQq+x2NxeNwqs0KrKALwINySed1p4IvgJOrxVub+hafOeJShLSWc9QskA0UbRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN05gB6cV7CitShcgE2FXMTjEBhvv++Y7Ol1xu+MPyWxYpQ++V
	KfCLjKkGclr/MUBLqCs1FBYtWB9ORdpmQrf9sJJEamPRt12dgWJWLcQNVDEnIYTaoD+DZ1KxUYZ
	3/Cijl71NCjzUNqG7V4/k6ga1XVygF24=
X-Gm-Gg: Acq92OH5VxbzEYjxYWda3ei8Zd3x4NVqF59vASuoBlPgHQ4eRTICrFkavSrZ49JosoJ
	o8JpTR3MO3GXA/3hGyhXXRdyoqKXMw49F+8mHeAP6kGQvRbFpaUwKswKkAEAud9tMU9yuTorUX3
	Kn7KLjWSR1GbQ7Hnn/OzcqqDwche8WfjlDwAoECkUdEyc9ZJzH9eMWKvt6TTzTc77MBC/Dtm+kg
	ji+a0M1lGSGgF7Lytd+Q0Qz2ar0H2Y8A45/0glWdIzmRurZx1IXdARkEPxwTjjaIuBbqn8bOR2k
	soPN
X-Received: by 2002:a05:690c:6d83:b0:7bd:73f3:7a67 with SMTP id
 00721157ae682-7c104dab235mr127731097b3.28.1778586513117; Tue, 12 May 2026
 04:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507223337.48437-1-m32285159@gmail.com> <CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
 <20260511181749.32d64889@jic23-huawei> <CAKqfh0GHY_WkiLQK3rhDYtvyab-iQdiUmGFHnYjix=K3xLXJ8A@mail.gmail.com>
 <20260512121703.54a7c2aa@jic23-huawei>
In-Reply-To: <20260512121703.54a7c2aa@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 12 May 2026 06:48:21 -0500
X-Gm-Features: AVHnY4L1bEy7hbv02OFVPdGIO4q-4O2PsbES8hfhCi13wNgechg3G65w5fA58X0
Message-ID: <CAKqfh0HfX-O6Wei3tDm3bC1niQpUCY+g2OHw6Ry3qTTbFSNv7Q@mail.gmail.com>
Subject: Re: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:17=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 11 May 2026 12:27:27 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Mon, May 11, 2026 at 12:17=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Fri, 8 May 2026 08:03:45 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > On Thu, May 7, 2026 at 5:33=E2=80=AFPM Maxwell Doose <m32285159@gma=
il.com> wrote:
> > > > >
> > > > [snip]
> > > > > @@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct =
iio_dev *indio_dev,
> > > > >         if (state && data->ev_enable_state)
> > > > >                 return 0;
> > > > >
> > > > > -       mutex_lock(&data->lock);
> > > > > +       guard(mutex)(&data->lock);
> > > > >
> > > >
> > > > Correct me if I'm wrong but this looks like a TOCTOU race, was
> > > > reported by sashiko at
> > > > https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40g=
mail.com.
> > > > If this is a confirmed race I'll get a fix out this evening.
> > > Indeed looks like a correct report.
> > >
> > > Take your time though. I'm swamped anyway so will be a while before
> > > I get to any new patches (probably!)
> > >
> >
> > Alrighty sounds good. Dunno if we merge this or not and then send the
> > fix just in case or if I base it off of the original. Former seems
> > preferable.
>
> Given we know about it the fix should go first then this change to guard(=
)
> etc based on top of that.
>

Alrighty then. Will send that then.

best regards,
max

>
> Jonathan
>
> >
> > best regards,
> > max
> >
> >
> >
> > > >
> > > > best regards,
> > > > max
> > >
>
