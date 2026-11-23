Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795445623;
	b=cIgH8MD96sepbYfY4hs99mDAt7molPRLpqRYA7iadpsoiYLanlpvmkhmxb49oYgxguRi
	 AB0Upwv1ZHWztVik9rJ48zUy8C9XEnVahh6CK2goW/9aIyDcSqk6gVfk6HOnCcuyiVXJi
	 mVu59Rwc/ATC6VQdMss8ziclvHkLnB9gyI4bmtZsDKbUkSYvaHVrd06UMjP6zkQ30Fe4a
	 0vW71I0L6PLPo0xPuLjxTend0V9va71vX9A1fXNyr9gySRYzLoXATeGYg9kwrHdiZIRIs
	 9FT37EEvJNFTPoguT/XrerLTsPuhL4lluTdMvvPrQKpzez3C3qj0hI37B9vLZvgnBKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
	b=iFQcRS2fdLXpNw0n89Mb+CZy+939X+fnd7ina/BzGXVCIWw+njgbseiZr9Ib44rXcjFV
	 7QTC8livHvVtgDt3Qf5FLjrAQUnLgnc1pebM6tXdFKJFGdcsCQrz6/gXfrCz4OoQYE1Kb
	 +iJ+5kgnDMNv4crTnOO5yew7HHzY/NIuKWold5nHF6vpkNDy/OVII6ClKQMIrbngc0gc/
	 oFGLDQYmDev8x9Knq//YOP56eyI91lxqbE18SvEtY4UjC8wpfJlUHQCYrqbbFffi6D2zn
	 edXh4/TSOBFwPia6JmmzI7UinVNTszqI9g6iL/92lgztyU+peZ8LrGFVxi3brlgUaFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiMZSRJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58C60A260A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B58C60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PiMZSRJb
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so2175462c88.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 06:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445622; cv=none;
        d=google.com; s=arc-20260327;
        b=ajvcM/tH5Nlq2IJaa6Jy/Qp5i+3kHLhxnXp3zVC6kjd0cW1sBUZwEZtooT28JJU+WX
         gycXTuN7rX5tv7UvitF5CPVCQD7u6ZwtMT6YgeRDJvOAxDfCMtNx+5RA98m8sfaXyejI
         PW7/FKjB4xpaOANqx9bbRIKfxxeT4m6MIOoP595w5AmBeUnWg5ZekuYpEd4kNwf3lPmo
         S+k+U4XsLkoTwMmW/lho5yzPQ0arueO3gK4jW46HOgq2fvA2LfpV7apVhpr+vDwB7Dl9
         8pE0CJAwjZMpfkqIn+0cntZavdHljQxknXXlv1SXehCDvBsN3xsnHbda3HHiLbIT7V0W
         UPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        fh=KRjiRes/TEEBz2JmNEuP6Jw46EawFPfup46Bop/KWUA=;
        b=I79yHohBZQgNfCwdi8XOExOccppVXy73SVoyRGWmVa8Mkl+9WdvGO+dF0msBq6gr4S
         jCPNLmt+FhDYFAGLwscMAY3xZq1ARhqWhfWB7K6Q8El2fu/gjVJDNMFJTAi6kkAnb5Kn
         UJRab5WPw+OkvZfZTbzJSm0knUy6tytuDksa2WQhRLrNaZJkllLxGE8WtQ9kNqjqj+MS
         4OOUa3vyzy5yXuxXAN1IqEnJcxSZwO7bLxwuaf+QkHFDWMx1OLjLqHLJNwJPLPOY2bSu
         UejbFdA7fSNt8YK8qrbVVJHZ1N10Lgnxa//F81C7Eufeii5H72vMEWQddIvop71WdUvP
         3L9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445622; x=1796050422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        b=PiMZSRJb2hdBJuWT4yy1Me5kar1Bb5BK9zXWfbSJNUiKI2c52eYNVL79YciceBNL+M
         8Uy8NcuE003k0Ra4dJbY/I2OQ2kOmAdUNusOEQIuD18kosJLs8Nd2jAkDHjeutoGAc8j
         Vxkh18cQc5ZmUSSXDzSFr5BabGnAkKFgo237umXEUjEc6W7JOesNQVtjLuL31kG8ZYD9
         AMSJuAwByl7OcWJgcYIN46052MA7BQr+/f68mNeEFOL62LhmDQWs9/Udw+C3eJzxUZ+W
         7uy+z1OcbFDEglGQ33vXk3oj8rZJ3ymlqJYv42FAbaKR5Rt9q4WOkaa6ZkLX9Z0RYi0K
         EiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445622; x=1796050422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiznapJ9s3bPtI2/myOJZGBSxLKcyfy/8YV0Q+JSslA=;
        b=17+IutKAn9QfwDsOgl/RtL1F/LqQL1dNaTEKM204qxG8rI7XbC1KYfbeCD2JUkyNQx
         Mx9hNMlUDVDIPGQsRvqKtefLD+UJg5e2CSJ/jYa4YwSjR3442PEJJ9wXSgixcQUF7RKH
         cl/VFJwjQcLIkNn8jq92CkVLiDMVohJlye96D200hbBwPjI2lIAH0LVGD9GY8umFED5y
         Yjj7SJGmUGS3dzD14beXRSFgHYQyX767auzLdLAyIzWm4SmhftX+fIk4J68QKhF0zUhw
         3rKVfWx3bfKRLCF3aTFjn43sxHoK7RVTiuBCpLH6vMwkprfxIrP6X/2lT8akRdovkYjk
         kkrw==
