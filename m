Return-Path: <john@metanate.com>
Date: Tue, 26 Jul 2016 12:16:40 +0100
From: John Keeping <john@metanate.com>
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, dianders@chromium.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, linux@roeck-us.net, jic23@kernel.org
Subject: Re: [PATCH 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
Message-ID: <20160726121640.2d5d9045.john@metanate.com>
In-Reply-To: <57974054.8040700@rock-chips.com>
References: <1469513510-1516-1-git-send-email-wxt@rock-chips.com>
	<20160726100007.5166e7f9.john@metanate.com>
	<57974054.8040700@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, 26 Jul 2016 18:49:56 +0800, Caesar Wang wrote:

>=20
> On 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 17:00, John Keeping wrote:
> > On Tue, 26 Jul 2016 14:11:47 +0800, Caesar Wang wrote:
> >
> >> SARADC controller needs to be reset before programming it, otherwise
> >> it will not function properly.
> >>
> >> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: Heiko Stuebner <heiko@sntech.de>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: linux-iio@vger.kernel.org
> >> Cc: linux-rockchip@lists.infradead.org
> >> ---
> >>
> >> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockc=
hip_saradc.c
> >> index f9ad6c2..2f0e110 100644
> >> --- a/drivers/iio/adc/rockchip_saradc.c
> >> +++ b/drivers/iio/adc/rockchip_saradc.c
> >> @@ -218,6 +231,13 @@ static int rockchip_saradc_probe(struct platform_=
device *pdev)
> >>   	if (IS_ERR(info->regs))
> >>   		return PTR_ERR(info->regs);
> >>  =20
> >> +	info->reset =3D devm_reset_control_get(&pdev->dev, "saradc-apb");
> >> +	if (IS_ERR(info->reset)) {
> >> +		ret =3D PTR_ERR(info->reset);
> >> +		dev_err(&pdev->dev, "failed to get saradc reset: %d\n", ret);
> >> +		return ret;
> >> +	}
> > Does this need to handle ENOENT so as to avoid failing with old device
> > tree blobs?
>=20
> I'm no sure why we have to support the old device tree,
> We can apply this series patches if we need to support the reset property.
> ---
>=20
> Maybe, I can follow you suggestion to handle the ENOENT, as following:
>=20
> + /*
> + * The reset should be an optional property, as it should work
> + * with old devicetrees as well
> + */
> + info->reset =3D devm_reset_control_get(&pdev->dev, "saradc-apb");
> + if (IS_ERR(info->reset)) {
> + if (PTR_ERR(info->reset) =3D=3D -EPROBE_DEFER) {
> + ret =3D -EPROBE_DEFER;
> + return ret;
> + }
> + dev_dbg(&pdev->dev, "no reset control found\n");
> + info->reset =3D NULL;
> + }
> ...
>=20
> How about it?

I think it's better to handle ENOENT specifically, we still want to fail
if some other errors like EINVAL is returned.

Something like this, perhaps?

    if (IS_ERR(info->reset)) {
        ret =3D PTR_ERR(info->reset);
        if (ret !=3D -ENOENT)
            return ret;

        dev_dbg(&pdev->dev, "no reset control found\n");
        info->reset =3D NULL;
    }

Although I do wonder if a devm_reset_control_get_optional() helper would
be useful (this isn't the first time I've seen reset control added to
existing drivers).
