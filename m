Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbeFXNtC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:49:02 -0400
Date: Sun, 24 Jun 2018 14:48:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180624144855.2ed07568@archlinux>
In-Reply-To: <20180624132858.GA2296@imap.1und1.de>
References: <20180623185420.GA17842@arbeit>
        <20180624141048.7628eaac@archlinux>
        <20180624132858.GA2296@imap.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Jun 2018 15:28:59 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jonathan,
> 
> Jonathan Cameron <jic23@kernel.org> schrieb am Sun, 24. Jun 14:10:
> > On Sat, 23 Jun 2018 20:54:21 +0200
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >   
> > > add data-ready-delay-ns property for hx711 ADC
> > > this is the delay after rising PD_SCK until DOUT is read and assumed to be
> > > ready
> > > 
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>  
> > 
> > One unconnected change.  I'm not sure it's wrong as such but it should not
> > be in this patch.
> >   
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > index b3629405f568..8c9bcaa4d750 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > @@ -8,11 +8,18 @@ Required properties:
> > >  		See Documentation/devicetree/bindings/gpio/gpio.txt
> > >   - avdd-supply:	Definition of the regulator used as analog supply
> > >  
> > > +Optional properties:
> > > + - data-ready-delay-ns:	additional delay in nanoseconds between rising of
> > > +			PD_SCK until DOUT is ready
> > > +			should be less then maximum PD_SCK high time which
> > > +			is 50000 in the datasheet
> > > +
> > >  Example:
> > > -weight@0 {
> > > +weight {  
> 
> The device tree compiler (dtc) gives a warning if there is no reg = <...>
> setting. That's why i changed it to be without @0.
> 
> Should i create an individual patch for this change in this series or
> create another patch which is unrelated to this series?

Either is fine by me.  It's such a trivial change that it really doesn't
matter.

Jonathan

> 
> Andreas
> 
> > 
> > Change has nothing to do with this patch...
> >   
> > >  	compatible = "avia,hx711";
> > >  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> > >  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > >  	avdd-suppy = <&avdd>;
> > > +	data-ready-delay-ns = <1000>;
> > >  };
> > >    
> >   
> 

