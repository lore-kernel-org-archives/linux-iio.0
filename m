Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F206282F16
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777799634; cv=pass; b=UeKhXi1udHWizQguwgyUCZhQMpedOd8U3A+Ls5Pb/dOQ3BDewncGf4jmqIcGmoTPD19SEYmfaBaPOp9IhGdfhBGsunUqmbtaArVI6ZPiKdZqfwDTlkmRyUQ+a3wGN9BdXNMAw2XRaIm/0iu1zFYl+HLZWXyLGCL50AaAJRMJRqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777799634; c=relaxed/simple;
	bh=YIqgXoZ6imG/VzbnBWJZ8tujjVTgtCczGxwUIVe0Bho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfzAduK8BKrwXCHGSKwegNrqbgWrer8l7KbG9bcLlsYwvk+Xgf+qKKuGpaQQYP3hW3oLwNyiCOzsmTLHA+GCvyEzjhobfDplWgnlVhYZ1FpQm5MaiamgDdOjhTETMilRnDfacEp8sRzFCgfLL5HOvFXznW+GqJeDPTHyZjbTm04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6P0NJa2; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6P0NJa2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso1279059f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 02:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777799631; cv=none;
        d=google.com; s=arc-20240605;
        b=VMz6zD7wConbiDf/EHl9j+ANBQZmdtWNbarL0/XYvYA1oPWtb0Mr0A8Z7R/+LuJkQf
         SwwEAZYY989dpcVY5ATmhSYdTXbCZDzU3ZUGcZYRrKy78tO3Gb1z1T3CuqGymez5jGRp
         wigDA3aG8Fop0t0Et/KgxlweB2ABQgqL8SjWlnEs96U9vaTqaer4b0wFFHuKJCbfe1+j
         8117W+XKRiyQQOjp0DCI6CR2FaLwju/OYbLx2p0SMrQpm4mLqQv5caqDW+MEaxKnWpzm
         QUDNBm4BrpVz1j1n3hzgky2F9pXEPTWPyliOu4tPTJX4zKen5VKe1/UxJRQUvUtOtSkO
         mahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nBch53QbKjnDEjxHlRj3FY1RI41Uob6J9x7vAVOf8tc=;
        fh=/3u7VdHC5MzuacKWuH07Rt//F81R9thVmMWbjEh8CgA=;
        b=i+BbyMwI52x7PTZEPci1teuiD9iKqvPBlU41UXayiLsS5Fpz2e3Z9yuixoHIGKzglQ
         PHfZ/0xx6sj4kT+QN0iVEp1T7tKOaAbxMLtrnfHWYoP7+KdJafHcLAfOhCjJC35x7ORE
         4ZEU+yob7sKxSsSKuevfxdJXs3RXbDVz+1KGDH8QC9Y5rM7vJ5bweQ1evnT6pGv6p0C0
         vyR7f4o0I6TH4IRx3rn0ZCDZiXuIVN1Yq+7AZRR7oWs103HWvcHV+HvPwx+HMgOY7AqR
         DfhOJrKpWX3+RJZ01Mkx32lvogvrdb4f4u5cMs7g38rL5AACxmQaRlMVFJ8OvbcjWhMu
         bMmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777799631; x=1778404431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBch53QbKjnDEjxHlRj3FY1RI41Uob6J9x7vAVOf8tc=;
        b=J6P0NJa2jeN6q36/XLljzeitowYanD0ESvzFINiZQlwn6ZwP0XXcUs3K3tuM4gwFHx
         ng4gE2jDVDKN9jelF9Q1koPlWfkM+ovnVM8VB9Tsd8GtQq217T5t5OXAm3tL9H3obr1h
         dFg2NMyPFD/xwrTxL7DdvUXPdVcwV5+w2MepbRFuAYPhaVa+9476nge4vLfZDAjummAo
         /knA9EMXVYEJqfg1XypQIa2W6uIQyrjbvcWmN3m77G5wLxvNmSv7mt+MZELCn7bMkoiw
         +etST4E+DXWEC9R76Xturwv1fneUoGtZEqXHas8lrj6AI9XkgWGALN7lfUc8DPcn5kY3
         xNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777799631; x=1778404431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBch53QbKjnDEjxHlRj3FY1RI41Uob6J9x7vAVOf8tc=;
        b=BlmbGTcaxP0BdT7OGS7pAUwoFVU7ursF9C3fHT7kpzrVuqv72+9/YFyNWaywqniQXK
         dya1dW5t7eaHV4usGDw8DwtNlIxbEq5oe+TzCU4zWjOoE9FJ7FHdPjgDL0LTRv1J3w6V
         UbdFW1O+CPrgqcfDfenfUGockdMeAAMMi/K+cJHrzAnq5/LQ8NJcRzIxbT3RMdXoYZ+t
         38pmwNCCXCPiAKhtUE6tihtmNBSuoRjgh1GQlmq/D4Ui04fRzzDaIIO1STL0NQ9pofmo
         qpnlQMTkhq+1glqb1J97TuoZ9QfJg/KNfHCxJTL59974Z6b+DKpawpW2F6kUuUH7O806
         qpaA==
