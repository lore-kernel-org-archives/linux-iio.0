Return-Path: <SRS0=+ZQ/=57=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Mon, 26 Jun 2017 07:01:15 +0200
In-Reply-To: <1498445692.844.5.camel@mhfsdcap03>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com> <1498110274-18678-3-git-send-email-zhiyong.tao@mediatek.com> <20170624210043.29569f3a@kernel.org> <1498445692.844.5.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 2/3] iio: adc: mt7622: add support for suspend/resume.
To: zhiyong tao <zhiyong.tao@mediatek.com>,Jonathan Cameron <jic23@kernel.org>
CC: robh+dt@kernel.org,knaack.h@gmx.de,lars@metafoo.de,pmeerw@pmeerw.net,srv_heupstream@mediatek.com,liguo.zhang@mediatek.com,yingjoe.chen@mediatek.com,sean.wang@mediatek.com,matthias.bgg@gmail.com,s.hauer@pengutronix.de,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-iio@vger.kernel.org,linux-mediatek@lists.infradead.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <114E2942-6A96-432A-A4E1-6976440D1883@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 26 June 2017 04:54:52 CEST, zhiyong tao <zhiyong=2Etao@mediatek=2Ecom> =
wrote:
>On Sat, 2017-06-24 at 21:00 +0100, Jonathan Cameron wrote:
>> On Thu, 22 Jun 2017 13:44:33 +0800
>> Zhiyong Tao <zhiyong=2Etao@mediatek=2Ecom> wrote:
>>=20
>> > This patch supports auxadc suspend/resume flow=2E
>> > Disable auxadc clk and power in suspend function=2E
>> > Enable axuadc clk and power in resume function=2E
>> >=20
>> > Signed-off-by: Zhiyong Tao <zhiyong=2Etao@mediatek=2Ecom>
>> Worth handling the cases where power management is not configured
>into the
>> kernel properly=2E
>>=20
>> So a few minor suggestions=2E  Otherwise looks good to me=2E
>> > ---
>> >  drivers/iio/adc/mt6577_auxadc=2Ec |   37
>+++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 37 insertions(+)
>> >=20
>> > diff --git a/drivers/iio/adc/mt6577_auxadc=2Ec
>b/drivers/iio/adc/mt6577_auxadc=2Ec
>> > index 2d104c8=2E=2E2dd7c74 100644
>> > --- a/drivers/iio/adc/mt6577_auxadc=2Ec
>> > +++ b/drivers/iio/adc/mt6577_auxadc=2Ec
>> > @@ -184,6 +184,37 @@ static int mt6577_auxadc_read_raw(struct
>iio_dev *indio_dev,
>> >  	=2Eread_raw =3D &mt6577_auxadc_read_raw,
>> >  };
>> > =20
>> > +static int mt6577_auxadc_resume(struct device *dev)
>> > +{
>> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> > +	struct mt6577_auxadc_device *adc_dev =3D iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	ret =3D clk_prepare_enable(adc_dev->adc_clk);
>> > +	if (ret) {
>> > +		pr_err("failed to enable auxadc clock\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>> > +			      MT6577_AUXADC_PDN_EN, 0);
>> > +	mdelay(MT6577_AUXADC_POWER_READY_MS);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int mt6577_auxadc_suspend(struct device *dev)
>> Mark these __maybe_unused for the CONFIG_PM but not CONFIG_PM_SLEEP
>case=2E
Preferred to mark __maybe_unused and use the macro mentioned below=2E
>
>=3D=3D> ok, We will add CONFIG_PM_SLEEP for the suspend/resume case in v2=
=2E
>thanks!
>
>> > +{
>> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> > +	struct mt6577_auxadc_device *adc_dev =3D iio_priv(indio_dev);
>> > +
>> > +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>> > +			      0, MT6577_AUXADC_PDN_EN);
>> > +	clk_disable_unprepare(adc_dev->adc_clk);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> >  static int mt6577_auxadc_probe(struct platform_device *pdev)
>> >  {
>> >  	struct mt6577_auxadc_device *adc_dev;
>> > @@ -269,6 +300,11 @@ static int mt6577_auxadc_remove(struct
>platform_device *pdev)
>> >  	return 0;
>> >  }
>> > =20
>> > +static const struct dev_pm_ops mt6577_auxadc_pm_ops =3D {
>> > +	=2Esuspend =3D mt6577_auxadc_suspend,
>> > +	=2Eresume =3D mt6577_auxadc_resume,
>> > +};
>> > +
>> Use the SIMPLE_SYSTEM_PM_OPS macro to make these assignments
>magically go away
>> if PM_CONFIG_SLEEP is not defined=2E
>
>=3D=3D> ok, We will use SIMPLE_DEV_PM_OPS macro to change it in v2=2E Tha=
nks=2E
>>>  static const struct of_device_id mt6577_auxadc_of_match[] =3D {
>> >  	{ =2Ecompatible =3D "mediatek,mt2701-auxadc", },
>> >  	{ =2Ecompatible =3D "mediatek,mt8173-auxadc", },
>> > @@ -280,6 +316,7 @@ static int mt6577_auxadc_remove(struct
>platform_device *pdev)
>> >  	=2Edriver =3D {
>> >  		=2Ename   =3D "mt6577-auxadc",
>> >  		=2Eof_match_table =3D mt6577_auxadc_of_match,
>> > +		=2Epm =3D &mt6577_auxadc_pm_ops,
>> >  	},
>> >  	=2Eprobe	=3D mt6577_auxadc_probe,
>> >  	=2Eremove	=3D mt6577_auxadc_remove,
>>=20
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
