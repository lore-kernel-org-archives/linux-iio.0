Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36140 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965798AbdADT0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 14:26:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so230312218pgc.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2017 11:26:13 -0800 (PST)
Date: Wed, 4 Jan 2017 11:26:08 -0800
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
Message-ID: <20170104192608.GN10531@minitux>
References: <20161226181153.11271-1-bjorn.andersson@linaro.org>
 <20161226181153.11271-2-bjorn.andersson@linaro.org>
 <20170104115424.GH27589@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170104115424.GH27589@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed 04 Jan 03:54 PST 2017, Lee Jones wrote:

> On Mon, 26 Dec 2016, Bjorn Andersson wrote:
> 
> > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > 
> > Implement support for initialization of the lm3533 driver core and
> > probing child devices from Device Tree.
> > 

[..]

> > @@ -512,6 +514,11 @@ static int lm3533_device_init(struct lm3533 *lm3533)
> >  	lm3533_device_bl_init(lm3533);
> >  	lm3533_device_led_init(lm3533);
> >  
> > +	if (lm3533->dev->of_node) {
> > +		of_platform_populate(lm3533->dev->of_node, NULL, NULL,
> > +				     lm3533->dev);
> > +	}
> 
> I think it's save to call of_platform_populate(), even if !of_node.
> It will just fail and return an error code, which you are ignoring
> anyway.
> 

I thought so too, but that's apparently how you trigger probing children
of the root node. So we're stuck with a conditional.

[..]

> >  static int lm3533_i2c_probe(struct i2c_client *i2c,
> >  					const struct i2c_device_id *id)
> >  {

[..]

> >  
> > +	if (i2c->dev.of_node) {
> 
> I'd prefer this check to be placed in lm3533_pdata_from_of_node().
> 
> Just return silently if !dev->of_node.
> 

I agree, will update this.

> > +		ret = lm3533_pdata_from_of_node(lm3533->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	return lm3533_device_init(lm3533);
> >  }
> >  

Regards,
Bjorn
