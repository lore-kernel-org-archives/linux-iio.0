Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C314AD0D
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590873; cv=pass; b=GKUYDu7Qq9xdKl/cDo2Tx7cRMQojzVzCoDQU9xKDPW7ZNPP56zwEqeObvlqD6Dk6+rFGKjzWaohUURDxg+9mXq27LQulRzJE67nJL+4rpIkgoFZAdp1wN8xtVrPVcTWVSzs/TvUiVqeNWklfR6U+FGupYrTlBBGyb/hRV3+JxpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590873; c=relaxed/simple;
	bh=I/N/K8WvFPQceqDzSD0crzbpbH6Dqlv+HRbp9QLvdC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAKWeWQDALb6W+G7EbwaVfgtx/c6iRkqC+CJzGcu9uMg9wgTconXIhby+eEAODsvcluYCb7vSxCQX2lwTSuywn1414CN5ZY9ANhESLA4UEJagrvNGht4TLMwE8l9HQtnpA2PLkB26iJ2KPdj5DRiTGuHqqaNotOshlRsKTdliF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LASGv/e9; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LASGv/e9"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393c93a01abso25728411fa.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779590870; cv=none;
        d=google.com; s=arc-20240605;
        b=AAJDYhXFscHz5/U3cySnw06yvfkf2+NmYGEhuqdKCuBy6DD4a86Odv9sRiXGQuJbMy
         q97V+4kJLxhSn3g26q1vhYlvImUaq0jp8ySzDsWLt7oPvO7MzuS/o/lfW54BHBBFV+ta
         rtYV9CMoRguuP7hIFkuvsO4vp/tmCeIdKIsRHRGkz7xiY975lASpid639r3rEpzAUMYq
         psJQfb4Cutei0w3fWlVoXxnMCLo98ZWsEnLCw/ef4Xl+4nbqwP0jAn4hfXy2P85zkk4O
         iHmc0xHDgljVfbz/KWrVyn5T7HzU7nPsn1oaApi/g+0wroUvgJLSzMSyc6HAj9ewhM9u
         dGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zvmM7qHda/oxQGoHR0NxIjHhHvelNuIoX0E+Fww4/EM=;
        fh=IUBVRv0LkA2fTmEdnXJAOpW+T8xzg3AtLoy/R2nvIWw=;
        b=F2UQShpyhAjsxqQOqMclvq5hFCUuclWSOCG7BRCoTfL9pYwlhKxFGE6Xyvj6rxS3t+
         d4wTPxqIpik+M7lCbzd5VeqDjhwJl6Z8FcMu2dwMN25Xbutc9tqDD5W1YI1fnhpqYhHN
         FvNHqcL8i6r7OkMJqIed/e3iM6WGxHvsUZoQKOfQjg59OMsT6fukzKQ68wjT7buTlzDA
         rRE0/HrdqI+2KfVEgxCBkyc7icYbCesEFbtrEw4Hhu2vbBiAOWoD9AiNltkeOyzPbgWT
         GkX8HJmPBzNR2OHjstWUVpeGAGve5C85GKmNmDc3dFoRsgVhP0dqR2usMZiIo9FURq7v
         PccQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590870; x=1780195670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvmM7qHda/oxQGoHR0NxIjHhHvelNuIoX0E+Fww4/EM=;
        b=LASGv/e9AgIP9Q8Aspf8xmei/O7go/HDBiZ3fxngj5173H1LpaTnxTujRtqO7I2yzg
         VAfnWl4sD1kWVeFj7OyKRZBCylaRxOp7w+5I3dToez+U/56oaa2MLVMeLkjbPIimrdBK
         d2CQhZGYMnPd54MC+stYCACeStkb+Os60xY6nyyEyOnTu6/Scvftv8IA0p8ExrX2sXxF
         wSi7dQyktZabRhSgQLKLSJfL6ynRdBy0DHV8ryqZUG76biVc5QnWEutQsNzaJ3pxlhex
         qF8sZONNJruJrUJi7XAL73hNDWqQvyqTpQamUEt3YYL1TAI1cxD/z7FZEDN5MmwkwInz
         7u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590870; x=1780195670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvmM7qHda/oxQGoHR0NxIjHhHvelNuIoX0E+Fww4/EM=;
        b=hUNDb7uqpCQMq8tRLB0n/HdtZelJZdWDHZ8dv8lCXupaTRvR4+xjKrcUxCWA5iH3+H
         XOYhvms99y4EN8AFcVfnqZggH/uApkDvDJhPFK6/MjhrjBHtre/PeAcTov7wQYjdm101
         ys0CxyCINhrYueNUEkwjjL/lChf9uq2vb07+Ar0i2s6LeH0UOPsPBA+fTWwKDL+dkUwG
         IKKuw+tlU5wMIR8rpCkU6qzOt3k10iuJHVOriBzKEOoVP/GhUfcKN5A7+G6CA3Pg7NaR
         MqxbzpfBXBqZzwv7mf7oEJ8GkG+0pdCPjDPxhEo4giPQH+qYdj4DSZY3G/Ly9Fn7WJ/V
         hTPg==
