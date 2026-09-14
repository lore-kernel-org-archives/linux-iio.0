Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BA46D2D3
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391144; cv=pass; b=koh6WktGQtYN8PcZHAQG+vYSQagRNCpcO30hPFW/39D/jv6f0elWVgxWt291o2cTvQnBeMjv9xqXjjuZSpezYvlhIIIaWu0albPhWWB9BGOr2nbTUPWmR/paxEepZE314yzVTFAxUlQBTGd5V/VkacOauVER2/jGHRwtsqVfpP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391144; c=relaxed/simple;
	bh=bbQUKXpSrm8Dumgxw0+FiKY3C3ThRr3S/59ssFTR3yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN75w+pCkiZUVPGRMfHIytDVz0BBwFvXs0g2fyRsbd2aW0v9R/QHhqKy7m22f9Rz+3VytWonV1wP0y8zCvuO7f/15DeXiCiqjia0vvjAkBc7NDqa7N6Diby5+gvnX5g2n40oFGryweHkDk9msFNd5fl+4nX5CWkU/cgpMN1MUV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwW5LESh; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwW5LESh"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f943b286fso1463757d50.2
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 06:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789391142; cv=none;
        d=google.com; s=arc-20260327;
        b=GJ8ZfogZJTGEkfB686wIxR1Mq4dwsSu+EhqkQ5KIGqin5GdqEHizvHywBh57CszAUe
         yvOI1IimJZ/kBgWk8PHaTomxLJI6DvhqrXHSC7a/Cl3kURl6QpUjI+DSP2QjlVlx4vjm
         kMgMFtE107/KBrY+cGs/Z2igXOY7V72g4619jj0G3siJGKups79F6B7r4HPBcD+ZWr9l
         YjJF+DTkchipxACmiyz2xEYqulYcnTc8Xtygw0jrQlT5G/sbQ8Dp8pFvKUQnCY20hDqU
         t/PWpcabTF6/bk9LxKIgi5pUufK6ZB92YTeJ22DY6e09rC+D91CvbC9J3zBGgXJvg7Tr
         w1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ATb80abIxzRNOcrbBCbD0LbdOqIeRMoUZA0iOkkMQfc=;
        fh=A4p2aOcSZmCUHXw+gzgBkrL0JoRUY32bQ7VhrVQY7xU=;
        b=hjRNMW0c3e5MFk3ZdXmMVZefNZvRuj868Rah6E/HGWNw2oxk3X2G1xtmKGmqpkWFRf
         P3pFQLR3d0cB/G6mwCQEU7eTiIkckPt1DGRJD6ZSSo9wVgfjPeSRq9Gql1G7Exaf/yWK
         SO6+EHWyfeUpNhAYJhC95+A+2wOtsznQ3TzVzZAWzf7SdzgkhZIUTJDycdkHbBElQIlS
         6UB0277mb9SaouCDPbBC7GktnTJ/HPdpVWbLWzYuhnSx6A6mh6t3/Oh6N/sqJ9PMsvJO
         AYBlJ4y8NE/5j9Xf34ObjBfBqxEbA6PluqvcXlais9RorI1LWfvzbsLXMPg6S+ml86Oh
         +IvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391142; x=1789995942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATb80abIxzRNOcrbBCbD0LbdOqIeRMoUZA0iOkkMQfc=;
        b=MwW5LESh6X+W8xu6RdYn+dnzvC8AnKAJK61uL2AdD/jMee22I5ZGy21/A0GWfnEENY
         TjA6UlUrGFhrwXlBT1YgrwT3f4JotRMyuhaiEPvhxVbB4QFrDALApYZ6b0ED9Lt6pg+D
         1nejTB9tT4bJcSg3n4mb3TB89xRVuFkvm/7zvTWYbjaaYUGBqQBF8duFT14NRv+aL7Rs
         0150qz1tMCoC7gxCjI4WgnwCBr6hEMJaij+OO0cn4xxiupSPTUdHH6Fq3fWdW+GppjWE
         xuLmc2o/tcZSQs2wetskKmFIh/eAk+P248Uu6w5sJV+IM0mphU7myJcJgJ8JTzSUjYjZ
         4Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391142; x=1789995942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATb80abIxzRNOcrbBCbD0LbdOqIeRMoUZA0iOkkMQfc=;
        b=klvaQ+boUfNgowm1oyRE+dg1MbabIVg2muC/cdMOPTa29x+qLFtwWUchZnL+XZju0D
         OhSh2YfU0/woqbeW8drdmSWX8MCIowN08pj5/qUqLvdNVP9zUBG7NbdtnYJWkCZ4VZhu
         GK5uzSY5P6uFNF21lyF3rdncOu+UxHVLMoR9AyTvFL8/egUS+PlVlPH6oHxKwIbpHuw4
         iN2HPLYptwYiXlYxmRLI4rJDSZSiVbsoWaDjcXfwQLnBZxvOdw5UDlOSRTtpmZBYQdzi
         Hn+S3ykQs071SPUIp6trkaEkHe/KAX3ILUvLLgV9tYIURGA5b6VLA/URDzlgTrOFN3Re
         Sq9g==
