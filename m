Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:48788 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932779AbdDSCXR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2017 22:23:17 -0400
Message-ID: <1492568591.8661.53.camel@perches.com>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
From: Joe Perches <joe@perches.com>
To: Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Date: Tue, 18 Apr 2017 19:23:11 -0700
In-Reply-To: <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
         <20170418085156.GA4773@kroah.com>
         <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
         <20170418114430.GA1496@kroah.com>
         <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2017-04-18 at 23:53 +0200, Peter Rosin wrote:
> On 2017-04-18 13:44, Greg Kroah-Hartman wrote:
> > On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
[]
> > > > > +	ret = device_add(&mux_chip->dev);
> > > > > +	if (ret < 0)
> > > > > +		dev_err(&mux_chip->dev,
> > > > > +			"device_add failed in mux_chip_register: %d\n", ret);
> > > > 
> > > > Did you run checkpatch.pl in strict mode on this new file?  Please do so :)
> > > 
> > > I did, and did it again just to be sure, and I do not get any complaints.
> > > So, what's wrong?
> > 
> > You list the function name in the printk string, it should complain
> > that __func__ should be used.  Oh well, it's just a perl script, it
> > doesn't always catch everything.
> > isn't always correct :)
> 
> Ah, ok.

Also, please use the checkpatch in -next as it has a
slightly better mechanism to identify functions and
uses in strings.

$ ./scripts/checkpatch.pl ~/1.patch
WARNING: Prefer using '"%s...", __func__' to using 'mux_chip_register', this function's name, in a string
#302: FILE: drivers/mux/mux-core.c:134:
+			"device_add failed in mux_chip_register: %d\n", ret);


