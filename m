Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932506AbdGKS1A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jul 2017 14:27:00 -0400
Date: Tue, 11 Jul 2017 19:26:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open
 drain mode
Message-ID: <20170711192656.7fd08a1c@kernel.org>
In-Reply-To: <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
        <20170709165704.26311-9-lorenzo.bianconi@st.com>
        <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 10 Jul 2017 21:51:58 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Jul 09, 2017 at 06:57:03PM +0200, Lorenzo Bianconi wrote:
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > index fca263e13400..732b83c06c08 100644
> > --- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> > @@ -5,6 +5,14 @@ Required properties:
> >  - reg: i2c address of the sensor / spi cs line
> >  
> >  Optional properties:
> > +- drive-open-drain: the interrupt/data ready line will be configured  
> 
> Needs a vendor prefix and "drdy-open-drain" would be more specific.
This is straight out of the pinctrl bindings and has been used in a few
other places as well.  I can see it should really be more obviously
associated with the drdy pin though.  A few IIO drivers already
use this binding (st sensors and the lsm6dsx).  If we are going
to decide it's a bad idea we should deprecate those bindings and
add whatever we do here as well.

Jonathan
> 
> > +  as open drain, which is useful if several sensors share the same
> > +  interrupt line. This is a boolean property.
> > +  (This binding is taken from pinctrl/pinctrl-bindings.txt)
> > +  If the requested interrupt is configured as IRQ_TYPE_LEVEL_HIGH or
> > +  IRQ_TYPE_EDGE_RISING a pull-down resistor is needed to drive the line
> > +  when it is not active, whereas a pull-up one is needed when interrupt
> > +  line is configured as IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_EDGE_FALLING.
> >  - interrupt-parent: should be the phandle for the interrupt controller
> >  - interrupts: interrupt mapping for IRQ. It should be configured with
> >    flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> > -- 
> > 2.13.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  

