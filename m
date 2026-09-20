Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB901DD525
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878061; cv=pass; b=ZoJTbVtPH/ZYaZcgteFpPFenLhCsRqVVo22g41mSl3tvZ/pb2vLv7QobE/VtADCmC6Y/F+QClxMpK/2FXVA+fJZvF3SdnVBeaxRjx2ivVi5hxOvWuRQ+DWtwcxe+FhyYW9j+YDGb8/z195GYKC0QC1nwmM0YombUl52Rp4lirm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878061; c=relaxed/simple;
	bh=gYUkzjKioAA+f+7IvuUVsZLVTUD+1nYh7rIkFFjMFEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0pLAX3VcC08NqTQ0AIv031OeTGz/Yvz0mW1CfY41bcOu5MoHZ5u0DKD/h+qauWOrEvVEspMzc4+SgVKpU1dl18T8v3iHZz/Zie/HzaoH4MYUHvbXBd7mJkDl9Yrmd+y3Q+j7r3ndsmppewePmpR/Ounkn9myYPlB7lTFaQZJjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRDRY5DX; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRDRY5DX"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1344919a91.3
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 21:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789878059; cv=none;
        d=google.com; s=arc-20260327;
        b=s9wFrUKUmWi/Z3nMJa36YP2Mym98ksNBH0ERn3bBM4j6DpNlq2Qe8SoMVsywilhGiR
         X4su0A32zEJdRaBmxS0HQNJteX7Aqzw4GBiT2aw5x9u+aXC8gF63WYAbHwYeQvm0U0jh
         AOOte3XzjRZyLXIzxuSjeS9zaObS1KV48N1UVOQ1bPryoHV+d10/s3+vqLnb1ShAyVHJ
         LNUNcSz0daIgcmbHmT3RiQA0D+4d9nSvDQTcgyWbd6VlKHLB2dH+HaAK3+y0AvFSMBBq
         RR5G0oYElMJ8qz3GKObPfbf+TYhjEgSr/N6W+PycLnVX3hSuE2l64y6VP0w3busDyZBH
         +Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0rQW/fe8BobSDmFnF0tV0bxHOOXEM5zynZeW/RC42Q=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=rdAU+PG56Feyd0ldrfoZsBPrPCg8fEsrl8fI/f9/mQ2qrJOze4dioydATYD6HVk68j
         7JBibSt78R3GlCbnCpW0Tq0si+az8qa2QSpGthUF+jpcQIrKuyAfdAELJog5SmzKkHkd
         Jvk1LliDYSnO5mXTr6LrWk63mTKtRfGw1rFYQ5IRuHxZGNuzoPuOJteJ1Ok7Etnuc0b7
         etPB8iNytsBQeyc94Txzj+CJrgxMtEm2V3EZ+Dzf3QL6QNtEvvUcA40E3xng54XTJvs5
         gtcScNHVvbA/BPmGJkZXa603MHUaeU7NLrGWwmdVr+It9kVjHdKic6VB7ZF4kVjdLKot
         rKQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789878059; x=1790482859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H0rQW/fe8BobSDmFnF0tV0bxHOOXEM5zynZeW/RC42Q=;
        b=jRDRY5DXbM6JX1Vpm91aGQwdQD/gDiOuxtRbbvVSXnNCKDHwcsblT/NLgx2t299OO4
         BO856YZGqWkYWlFhIrQBAOojDJ6qpdQkvztyhHD1lzZMeqgZscoYrM5RdB7EVpHbjWUu
         wtAaKXAVpkK56xYa0dXtZjANX0MPK9CCL8RXSvQF7bZ1kyX4MF5Y/bNBgPKZ7L58zuwt
         rolKdW5LiHKeKE8mT7FBtfE83JMO6FbDhCJvUrsTetaxroNmx+Nv7zXLCp54WRGwhKGD
         zn2WRleiqHf5Cfxdtn29sFedDtHxoaJbXSaiW3yxhlYdBvBKGymstpOjy2CRTOTHwxId
         P8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789878059; x=1790482859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H0rQW/fe8BobSDmFnF0tV0bxHOOXEM5zynZeW/RC42Q=;
        b=cf8SLvuMG/dkEKCZF/k5dJsJQbAGX39QdNe6m4UfJhJ2MUrf4kMpZl+jCdEqrfY/06
         oR1mWwHh8nREUYDBZZkAU73gK2TepxUM36i6QzQNYe7tE/ICRq0Oz7unZDhdMgNs1Zhj
         pxAUtZDmrRDvQbVCFHlDz6DjCSbfuBpE6TVnlSElh/Qng4zSSBPZhy+gCWwx7giurNnq
         tGnSH1ksvqofFwY9SY7ZZ4TKOjqX/bT2Q0kPGTfWDTSVS3NUDV6u8o4z0GHqKOhR+vAd
         tA0mTqp0ub65CbgfWSeoJs5AiSa1gfT6bnItpCH/TtsLEei/bQJAozXDXr2/qP5gPPpP
         DrRQ==