X-Forwarded-Encrypted: i=1; AFNElJ8TI9NxrDHlhN02DqBEC9ADTqvg+lNDUg/H/c34+7MxOoYEaEycU3nGQt4ybCojIsWCXaJFsgtyqSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MrgMhE6rwYFzV4000afauLBW0XxFrtmDwky+i2m0OwPiOejc
	akiET5u4e1muZ1cc0v074N8M3iJn7Rrf9NCvaA+99c4LvVqNuzgEpRooVWW0vqio5rPrW/S2Ubw
	bf7uquycJID3FGKJx83YnOlcf+ndpmJI=
X-Gm-Gg: AeBDies1jrhYfAWJ2gS/cQMLb+ehUns8ZZ/SOJzcf1Hy5Iut2s/I7RyphqLj0AvUoRO
	BxQgzPXH4JzSu+AdLqVwB9yGu/AFYOrxAgmSGUvHiTMPweJUBm10SYARq94XGv+aVPZrdA9PN8+
	evy+vYmFzR/pSCNVEOQPdPSwHowY9eGGetdKfRDD+IGFNBqov0qwXAmm6xYx0nM/LTYL/CIrz21
	UuUs0LzbFOPqqkoPj3NSv0n5wbg7VYaVRNZvUDzLZbCTL4dmxk04i2myK5RqGojLS2IuxcLpWy7
	orWkTEMdPejRRRT5S8uLJTrEmsr+ZnngkMsVHrv/hKGaiwHzMBcW3+v0kTki8gx5DjM9O+YshOC
	3HHj/iGbdphZfaHbpCcODeh4xeWPx/7AB9xRH8yrs8vXxW6iPUuQmz1GgvIdMZnOn9j7C68fUW7
	vG4ahhz7HLtHAS3NeVM/OVs8wCsjD5CAWFq3A5RzNNu24NVotg
X-Received: by 2002:a05:6000:24ca:b0:44a:52d5:e4f1 with SMTP id
 ffacd0b85a97d-44bb3207ac5mr9182290f8f.5.1777799630572; Sun, 03 May 2026
 02:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
In-Reply-To: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 3 May 2026 11:13:39 +0200
X-Gm-Features: AVHnY4Jq1K3tV8S88hLAacpOIUjqXIm6se8G5pLAsw9ZNMnaEFLFbSTfj1NzDT8
Message-ID: <CALoEA-x7kEXYNzGWJ-6dxJzBoShnx+26Y-VhDP4wFz99VsxiWQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: refactor accel/gyro configuration paths
To: =?UTF-8?Q?Jo=C3=A3o_Fernandes?= <joaovictor.fernandes@usp.br>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, gcotavio@usp.br, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 3 May 2026 at 05:17, Jo=C3=A3o Fernandes <joaovictor.fernandes@usp.=
br> wrote:
>
> Refactor accel and gyro configuration paths to remove duplicated
> logic and improve code structure.
> Introduce a generic helper, inv_icm42600_set_sensor_conf(), to handle
> common register programming and state updates.
>
> Keep sensor-specific handling in inv_icm42600_set_accel_conf() and
> inv_icm42600_set_gyro_conf() wrappers. Also extract configuration
> sanitization into a dedicated helper inv_icm42600_sanitize_conf()
> to further reduce repetition.

This should be (at least) a four-part patch series, please don't send multi=
ple
logical changes as one patch. Patches should be atomic and only deal with
one change/fix. Try to introduce preparatory patches when sending, it speed=
s
up the reviewing process.

> -int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
> -                               struct inv_icm42600_sensor_conf *conf,
> -                               unsigned int *sleep_ms)
> +static int inv_icm42600_set_sensor_conf(struct inv_icm42600_state *st,
> +                             struct inv_icm42600_sensor_conf *target_con=
f,
> +                             struct inv_icm42600_sensor_conf *accel_conf=
,
> +                             struct inv_icm42600_sensor_conf *gyro_conf,
> +                             struct inv_icm42600_sensor_conf *oldconf,
> +                             unsigned int reg_config0,
> +                             unsigned int target_config0_val,
> +                             unsigned int *sleep_ms)

Incorrect indentation, try to align the parameters within the parentheses
below each other.

