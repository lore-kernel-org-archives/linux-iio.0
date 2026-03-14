Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F852522BA
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506227; cv=pass; b=S0xm+6F0YU32dHg0rAEOho0l7z0sd0wwGIxsAoScgQdCz7Q7Habc6YdipVmtC1eXhAd+VGw1gwI/Q5pfcFNvkI+5EUWHG4dTcxH2tFbNOKmIK9vBd+Qzr49g+qkdu0WXUJNNZnNlJ7Tk0IcCUDKVLBDDgysdnLCjHB+xvMVW5kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506227; c=relaxed/simple;
	bh=AChuMYvzN9FAUF/EEMXao0p5KoUwHXrwfFFL2igcsZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkfjzINLHByRXNyWL7OWL+MM2YTiRKfGROzOeHW1afJpntih2sCJsaMQqXJgaPltW5VUtXTFl0jUGPd2TWp0TcIZEapezCcOteaJXZwAvIXfmGWtzZaiCZVyYO7GgjzbgIvXGXh2L0Ws/u9Y+N8edhZ5fIL0MdStlpX0cTsu9yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B79qGRvQ; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B79qGRvQ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46708149af2so1733694b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773506225; cv=none;
        d=google.com; s=arc-20240605;
        b=F/jQ5bWYygSU0NDCue2Wt6YBUM2raaTGD0SPdrMBUkiQ0+GKtwimbh6P1t8TekLyuo
         AONRxxexXngHszTX4+oG9KdK5VvAU3VdCC4S36KgG9nnVoVMW/IRt5bLDBVbIYllG+3f
         SKTnF1pt8Rf+kS3j2ruuaw1LJz41I1X7wud3rreKM8PrGFfgFM+Qfo15Vs5pWHHFzMWo
         tBW+X08n8HxY53lOb1a2m0gGa3Jxi7JZvVuayNqYy8C0uRGhcUV2vzCD+MvQP24zJDQw
         plRuzJlirRXT0p8rkNB0j2GkIwyuWPj12Szs1v6lI3V/wZUpFc3p4JaCbIdMKinmD/Ae
         8uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6UH7E+PyL5XHcjZkvJVPR6jCyW0Zkum2Jt0XVUTJW0=;
        fh=RFsO/vB5j22NT8iWq4z7j2VZTDkD94uDaYq9SvXQgcE=;
        b=S0T4eUD2fovvTet6YX31cVDWgH+eG/FcoYhdAFCmB80PCvkSKhGEf+VeHfvy84WEAV
         MpNA8on4kFoyDqodxCwIEUnYo3dOh87fBVc1t12zD1xxzQ3V1YAtgRN/RrYj9bmkh0u7
         lLVL3uKm4DOLKd0cIwk8OmmFs7l8YDHRDrLfiwBEbesa67qC+w9xKUkkViwvC0FybGzV
         qQI4PsHGiJ00mj94D4Pn1Y/IENINGP+C7PrUiaS9F3MkB7mh+v5jeyrkSW8DMzk/QTZT
         QnZW1jTGHZpBEezBqc7HgrLZJxDxeluJl42RcdWT6Jsz1/iYEWISaOUx9H7z25Al8rgC
         RFPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773506225; x=1774111025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6UH7E+PyL5XHcjZkvJVPR6jCyW0Zkum2Jt0XVUTJW0=;
        b=B79qGRvQkGAO9pPwBEMu1lSFHeKMxHTmT7cFSrd5mVXwr7do/eJtA9Fx5iMLmsd8kc
         OgOqe5ytahKUvcBDSBzcQVBD14WBnXQ1DxMOV2mjAlBElS6XkVcxBAq/9alslm2YRz0L
         ROyQQSup90dBxPP35pDF2q5jKB7p6gqAeZAF+ZCVzUEixlsz85HSxuwVyuT1Ro6vzVtg
         9szgc/JP9FjTuXL2Nu2xEjG5k9IBAmbb5Gp1jgBW3iLsvmtDuzuLY2eJWNmm3WAa9o0z
         4jjDqkQvG19pjr9pTkpNk/f3OxEI0u0KKUQWib4r6ezg7Ud7Re/Z1qc8JaAyeyZ6FJP0
         vOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773506225; x=1774111025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6UH7E+PyL5XHcjZkvJVPR6jCyW0Zkum2Jt0XVUTJW0=;
        b=SyoysAw4JaUJxD7IYxht/Ue6CSo2m3uzXp1nLVdwgE7HK2P18T/nezC2gbP0ctDJYN
         SyqosjoqCy7Fb0aXcXaPaqXlbYMg9diS66/z8uWh9SZxOKKUuIvJ0aFc8dFZGzO+FNDF
         0U/l8+tuCt8Bezb6+qzGoLjxEbxliHr8RmRAXDGjaRRHAJdXt58pAZkKNYk0NplpLygE
         8kQxvOko1jq2VzzVdfh/3mcwHkV80mBS3EGco4rw7T6ji1ut5HNzZN54cojQ4Bro9Vqg
         ys1UIn3890tgqwqpQsha6S7+JaFtdIgD9vzqFUgalf11utiOQyVfi+FPwsGwVPp0c4eD
         1UmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5fXOyWjE2Ijz5w70/f+7K9/Y6C2NFwyfeI1ivqZtJICpZU0pnxNByyMc9KSpHzUwJ6/SZZLhz/+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkMOedi70cUXFm5dv8+rt7SHqxhT8VcV1VD35lLmz0z6hVd6/
	vCF5+llZlv38EQxxKxf/yEHo51Mb6STHKUoqISyGY4KmAZf7SbF7HtOeRjH0u6ULMkQy0Kdsmp+
	f/J94e1Q2MZsT45mXeEnsw0FoSLcd9LQ=