X-Gm-Message-State: AFuF++k6B45w0cOGujMdYeb04kY9G27qX2sw7yAaYy1vab7qjFzxmB5F
	uAvX/1Ezeeaqvi0qdCzrG8beQ9oH7nOGN25YomWwAeli5LLQUKmdrcZoofweeH8zSVjOqq/64ih
	YwyNpD+0eZPWGe8zlJa3ieno3/deQ690=
X-Gm-Gg: AYBFou0uDimTI3pNIy1p57dVLIidXxpVPcyNFPNjkd4miMvGvA+Tqi7EWZQMlGfzY3S
	dJDRWPZncMYHD7CiMDoY2tI1j0jPUtI8OC1Scm169k3xnQyj41ifC53ZMAKOc/YhTHC8tUfK43B
	pSGdsz9RqLTw+V4+Rb2PoHTCcBCjlI8CWMdf9OH5cnOc4YxOoepHV50uuDqQsQIsW2YuOrMyHvm
	jtLHV7d4GE2bH5Z2Blqwuu665hJKtuHDCbeI7OHdwRwAKslNFEb0EOBRf5gdhzOBrf2qSv73m8F
	NGy9ReSnunpa9Wh5Or4PpNt3En0JMNj+cJ0hA6vxyzT+UWVKvgd0vyY3CSqOwavpUVujastG2KJ
	UXQUIZrCI3pjyytdlb2pXu9Fgru/thbMPTwBrsf4N
X-Received: by 2002:a17:90b:4a85:b0:39e:6a80:dd9b with SMTP id
 98e67ed59e1d1-39e6a810c53mr5806147a91.34.1789878059055; Sat, 19 Sep 2026
 21:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <c88d0ced0bff5cf29e765cd2c280ce3c10c50988.1789753020.git.kimjinseob88@gmail.com>
 <20260920030352.62526119@jic23-hlaptop>
In-Reply-To: <20260920030352.62526119@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 13:20:50 +0900
X-Gm-Features: AcwNN1XwUMOHO7d-HTPl9R3DieB_QiBkB93sTGZ-NwPkf20y7940qgwv84fQjLA
Message-ID: <CALMSewLa+UF6khnZDNC+kPJz7EXx9PtCud75UE28_4sZb6CSsg@mail.gmail.com>
Subject: Re: [PATCH v10 6/8] iio: osf: add IIO devices from capability reports
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Using an extra lock is one solution I suppose to the risk
> of this racing with the buffer tear down and the problems
> around active_scan_mask being freed. Could you use
>
>     if (iio_device_try_claim_buffer_mode(indio_dev))
>
> and later a release on that to achieve the same result?
>
> Only the ade9000 is doing similar at the moment so would need
> some testing to make sure no lock inversions occur in general
> but given you don't take any other locks in here it should be fine.

I think that should be a better fit here. I'll test replacing the
private buffer lock and active flag with
iio_device_try_claim_buffer_mode() , iio_device_release_buffer_mode(),
including the existing buffer disable/unregister race coverage and
lockdep checks.

If that confirms the expected serialization against buffer
reconfiguration, I'll use that approach in the next revision.

