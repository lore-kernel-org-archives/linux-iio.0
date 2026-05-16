Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC43E3176
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950805; cv=pass; b=bixr0uis0PmGF3fTxhT6PHW5+A8Y9exTdydODkDokNGXZP811rYmjeXyYJC4nglJcMEr2NF+G9m2H2oRvcG6dMqfIDZuPPcPdrvAQlnrtD4xuKCMZ86NtbO6kDJnCIBfBRCcPeF+Uyow740CawRbgPzUqxrc9DWWo6z4WbHwf58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950805; c=relaxed/simple;
	bh=CC2h+Lfe3Gq43vu2SMkYhwfznuDJjOKQJx7pS1AcJxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdoYOgbhAMtmUcZdMaB2O30CW8VXqdwu5YgZDwOYrGs+Lqtd8mCcJumKZOzPE+0JnCePN8LrFzkEcjZwMv1ORmuQ+mQhkP58IIXMEH5oC/sYbN2DeGzHHMIW06aSRNpACfuGS0rjFBaA96Xvt7u6n8S5JjOJ00ErRtoK0YyJcTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf+nP/D2; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf+nP/D2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso425859f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 10:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778950802; cv=none;
        d=google.com; s=arc-20240605;
        b=lV83J6RVZafTZHTbEmQzH//ImkVGyKgtG47BUDTxDcXVm5S+mAHr+igtwXv9hxqS8c
         i10z/9+QE8zMsRzvnnd8Jkjsiwa2ZtwVJ1WOLumRTQqGFvXscsjDAON23lL9pnUuA+ER
         ScH5/GBiftIqABUa+iyhZibohs0kMWVIR3x4xhwTLO/25SE/0kE328gojkUPQd+5KSSd
         jPpTNQg7esJ/dWgpKxIKLQ9Cz1TAn3HBzPp5fboQQFHhsPyNwZsR3nbmhVTjLAVmSNUO
         aU36eF/MCXcf8bdKWDRrLl7ZhhBiFHEMVfzkjAEENcE7oKLjK0ksCgyslv8CrPvok1d6
         wfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FxgVFevhl+/NzPDksmIzUd7ycRy5qImyHlk43cpNHu0=;
        fh=w8rQGgA56TeCwghF6gTswDFUI8hOJv3lYeNme4GPhgc=;
        b=GncRnccMps8FqH7insGPK2OZQqiDf0Xmb91lSz1iIH6ouIgpng8B2yBAG81ZtcI2iZ
         mFuWw5EZkBSYMiSv6ON1C7JHDbmzRytr40c5aSyePFQGpmTjJ7gZiI65pcYmEnSjEUSj
         OkjP4E+4DgII91CaKQUh5gVCt+fDfOadN8kZh0B2L6O3mGS79S0i5Vdz2w/7XTrmvwgx
         RGHJMfhyNpi1zfR2iwB8yO5q2W/GU4tSiBocxJFSL0uRy2NbIoEhicJYydGUbQYmihzE
         54IJWEiphBkZcKc7TrJ1DeBvKYfemg2uODmcyL9AJn4vEMwUuvOax9C8KjsOVG2I9WNc
         uXbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778950802; x=1779555602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FxgVFevhl+/NzPDksmIzUd7ycRy5qImyHlk43cpNHu0=;
        b=Hf+nP/D2MAuUzMvq08Ddv0pcrXzFFw30q0zConWVYyTHHyR7CE73QlV10NBhd3R1V7
         7sCLr4muCcR2TWeC7oHFD8M3zNxd4LoY1KuurfY49iMQNZWFZ2f/GDwXrO+9upSXV5e/
         8OvahRBZgMcRc41SjMJtwo6isyuV6JkgBshRDGqVT84N6FlMfBzfe6+1mBTsVXeryr5L
         WyN1tqJ4msgClb1Eiui1CCUuFrAEymDFpcAIL78z7c0kM5mfWQJVS8F9CvGCliaKrgYB
         QbV4jn2lC46Pn6Ew6DHM/ao433fwhVQ14KKvMy76AHnap98lkRprn5DE/IAhQfq4Q6IE
         DZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778950802; x=1779555602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxgVFevhl+/NzPDksmIzUd7ycRy5qImyHlk43cpNHu0=;
        b=H/Y13fr9fsHwECBn0sAOqYAl9CYeFzwLzE5qvXYkReKxW/Wdeeg90dSg9FEdOzb8T7
         7dIFuqNEUH/AZjQPdunBC0Hx3jJ9ruuGFyHzLYQbnGgxtIKnUpzJsfG9WpQodqnWycKl
         /2JIMfCiY3QjTexbs/R36ZSG3iXnQpXlvxSKWnewa5ixKVUQdZ/a5BuwnhSCeJw8W6wX
         WlN2oxP67MJ9nHhaUQM6C+0AiFPAeKXfENFiPb48KU3LFpEtkH1WU2RgG4YuAigQpFz2
         Zc83D79bqecrbgLtpTgJEoQIavL+vynvXCZA2787IM4+6YDRX+lU1GnpXvhpQv3+MMD4
         E+MQ==
