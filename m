Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509B76026
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393420; cv=pass; b=U/8UqlGRTt+hIasxSD8pKB+cCwFAdhaQyvGDUfd1C7fFCGsu2nkxu7rnkvZ06yrgwTnBti0ElPK+go/Ch5TWp1YJqlFyfFNwOM15whDlMxZFG+Q+8HDvnomVD/a4wCVgTjKCdqQFPOgMeur+4q7OdiJiXwuY+taEiQAe9h2+ke8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393420; c=relaxed/simple;
	bh=OjaoeEXyT4g07zYPZ6AJ82LbciewIaIJsjQGkQRMyWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeVTLpNrXUvAvVGYA5U0ewCAkZbIkHT79FO6nd3uypqHGW0YylP/1UT8Ka2uZqg/jab5CyNoK8BDzAhka098TAFFAA8h21mnzGRzd1EopXoZUPScy4Au+wuSH++85BGg/o20Pn50b/zxxbpqi/ChaBP7h2OipTj9y/7LHoGaDFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEEUulqr; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEEUulqr"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d596a96475so1789077a34.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 11:30:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772393418; cv=none;
        d=google.com; s=arc-20240605;
        b=e9ULALN6ZdvB9+I0/tcZCP0AGUT8i75Ca990fbn94ns+pz8DOkEFJGN4wqE4sKgE7Y
         ehxw1z5DJTK63J1UvRrLuzcrOB31iNI6uICjRcoIEDmpOlRGOX29dfIwYIQh5fYBbN1Y
         0zErZDmF32AuOFiyu/mJg6rrIp1OcInQ3HFpg89JUYbkFtwCjy4oIWHzqNGSI+9yIOiu
         wEaKMcW/n3+8uGn/oIMViMpULI9Gjm7VFusH6vk2bH4VtmHXwQ9Y8BokVqVmzz+MPiOi
         RMMV94jHCOzAx1AD6lbBsHDslxCyELra1ut5z3xVTqT/SKJsfnVf+8rP3XrKuNliMkG4
         AbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        fh=nEXeJtS2yLPQfZqn9VoAZLIEhA8hVmwJkwXw1XPv43I=;
        b=Q9eKQsLuQ4IrASv9jwVVIvwXvVBkqnIU+yzKobI1GT4sYrZjq8zxh120mcwFpS5eMA
         /TapNdPqVUzADItw9yPQUQjkwMD/ayYe+z+NvJSBTYTnR32AIkpmYpLhfkNx71m5qMPj
         6klMs2vd1Dxs5mf9aXHXRpmMY9JZF9TZ/Wu/DnLWL5nGHrbVhBDP3t4wX3WYi1ldbmlD
         1Mm8ShZVlJgQgGTFCbfD5miBZkrr85Hx//ObeY48JchmvRh5YtBY/SAL6GpGVFd+Pntj
         lr5GXXvLOnpYoMSSX0BrAwW9tPspW/pv+rO5pEmqv70NWsbiqXk8WDT/z/6Uday+43tn
         oRLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772393418; x=1772998218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        b=nEEUulqrsU4Nw7w8x8ugXwskTsqsywRtP84EueS1FfN7N4tnUoRZ8FcPQbK8RQwRtK
         IKe+N7HN7Y2MvSXlbbovCWY//2DbimIHKjE6+MVThHNAeytsicrwp+rWXuw7dW/F4R84
         lofDkajcTtIEx9LsST90/sPlaiXpZXdS7KO1fkgndEvSrnP16V9kIxEWiIwZhvdRELXk
         7LaBrieowxp3f+Wmb5lz0l1/eCKAyVSzY+mwurQV2hKQqbpVQTRnKd8lPW4fD8M82nG1
         qVtMyj8uHTpus6S4Wu+HxlFzdGh+5Pn6s5de0UlrzUdPaLU5ihH+B59m6zFkZfth0YoH
         Qptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772393418; x=1772998218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        b=G7dD2Ib2UGIrp9pG+YWRPANokfMGjn9vVZtP8IOIJmZjhsLKmbO/2yvMlH+s03Z19b
         TirDb1Njk5R/Y3GhmAo+eP+RSQ6vXgvFMDRcIKuJZtiXDCSxuwAQ3ka8BkvfeCybhTNq
         wM7VgZoNZDKn0xsN7EVYHPoHu+mF3LHm/a0gxEbUGy3dEIp/nI2BaNkl3GpGOO6F57rc
         XELT4Ct5WuABlM88ku2l+BkLJYwyRrldQo8x55AfGa6ryP+u1MZLZncSpdfRcVq4ASV1
         fGTvY2J9tDosL77fUFR0hQcP6QUxTJIBoMzWW6ipuHp1aNTUEpQ7Wb6bJnUmrB9RztWJ
         Ns7g==
X-Forwarded-Encrypted: i=1; AJvYcCWAzLhTtQetc9VehX0VT4hSxXVf5SQpQ3tljKNWEjHoiB2vgH/Uu+UKw1SWqToNeQp+W0X592lKYms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxneON6HJve8M9y+B5Ghg1fIZ7/japkTRNv+QGlXqrrEn2NEdb
	xM2v0HRtTbCYEa39RsSfi37WCaJXmQwhgWfv6Xhki5tGc5H+mhiP3lx2aN2jk5nOtIpnP+M1ZQA
	c2rVqXzRKicztuYz/yzfMWZ6CV3y4n5o=
