Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53249 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaISI15 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Sep 2014 04:27:57 -0400
Date: Fri, 19 Sep 2014 10:27:55 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iadc: Qualcomm SPMI PMIC current ADC driver
In-Reply-To: <1411109437.3997.9.camel@iivanov-dev>
Message-ID: <alpine.DEB.2.01.1409191026380.4354@pmeerw.net>
References: <1411046123-30625-1-git-send-email-iivanov@mm-sol.com>  <alpine.DEB.2.01.1409182041040.30983@pmeerw.net> <1411109437.3997.9.camel@iivanov-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > I'd prefix with SPMI_IADC_  
> 
> Is this really necessary? I could prefix it with IADC3, which 
> is the subtype of this peripheral.

I think for a similar driver we are sticking with VADC, so no...
 
> > > +#define IADC_REVISION2				0x1
> > > +#define IADC_REVISION2_SUPPORTED_IADC		1
> > > +
> > > +#define IADC_PERPH_TYPE				0x4
> > > +#define IADC_PERPH_TYPE_ADC			8
> > > +
> > > +#define IADC_PERPH_SUBTYPE			0x5
> > > +#define IADC_PERPH_SUBTYPE_IADC			3
> 
> Rest of the comments will be fixed in next version.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
