Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33400 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756282AbdAFSy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2017 13:54:28 -0500
Received: by mail-pf0-f173.google.com with SMTP id d2so95598079pfd.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Jan 2017 10:54:27 -0800 (PST)
Date: Fri, 6 Jan 2017 10:54:22 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Jingoo Han <jingoohan1@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 2/5] mfd: lm3533: Support initialization from Device
 Tree
Message-ID: <20170106185422.GQ10531@minitux>
References: <20161226181153.11271-1-bjorn.andersson@linaro.org>
 <20161226181153.11271-2-bjorn.andersson@linaro.org>
 <20170104115424.GH27589@dell>
 <20170104192608.GN10531@minitux>
 <20170105074952.GG24225@dell>
 <20170105163054.GO10531@minitux>
 <20170106095349.GE9851@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170106095349.GE9851@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri 06 Jan 01:53 PST 2017, Lee Jones wrote:

> On Thu, 05 Jan 2017, Bjorn Andersson wrote:
> 
> > On Wed 04 Jan 23:49 PST 2017, Lee Jones wrote:
> > 
> > > On Wed, 04 Jan 2017, Bjorn Andersson wrote:
> > > 
> > > > On Wed 04 Jan 03:54 PST 2017, Lee Jones wrote:
> > > > 
> > > > > On Mon, 26 Dec 2016, Bjorn Andersson wrote:
> > > > > 
> > > > > > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > > > > > 
> > > > > > Implement support for initialization of the lm3533 driver core and
> > > > > > probing child devices from Device Tree.
> > > > > > 
> > > > 
> > > > [..]
> > > > 
> > > > > > @@ -512,6 +514,11 @@ static int lm3533_device_init(struct lm3533 *lm3533)
> > > > > >  	lm3533_device_bl_init(lm3533);
> > > > > >  	lm3533_device_led_init(lm3533);
> > > > > >  
> > > > > > +	if (lm3533->dev->of_node) {
> > > > > > +		of_platform_populate(lm3533->dev->of_node, NULL, NULL,
> > > > > > +				     lm3533->dev);
> > > > > > +	}
> > > > > 
> > > > > I think it's save to call of_platform_populate(), even if !of_node.
> > > > > It will just fail and return an error code, which you are ignoring
> > > > > anyway.
> > > > > 
> > > > 
> > > > I thought so too, but that's apparently how you trigger probing children
> > > > of the root node. So we're stuck with a conditional.
> > > 
> > > Ah, so this is to protect against the case where DT is present, but a
> > > node for this device is not (or is disabled), so is left unprobed.
> > > Then the bind is initiated via I2C?  Or something else?
> > > 
> > 
> > In the event that a new lm3533 is spawned from sysfs we would not have
> > platform_data when entering lm3533_device_init() and just bail early.
> > 
> > Therefor, this issue would be limited to the odd case of lm3533 being
> > initiated from code (e.g. a board file) on a DT enabled system. In which
> > case it will create and probe new devices from the root of the DT.
> 
> Eewww, do we really want to support that?
> 

As long as we support non-DT probing of the driver this is a possible
scenario. And with modern ARM being DT-centric I think that if anyone
uses this driver with a modern version of the Linux kernel it's likely
that they would have this kind of hybrid solution.

So, although ugly, I think we should keep this conditional and hope that
anyone using the driver will transition to use the DT binding.

Regards,
Bjorn