X-Forwarded-Encrypted: i=1; AFNElJ8E3EOZWE+4goD9lY4upB4Dr8MycLo7+WRxtxAuMCeRsWDvf/7EiYFLnwvFp0plAh5P6W5usu2VbUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPr7WHGn1EUFKK4rn5NvQ0wbPxBUUTaSXscAcn/2gEKJD199oc
	bK1DgzfhUjY85rK4O1mLDLk7/yXugsxHF3jV96B8hyIdVdPombiRoknlscf67Xn3pjwJiSsUEVL
	HnixqbKbZjAQHX3AlcV76RTEUje1U0Nw=
X-Gm-Gg: Acq92OGO8LWmQGIz3w8ftomyXksIPajs+qQoh2PXp6yqG3mokujd66Z0WNJecYiJgVl
	2HO2WmYmrmNbQPOosSaw0Mqtf7+RMPOJe5rmwPgETc9FXvWURR94yM7ILG6J7nDrrGYbbGI2k55
	zR//xbLgfPBIpSKaYzRAiYgTjlNKw8PMB9gYWXJxlfbfMbWiz9q/r0FV/2n0t6QpsRJck+SR1bo
	fpzCQnCTI5ZgDy096r/7Uy/CxvkQNUVsuPVm6iG2fcA2pF7F/yx9vHu+8R8ZxaNrE18bS2Tv/Cz
	QN6sIjui9jpkWqQIfL1RbCLr7BACr0OdlCiWHNasUmnzBkHOEOPGBhMgurDb1rMDplNtZ57FxSk
	Hs8RqFBhPKY96/NEaC/ynKWxcUglTQlkZmpdKDNwkDk1GDOOWXiB3CuMYBXHxp4/YUGmWkW5TRB
	3+1SAA4rg=
X-Received: by 2002:a05:6000:2c01:b0:43d:75a2:44aa with SMTP id
 ffacd0b85a97d-45e5c5db0f5mr11689935f8f.43.1778950802021; Sat, 16 May 2026
 10:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-8-8018cf3a8a0a@gmail.com> <20260516130537.78255297@jic23-huawei>
In-Reply-To: <20260516130537.78255297@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 16 May 2026 18:59:50 +0200
X-Gm-Features: AVHnY4IjYeaLNZZx1mmQsYlBa2G1EUb5CEdK3XBoYTRsAAwBoIMocV-QGM4hM-4
Message-ID: <CALoEA-zAxvO2rojhn4R3i3-+n5qun+f-oQ_3xboqQUPah47ENg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] iio: light: opt3001: move driver to
 guard(mutex)() use
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 May 2026 at 14:05, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 12 May 2026 12:57:28 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Move driver to use guard(mutex)() macro, to facilitate automatic
> > locking/unlocking of resources. This modernizes the driver and
> > improves code style.
> >
> > While at it, remove unnecessary gotos and return variables.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> A couple of very trivial things where I'd have done it differently.
> I don't mind much however if you want to keep it as is.
>
> > @@ -615,18 +601,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
> >               opt->low_thresh_exp = exponent;
> >               break;
> >       default:
> > -             ret = -EINVAL;
> > -             goto err;
> > +             return -EINVAL;
> >       }
> >
> >       ret = i2c_smbus_write_word_swapped(client, reg, value);
> > -     if (ret < 0) {
> > +     if (ret < 0)
> >               dev_err(dev, "failed to write register %02x\n", reg);
> > -             goto err;
> Similar to below.  Though very much a matter of personal taste - I'd
> definitely not have asked for a respin for this alone!
> > -     }
> > -
> > -err:
> > -     mutex_unlock(&opt->lock);
> >
> >       return ret;
> >  }
> > @@ -660,7 +640,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
> >       if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
> >               return 0;
> >
> > -     mutex_lock(&opt->lock);
> > +     guard(mutex)(&opt->lock);
> >
> >       mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
> >               : OPT3001_CONFIGURATION_M_SHUTDOWN;
> > @@ -669,21 +649,16 @@ static int opt3001_write_event_config(struct iio_dev *iio,
> >       if (ret < 0) {
> >               dev_err(dev, "failed to read register %02x\n",
> >                       OPT3001_CONFIGURATION);
> > -             goto err;
> > +             return ret;
> >       }
> >
> >       reg = ret;
> >       opt3001_set_mode(opt, &reg, mode);
> >
> >       ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> > -     if (ret < 0) {
> > +     if (ret < 0)
> >               dev_err(dev, "failed to write register %02x\n",
> >                       OPT3001_CONFIGURATION);
> > -             goto err;
>
> I'd return ret here
>
> > -     }
> > -
>
> Then return 0; here
>
> Makes it a little easier to spot the good path.

Ah, apologies, I've totally missed these paths, normally I would
delete these and add a return.

-- 
Kind regards

CJD
