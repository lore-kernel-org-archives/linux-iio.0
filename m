Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795199585;
	b=kcRKN7bRZrLdf8D72YHJ0cg5a3E9Csns3K9uE4lZmTjCWrr2Yh+02Nr+12cYGvPUZztW
	 yqHRg+gDcPbNaY4wYYZHKLrIs2utdNbS3zgprlSstwMbsii1646Clm4XezQD1XJOQvysV
	 AkXY4fm7hpH9pLGLt8IpT3i61QbzSo+rqLAGirDepjFWVyUiPpwLH2Lj9ZIzlEfOnQXBs
	 zOrVEFTSYjt5DLNpcEJmc7KoRGFinAYCWzh6DB+B76HujOcxUdrl6DHCw76j0+LMC4cl2
	 Wi2hFNfsPrWTXQKWRVUwH9oWKjf3p/NnqX3YHtwgMAu21oc+k7ubgxErPEmQlH1w/qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CAPneeylBz3YXn2VnybkvLnn9F0XjtSc9eSWIHGISq0=;
	b=RnwnOTCcHzSzHCcApAPGnFjjEdrCWriOuJ3uR0lOdTVjuuwtU0OPlVXPJEouN8QMlhE3
	 Ow9vPhSdorniQF3d3SF4bE6SjqJGNR6sr9t0jRmF8jds7jr0aGdDopeOZQgNMWrZovmZm
	 lb4nqOK7KOtBOA6xaQpug85tM8ZFW85vrM64nCz+AB/G/5T8JmMsl1oDtaUYvo53db1hn
	 mSzn5CDL6OH4FvrlZ9doyl4pvgaPXDcF7bxO96lyInX0I6BLF8i/aO8fvM93lu2khwoK/
	 xklqEwnC0ESLw7QOMZ+EPhPponxklvISCUSn+fIUbGZWOetk3UD04xt9hwWiKXnxU+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F0cMgM5B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF160A2601
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 18:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DAF160A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F0cMgM5B
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b85b58d303so771138a12.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795199583; cv=none;
        d=google.com; s=arc-20260327;
        b=qAzw+XtpZtwbv4Sne5OQF/DcL+PB9LG8BRO7Q4B+P9kcJN9E6gfUOSRwZcCf2t1r9r
         dF+R+TxkmNviCnX9O5zHUl40/mbugFwUNyfIBoXzoBOR7uJaJ+EuJ2A4dM6HMsotVh6N
         R0s3cF2GYOos1xBJDZzh1gpHysgkGnglMXPZYM61HAajOYPtTzCqB9a4dR7+G1W2LENg
         TpgkZ/xm2GzeRYXRRc3oAf2smmMhn+aqpNj5T3v8y2WoQErpA19HecdHnCiEkUrb4FMQ
         uT8aCwx2Dc78ex3bOYNhog9hxbHoj9BPaRsfe5i7/FsZoWA7Kz/8N4RTAAq7TPRwifyN
         3xTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CAPneeylBz3YXn2VnybkvLnn9F0XjtSc9eSWIHGISq0=;
        fh=KuFSXwa5l0J+fmOq1rIq3iiyofAYL36MuohJXyuXkNY=;
        b=IMOKiFZlkY07+nhCHza0Rq7Ss1jDv15uMxGU+bZh/HDb4NaFwoPAOd0DTZDThZ7rBe
         4Gvxnw3ePete1sJw7E6VLwf3oaIhCyVm9lEbdxpwZYHHwsnjuVXiKdZuxhng6H6OIqW2
         lSbKDZ3xY8C4DFgFclMLOyz8RZYl3znRdtZq4lPZFTgkHhFOXCJIX8exMdAQZ77h/6Oi
         uIpQbc4A9gBsSm50NjMwCQvTuX5Y2llfXRs59Ndz8c4uyLq3BmA1oGeL+PuUVXOmftUy
         gkEgv9ADtA2ro2sCIWgYj1P3hCWQQ2kU0vOKTnECsE8RHDKFFkvI799TOxiCCHWMeVdi
         5W4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1795199583; x=1795804383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CAPneeylBz3YXn2VnybkvLnn9F0XjtSc9eSWIHGISq0=;
        b=F0cMgM5B/mftILx/4d2yWLhLfvI0yR4/pkUXQ+93jk5juo55xYmqJlJpxsW6MtWXPl
         I2834IQNamlmFvPt/aAARRFZGLzdUtYs9vfbW0X7e/0qrXqlN0rPKY/q5Ddvlb757QUY
         iCSOWRiM88EZr5fANrYkh9w05tphycwC+OZz3wlSYD+hY9774yI6vwMYUWT/jqy9qPBG
         54dq7T4Qra4REIbZzV6iVJRSbheJhZCgXDzI9NF2dl9yGkWHRT8m9MOo19zTE1rB5UG9
         dPKYxxJLcOlufEzSlCkv8dagYdAKqTvivKNPsV/CV7VGe/ba9dBel/Hfx2EuvufDJOZE
         eWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199583; x=1795804383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAPneeylBz3YXn2VnybkvLnn9F0XjtSc9eSWIHGISq0=;
        b=dQYZiZJMcnYlbH9AAZIZ/GkdXh1/JTVGjC1RDlXX9av9neeL6onTHZT7ChBZ5ll6HM
         8EU7vPzkQPXkXuD87sjWY7t05m5OQgGK+/koGcqRAaSseV25KdxHthVGTrudcDjNnCVF
         RS7GduPwaDclp23Jo5roce0ZHcyACI9h1mCQ+gOytdf+bb2jepqZ2MGa8mnR97yPQfh9
         Wd3kU/cd/P4FuYQpblcWFYClKSo8DvhZq6USDxysSkscFy59fJCTHUyrfEVKXzlACpZ8
         svnJ18mEWFzU58U9xSB+AMjpNT+o/j9QIlyz8rlIHvVV9rTy/Lra1MLg00lbdep4RXJn
         jpSw==
