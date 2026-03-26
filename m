Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A633F166E
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527645; cv=none; b=KhfXMYMklNKjaS8/Bl/0MvrKk+OwlPFtYVfXW7dBJ01GgDBSOJS6UzHUzMzz8ZgKzpMOcA04wBqfqWByCPzBMS2d5Hw0F7AP8oYUiY8q2ENvyq7bXSJowYsqVHpD1w+PhU8puC4IR0Jpn4CiCMi2vZkmnwflY6zSTH5hbHczV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527645; c=relaxed/simple;
	bh=SjA50/xzPCzBZpeiNlpZ1frmsgq4yd5aqt5t9Ve+hv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO0qX17jsg+rwwl/LN+0GuKBG3FHcPts+338EzYZczW7dQcrb/O6IvVWv8lU/UYUnTRO0vjYU0HTlqyjEqRQ92cOPbLLKENSbS1J0n6Irvogi3jnMX5e4D/dQxE6obCwFCJCd9BJEP13CEB7/huYVeNe32ld2rKLNPCv3wAJw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64acd19e1dfso872658d50.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 05:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527643; x=1775132443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7OU8fAyOGvGnQIm42e3kymPTmEmyDZVdHe89ZVPV8s=;
        b=B2X0zp+zZS96QuKfj0fIJwcRNWiHg087/ZMOIUoJMtaF0qdSPS16TpCTyYvZ1UMFhY
         Ca2CLCRd20XDurZ3eOMUTb3nrOMie2fR9KSnAQrWBdAta+ntB7bAGHikQ95ffe5LhQMO
         ODAXH1pf69BntGqQJ5fOtVq1YxcAjrj+wBWi9aTw0j3yesJs1NFIJePej08M6Wj4VYcb
         HlFOfjELsrk2ZBnvqXnaZ90F5WKVGSUu77qkqSzI8H2bz2SXc6MnXZ8hpZ+VmcYbooYA
         BfF7r5Q1xEHmxKtlrB8ekZe5F44uXLLp2V1UtOvLmUfhLVW1aBez/91gt5hsyqX+tjh0
         AQ/w==
X-Gm-Message-State: AOJu0Yx6xOLhtx1xlmpVbb/iH7aQqKubofDt/MTYktjsyTZaPV/NRM64
	kLDJHu+InMJT9K4tZb3QL/UdG61+3rCx8se0k8U8OXeV3v55hvNZdfuhErhN9H4V
X-Gm-Gg: ATEYQzwB0mRlu4+RKlN2OERdoGZ1QuJ8pPaelBkxD5g2l0NdfP9dYGwKRVmqUIiuUCt
	Ev7O0U3qy98LCqAr7dTGS0+HSszH1+ZZGSJyEd6blFvKrW/PcARBFrm/I3doI/8ml/WWjYrZmfa
	GnlML8oByn9O1we4RMwNLwojAOImRl2u2DNU+utKEysxXeFSll4ryGKQjwKOWi4qeRQBKpBt3dR
	TwRq7q8DN9/Yd2l8ixjunEgIa7tv3KzEMY/FW5gUoBpKK+MwO8o4XbVEl0MSRXietkE+NLsAd9s
	ZRX6+hNPua2MV6uw1FHgR77YEm4MuNYvTjTASyRmhRvPw9N68JNwtqYzWqr/4IT29L2FfibMyjK
	3ylRH9o+zeVRvxX82wkfYjnp/CINkrequ3na8k5UwitQbra5x5OLAk06hz9wBDqOL1pb5TEh3ns
	Yz6qXguKerB4E9jD2YjEWsPsNTiE7sMZ0TVsZfgpK/RE9ulwXhIDEJ5A1ZI86huF0Xw+WMZjpKv
	/UDW+cpFIvpQEtF2iL2j9k9+ycWXznZbDqXykSiSg==
X-Received: by 2002:a05:690e:d55:b0:64c:9a6d:66bd with SMTP id 956f58d0204a3-64ee6082c3fmr6276619d50.8.1774527643299;
        Thu, 26 Mar 2026 05:20:43 -0700 (PDT)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com. [74.125.224.53])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef3c37f2esm1424027d50.0.2026.03.26.05.20.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:20:41 -0700 (PDT)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ee82e853cso756492d50.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 05:20:41 -0700 (PDT)