X-Forwarded-Encrypted: i=1; AL+hErGBLqCngR3m2RRNp+/+VdGmAm6r8NwQQaURSj/ybqFLMiq91selehgYcodcrvkERbF7RY+uOd9jhJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xxUdIpqoWoYDSEa/CF037tKeUtUE1B33hhx0xKRHLUFwJXTgw
	iV6WS4kXEKNz47e/Rm8Hu3h0xh8aZ1jXa2BJZuCAI1hkGiHgT4ii/pXit/uvhN0tHDjOav23mob
	q98cK0jPB4pkzfRyQDbeoPixBXi5ecrSWyH9e
X-Gm-Gg: AZFdTZf/wBV6COZNzsl4tkWB1yIO8rGkZsZUtSgiap2MqUg+1GwHHFDk1pw9X1uqakk
	V3CXdgAEQD58Vlu1JkI6GTZvQY+pnESaVGr6qXHy0qQWCaIV5pMqQBdjvysjQKHOp5JnzlUbYCL
	r/xQs6L+HSnKSya/sRk/dwvQd1xSLP/v0BsInNwatJx1/JS8rZsuCg3iFPBRt6/nxm+R8HgRWYi
	6NjFYsa4UYjIogDXLGRUWVHvWA3O670cPmyV87Am5b/MmVWfnmPJZ5R53Rh7Naxj9ob+dLgNA8h
	zZ9eBhrMASRiZMiQQCFCXKLiMMPqXu5xLoszkFF4WIMkt5OP2MDkzZsBbdKgxf5nqEv2m5PE3iA
	80Yb8PSMDSbmeryrOcRUZfevDzDQ+0JzhTnk=
X-Received: by 2002:a05:7022:ea56:20b0:1b2:4e2c:6838 with SMTP id
 a92af1059eb24-1b5568cf7a0mr13384775c88.15.1795445622228; Mon, 23 Nov 2026
 06:53:42 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com> <3d83eafc370354cef4280fd70d1228191486a212.camel@linux.intel.com>
In-Reply-To: <3d83eafc370354cef4280fd70d1228191486a212.camel@linux.intel.com>
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Date: Mon, 23 Nov 2026 20:23:30 +0530
X-Gm-Features: Aa3M54p4k_LbVFdwSVxSxoz8NO28fV58yQh4DUC_tyGXKDsdGjchmGgw3AVrmX8
Message-ID: <CAJi8Lv_M2uuiiJXPMqo2pptYT9gK_5uYBh2tWMp7CP=iUsgouA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>, 
	Zheng Shuhao <viennaoffh@gmail.com>, Arnav Kapoor <kapoorarnav43@gmail.com>, 
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,

My apologies. I missed changing NULL to data in sensor_hub_remove() again.
I've fixed it, verified the diff, and am sending v4 now.

Thanks,
Ayaan

On Mon, Nov 23, 2026 at 7:51=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2026-11-23 at 18:17 +0530, Ayaan Mirza Baig wrote:
> > In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
> > while calling device_for_each_child(), which iterates child devices
> > via
> > klist_next() and acquires the driver core's &k->k_lock.
> >
> > Because &data->lock is acquired in softirq context by
> > sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
> > softirqs enabled, nesting &k->k_lock under &data->lock triggers a
> > SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
> > deadlock between process context and softirq context.
> >
> > Move spin_lock_irqsave()/spin_unlock_irqrestore() into
> > sensor_hub_finalize_pending_fn() and pass data through
> > device_for_each_child(), so &data->lock is only held while inspecting
> > and completing each child's pending state after klist_next() releases
> > &k->k_lock.
> >
> > Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-
> > data on remove")
> > Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
> > Closes:
> > https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.co=
m/T/
> > Suggested-by: Zheng Shuhao <viennaoffh@gmail.com>
> > Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> > ---
> > Changes in v3:
> >  - Actually pass 'data' instead of NULL to device_for_each_child()
> >    (missed in the v2 submission).
>
> Are you sending correct patch?
>
>
> -       spin_lock_irqsave(&data->lock, flags);
>         device_for_each_child(&hdev->dev, NULL,
>                               sensor_hub_finalize_pending_fn);
> -       spin_unlock_irqrestore(&data->lock, flags);
>
>
>
> Thanks,
> Srinivas
>
> >  - Drop the NULL platform_data guard since hid/for-next already
> > checks
> >    dev_is_platform() and !hsdev.
> >
> > Changes in v2:
> >  - Attempted to pass 'data' instead of NULL to
> > device_for_each_child().
> >
> >  drivers/hid/hid-sensor-hub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index e9d6eb3b3831..090e5a232efa 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device
> > *hdev,
> >  static int sensor_hub_finalize_pending_fn(struct device *dev, void
> > *data)
> >  {
> >       struct hid_sensor_hub_device *hsdev;
> > +     struct sensor_hub_data *sd =3D data;
> > +     unsigned long flags;
> >
> >       if (!dev_is_platform(dev))
> >               return 0;
> > @@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct
> > device *dev, void *data)
> >       if (!hsdev)
> >               return 0;
> >
> > +     spin_lock_irqsave(&sd->lock, flags);
> >       if (hsdev->pending.status)
> >               complete(&hsdev->pending.ready);
> > +     spin_unlock_irqrestore(&sd->lock, flags);
> >
> >       return 0;
> >  }
> > @@ -825,14 +829,11 @@ static int
> > sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> >  static void sensor_hub_remove(struct hid_device *hdev)
> >  {
> >       struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> > -     unsigned long flags;
> >
> >       hid_dbg(hdev, " hardware removed\n");
> >
> > -     spin_lock_irqsave(&data->lock, flags);
> >       device_for_each_child(&hdev->dev, NULL,
> >                             sensor_hub_finalize_pending_fn);
> > -     spin_unlock_irqrestore(&data->lock, flags);
> >
> >       mfd_remove_devices(&hdev->dev);
> >       /* Clients share one HID open; release it if references
> > remain. */
