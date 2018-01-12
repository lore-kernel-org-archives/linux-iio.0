Return-Path: <SRS0=DKsY=EH=huawei.com=weiyongjun1@kernel.org>
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@st.com>, Mark Brown <broonie@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@st.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] IIO: ADC: fix return value check in
 stm32_dfsdm_adc_probe()
Date: Fri, 12 Jan 2018 01:37:20 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB40132A0E3@dggemi507-mbx.china.huawei.com>
References: <1515669161-125426-1-git-send-email-weiyongjun1@huawei.com>
 <20180111212837.minmnjkvhudstafs@mwanda>
In-Reply-To: <20180111212837.minmnjkvhudstafs@mwanda>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

>=20
> On Thu, Jan 11, 2018 at 11:12:41AM +0000, Wei Yongjun wrote:
> > In case of error, the function devm_iio_device_alloc() returns NULL
> > pointer not ERR_PTR(). The IS_ERR() test in the return value check
> > should be replaced with NULL test.
> >
> > Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC
> support")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-
> dfsdm-adc.c
> > index e628d04..5e87140 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -1100,9 +1100,9 @@ static int stm32_dfsdm_adc_probe(struct
> platform_device *pdev)
> >  	dev_data =3D (const struct stm32_dfsdm_dev_data *)of_id->data;
> >
> >  	iio =3D devm_iio_device_alloc(dev, sizeof(*adc));
> > -	if (IS_ERR(iio)) {
> > +	if (!iio) {
> >  		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
> > -		return PTR_ERR(iio);
> > +		return -ENOMEM;
> >  	}
> >
> >  	adc =3D iio_priv(iio);
>         ^^^^^^^^^^^^^^^^^^
> This one doesn't return an error pointer either.  The check causes a
> static check warning for me.  (It can't actually fail, though so maybe
> it will return an error pointer in the future?)

It seems that we can simply remove the check since 'adc' can never
be an invalid address here.

Regards,
Yongjun Wei
