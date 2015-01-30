Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:55815 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756654AbbA3JJy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 04:09:54 -0500
Message-ID: <1422609003.11083.13.camel@mm-sol.com>
Subject: Re: [PATCH v5 2/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Fri, 30 Jan 2015 11:10:03 +0200
In-Reply-To: <54C92E7C.5040507@kernel.org>
References: <1421748922-8933-1-git-send-email-iivanov@mm-sol.com>
	 <1421748922-8933-3-git-send-email-iivanov@mm-sol.com>
	 <54C92E7C.5040507@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Wed, 2015-01-28 at 18:46 +0000, Jonathan Cameron wrote:
> On 20/01/15 10:15, Ivan T. Ivanov wrote:
> > From: Stanimir Varbanov <svarbanov@mm-sol.com>
> > 
> > The voltage ADC is peripheral of Qualcomm SPMI PMIC chips. It has
> > 15bits resolution and register space inside PMIC accessible across
> > SPMI bus.
> > 
> > The vadc driver registers itself through IIO interface.
> > 
> > Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> One minor comment inline.  Looks good to me.
> Applied to the togreg branch of iio.git - initially pushed out as testing.
> 
> Glad to have this one out of the pending list ;)

Thank you.

> 
> > +
> > +       irq_eoc = platform_get_irq(pdev, 0);
> > +       if (irq_eoc < 0) {
> > +               if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
> > +                       return irq_eoc;
> This does feel a little backwards.  I'd normally expect to see those
> errors that indicate one is not specified tested against, rather than
> trying to guess all the reasons it might fail otherwise....
> 
> This way round strikes me as probably more fragile as additional errors
> may turn up in that function over time..
> 

Agree, would it be better if driver just check for EPROBE_DEFER
and treat all other error codes as "no interrupt defined"? 
I could send followup patch if you like.

Regards,
Ivan

