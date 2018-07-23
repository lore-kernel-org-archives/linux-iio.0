Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:47428
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388080AbeGWKfO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Jul 2018 06:35:14 -0400
From: Manish Narani <MNARANI@xilinx.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
Date: Mon, 23 Jul 2018 09:34:50 +0000
Message-ID: <SN6PR02MB4959F2ABE80C54242B8BF0C9C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
        <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
 <20180721172423.11efb5ea@archlinux>
In-Reply-To: <20180721172423.11efb5ea@archlinux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for your comments.

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, July 21, 2018 9:54 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Manish Narani <MNARANI@xilinx.com>; knaack.h@gmx.de;
> pmeerw@pmeerw.net; Michal Simek <michals@xilinx.com>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas
> Goud <sgoud@xilinx.com>
> Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk=
 related
> functions
>=20
> On Thu, 19 Jul 2018 18:40:26 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>=20
> > On 07/18/2018 01:12 PM, Manish Narani wrote:
> > > This patch adds check for return values from clock related functions.
> > > This was reported by static code analysis tool.
> >
> > This patch seems to do something else.
> Indeed, definitely doing two things only one of which is mentioned.
> Please break it up and resend.
I will break it up and resend.

>=20
> Jonathan
>=20
> >
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/xilinx-xadc-core.c
> > > b/drivers/iio/adc/xilinx-xadc-core.c
> > > index 248cffa..47eb364 100644
> > > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > > @@ -322,6 +322,7 @@ static irqreturn_t
> > > xadc_zynq_interrupt_handler(int irq, void *devid)
> > >
> > >  #define XADC_ZYNQ_TCK_RATE_MAX 50000000  #define
> > > XADC_ZYNQ_IGAP_DEFAULT 20
> > > +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> > >
> > >  static int xadc_zynq_setup(struct platform_device *pdev,
> > >  	struct iio_dev *indio_dev, int irq) @@ -332,6 +333,7 @@ static int
> > > xadc_zynq_setup(struct platform_device *pdev,
> > >  	unsigned int div;
> > >  	unsigned int igap;
> > >  	unsigned int tck_rate;
> > > +	int ret;
> > >
> > >  	/* TODO: Figure out how to make igap and tck_rate configurable */
> > >  	igap =3D XADC_ZYNQ_IGAP_DEFAULT;
> > > @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct
> > > platform_device *pdev,
> > >
> > >  	pcap_rate =3D clk_get_rate(xadc->clk);
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret =3D clk_set_rate(xadc->clk,
> > > +				   (unsigned
> long)XADC_ZYNQ_PCAP_RATE_MAX);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	if (tck_rate > pcap_rate / 2) {
> > >  		div =3D 2;
> > >  	} else {
> > > @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_devic=
e
> *pdev,
> > >  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE
> |
> > >  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret =3D clk_set_rate(xadc->clk, pcap_rate);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_d=
ev,
> > >  	unsigned long clk_rate =3D xadc_get_dclk_rate(xadc);
> > >  	unsigned int div;
> > >
> > > +	if (!clk_rate)
> > > +		return -EINVAL;
> > > +
> > >  	if (info !=3D IIO_CHAN_INFO_SAMP_FREQ)
> > >  		return -EINVAL;
> > >
> > > @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device
> *pdev)
> > >  		goto err_free_irq;
> > >
> > >  	/* Disable all alarms */
> > > -	xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > -		XADC_CONF1_ALARM_MASK);
> > > +	ret =3D xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > +				  XADC_CONF1_ALARM_MASK);
> > > +	if (ret)
> > > +		goto err_free_irq;
> > >
> > >  	/* Set thresholds to min/max */
> > >  	for (i =3D 0; i < 16; i++) {
> > >
> >

Thanks,
Manish Narani
