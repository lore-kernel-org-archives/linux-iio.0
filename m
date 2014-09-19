Return-Path: <iivanov@mm-sol.com>
Message-ID: <1411109437.3997.9.camel@iivanov-dev>
Subject: Re: [PATCH] iio: iadc: Qualcomm SPMI PMIC current ADC driver
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  Hartmut Knaack <knaack.h@gmx.de>,
 linux-iio@vger.kernel.org
Date: Fri, 19 Sep 2014 09:50:37 +0300
In-Reply-To: <alpine.DEB.2.01.1409182041040.30983@pmeerw.net>
References: <1411046123-30625-1-git-send-email-iivanov@mm-sol.com>
	 <alpine.DEB.2.01.1409182041040.30983@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-09-18 at 20:59 +0200, Peter Meerwald wrote:
<snip>

> I'd prefix with SPMI_IADC_  

Is this really necessary? I could prefix it with IADC3, which 
is the subtype of this peripheral.

> > +#define IADC_REVISION2				0x1
> > +#define IADC_REVISION2_SUPPORTED_IADC		1
> > +
> > +#define IADC_PERPH_TYPE				0x4
> > +#define IADC_PERPH_TYPE_ADC			8
> > +
> > +#define IADC_PERPH_SUBTYPE			0x5
> > +#define IADC_PERPH_SUBTYPE_IADC			3

Rest of the comments will be fixed in next version.

Thank you for review.

Regards,
Ivan
