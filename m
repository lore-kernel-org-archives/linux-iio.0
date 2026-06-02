Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8118787A
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408230; cv=pass; b=qinOiFwmxZtgnrO5wB7xDMon5+S4KBUauaiWpJ84knjTgBfcfZeUqZwOJ0jNSWBf/7lk9DV81o8HzUGZFW31ewLYijssA3AU1JbGyznIC0YeUyJH7ccIqtNSQOwwYwdnv6SWFP22kVDz8IJObV1VQsBXzZqu8BFOxOEwvpaLjrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408230; c=relaxed/simple;
	bh=NVI4xF0q0eE4RXQugggAMrzJxldQ0dmIPoc43HTpsWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9LtVU4BfCqWSjPXbjogBt6DY1sqa6YWz1H1HRj59uLDf6VRb+qWoaDOJCj/klDEsQcb5U1l3L3B+dBXk0HvRfcE5krP1eMa0dNlDQ10LWLljaWpC1nIqowus2U/z/GQCsvodhbAAW5N6F28UgJ0o6eAXBOEQT5b/xZ/euJtOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpZfRNzI; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpZfRNzI"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304545f5206so15600578eec.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408228; cv=none;
        d=google.com; s=arc-20240605;
        b=HgZ/+uuFUTLFAQTomrQKbifCj0kxppMQd6Fza0gVMXnf76ZTHsWXzip7Y9F24Ewnm3
         KiDbO/SNoNCXwXghbOQnLdHQEPkRuRPab87lLV0Y0TJRt9TdSdcMCJLIaJGSCjY+9ltk
         U9aGMRWXX57HGNmV3B48w0MK8xPVNJjU6Tz+znVXrBFtj7m/w0aGEkckRlz4/Ii0003a
         oPQU1Sq5qU8dTcgeWg9cIYESB5wuCt6939a2E10xqi+B5wmlD+10lS1VPWRGxM/Q73NN
         0d4t9JzmrDfaxiz4sEZoPvGhecGHdFvkO59jV8gj6QFB38nGCXWrfv2l9EVXnF7YPLnC
         KHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        fh=EpRyAciVR423HxR6HTtSyGHU8qLMGMe0JIK5ZfvBiPc=;
        b=cZ+FP3vTsfvSpVAOC/H8wrJGxUUNzWKuQFimX3sCNoFM4E4KGWjvUm35qzqVr6EeiO
         GzKMGKy41pJb2W7nD6SIWYon9RY2TgScDm+q3qhgN2xaPuApHpcGsO6AdvjWUb2/XiFK
         zJnHQbsGFcHyAMRm5Nl27wItUNEg000o6TDa/fuMGs/vUgKSavnxKMd7N5gq+w7UODxU
         /WCzpeCO8A+mO0Fh6QHFJNLpmCBEBzARWqbrfXcIlUCvuRphpVrALXBbr2tAFPrCSgls
         JERNQlUb/ZFs9pqJXNDIbOIZnMR10iivp4mc9BT1maOZM0gEWvP8dUIMvmtIfTs+8EoQ
         jgYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780408228; x=1781013028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        b=WpZfRNzII18pq3ZL6sObbH7QWDzG/lwUsSm8R/EAPn49vOM6x1YnRY6lU1kTrje/+r
         eH1unkYQWCB+UfaNlov/e1KTvzTuYaFPA/pPk64cte29X9zLnBYnEWHGNcXZ7rm1fUBj
         5IUcMifVOylKCBkbih3OuxCp3VDepMzqAIzuShWO23K0Sl/eNKptkHdhvBYNtrBbh5fc
         q2MDTkpjchmjAFZSofQzH/erjQ3z/41mVDrlemVKUXyyopDZCB2gMWNpwOWUGIQkbGe+
         Z/sbV+NH1e9evdm/MEbXdTxdYzmfDPlZVjnWqpv3JHvuBqaqk5ZKEKMqK4gFCmuQmsex
         Ijgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408228; x=1781013028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        b=DR95QUVkr2gP/S+1LOZbFOdGCkPnfoULLD/cHVsvl4ciwin9yApQ1BgQGxwScNyA4s
         uCSWLpihTwzI/JcLrlM/C+N5y65UU4cIzdaxvY0/3sKrfyUp83MN4SyD89nCwb+sAd3M
         SyM5Ofl4aGdwCSVmckyXYUyCM97aLWs5XmQCMs5S/yN0vO0DxiRcnHB1p7WbYLXkOIij
         T3jGsPUgPNTdOWdd14wPU8mO/jMhkqJShvCLc4SUiI86xje5ZiAxDMgXip8ExqGs6L+3
         ADxTSqmZAUQhAxWqRG5VF2Xpon4IwU2wOLXISBKy4VXh0paF703aUAM84k6YFhYevuEQ
         M4GQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cI6Y2nU4F8ofmmRE9xwLPK862pcXKTcmoHqV/mX917+lVXpIejIpj62j56UmYdbsySebt8+0zY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2UcAPT5oItCZ8BR2dnJZAx8IpVLAtkXNv2tziT+ra306bV/FB
	TiIogG05xdkjBNAMTQmwmwMfiorQpQwjYl612XXibgULGRUHwHjp0+++yRSvghfiJuWHp92FWx2
	e7/Vy95AU0T6kQE6wJ4wLURgoC6/v3Vg=
