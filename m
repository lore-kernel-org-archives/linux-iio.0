Return-Path: <SRS0=O02D=CM=googlemail.com=chf.fritz@kernel.org>
Message-ID: <1510669220.1892.4.camel@googlemail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: add Intersil isl76683 light
 sensor bindings
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler
	 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 14 Nov 2017 15:20:20 +0100
In-Reply-To: <20171110212604.bpbsgtw7zbk5qp2d@rob-hp-laptop>
References: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
	 <1510068983-25769-3-git-send-email-chf.fritz@googlemail.com>
	 <20171110212604.bpbsgtw7zbk5qp2d@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Rob

On Fri, 2017-11-10 at 15:26 -0600, Rob Herring wrote:
> On Tue, Nov 07, 2017 at 04:36:22PM +0100, Christoph Fritz wrote:

> > +Optional properties:
> > +
> > +  - isil,external-resistor: integer in kOhm of external resistor R_ext.
> > +                            Valid values are from 1 to 1000.
> > +                            If not supplied, 100 kOhm will be assumed.
> 
> Add an unit suffix as defined in property-units.txt.

Thanks, I'll use "isil,external-resistor-ohms" as defined in
property-units.txt.

What bothers me a bit is that there is no "-kilo-ohms" suffix but a
"-micro-ohms" which is pretty uncommon. Even the only use of suffix
"-micro-ohms" could have been expressed easily as "-ohms" while being
more readable:

qcom,external-resistor-micro-ohms = <10000>;

Due to stable dt-api I suppose this cannot be changed and/or extended
with "-kilo-ohms", right?

Thanks
 -- Christoph