X-Forwarded-Encrypted: i=1; AL+hErH822BrZRDiVfWrhyfzJIafmduw6fHireZ8fJgF1LtQ8hk83BPac+ThKAnd4y8XxgYYorghN5XAucA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fk0mVv2VXhHCtdZCpWvAkOp7no2Mu58gffop9eR06ui761O4W
	zFP8BVasLByrHzprsqw80iDBxZtx/aO7YJxgsEbKQQ5+liyf5g6bPa49LuWU+iRHtZw4Dc7m+zF
	dNVYvqEWyYqz+eHOu7rThTUVyKuJe54b4VOV1z4LdHw==
X-Gm-Gg: AZFdTZdYyvNpYTDH58LwXAvVQg33QjulKBIlcGMUWLq7WsrFcFw4ewUbzlg90/aZkVT
	VHlz7bgheTMTAksI0D44l6FRH46HGXsmA9hw4VfFwRqtd6nxpLMifJSuVbJmYLDEMwxEg3tRwt6
	7G9C9mW/ew/ZqE5H7CzYKhyo26blNT+NPUOAIoczlyBG0a4MoxAtbfGNMgT+97Fdl740IMSO/4s
	UjGJGrpZM/0G20Ksxe6Ow2t4xCkIv5PFWfgl+o+RZYEXikAgJ/5nWK2ipjmjvL0bpVKHL+jbhN/
	yR5kg0I7/DJG5Akimg4CYoWcYt6Yu76WO/szQ/NhACet9yMPMr/5QL80m9NY1gxd8+8aUnokW/E
	ssrj4hPRpwYtFSdstcniaCg/yEUeM6QYX9anAUKFDdjnPXSceQ6FCeIb7YPslVxABqkZhZOJ+Rm
	crYVNWv9nGtrILwZPWyzGYKHEJQ/BM8sxMZWeMPU4qt8rm3WUJpg==
X-Received: by 2002:a05:6402:a594:10b0:6b8:a711:65f3 with SMTP id
 4fb4d7f45d1cf-6ba37e935e0mr2522060a12.14.1795199583392; Fri, 20 Nov 2026
 10:33:03 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120020850.24318-1-joe.l@reflexrobotics.com>
 <20261120020850.24318-2-joe.l@reflexrobotics.com> <awAT-ofy0p_uhvGN@ashevche-desk.local>
In-Reply-To: <awAT-ofy0p_uhvGN@ashevche-desk.local>
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Fri, 20 Nov 2026 10:32:52 -0800
X-Gm-Features: Aa3M54ooMSbRCqeK2L0GWBOnVFZSWQ2EEWv_N9fWbx0PggVT0BMZwu4_tSVZ3Vo
Message-ID: <CAJLMkXafYtUx7gXE8g-sJ0keGW8eSrVGPc2ao5EzjkxZ-nN2cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: return -EBUSY for temperature
 reads when idle
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

The -EBUSY here is consistent with the existing invalid-data case in
inv_icm42600_temp_read(), which commit dfdc31e7ccf3 (=E2=80=9Ciio: imu:
inv_icm42600: change invalid data error to -EBUSY=E2=80=9D) changed from
-EINVAL to -EBUSY for the same situation (both accel and gyro off).
Patch 1 returns the same error for the stale-data case, so userspace
sees one consistent response.

https://git.kernel.org/torvalds/c/dfdc31e7ccf3

Thanks,
Joe

On Fri, Nov 20, 2026 at 1:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Nov 19, 2026 at 06:08:49PM -0800, Joe LeVeque wrote:
> > The temperature sensor only measures while the accel or gyro is on.
> > With both off, its data register keeps the last measurement, so a
> > temperature read returns stale data. On an ICM-42688-P, a value held at
> > about 52 C was returned while the chip was at about 62 C. The data only
> > reads as invalid before the first measurement after power-up.
> >
> > The temperature is the die temperature, used for accel and gyro
> > compensation, so return -EBUSY when both are off instead of stale data.
>
> Hmm... EBUSY means they are doing something and kinda hints user to come =
again.
> Would this condition change on its own if user comes again later with the=
 same
> request?
>
> ...
>
> > +     /*
> > +      * The temperature sensor only measures while the accel or gyro i=
s
> > +      * on; with both off, its data register holds a stale value.
> > +      */
> > +     if (st->conf.gyro.mode =3D=3D INV_ICM42600_SENSOR_MODE_OFF &&
> > +         st->conf.accel.mode =3D=3D INV_ICM42600_SENSOR_MODE_OFF) {
> > +             ret =3D -EBUSY;
> > +             goto exit;
> > +     }
>
> I would choose one from the below (they all have their pros and cons)
>
> ESTALE
> something like this, but error message is specific about file handle
>
> EL3HLT
> what is level 3? But we have the only user, and it is outside network
> and it sounds close to this case, but why not EL2HLT? (Also the users
> are outside network.)
>
> ENODATA
> also used a lot, so semantics not so clear, and data is there, but outdat=
ed
>
> Depending on the answer to the question at the top of my reply, the error
> codes may be EIO, ENXIO, EPROTO, EAGAIN (but if EAGAIN fits to the flow,
> EBUSY also fits).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
