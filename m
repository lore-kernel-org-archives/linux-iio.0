Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758939AbdJRINd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2017 04:13:33 -0400
Date: Wed, 18 Oct 2017 09:12:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Rob Herring <robh@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-microamp property to ina2xx
Message-ID: <20171018091226.000017dd@huawei.com>
In-Reply-To: <20171017205821.GA8737@roeck-us.net>
References: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
        <CGME20171012123635eucas1p1ff9a982db9d541cd0475d44d114ff92a@eucas1p1.samsung.com>
        <1507811765-31005-4-git-send-email-m.purski@samsung.com>
        <20171017203631.xaut7o3szaiucnqh@rob-hp-laptop>
        <20171017205821.GA8737@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Oct 2017 13:58:21 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Oct 17, 2017 at 03:36:31PM -0500, Rob Herring wrote:
> > On Thu, Oct 12, 2017 at 02:36:04PM +0200, Maciej Purski wrote:  
> > > Add optional max expected current property which allows calibrating
> > > the ina sensor in order to achieve requested measure scale. Document
> > > the changes in Documentation/hwmon/ina2xx.
> > > 
> > > Signed-off-by: Maciej Purski <m.purski@samsung.com>
> > > ---
> > >  Documentation/devicetree/bindings/hwmon/ina2xx.txt | 4 +++-
> > >  Documentation/hwmon/ina2xx                         | 3 +++
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> > > index 02af0d9..49ef0be 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> > > +++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> > > @@ -14,11 +14,13 @@ Optional properties:
> > >  
> > >  - shunt-resistor
> > >  	Shunt resistor value in micro-Ohm
> > > -
> > > +- ti-max-expected-current-microamp
> > > +	Max expected current value in mA  
> > 
> > ti,max-...
> > 
> > The property name is a bit long. Does "expected" add anything? Is there 
> > a max unexpected current?
> >   
> I am not too happy with it either. To me it suggests that there _can_ be
> an unexpected current (why specify a max _expected_ current otherwise ?),
> and that unexpected current won't be measurable and thus not reported
> because it is ... well, unexpected.

After calibration I 'think' this corresponds to the maximum current
that the device can measure (it's applying scaling inside to make full use
of available range of the register - there are some arguments that there is
an optimum value after which we could do better in software).

I guess the issue here is that this that we might need to separate the maximum
current the device is capable of measuring from what it is currently configured
to measure.  No idea how to describe that :)

Jonathan

> 
> Guenter
> 
> > >  Example:
> > >  
> > >  ina220@44 {
> > >  	compatible = "ti,ina220";
> > >  	reg = <0x44>;
> > >  	shunt-resistor = <1000>;
> > > +	ti-max-expected-current-microamp = <3000>;
> > >  };
> > > diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> > > index cfd31d9..30620e8 100644
> > > --- a/Documentation/hwmon/ina2xx
> > > +++ b/Documentation/hwmon/ina2xx
> > > @@ -55,6 +55,9 @@ The shunt value in micro-ohms can be set via platform data or device tree at
> > >  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
> > >  refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
> > >  if the device tree is used.
> > > +The max expected current value in miliamp can be set via platform data
> > > +or device tree at compile-time or via currX_max attribute in sysfs
> > > +at run-time.
> > >  
> > >  Additionally ina226 supports update_interval attribute as described in
> > >  Documentation/hwmon/sysfs-interface. Internally the interval is the sum of
> > > -- 
> > > 2.7.4
> > >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