X-Gm-Gg: ATEYQzxsWJ4fa185Fn30BkLPSCulJgd3jKpwUYwhiEibD92kbXUqHIPzrg7nOb1PNdV
	eyyZDJ1qYfyeeyk9Ud4JoCumCCqaD1hU9SNQ63P5VSqTKYhcAA5rrW3rHdHtag8x2/7kg6csbO1
	xzmn1uyGOYzwzm4HJC/VSKfNMTq1usI8/yjufcPPA13njiT6/8PoUCh86hwPgpot8Jg/P/If2LW
	Wt6Dgdalnb9hD+DYQg+m8pbVo2xMVBVXEATouYmdrH9QNq4KM7kU1WG2hh8tu1b9pDsXC/CKfP8
	9GXHX4QdqhGvObJXa0h0jv5QfygL52DO01EKZC4=
X-Received: by 2002:a05:6830:718b:b0:7d1:9da9:c6c with SMTP id
 46e09a7af769-7d591bcdad7mr6622117a34.17.1772393417813; Sun, 01 Mar 2026
 11:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228191400.19244-1-rougueprince47@gmail.com>
 <20260228191400.19244-2-rougueprince47@gmail.com> <20260301114450.17f79213@jic23-huawei>
In-Reply-To: <20260301114450.17f79213@jic23-huawei>
From: Bhargav Joshi <rougueprince47@gmail.com>
Date: Mon, 2 Mar 2026 01:00:06 +0530
X-Gm-Features: AaiRm52kw1wnE8IDel-K5c3NBDoj7DLWgIYMU_GQ7TIXPDj-_JL_JT4-UcGgRP8
Message-ID: <CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 5:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Mar 2026 00:43:59 +0530
> Bhargav Joshi <rougueprince47@gmail.com> wrote:
>
> > Currently, calling iio_device_register() before
> > sensor_hub_register_callback() may create a race condition where the
> > device is exposed to userspace before callbacks are wired.
>
> We needs some more here on 'why' this is a problem.
> Whilst this is an unusual arrangement, I couldn't immediately find
> anything that was actually broken.  It's possible data will turn up
> after we tear down the callbacks and before the userspace interfaces
> are removed, but I think that just results in dropping data. Given it's
> in a race anyway I don't think we care about that. The callbacks
> don't seem to be involved in device configuration which can go on whether
> or not the callbacks are registered.  Maybe there is something that
> won't get acknowledged if they aren't in place in time?
>
> For a fix like this we'd normally want to see a clear flow that
> leads to a bug.
>
> Also a fixes tag so we know how far to backport.
>

Hi Jonathan,

I originally submitted the patch for the driver because calling
iio_device_register() before the callbacks are wired up violates
standard IIO LIFO ordering. I assumed this created a dangerous race
condition with userspace. However, as you correctly pointed out, the
HID sensor hub safely drops those early events without crashing, even
if it is unusual behaviour still won't have a hard crash.

My underlying goal was simply a structural cleanup to align the
probe() and remove() sequences with standard IIO architecture.

Would you like me to send a v2 of this patch with a revised commit
message classifying it purely as a structural cleanup (and without a
Fixes tag), or is the current driver behavior acceptable enough that I
should just drop this patch entirely?

Thanks,
Bhargav

> >
> > Move iio_device_register() to the end of the probe() function to preven=
t
> > race condition.
> >
> > Consequently, update the error handling path in probe() and in remove()
> > ensuring that iio_device_unregister() is called first to cut off
> > userspace access before the hardware callbacks are removed.
> >
> > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > ---
> >  drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/h=
id-sensor-gyro-3d.c
> > index c43990c518f7..8e3628cd8529 100644
> > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct platform_devic=
e *pdev)
> >               return ret;
> >       }
> >
> > -     ret =3D iio_device_register(indio_dev);
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "device register failed\n");
> > -             goto error_remove_trigger;
> > -     }
> > -
> >       gyro_state->callbacks.send_event =3D gyro_3d_proc_event;
> >       gyro_state->callbacks.capture_sample =3D gyro_3d_capture_sample;
> >       gyro_state->callbacks.pdev =3D pdev;
> > @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct platform_devi=
ce *pdev)
> >                                       &gyro_state->callbacks);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "callback reg failed\n");
> > -             goto error_iio_unreg;
> > +             goto error_remove_trigger;
> > +     }
> > +
> > +     ret =3D iio_device_register(indio_dev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "device register failed\n");
> > +             goto error_remove_callback;
> >       }
> >
> >       return ret;
> >
> > -error_iio_unreg:
> > -     iio_device_unregister(indio_dev);
> > +error_remove_callback:
> > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >  error_remove_trigger:
> >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attribut=
es);
> >       return ret;
> > @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct platform_devi=
ce *pdev)
> >       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> >       struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> >
> > -     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >       iio_device_unregister(indio_dev);
> > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attribut=
es);
> >  }
> >
>