X-Gm-Message-State: AOJu0YygBXQ+dEQ81eN3qWe/7JrVPLxv4k0FDMXl7hoSKxkVmMfUTaKk
	Igk15jto9PseCnjEGhy8iTQQCURl+3C2ApamTaNjdpKvc4/QONPszSa5a/CCqnHOUaevHjtk/Mk
	3v3qutHKfmBR2dQGAENJH9OW8MrOtEws=
X-Gm-Gg: Acq92OHGYV9n7CfXggYKwvF8kuXSr+5pLXIspppyQxcqMwz2Z42qZ5cL2VhoT0sE5U8
	WxQHga5uiVk3Vtz3Gv5FeRCn2svQ9ONhGjekux/5Ubj4KRd/DU98T8iyOzl/WMjGdnKieFGPlB8
	KEzN6MAVQxkkC/lNxm1zMPLZbjz8x31kTWImsAKcoUuMl2qkZoCZf9dCCJQBO/1Yo06vJToz5aa
	PAcz0/vsteXCpwBr8/mBr0LLvw3f3CwN7cgOB0OMjGPahSQ/JuU/Dc5I18rsVJrq/Th2s2yncI8
	ojEp/8gnweJ6YvXjVbfC8QYFIOpjCKEfZpWgx7AB
X-Received: by 2002:a2e:bcc1:0:b0:38e:1dcc:6c77 with SMTP id
 38308e7fff4ca-395d8d9160amr30829091fa.29.1779590870041; Sat, 23 May 2026
 19:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
 <20260518220228.63322-9-piyushpatle228@gmail.com> <20260520112438.4b396652@jic23-huawei>
In-Reply-To: <20260520112438.4b396652@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 24 May 2026 08:17:13 +0530
X-Gm-Features: AVHnY4KRxiRMaLEFB1hv-DFh55J-HHbP41FD40lpNrpCFFnEtyo0HaJITqXoBrc
Message-ID: <CAMB+xkaeNGLv2nGs4gkGGT-PFpsC+Vy=N_wUgga6mRbjSaXQrA@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, 
	Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:54=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 May 2026 03:32:24 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > Separate the initial value assignments from the declarations in
> > hx711_read() and hx711_reset().
> >
> > This is a small preparatory cleanup before the later loop-iterator and
> > variant-specific changes adjust the local variable layout in these
> > functions.
> >
> > No functional change.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > ---
> > No change from v8.
> >  drivers/iio/adc/hx711.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 30e1ce321747..9e5cafa1e307 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_dat=
a, int trailing_pulses)
> >  {
> >       int i, ret;
> >       int value =3D 0;
> > -     int val =3D gpiod_get_value(hx711_data->gpiod_dout);
> > +     int val;
> >
> >       /* we double check if it's really down */
> > +     val =3D gpiod_get_value(hx711_data->gpiod_dout);
> >       if (val)
> >               return -EIO;
> >
> > @@ -204,7 +205,9 @@ static int hx711_wait_for_ready(struct hx711_data *=
hx711_data)
> >
> >  static int hx711_reset(struct hx711_data *hx711_data)
> >  {
> > -     int val =3D hx711_wait_for_ready(hx711_data);
> > +     int val;
> > +
> > +     val =3D hx711_wait_for_ready(hx711_data);
> >
>
> Trivial but no blank line here. We want that error
> check closely associated with the thing that set val.
>
> >       if (val) {
> >               /*
>
ack! will fix in v10