X-Received: by 2002:a05:690e:408a:b0:64e:e74c:76b with SMTP id
 956f58d0204a3-64ee74c0e9dmr6490680d50.37.1774527641472; Thu, 26 Mar 2026
 05:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325202005.29822-1-email@sirat.me> <20260325202005.29822-3-email@sirat.me>
 <acUHDGUqg4RdI7fW@ashevche-desk.local>
In-Reply-To: <acUHDGUqg4RdI7fW@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Thu, 26 Mar 2026 18:20:30 +0600
X-Gmail-Original-Message-ID: <CANn+LW+26VVCvr1aaqgBc8OiY7-OM8K_vWYN7wz=8-S4ChTPyA@mail.gmail.com>
X-Gm-Features: AQROBzCbsxKRoKqt2OgrX0C5boggozm_EFZh5iePbC7NZOX5nXS6PRubvYu5qvA
Message-ID: <CANn+LW+26VVCvr1aaqgBc8OiY7-OM8K_vWYN7wz=8-S4ChTPyA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 02:19:42AM +0600, Siratul Islam wrote:
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
>
> Some ideas for small followup amendments.
>
> ...
>
> > +#define VL53L1X_REG_SOFT_RESET                                        =
       0x0000
> > +#define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND            0=
x0008
> > +#define VL53L1X_REG_VHV_CONFIG__INIT                                 0=
x000B
> > +#define VL53L1X_REG_GPIO_HV_MUX__CTRL                                 =
       0x0030
> > +#define VL53L1X_REG_GPIO__TIO_HV_STATUS                               =
       0x0031
> > +#define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO                    0=
x0046
> > +#define VL53L1X_REG_PHASECAL_CONFIG__TIMEOUT_MACROP                  0=
x004B
> > +#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_A                   0=
x005E
> > +#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_A                     0=
x0060
> > +#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_B                   0=
x0061
> > +#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_B                     0=
x0063
> > +#define VL53L1X_REG_RANGE_CONFIG__VALID_PHASE_HIGH                   0=
x0069
> > +#define VL53L1X_REG_SYSTEM__INTERMEASUREMENT_PERIOD                  0=
x006C
> > +#define VL53L1X_REG_SD_CONFIG__WOI_SD0                                =
       0x0078
> > +#define VL53L1X_REG_SD_CONFIG__WOI_SD1                                =
       0x0079
> > +#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD0                     0=
x007A
> > +#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD1                     0=
x007B
> > +#define VL53L1X_REG_SYSTEM__INTERRUPT_CLEAR                          0=
x0086
> > +#define VL53L1X_REG_SYSTEM__MODE_START                                =
       0x0087
> > +#define VL53L1X_REG_RESULT__RANGE_STATUS                             0=
x0089
> > +#define VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0   0=
x0096
> > +#define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL                         =
       0x00DE