>  {
> -       struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.accel;
>         unsigned int val;
>         int ret;
>
> -       /* Sanitize missing values with current values */
> +       /* set target sensor's CONFIG0 register */
> +       if (target_conf->fs !=3D oldconf->fs || target_conf->odr !=3D old=
conf->odr) {
> +               ret =3D regmap_write(st->map, reg_config0, target_config0=
_val);
> +               if (ret)
> +                       return ret;
> +
> +               oldconf->fs =3D target_conf->fs;
> +               oldconf->odr =3D target_conf->odr;
> +       }
> +
> +       /* set GYRO_ACCEL_CONFIG0 register */
> +       if (target_conf->filter !=3D oldconf->filter) {
> +               val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(accel_=
conf->filter) |
> +                     INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(gyro_conf=
->filter);
> +
> +               ret =3D regmap_write(st->map,
> +                                  INV_ICM42600_REG_GYRO_ACCEL_CONFIG0,
> +                                  val);
> +               if (ret)
> +                       return ret;
> +
> +               oldconf->filter =3D target_conf->filter;
> +       }
> +
> +       /* set PWR_MGMT0 register */
> +       return inv_icm42600_set_pwr_mgmt0(st, gyro_conf->mode, accel_conf=
->mode,
> +                                         st->conf.temp_en, sleep_ms);
> +}
> +
> +static void inv_icm42600_sanitize_conf(
> +       struct inv_icm42600_sensor_conf *conf,
> +       const struct inv_icm42600_sensor_conf *oldconf)
> +{
>         if (conf->mode < 0)
>                 conf->mode =3D oldconf->mode;
>         if (conf->fs < 0)
> @@ -306,6 +342,17 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_=
state *st,
>                 conf->odr =3D oldconf->odr;
>         if (conf->filter < 0)
>                 conf->filter =3D oldconf->filter;
> +}
> +
> +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
> +                               struct inv_icm42600_sensor_conf *conf,
> +                               unsigned int *sleep_ms)
> +{
> +       struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.accel;
> +       unsigned int config0_val;
> +
> +       /* Sanitize missing values with current values */
> +       inv_icm42600_sanitize_conf(conf, oldconf);
>
>         /* force power mode against ODR when sensor is on */
>         switch (conf->mode) {
> @@ -324,30 +371,12 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600=
_state *st,
>                 break;
>         }
>
> -       /* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> -       if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> -               val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
> +       config0_val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
>                       INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
> -               ret =3D regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONF=
IG0, val);
> -               if (ret)
> -                       return ret;
> -               oldconf->fs =3D conf->fs;
> -               oldconf->odr =3D conf->odr;
> -       }
> -
> -       /* set GYRO_ACCEL_CONFIG0 register (accel filter) */
> -       if (conf->filter !=3D oldconf->filter) {
> -               val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->=
filter) |
> -                     INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(st->conf.=
gyro.filter);
> -               ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL=
_CONFIG0, val);
> -               if (ret)
> -                       return ret;
> -               oldconf->filter =3D conf->filter;
> -       }
>
> -       /* set PWR_MGMT0 register (accel sensor mode) */
> -       return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->m=
ode,
> -                                         st->conf.temp_en, sleep_ms);
> +       return inv_icm42600_set_sensor_conf(st, conf, conf, &st->conf.gyr=
o, oldconf,
> +                                           INV_ICM42600_REG_ACCEL_CONFIG=
0,
> +                                           config0_val, sleep_ms);
>  }
>
>  int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
> @@ -355,45 +384,17 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_=
state *st,
>                                unsigned int *sleep_ms)
>  {
>         struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.gyro;
> -       unsigned int val;
> -       int ret;
> +       unsigned int config0_val;
>
> -       /* sanitize missing values with current values */
> -       if (conf->mode < 0)
> -               conf->mode =3D oldconf->mode;
> -       if (conf->fs < 0)
> -               conf->fs =3D oldconf->fs;
> -       if (conf->odr < 0)
> -               conf->odr =3D oldconf->odr;
> -       if (conf->filter < 0)
> -               conf->filter =3D oldconf->filter;
> +       /* Sanitize missing values with current values */
> +       inv_icm42600_sanitize_conf(conf, oldconf);
>
> -       /* set GYRO_CONFIG0 register (gyro fullscale & odr) */
> -       if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> -               val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
> +       config0_val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
>                       INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
> -               ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFI=
G0, val);
> -               if (ret)
> -                       return ret;
> -               oldconf->fs =3D conf->fs;
> -               oldconf->odr =3D conf->odr;
> -       }
>
> -       /* set GYRO_ACCEL_CONFIG0 register (gyro filter) */
> -       if (conf->filter !=3D oldconf->filter) {
> -               val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(st->co=
nf.accel.filter) |
> -                     INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->fil=
ter);
> -               ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL=
_CONFIG0, val);
> -               if (ret)
> -                       return ret;
> -               oldconf->filter =3D conf->filter;
> -       }
> -
> -       /* set PWR_MGMT0 register (gyro sensor mode) */
> -       return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.=
mode,
> -                                         st->conf.temp_en, sleep_ms);
> -
> -       return 0;
> +       return inv_icm42600_set_sensor_conf(st, conf, &st->conf.accel, co=
nf, oldconf,
> +                                           INV_ICM42600_REG_GYRO_CONFIG0=
,
> +                                           config0_val, sleep_ms);
>  }
>
>  int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enabl=
e,
> --
> 2.43.0
>

--=20
Kind regards

CJD
