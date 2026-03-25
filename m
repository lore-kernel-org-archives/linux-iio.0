Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267D3FBED8
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456423; cv=none; b=O/9SJpdZP219p9O/GeNEUwH3YpBDz6PFMwJUHUR736tTgNghDRwev0Ja9rtU1jLeEXF7zGN4o/1O7DxBgMys8rLQYTWtUog9v5V3Kxnb4bdrvxM1KicUiNOFwf+KIlj25iCTxRPcgN2zPaCW51IW0Lp4nMnuaF+7FQoCjjQAtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456423; c=relaxed/simple;
	bh=h0O2cYoRVNJWzf+TBUudwD+89c3pM+LYikcFSp4MzJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec+nHql3qbv2PfN06R/s8R4YQl+NsHxh54hHncYH5xd2BR1a0L9Ees/3xa5I0Mj8IL0hv5Z+GtxhecxEzDwcnOtk6XCdVcc9k9uhm3Vh7ljeUyR88TYZBW4pWrd4OzOfJYWezZbw1kIpIRDgZ1aOKAMNXtSuo4LCM2pvMqSf34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-793fdbb8d3aso33987b3.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 09:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774456416; x=1775061216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8us9FMf4Ix2FjVhaTc55RnFnYiTbZ7h6aPgiDRplAFk=;
        b=kiFRGIGyVvfq852sPK2Z3IXQqijSH9bnatCdWocfj1HdH/mCs8twIoYJ/OTgqB2XrK
         nrcfhGwu+dkedFpAH9Y9LQDfZAGtp+1yOL7OGDOYnzIuLpJyHg6E9Uw0e8MHzm+7sfrI
         mdK1btxoGCGbRUAfNeueA+aEVwwbM5NjxfAMhqWCudKw0nSkq1vyQUqKTvx5aVOiLxF7
         WTpu2rPAi+PJLVQZOcrFaoTXaUy52w3IVi/cYKaJR4NIMq5BCL/RB1UJtolDNTQFHQwv
         Z3wIEr6fOh1m3v/vknnp2oD9ALlhj2oqzGIY6UEWE1krPr80WvNgYP8z5T4zTj2Tcbse
         hU9Q==
X-Gm-Message-State: AOJu0YyM7OcQBCKm/lXcBBFZHzRDGdDMPkRG6Xo1XTxuT9RPxxtmzcd9
	awAuWjWj4h0UWAeBdO2KgckceSfQ7zPb5B2BHB6tiF06J2xGyee/xA/QMxuvxG5K
X-Gm-Gg: ATEYQzzmkW9vC0udgbJZQbJ4bunilUdYCpHtZnZDvYzs7NQ25TpemShoKhgwP6I77Jh
	PD75xijXe13SssxQq8q/M6s2mMOg1fTwY8P3/lrxwwCgZHGsgzIXAWI99qFdQ0wNFlHOcjVOMxU
	5yAmTmGIxKZ+fogrmjmo6fey7yk5ji4dmlWAYyapyk2eKbDoYeZpL1P8biuu0fNCVKBDzLkE/V+
	acwpsp0vVreUhZuyfyuBVF25QmYvXXYZ520MEVgbBXSjYpUrBCvXjZ/HyfmVs5kDoPECAa3UsCP
	/MFAwdosW25nXkvZKIsSixo5KS5QEdgbXmoy6HlWDe4ljm/TctbBXIVB8YZYHSOEWy5OV4e9vmx
	h14B5BhkLi7tacj1xYHy2PQlf5/IdCnXhvcz9CUFMF8sZhBmVG7v1e5HLEEtnQekq+e/z9J+MUm
	vNi/dlpuGsenngQKvy9dGkOREpKnSbAWFVyBPhvx8fUFZttJu5Go2+qGfQv4Q6OXFwYniou0WCX
	qk+nfBn40+NfU8SJKezB2zzNzIC5gFKhWiiunNPcQ==
X-Received: by 2002:a05:690c:3181:b0:79a:ceaa:997a with SMTP id 00721157ae682-79acf328276mr41158017b3.3.1774456415497;
        Wed, 25 Mar 2026 09:33:35 -0700 (PDT)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com. [74.125.224.52])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b0b200e26sm593867b3.0.2026.03.25.09.33.34
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:33:34 -0700 (PDT)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ef161129bso59012d50.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 09:33:34 -0700 (PDT)
X-Received: by 2002:a05:690e:1286:b0:64c:a09f:12ab with SMTP id
 956f58d0204a3-64ee60a15f8mr3833496d50.30.1774456414053; Wed, 25 Mar 2026
 09:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063254.18062-1-email@sirat.me> <20260325063254.18062-3-email@sirat.me>
 <20260325144719.00005a92@huawei.com>