> > +#define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS                          0=
x00E5
> > +#define VL53L1X_REG_IDENTIFICATION__MODEL_ID                         0=
x010F
> > +#define VL53L1X_REG_DEFAULT_CONFIG                                   0=
x002D
>
> Keep the list ordered by the value?
>
> ...
>
> > +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> > +{
> > +     struct device *dev =3D regmap_get_device(data->regmap);
> > +     unsigned int val;
> > +     u16 model_id;
> > +     int ret;
> > +
> > +     if (!data->xshut_reset) {
> > +             ret =3D regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET=
, 0x00);
> > +             if (ret)
> > +                     return ret;
> > +             fsleep(100); /* conservative reset pulse, no spec */
> > +
> > +             ret =3D regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET=
, 0x01);
> > +             if (ret)
> > +                     return ret;
> > +             fsleep(1000); /* conservative boot wait, no spec */
> > +     }
> > +
> > +     ret =3D regmap_read_poll_timeout(data->regmap,
> > +                                    VL53L1X_REG_FIRMWARE__SYSTEM_STATU=
S, val,
> > +                                    val & BIT(0),
> > +                                    1 * USEC_PER_MSEC,
> > +                                    100 * USEC_PER_MSEC);
>
> Use logical split
>
>         ret =3D regmap_read_poll_timeout(data->regmap,
>                                        VL53L1X_REG_FIRMWARE__SYSTEM_STATU=
S,
>                                        val, val & BIT(0),
>                                        1 * USEC_PER_MSEC, 100 * USEC_PER_=
MSEC);
>
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "firmware boot timeout\n")=
;
> > +
> > +     ret =3D vl53l1x_read_u16(data, VL53L1X_REG_IDENTIFICATION__MODEL_=
ID,
> > +                            &model_id);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (model_id !=3D VL53L1X_MODEL_ID_VAL)
> > +             dev_info(dev, "unknown model id: 0x%04x, continuing\n", m=
odel_id);
> > +
> > +     ret =3D regmap_bulk_write(data->regmap, VL53L1X_REG_DEFAULT_CONFI=
G,
> > +                             vl53l1x_default_config,
> > +                             sizeof(vl53l1x_default_config));
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(data->regmap, VL53L1X_REG_GPIO_HV_MUX__CTRL, =
&val);
> > +     if (ret)
> > +             return ret;
> > +     data->gpio_polarity =3D !!(val & VL53L1X_GPIO_HV_MUX_POLARITY);
> > +
> > +     /* Initial ranging cycle for VHV calibration */
> > +     ret =3D vl53l1x_start_ranging(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra L=
ite Driver) */
> > +     ret =3D regmap_read_poll_timeout(data->regmap,
> > +                                    VL53L1X_REG_GPIO__TIO_HV_STATUS, v=
al,
> > +                                    (val & 1) !=3D data->gpio_polarity=
,
> > +                                    1 * USEC_PER_MSEC,
> > +                                    1000 * USEC_PER_MSEC);
>
> Ditto.
>
>         ret =3D regmap_read_poll_timeout(data->regmap,
>                                        VL53L1X_REG_GPIO__TIO_HV_STATUS,
>                                        val, (val & 1) !=3D data->gpio_pol=
arity,
>                                        1 * USEC_PER_MSEC, 1 * USEC_PER_SE=
C);
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D vl53l1x_clear_irq(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D vl53l1x_stop_ranging(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(data->regmap,
> > +                        VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BO=
UND,
> > +                        VL53L1X_VHV_LOOP_BOUND_TWO);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(data->regmap, VL53L1X_REG_VHV_CONFIG__INIT, 0=
x00);
> > +}
>
> ...
>
> > +     if (data->irq) {
> > +             reinit_completion(&data->completion);
> > +
> > +             ret =3D vl53l1x_clear_irq(data);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (!wait_for_completion_timeout(&data->completion, HZ))
> > +                     return -ETIMEDOUT;
> > +     } else {
> > +             unsigned int rdy;
> > +
> > +             /* 1ms poll, 1s timeout covers max timing budgets (per ST=
 Ultra Lite Driver) */
> > +             ret =3D regmap_read_poll_timeout(data->regmap,
> > +                                            VL53L1X_REG_GPIO__TIO_HV_S=
TATUS, rdy,
> > +                                            (rdy & 1) !=3D data->gpio_=
polarity,
> > +                                            1 * USEC_PER_MSEC,
> > +                                            1000 * USEC_PER_MSEC);
>
> Ditto.
>
>                 ret =3D regmap_read_poll_timeout(data->regmap,
>                                                VL53L1X_REG_GPIO__TIO_HV_S=
TATUS,
>                                                rdy, (rdy & 1) !=3D data->=
gpio_polarity,
>                                                1 * USEC_PER_MSEC, 1 * USE=
C_PER_SEC);
>
> Yes, in this case they are slightly longer than 80 characters. But
> looking at the above this entire call should be a helper, so you can
> reuse it here and above.
>
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
Hi Andy!

Thanks for the review again. I will send a small separate cleanup
patch for this once it gets to a more stable stage.

Sirat
