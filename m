Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37516 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764001AbdAFJuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2017 04:50:20 -0500
Received: by mail-wm0-f45.google.com with SMTP id t79so21793082wmt.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Jan 2017 01:50:05 -0800 (PST)
Date: Fri, 6 Jan 2017 09:53:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
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
Message-ID: <20170106095349.GE9851@dell>
References: <20161226181153.11271-1-bjorn.andersson@linaro.org>
 <20161226181153.11271-2-bjorn.andersson@linaro.org>
 <20170104115424.GH27589@dell>
 <20170104192608.GN10531@minitux>
 <20170105074952.GG24225@dell>
 <20170105163054.GO10531@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170105163054.GO10531@minitux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 05 Jan 2017, Bjorn Andersson wrote:

> On Wed 04 Jan 23:49 PST 2017, Lee Jones wrote:
> 
> > On Wed, 04 Jan 2017, Bjorn Andersson wrote:
> > 
> > > On Wed 04 Jan 03:54 PST 2017, Lee Jones wrote:
> > > 
> > > > On Mon, 26 Dec 2016, Bjorn Andersson wrote:
> > > > 
> > > > > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > > > > 
> > > > > Implement support for initialization of the lm3533 driver core and
> > > > > probing child devices from Device Tree.
> > > > > 
> > > 
> > > [..]
> > > 
> > > > > @@ -512,6 +514,11 @@ static int lm3533_device_init(struct lm3533 *lm3533)
> > > > >  	lm3533_device_bl_init(lm3533);
> > > > >  	lm3533_device_led_init(lm3533);
> > > > >  
> > > > > +	if (lm3533->dev->of_node) {
> > > > > +		of_platform_populate(lm3533->dev->of_node, NULL, NULL,
> > > > > +				     lm3533->dev);
> > > > > +	}
> > > > 
> > > > I think it's save to call of_platform_populate(), even if !of_node.
> > > > It will just fail and return an error code, which you are ignoring
> > > > anyway.
> > > > 
> > > 
> > > I thought so too, but that's apparently how you trigger probing children
> > > of the root node. So we're stuck with a conditional.
> > 
> > Ah, so this is to protect against the case where DT is present, but a
> > node for this device is not (or is disabled), so is left unprobed.
> > Then the bind is initiated via I2C?  Or something else?
> > 
> 
> In the event that a new lm3533 is spawned from sysfs we would not have
> platform_data when entering lm3533_device_init() and just bail early.
> 
> Therefor, this issue would be limited to the odd case of lm3533 being
> initiated from code (e.g. a board file) on a DT enabled system. In which
> case it will create and probe new devices from the root of the DT.

Eewww, do we really want to support that?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