X-Forwarded-Encrypted: i=1; AKwUvBzTDX37Gv7eLQMVYicMYecUFkUyKGMcx/38+Ixd/13TyKtoMJArHJjAtOG7QwMxmMKT5wZyaDa+dmI=@vger.kernel.org
X-Gm-Message-State: AFuF++mKJSFi467E27sXUldzL5Atzz19+kEJ3BhPulUAsrpTvZp0XSL6
	7m5LpDpcDUmJiE08SnVd3LHWeTm1FGV3fois2A90fwVKaPb58PFNm8hjxrY9KVksgZAPy61LotK
	WuC4ReBeiM3byAxA6k99rplY22tfZddQ=
X-Gm-Gg: AYBFou3h/W6xvJCnabCrBMNZcS3ZA+6/Tz45SphHKsX/cBDF+h3S6l1EKDZ2Lh7bkD/
	6gWS55YOU++zxe4f5RoynS8DIaEv+L0VjnQVChGBT+y/NHml1xNjn27dtzKgC9hr3F+U5rLThhV
	i0KkiWDzxpTWco660HrGfpKc9POD6Rm+Frcyv2LwMZFS/i8C9hl+uohV3UrBba7kykdqXPTQOaG
	+AoEzvgWke2e16fORyGUWDyL5hF8CjLR2GOsUm8NM5LvLJryNEZdAMuPBDu/ylKrlwaaBzVX3nN
	gHReeDgMwjbeClMHOw13HYr8Ts83cT+V3B1wm+BTIxMi1Lu1ZFfXuw1GSAV4oLgM22qTm749POp
	KbJlNIkgDbRqn
X-Received: by 2002:a05:690e:4390:b0:670:f743:6eb0 with SMTP id
 956f58d0204a3-6714e30999amr315323d50.98.1789391142036; Mon, 14 Sep 2026
 06:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-7-architanant5@gmail.com> <apCP7TkGVZ3I4jFO@ashevche-desk.local>
 <178813067693.2788519.14185731509268102204.b4-reply@b4>
In-Reply-To: <178813067693.2788519.14185731509268102204.b4-reply@b4>
From: Archit Anant <architanant5@gmail.com>
Date: Mon, 14 Sep 2026 18:35:26 +0530
X-Gm-Features: AcwNN1Xeq6_r3LCXmWL2fFSYRWYfvRHnKfx33tbn8arVaRIb_7x0aHNdDWvjW8o
Message-ID: <CADJHxWB1EyM0q=qDx9f79XMkTkX6ngiswFA7++A3oZvzMQV3Bw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iio: adc: ti-ads1015: Convert to managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com, andy@kernel.org, 
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:28=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On 2026-08-27 22:28:45+03:00, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2026 at 10:50:58PM +0530, Archit Anant wrote:
> >
> > > Use managed resource helpers for the mutex and runtime PM setup.
> > >
> > > Replace mutex_init() with devm_mutex_init() and replace the separate
> > > pm_runtime_set_active() and devm_pm_runtime_enable() calls with
> > > devm_pm_runtime_set_active_enabled().
> > >
> > > This simplifies resource management and ensures resources are
> > > automatically cleaned up on probe failure and device removal.
> >
> > ...
> >
> > >     data =3D iio_priv(indio_dev);
> > >     i2c_set_clientdata(client, indio_dev);
> > >
> > > -   mutex_init(&data->lock);
> > > +   ret =3D devm_mutex_init(dev, &data->lock);
> > > +   if (ret)
> > > +           return ret;
> >
> > This part is good and maybe introduced in a separate commit (depends on=
 the
> > resolution for the below).
> >
> > ...
> >
> > > -   ret =3D pm_runtime_set_active(dev);
> > > -   if (ret)
> > > -           return ret;
> > >     pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> > >     pm_runtime_use_autosuspend(dev);
> > > -   ret =3D devm_pm_runtime_enable(dev);
> > > +   ret =3D devm_pm_runtime_set_active_enabled(dev);
> > >     if (ret)
> > >             return ret;
> >
> > This should be done with care. There were some changes lately that actu=
ally
> > moved from devm_*() back to regular calls due to some races in runtime =
PM.

I reviewed the series again. Considering Andy's concerns, I looked
through other patches that included this change and the concerns
raised there.
However, in this driver the runtime suspend/resume callbacks only
update the conversion-mode bits through regmap. The existing
ads1015_power_down() devm action also only switches the device to
single-shot mode; it does not manipulate runtime-PM usage counts or
shared resources such as regulators or clocks (as in other cases).
Thus, I don't see a runtime-PM reference-count or resource-balance
issue introduced by the conversion.
Is there a type of condition I have missed? If there is a relevant
thread, I would be happy to check that out.

>
> In particular here, the patch description needs to say what this
> changes.  It is not a noop change.
>
> I'm not saying it is wrong, but I would do it in a seperate patch
> where you can clearly talk about what changes as a result of this
> and what affect that can be expected to have.

I understand now. Although the cleanup callback itself is simple, the
change to managed runtime PM also changes the teardown semantics, so
it is not a no-op change. I'll move this to a separate patch and
explicitly describe the behavioral change.

--=20
Sincerely,
Archit Anant