X-Gm-Gg: Acq92OG6Xxu9Jv12o1yzrWG112+bKqb7jToPJBNj+I2vtOUPpMpVne0Hxbq3iLMjfp7
	xc7nNxkFORlUxDBOLV3Fj9rXmOvawURGe81GXERQomBDlpd51eN4/jmv7zwkMuwjKOMqZkMiTon
	dZGW7PF4+UuCVkr76deeaK+9uurUOvMU4/qR4mmdnxbxd0Bhh1gzh0u6GVB+tbaU5OQzttBA2xq
	K+Ai/w5eftPqbtJGMaw61nIB431Wrf8hhcEemnYL3fTcBf598Yiq1UIU+OZUXBOKw5bq1X0odZg
	RDhby5fXcdXVAE55GrQ=
X-Received: by 2002:a05:7301:1f0d:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-304fa693628mr8033250eec.34.1780408227938; Tue, 02 Jun 2026
 06:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <20260602144640.433b4d35@jic23-huawei>
In-Reply-To: <20260602144640.433b4d35@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:50:16 +0300
X-Gm-Features: AVHnY4KYcv6nkoqF49he0KoddQyJUPiBV8YuVyKK6U5KG-s9hQUTG1_wCFFBKFE
Message-ID: <CAPVz0n1r97d8-uzhPGBx0LFSp75A3_2mMXDQQ30utT-6NtpHNA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:46=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:25 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
>
> > index 52136ca1abc9..55b35467a722 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
> > @@ -16,16 +16,19 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/mfd/lm3533.h>
> >
> >
> > -#define LM3533_ALS_RESISTOR_MIN                      1
> > -#define LM3533_ALS_RESISTOR_MAX                      127
> > +#define LM3533_ALS_RESISTOR_MIN                      1575
> > +#define LM3533_ALS_RESISTOR_MAX                      200000
> >  #define LM3533_ALS_CHANNEL_CURRENT_MAX               2
> >  #define LM3533_ALS_THRESH_MAX                        3
> >  #define LM3533_ALS_ZONE_MAX                  4
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
> >
> >
> > @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device =
*dev,
> >       int enable;
> >       int ret;
> >
> > -     if (als->irq) {
> > +     if (als->irq > 0) {
> >               ret =3D lm3533_als_get_int_mode(indio_dev, &enable);
> >               if (ret)
> >                       return ret;
> > @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_als_at=
tribute_group =3D {
> >       .attrs =3D lm3533_als_attributes
> >  };
> >
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > +static int lm3533_als_setup(struct lm3533_als *als)
> >  {
> >       struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode");
> > +
> >       ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> >                                LM3533_ALS_INPUT_MODE_MASK,
> > -                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
> > +                              als->pwm_mode ? LM3533_ALS_INPUT_MODE_MA=
SK : 0);
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > -                                  pdata->pwm_mode);
> > -
> > +                                  als->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > -                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > -                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > -                     return -EINVAL;
> > -             }
> > +     if (!als->pwm_mode) {
> > +             ret =3D device_property_read_u32(dev, "ti,resistor-value-=
ohms",
> > +                                            &als->r_select);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to ger resistor valu=
e\n");
> > +
> > +             als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTO=
R_MIN,
> > +                                   LM3533_ALS_RESISTOR_MAX);
>
> If we are getting garbage from DT I think I'd rather error out that paper=
 over
> that problem.  So similar to before, check valid value and if not fail pr=
obe
> so that hopefully someone goes and fixes it!
>

sure

> > +             als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_sel=
ect);
> Why do we need this when we didn't before?  The range checks are the same
> so it smells like it shouldn't need transforming. I'd also rather we didn=
't do
> rewriting of the meaning of r_select like this.  Just use a local variabl=
e for
> the intermediate result.
>

before pdata passed resistor value as actual register value, not we
are getting the actual resistance in ohms from the tree and must
convert it into register value.

> >
> >               ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > -                                pdata->r_select);
> > +                                als->r_select);
> >               if (ret)
> >                       return dev_err_probe(dev, ret, "failed to set res=
istor\n");
