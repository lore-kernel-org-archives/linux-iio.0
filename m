Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72053164BB
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778333596; cv=pass; b=tWWd8kfceaDbPeRRyQrgZF4GYTZTurFcYJWI8l+Ns/BC26nrBZvZEFwyN8n7qvfMz/ZfMzza3N5DRiJXCUprWdhmSYND02i/E5Or1++vR10aO4Pjto5swadUEpWlEbVQu1dQUL5BMKIeXw3uJNkuCfMCYzUizfnB9Z1eVJNHUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778333596; c=relaxed/simple;
	bh=dOk8E39mb22BTEfJuiqAp5RQRbHpHtVsimj//m1zr/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UETyPocwH7Ztp5Q8ToBPZeY0WtBKAEYTbuvbOUeevKCPrhQ2oynTbh3SgCubYqsjEdS8HQ3M3dRHpuXpqKWXFcoQTmC99gXn4T31Gs14K79OxQ4lK4tZCGBYHKzJqxMtjheZqdBXjaYuifAvEC1RY4Vh2aJ8jLLYIswEVPCMRqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHrtS+ZK; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHrtS+ZK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44e5624c053so1623223f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 06:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778333593; cv=none;
        d=google.com; s=arc-20240605;
        b=WB9s9JePxohN0IJM5M2HKLdszA/6nfL1i8+IaV+F4NJsb4RwPtKG0YsZgAAy9MyVIR
         JHkPecGhQ9U7S5RMaIiPNtZw3JXA78HkTil5bRwc349TqWrm6PSO98db2vhpL80lGGb5
         j2axUpYyzuGywodu8hGD5wgJDQwho9jJNysLTj+hkO17OqDHs45WRZNErjaeIk+5zLz0
         enh0VcesO/YIJT1vt8ycNm+X3z89N/sZyp4eYrpvEhUC13d6rZ61XnAcJiV2slxJliqJ
         JEP030X9fAbOteRSBk40n9TyYaTYafI2nE97E/WUpouD//s19su1N6OXDNAkeb4cqsof
         pU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlmOyub2Myu6SglLHPmoY1e0jNawMMYtSxeiECqecaE=;
        fh=dNo2pDp9anKXMxAQqmTol0LCUIYeWtGXJEmimLAVRko=;
        b=VJ8Y1fl0W5vVAx0yKjWdB1FvGoEKD/i/5gGjR1hGrXQYSh4SPqK19UgYaB6TgiNSCt
         BuQ+kL2kzfth6LtObnfUexT8G3sihX2Z0ApaFT5/SVATfQ7L8pR4DMIwYETcrFkHTfAO
         EqC+ckPBKcW872h8upEzOURT2Vk9L6od1HqnPfEafZCnb6XZ3LhF+YczRC7JQuGLEL4j
         z85su/nBbY0ga6Ug382RLpu5yDl+XRJObbdgKGpbIqu7KPjNGFNBnmt+lTBXrzUH0s3i
         qzJIgD66HZKTn4HpX0wdlzUtFBUuMcPCISF9s7M7NiV+R7x5DnQUhrZichTUhuMj8r1k
         ZRxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778333593; x=1778938393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlmOyub2Myu6SglLHPmoY1e0jNawMMYtSxeiECqecaE=;
        b=XHrtS+ZKdvuzlMShSXUxDJ45zZoAn7Ni2vmIlZUIvlOBwliayVB5IVD7qD3LWmsjZp
         0GBUQ0tOVyIp5Sq7orlg829wAPLmz71NkH9s1OanyGvYkhVIKXEdWqdAV5G/rstTkLH8
         Kpbl6fFDsKY9oE+zQ29MRUYfPYH7wW7okVhd4iUi79xkFGfIMAoU7xClIXNCOvgJUguL
         d3N4QWu2dx5A8iPTQM5x29GuR27yofrLxpK7GLOTYlFEo08MFn67TKRvEosJMhi7ntAm
         BtbiamiYC/3U80hJOeVu9jTKOEWKbXgFsMmHxo1C4GmXbf3YyPMGAoUUPNfU/Ea+tavn
         bMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778333593; x=1778938393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlmOyub2Myu6SglLHPmoY1e0jNawMMYtSxeiECqecaE=;
        b=A6IpiwKwHY8EUF5qCEOQdP/hOJHx+3PItS0lDAMW3+0Hx++HrlSmmb3h47432qvdNw
         5pGd0YN1FI0FSRPW/kvg+AcaJ/1mX+xFNT/X8vZWI6YjTc4LbDkQjJRYAjrGlIdzZeIz
         +IyrKRFVVO6QXO1emmBIDCLbg7R1wWB6nF1oiR5yvRcj/JVcYSGykm/PS6oqfR4H2tQQ
         DxAaFEgZqBLd+EThAAKnHK5g6xWVGN5hrDEulubDIi/Ix9Pi/A9m+f7MHXj8O2NiKNL1
         RZ+ikpSkjaDe7uUAFqKGrud6fgogaWo2SWbiwJToykqZVjciFz2wE0tdg3SdSsOtV0IR
         hLvg==