X-Gm-Gg: ATEYQzy/XPW/hwtzou0tO4J6agZ8DPep3WKvurJka+aquJdf6eAcmLIsEGh1PyH4pSq
	rQa6MLt6mvR2acLU85Ha5QLC02yoQDdqTXJWP656pkfo8sSITIM7R9csZLbbxD6rCu9X3xrMffD
	EIF48IhWcaP56VGHfMLrmfi3DnDrrGWuETKUnffYjjRhIeO/KLtvpcsIPRzc5R+/CxaUnk2vn5q
	DdQDEbma4qlyTQ09K7FpwU1JAEvI2FJswJt4SNojplwGyCWKtWvDxfya3sxQVALPW96T2mzOqgm
	w2dzTxUtd0VdGS5fQ1i5D7aarWEutwNH4itmU/j7lA==
X-Received: by 2002:a05:6808:6909:b0:450:32f0:4887 with SMTP id
 5614622812f47-467572d3896mr3753931b6e.31.1773506224754; Sat, 14 Mar 2026
 09:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228191400.19244-1-rougueprince47@gmail.com>
 <20260228191400.19244-2-rougueprince47@gmail.com> <20260301114450.17f79213@jic23-huawei>
 <CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
 <20260307142153.26bab5b0@jic23-huawei> <4695861781487359fddc6cb8aab932c70cb8ebba.camel@linux.intel.com>
In-Reply-To: <4695861781487359fddc6cb8aab932c70cb8ebba.camel@linux.intel.com>
From: Bhargav Joshi <rougueprince47@gmail.com>
Date: Sat, 14 Mar 2026 22:06:53 +0530
X-Gm-Features: AaiRm51Me6kyVGZ2MRCS65Psgv5NxNTJQNJRusBIV_44237y4VDotlnTjJSQiu4
Message-ID: <CAPC4XCTrV3Ww1TzKzb2KvaTzGmUPb8K1RsJ5yyZYvW48wt8_PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 9, 2026 at 9:12=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sat, 2026-03-07 at 14:21 +0000, Jonathan Cameron wrote:
> > On Mon, 2 Mar 2026 01:00:06 +0530
> > Bhargav Joshi <rougueprince47@gmail.com> wrote:
> >
> > > On Sun, Mar 1, 2026 at 5:15=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org>
> > > wrote:
> > > >
> > > > On Sun,  1 Mar 2026 00:43:59 +0530
> > > > Bhargav Joshi <rougueprince47@gmail.com> wrote:
> > > >
> > > > > Currently, calling iio_device_register() before
> > > > > sensor_hub_register_callback() may create a race condition
> > > > > where the
> > > > > device is exposed to userspace before callbacks are wired.
> > > >
> > > > We needs some more here on 'why' this is a problem.
> > > > Whilst this is an unusual arrangement, I couldn't immediately
> > > > find
> > > > anything that was actually broken.  It's possible data will turn
> > > > up
> > > > after we tear down the callbacks and before the userspace
> > > > interfaces
> > > > are removed, but I think that just results in dropping data.
> > > > Given it's
> > > > in a race anyway I don't think we care about that. The callbacks
> > > > don't seem to be involved in device configuration which can go on
> > > > whether
> > > > or not the callbacks are registered.  Maybe there is something
> > > > that
> > > > won't get acknowledged if they aren't in place in time?
> > > >
> > > > For a fix like this we'd normally want to see a clear flow that
> > > > leads to a bug.
> > > >
> > > > Also a fixes tag so we know how far to backport.
> > > >
> > >
> > > Hi Jonathan,
> > >
> > > I originally submitted the patch for the driver because calling
> > > iio_device_register() before the callbacks are wired up violates
> > > standard IIO LIFO ordering. I assumed this created a dangerous race
> > > condition with userspace. However, as you correctly pointed out,
> > > the
> > > HID sensor hub safely drops those early events without crashing,
> > > even
> > > if it is unusual behaviour still won't have a hard crash.
> > >
> > > My underlying goal was simply a structural cleanup to align the
> > > probe() and remove() sequences with standard IIO architecture.
> > >
> > > Would you like me to send a v2 of this patch with a revised commit
> > > message classifying it purely as a structural cleanup (and without
> > > a
> > > Fixes tag), or is the current driver behavior acceptable enough
> > > that I
> > > should just drop this patch entirely?
> >
> > My gut is leave this one alone. It's a rather unusual driver in lots
> > of ways, so I don't really mind one more ;)
> >
> > Lets see if anyone else has strong views one way or the other.
> >
> > Srinivas?
> >
> I don't see anything wrong with this. If you register callback before,
> then iio_push_to_buffers_with_timestamp() can be called before
> iio_device_register(), although it will not happen because nobody
> powered on sensors in the hub.
>
Thank you for the clarification, given that current code won't cause
any issues, Jonathan I am completely fine with dropping this one.

