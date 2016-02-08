Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50196 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbcBHUAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Feb 2016 15:00:42 -0500
Date: Mon, 8 Feb 2016 21:00:27 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Michael Welling <mwelling@ieee.org>
Cc: Sricharan <sricharan@codeaurora.org>,
	'Daniel Baluta' <daniel.baluta@intel.com>,
	'Jonathan Cameron' <jic23@kernel.org>,
	'Hartmut Knaack' <knaack.h@gmx.de>,
	'Lars-Peter Clausen' <lars@metafoo.de>,
	'Peter Meerwald-Stadler' <pmeerw@pmeerw.net>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	'Lucas De Marchi' <lucas.demarchi@intel.com>,
	'Andy Gross' <agross@codeaurora.org>,
	'Pramod Gurav' <pramod.gurav@smartplayin.com>,
	'Bjorn Andersson' <bjorn.andersson@sonymobile.com>,
	'Guenter Roeck' <linux@roeck-us.net>, eibach@gdsys.de,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160208200027.GA1997@tetsubishi>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160205172457.GA16778@deathstar>
 <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
 <20160206003245.GA1329@deathstar>
 <20160208102459.GC2220@tetsubishi>
 <20160208163632.GA3630@deathstar>
 <01fd01d162a4$8e28c450$aa7a4cf0$@codeaurora.org>
 <20160208191658.GA23145@deathstar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <20160208191658.GA23145@deathstar>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > > On Mon, Feb 08, 2016 at 11:25:00AM +0100, Wolfram Sang wrote:
> > > > On Fri, Feb 05, 2016 at 06:32:45PM -0600, Michael Welling wrote:
> > > > > On Fri, Feb 05, 2016 at 09:32:34PM +0200, Daniel Baluta wrote:
> > > > > > >> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> > > > > > >> +                         struct iio_chan_spec const *chan, int

Guys, please quote only relevant sections.

>                          pca: pca@40 {
>                                  compatible = "nxp,pca9685-pwm";
>                                  #pwm-cells = <2>;
>                                  reg = <0x40>;
>                          };

Does accessing the pca work?


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuPPaAAoJEBQN5MwUoCm2Z+gP/39AjB5gaJEgNxWNgrZWoY8v
mIAiX3gzVRAyN7Ao6PfUB10OXmw8UO9QHjn2nsuIgyVApHw4mSetQXr+p9m6JIJW
ar9bv2TtaNw+N++PVaf/1BW2vVKElzvyTk3mxd2G8NjxOHKPuCYqaLIhgbuLaBEb
ocVr3ndAK8972o0B/URB8Z3cieknpgspMbmjADDh95OpDgPrc34qtMcD/rsJejx0
nSlZKdsMisxASTJOAFt/xIGJNAdEu9GJ4Tl2RpPsMpK0KnYsT6ERFGfEb2yJ5/an
XzHydQ52JTtJkwu5B4UZnPnzK8uklYM2L0ZgPOH9YBi7d7zjP1bF+5vBMB1mwPuy
HVhFQSk28PY2nliv+N/2C9GIM2W+X31voCGyunOcD+teTqmgAWJ6hRzuq1LeHrBX
P0+Ni4UN2Q/f1Mnyw5OGiufSQMv53qCCCO08ScsjGAgcaJAU76LxJF2LAVsWroYk
msaR+BEyvSAnU3CqWyMqK1/HP6LHfNUFAFjC3etxpWTh4PEXwwd1JVHaXLEeCWMF
0dIiBV/b3RMPnJhQj70aXXwCcv/Uu/OATefrCp4cs0sd9KSiWaQUKWao09eurXad
WYN2H+oImbj4GTPEGBW23iJArLKIqGdMpINZ2bIUisQRDMob9Ll90EcTA/hALxBh
4chW31gAgJSLAxMbuf6B
=YveV
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