X-Forwarded-Encrypted: i=1; AFNElJ++VWhmuhp9YRzeU4tnjP+s+Lr94Wmy4xj5LdY0qcOOVG/dMUwM8UB2W0M4zReQjWb4zyrlRR7pF5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7/J9HdCYbIGMsMu+uzeqB8gdt9uF9v94khdItZ/2Ux7xOsuj
	2KGcWR9p9I1Bnbf3Uiuum9+IYqaQFTp+3BxUsHKvdKJxi5TEqzhjLcDqbdhcDKYH6CVXQjxTLni
	78oFKJJsg0pEtoWCucHd8C/siJwQJ/Lw=
X-Gm-Gg: Acq92OEmnx9jg23Vz9jyYPoQeTiJgof9wxb7LufvlHlTx5CmLaQTynFN53Th3LX+Vo3
	gXTWcKgbe4AwIT0LdlfQrVMgoICI4IqlJ5hoRAdc7noYK16lr6uUtLtn3/bR0BWToVt99q6Jp6W
	ztVKckKajUU+0hzL++yqjePy22SkJWthbVr/CC3SXP3YZhxnQn/sHtrcJ1E8H+SCrFnmRJRXgOS
	7lZM5NpKeoGWBDVbjEyNgE5fC5UWnv4gcJxIAV1H1DpmldmKFhjHXOQf46i451V2Q+Z0FS1KVHJ
	ka1Kj7CGT6jdsWCn9MdTDeTtpLhE/rQpvDohbMtdKrQtTLCHQcj+13t3zBJVoqamYLS00q05P/j
	5IDcVsrdvL7CmJ0ISh7GUbPW3TwpRYcCITYu4ouhLiFMGTc6sk95281Gq6KW0EidUWRGfT9SXl+
	hjPVPUc3sxHgIvYyuaH+AYVW2rZalxjB2wAynVejvCEeyaML2n
X-Received: by 2002:a05:6000:288e:b0:449:af52:6167 with SMTP id
 ffacd0b85a97d-4515b056e09mr27507824f8f.8.1778333592894; Sat, 09 May 2026
 06:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com> <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