Best Regards,
Bhargav

> Thanks,
> Srinivs
>
>
>
>
>
>
> > >
> > > Thanks,
> > > Bhargav
> > >
> > > > >
> > > > > Move iio_device_register() to the end of the probe() function
> > > > > to prevent
> > > > > race condition.
> > > > >
> > > > > Consequently, update the error handling path in probe() and in
> > > > > remove()
> > > > > ensuring that iio_device_unregister() is called first to cut
> > > > > off
> > > > > userspace access before the hardware callbacks are removed.
> > > > >
> > > > > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > > > > ---
> > > > >  drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++---------
> > > > > -
> > > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > index c43990c518f7..8e3628cd8529 100644
> > > > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > > @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct
> > > > > platform_device *pdev)
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > -     ret =3D iio_device_register(indio_dev);
> > > > > -     if (ret) {
> > > > > -             dev_err(&pdev->dev, "device register failed\n");
> > > > > -             goto error_remove_trigger;
> > > > > -     }
> > > > > -
> > > > >       gyro_state->callbacks.send_event =3D gyro_3d_proc_event;
> > > > >       gyro_state->callbacks.capture_sample =3D
> > > > > gyro_3d_capture_sample;
> > > > >       gyro_state->callbacks.pdev =3D pdev;
> > > > > @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct
> > > > > platform_device *pdev)
> > > > >                                       &gyro_state->callbacks);
> > > > >       if (ret < 0) {
> > > > >               dev_err(&pdev->dev, "callback reg failed\n");
> > > > > -             goto error_iio_unreg;
> > > > > +             goto error_remove_trigger;
> > > > > +     }
> > > > > +
> > > > > +     ret =3D iio_device_register(indio_dev);
> > > > > +     if (ret) {
> > > > > +             dev_err(&pdev->dev, "device register failed\n");
> > > > > +             goto error_remove_callback;
> > > > >       }
> > > > >
> > > > >       return ret;
> > > > >
> > > > > -error_iio_unreg:
> > > > > -     iio_device_unregister(indio_dev);
> > > > > +error_remove_callback:
> > > > > +     sensor_hub_remove_callback(hsdev,
> > > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > >  error_remove_trigger:
> > > > >       hid_sensor_remove_trigger(indio_dev, &gyro_state-
> > > > > >common_attributes);
> > > > >       return ret;
> > > > > @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct
> > > > > platform_device *pdev)
> > > > >       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > > > >       struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> > > > >
> > > > > -     sensor_hub_remove_callback(hsdev,
> > > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > >       iio_device_unregister(indio_dev);
> > > > > +     sensor_hub_remove_callback(hsdev,
> > > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > >       hid_sensor_remove_trigger(indio_dev, &gyro_state-
> > > > > >common_attributes);
> > > > >  }
> > > > >
> > > >