In-Reply-To: <20260325144719.00005a92@huawei.com>
From: Sirat <email@sirat.me>
Date: Wed, 25 Mar 2026 22:33:22 +0600
X-Gmail-Original-Message-ID: <CANn+LW+tLc2sQwfknieUi1pCat0+HQWrCFN0WTJ4rC_7_qFGpQ@mail.gmail.com>
X-Gm-Features: AQROBzDyk3XrETGSBpjycQrkM6of18Z8KC1GFbAqmc5msBHz6MbZdMnXNCjnOgQ
Message-ID: <CANn+LW+tLc2sQwfknieUi1pCat0+HQWrCFN0WTJ4rC_7_qFGpQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:47=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 25 Mar 2026 12:32:23 +0600
> Siratul Islam <email@sirat.me> wrote:
>
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Siratul Islam <email@sirat.me>
>
> Hi Siratul,
>
> I used this as a bit of an experiment as you'd +CC lkml and took a close
> read of the feedback google's AI bot produced.
> https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me
>
> Be very careful when considering the output. There are some things
> in here that are not true, or we don't generally defend against (like the
> interrupt type related comments).
>
> The iio_trigger_get() is (I think) a more general problem so ignore that
> for your driver - will just be a tiny memory leak and stop the
> module being easily unloaded.  I'll take a look at that one on a more gen=
eral
> basis.
>
> The regmap one is where these bots excel in that they sometimes go deeper
> in analysis than a typical person focused on one driver.
>
> The stuff on using standard devm_ wasn't from the bot and I think will ma=
ke
> things rather simpler.
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  MAINTAINERS                         |   1 +
> >  drivers/iio/proximity/Kconfig       |  15 +
> >  drivers/iio/proximity/Makefile      |   1 +
> >  drivers/iio/proximity/vl53l1x-i2c.c | 795 ++++++++++++++++++++++++++++
> >  4 files changed, 812 insertions(+)
> >  create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c
> >
>
> > diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximit=
y/vl53l1x-i2c.c
> > new file mode 100644
> > index 000000000000..085bff04f5d9
> > --- /dev/null
> > +++ b/drivers/iio/proximity/vl53l1x-i2c.c
...
> > +
> > +static int vl53l1x_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct vl53l1x_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(client->adapter,
> > +                                  I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> > +                                  I2C_FUNC_SMBUS_BYTE_DATA))
> Sashiko had an interesting comment on this...
> https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me
> (note in general be careful with this tools feedback, it has a significan=
t
> false positive rate!)
>
> "Does this check needlessly reject pure I2C adapters?
> The driver configures regmap with reg_bits =3D 16, which forces regmap to=
 use
> raw I2C transfers requiring I2C_FUNC_I2C. Checking for SMBUS_READ_I2C_BLO=
CK
> might prevent the driver from loading on pure I2C adapters that can perfe=
ctly
> support the device via regmap."
>
> By by reading the comment is actually wrong, however... It did made me lo=
ok.
> With regbits =3D=3D 16 & valbits =3D=3D 8
> The regmap code checks for I2C_FUNC_SMBUS_I2C_BLOCK
> (and if not present fails).
>
> So the I2C_FUNC_SMBUS_BYTE_DATA seems unused and
> a broader check on both read and write versions of I2C_BLOCK seems
> appropriate.
>
> However, not a lot of point in checking it at all given regmap does
> so for us. So I'd drop this check.
>
> If anyone is bored, we should probably take a look to see if there
> are other redundant (or wrong) calls for this.
>
> There is another point about trigger references that might be
> correct (but not unique to this driver so ignore it).  That warrants
> some investigation - I'll take a look in near future.
>
I will drop the check altogether here then.
...
> > +     /*
> > +      * XSHUT held low puts the chip in hardware standby. All register
> > +      * state is lost on de-assert so this is functionally a reset.
> > +      */
> > +     data->xshut_reset =3D devm_reset_control_get_optional_exclusive(d=
ev, NULL);
>
> If you can switch to devm_regulator_get_enabled() this can I think be
>         ret =3D devm_reset_control_get_optional_exclusive_deasserted()
> removing the need to register the action to power off.
>
> If you do that remember we still need the sleep after this call.
>
So I will move the sleep after
devm_reset_control_get_optional_exclusive_deasserted() then.
>
>
Thanks for the detailed review, Jonathan!

A quick question. Since these are some small  fixes, mostly removals,
and the patch has seen quite some revisions, does the 1 week wait rule
still apply here? I am still getting used to this mailing workflow
coming from the PR workflow of Github and it will help me in the
future.

Thanks
Sirat