Thanks,

Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 11:03, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:44 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Register IIO devices from supported capability descriptors and expose
> > signed raw samples, descriptor scales and software buffers. Keep early
> > capabilities owned by the core until UART and supply setup is complete,
> > and unregister children after the receive producer has stopped.
> >
> > Validate nonzero descriptor scales and sample/descriptor equality, leav=
e
> > discovery open after empty or unsupported inventories, and compare
> > repeated descriptors independently of order. Fault a bound session if a
> > descriptor changes meaning, gating cache and buffer publication togethe=
r.
> >
> > Add initialized active-scan packing and buffer producer quiescence. The
> > production implementation is now complete; subsequent patches only add
> > the existing core and IIO KUnit suites and their build wiring.
>
> No need to talk about what other patches do and that a series is function=
ally
> complete in a patch. If you want to do it, under the --- so it doesn't en=
d
> up in the git log.
>
> >
> > Assisted-by: LLM
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
>
> A few things inline.  Biggest one is a question (I'm not sure) on
> whether you can use a claim on buffered mode (which will hold it in that
> if it succeeds until released) is sufficient to replace the extra lock yo=
u
> have to block that transition.
>
> Thanks,
>
> Jonathan
>
>
>
> > diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opens=
ensorfusion/osf_iio.c
> > new file mode 100644
> > index 000000000000..f4011b8fae14
> > --- /dev/null
> > +++ b/drivers/iio/opensensorfusion/osf_iio.c
> ...
>
> > +
> > +struct osf_iio_scan_3axis {
> > +     s32 values[3];
> > +     u32 padding;
> No needed unless you explicitly write into padding for some reason.
> C rules add it anyway and then we don't need to make sure it remains
> correct if this structure changes in future.
> > +     aligned_s64 timestamp;
> > +};
> > +
> > +struct osf_iio_scan_1axis {
> > +     s32 value;
> > +     u32 padding;
> As above, unneeded.
> > +     aligned_s64 timestamp;
> > +};
>
> Given I think these are only used in one place, moving them to there woul=
d
> avoid need for named structure types.
>
> > +
> > +#define OSF_MOD_CHAN(_type, _mod, _idx)                              \
> > +     {                                                               \
> > +             .type =3D (_type),                                       =
 \
> > +             .modified =3D 1,                                         =
 \
> > +             .channel2 =3D (_mod),                                    =
 \
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
 \
> > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),  =
 \
> > +             .scan_index =3D (_idx),                                  =
 \
> > +             .scan_type =3D {                                         =
 \
> > +                     .sign =3D 's',                                   =
 \
> > +                     .realbits =3D 32,                                =
 \
> > +                     .storagebits =3D 32,                             =
 \
> > +                     .endianness =3D IIO_CPU,                         =
 \
> > +             },                                                      \
> > +     }
> > +
> > +#define OSF_CHAN(_type, _idx)                                        \
>
> Given this is not much used, you could use the IIO_NO_MOD modifier as a g=
ate
> on setting .modified =3D (_mod !=3D IIO_NO_MOD) ? 1 : 0,
> and have just one macro.
>
> > +     {                                                               \
> > +             .type =3D (_type),                                       =
 \
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
 \
> > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),  =
 \
> > +             .scan_index =3D (_idx),                                  =
 \