In-Reply-To: <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 9 May 2026 15:32:59 +0200
X-Gm-Features: AVHnY4K_mZVFWq72ZVMJKwgMEKX-P-0P_klHRulolnib1W-uTR_IeWoPRb8KrFw
Message-ID: <CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 May 2026 at 11:02, Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> >
> > Additionally, remove any pm_runtime_get/put*() function calls that
> > dummy cycled the counter to autosuspend the device.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 74 ++++++++++++++++++++++---------=
--------
> >  1 file changed, 41 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetomet=
er/ak8975.c
> > index
> > 63b6e8465f5f3873841550a1cd03ce86b95d1d67..1d8f448d5179fe9b33af989cc2f45=
6ac91bc2f17
> > 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -898,9 +898,24 @@ static irqreturn_t ak8975_handle_trigger(int irq, =
void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     struct ak8975_data *ak =3D data;
> > +     struct device *dev =3D &ak->client->dev;
> > +
> > +     /* Only power down if currently active */
> > +     if (pm_runtime_status_suspended(dev))
> > +             return;
> > +
> > +     /* Soft-stop the chip before hard-stopping the regulators */
> > +     ak8975_set_mode(data, POWER_DOWN);
> > +     ak8975_power_off(data);
> > +}
> > +
> >  static int ak8975_probe(struct i2c_client *client)
> >  {
> >       const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> > +     struct device *dev =3D &client->dev;
> >       struct ak8975_data *data;
> >       struct iio_dev *indio_dev;
> >       struct gpio_desc *eoc_gpiod;
> > @@ -968,10 +983,21 @@ static int ak8975_probe(struct i2c_client *client=
)
> >       if (ret)
> >               return ret;
> >
> > +     /*
> > +      * Set device as active early so pm_runtime_status_suspended() wo=
rks
> > +      * correctly if probe fails before pm_runtime is enabled. Do not =
attempt
> > +      * to move this line lower.
> > +      */
> > +     pm_runtime_set_active(dev);
> > +
> > +     ret =3D devm_add_action_or_reset(dev, devm_ak8975_power_off, data=
);
> > +     if (ret)
> > +             return ret;
>
> This looks a bit hackish to me. Why don't we just register this powerdown=
 action
> after enabling PM?

This is to prevent a resource leak. If we register the power_off
function at the end,
any potential probe() failures will leave the regulators on.

> > +
> >       ret =3D ak8975_who_i_am(client, data->def->type);
> >       if (ret) {
> >               dev_err(&client->dev, "Unexpected device\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >       dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> >
> > @@ -979,10 +1005,13 @@ static int ak8975_probe(struct i2c_client *clien=
t)
> >       ret =3D ak8975_setup(client);
> >       if (ret) {
> >               dev_err(&client->dev, "%s initialization fails\n", name);
> > -             goto power_off;
> > +             return ret;
> >       }
> >
> > -     mutex_init(&data->lock);
> > +     ret =3D devm_mutex_init(dev, &data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> >       indio_dev->channels =3D ak8975_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(ak8975_channels);
> >       indio_dev->info =3D &ak8975_info;
> > @@ -990,52 +1019,32 @@ static int ak8975_probe(struct i2c_client *clien=
t)
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >       indio_dev->name =3D name;
> >
> > -     ret =3D iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle=
_trigger,
> > -                                      NULL);
> > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                           ak8975_handle_trigger, NULL=
);
> >       if (ret) {
> >               dev_err(&client->dev, "triggered buffer setup failed\n");
> > -             goto power_off;
> > +             return ret;
> >       }
> >
> > -     ret =3D iio_device_register(indio_dev);
> > +     ret =3D devm_iio_device_register(dev, indio_dev);
> >       if (ret) {
> >               dev_err(&client->dev, "device register failed\n");
> > -             goto cleanup_buffer;
> > +             return ret;
> >       }
> >
> >       /* Enable runtime PM */
> > -     pm_runtime_get_noresume(&client->dev);
> > -     pm_runtime_set_active(&client->dev);
> > -     pm_runtime_enable(&client->dev);
> > +     ret =3D devm_pm_runtime_enable(dev);
> > +     if (ret)
> > +             return ret;
>
> Maybe it would make sense to move this before devm_iio_device_register().=
 At the
> point we register the device, userspace can start to interact with the de=
vice where
> we have pm calls? Not that it is a problem (I think) but makes sense to m=
e to enable
> PM before exposing the device.

Sure, I agree with this.

--=20
Kind regards

CJD