> > +             .scan_type =3D {                                         =
 \
> > +                     .sign =3D 's',                                   =
 \
> > +                     .realbits =3D 32,                                =
 \
> > +                     .storagebits =3D 32,                             =
 \
> > +                     .endianness =3D IIO_CPU,                         =
 \
> > +             },                                                      \
> > +     }
> > +
> > +static const struct iio_chan_spec osf_accel_channels[] =3D {
> > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_X, 0),
> > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Y, 1),
> > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Z, 2),
> > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static const struct iio_chan_spec osf_gyro_channels[] =3D {
> > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_X, 0),
> > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, 1),
> > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, 2),
> > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static const struct iio_chan_spec osf_mag_channels[] =3D {
> > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_X, 0),
> > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Y, 1),
> > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Z, 2),
> > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static const struct iio_chan_spec osf_temp_channels[] =3D {
> > +     OSF_CHAN(IIO_TEMP, 0),
> > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> > +static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] =3D {
> > +     {
> > +             .sensor_type =3D OSF_SENSOR_ACCELEROMETER,
> > +             .channel_count =3D 3,
> > +             .name =3D "osf-accel",
> > +             .channels =3D osf_accel_channels,
> > +             .num_channels =3D ARRAY_SIZE(osf_accel_channels),
> > +     },
> > +     {
> > +             .sensor_type =3D OSF_SENSOR_GYROSCOPE,
> > +             .channel_count =3D 3,
> > +             .name =3D "osf-gyro",
> > +             .channels =3D osf_gyro_channels,
> > +             .num_channels =3D ARRAY_SIZE(osf_gyro_channels),
> > +     },
> > +     {
> > +             .sensor_type =3D OSF_SENSOR_MAGNETOMETER,
> > +             .channel_count =3D 3,
> > +             .name =3D "osf-magn",
> > +             .channels =3D osf_mag_channels,
> > +             .num_channels =3D ARRAY_SIZE(osf_mag_channels),
> > +     },
> > +     {
> > +             .sensor_type =3D OSF_SENSOR_TEMPERATURE,
> > +             .channel_count =3D 1,
> > +             .name =3D "osf-temp",
> > +             .channels =3D osf_temp_channels,
> > +             .num_channels =3D ARRAY_SIZE(osf_temp_channels),
> > +     },
> > +};
> > +
> > +static const struct osf_iio_sensor_spec *
> > +osf_iio_find_sensor_spec(u16 sensor_type, u16 channel_count)
> > +{
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(osf_iio_sensor_specs); =
i++) {
> > +             if (osf_iio_sensor_specs[i].sensor_type =3D=3D sensor_typ=
e &&
> > +                 osf_iio_sensor_specs[i].channel_count =3D=3D channel_=
count)
> > +                     return &osf_iio_sensor_specs[i];
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
> > +{
> > +     if (osf_iio_find_sensor_spec(sensor_type, channel_count))
> > +             return true;
> > +
> > +     return false
>
>         return osf_iio_find_sensor_spec(sensor_type, channel_count) !=3D =
NULL;
>
> > +}
>
> > +
> > +static int osf_iio_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > +
> > +     guard(mutex)(&state->buffer_lock);
>
> These transistions are already guarded by the core, so see the question l=
ater
> on whether you can just claim buffered mode in the data handler
> to avoid the need for this. That might not work but the way you did
> this got me thinking about a more general solution to the problem.
>
> > +     state->buffer_active =3D true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int osf_iio_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > +
> > +     /* Wait for the current push before the IIO core changes its buff=
ers. */
> > +     guard(mutex)(&state->buffer_lock);
> > +     state->buffer_active =3D false;
> > +
> > +     return 0;
> > +}
>
>
> > +
> > +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> > +                     u16 channel_count)
> > +{
> > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > +     s64 timestamp;
> > +
> > +     if (channel_count !=3D state->spec->channel_count)
> > +             return -EPROTO;
> > +
> > +     guard(mutex)(&state->buffer_lock);
>
> Using an extra lock is one solution I suppose to the risk
> of this racing with the buffer tear down and the problems
> around active_scan_mask being freed. Could you use
>
>         if (iio_device_try_claim_buffer_mode(indio_dev))
> and later a release on that to achieve the same result?
>
> Only the ade9000 is doing similar at the moment so would need
> some testing to make sure no lock inversions occur in general
> but given you don't take any other locks in here it should be fine.
>
>
> > +     if (!state->buffer_active || !iio_buffer_enabled(indio_dev))
> > +             return 0;
> > +
> > +     timestamp =3D iio_get_time_ns(indio_dev);
> > +
> > +     switch (channel_count) {
> > +     case 1: {
> > +             struct osf_iio_scan_1axis scan =3D {
> > +                     .value =3D values[0],
> > +             };
> As suggested above, this structure type is only used locally here. So
> make the definition local as well.
>                 struct {
>                         s32 value;
>                         aligned_s64 timestamp;
>                 } scan =3D { };
>
> > +
> > +             return iio_push_to_buffers_with_ts(indio_dev, &scan,
> > +                                                sizeof(scan), timestam=
p);
> > +     }
> > +     case 3: {
> > +             struct osf_iio_scan_3axis scan =3D {
> > +                     .values =3D { },
>
> Setting values doesn't add anything useful as =3D { }
> zeros the whole structure (including any holes - they kernel is
> built with specific compiler options to ensure that last bit
> as it wasn't required in older c specs).
>
> > +             };
> > +             unsigned int channel, index =3D 0;
>
> Please split declarations that assign and ones that don't on to separate =
lines.
> Ends up a little more readable.
>                 unsigned int index =3D 0;
>                 unsigned int channel;
>
> > +
> > +             /* Pack the active channels; unused storage remains initi=
alized. */
> > +             for_each_set_bit(channel, indio_dev->active_scan_mask, ch=
annel_count)
> > +                     scan.values[index++] =3D values[channel];
> > +
> > +             return iio_push_to_buffers_with_ts(indio_dev, &scan,
> > +                                                sizeof(scan), timestam=
p);
> > +     }
> > +     default:
> > +             return -EPROTO;
> > +     }
> > +}
>
> > diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/op=
ensensorfusion/osf_serdev.c
> > index 8a747c01ff9d..3d5e90d83967 100644
> > --- a/drivers/iio/opensensorfusion/osf_serdev.c
> > +++ b/drivers/iio/opensensorfusion/osf_serdev.c
> > @@ -23,7 +23,7 @@ struct osf_serdev {
> >       bool vcc_enabled;
> >       struct osf_device osf;
> >       struct osf_stream stream;
> > -     /* Protects the parser and all RX counters. */
> > +     /* Protects the parser, all RX counters, and the registration gat=
e. */
> >       struct mutex rx_lock;
>
> Just name it 'lock' given it has scope beyond rx.  Do that in earlier pat=
ch
> though rather than changing it here.
>
> >  };
>
> >
> > @@ -139,5 +144,5 @@ static struct serdev_device_driver osf_serdev_drive=
r =3D {
> >  };
> >  module_serdev_device_driver(osf_serdev_driver);
> >
> > -MODULE_DESCRIPTION("Open Sensor Fusion UART receiver");
> > +MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
>
> Just have that being slightly missleading in earlier patch to reduce chur=
n here.
>
> >  MODULE_LICENSE("GPL");
>
