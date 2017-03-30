Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbdC3IJo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 04:09:44 -0400
Date: Thu, 30 Mar 2017 10:09:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v12 00/10] mux controller abstraction and iio/i2c muxes
Message-ID: <20170330080926.GA21926@kroah.com>
References: <1490624525-15865-1-git-send-email-peda@axentia.se>
 <c321dad0-4c0e-b192-ee93-45359e29f61b@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c321dad0-4c0e-b192-ee93-45359e29f61b@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 30, 2017 at 09:34:52AM +0200, Peter Rosin wrote:
> On 2017-03-27 16:21, Peter Rosin wrote:
> > Hi Greg!
> > 
> > Please apply.
> >
> 
> *snip snip*
> 
> > v10 -> v11 changes
> > - added a new patch (12) with a fix for messed up error path reported
> >   by Paul Gortmaker.
> 
> Oops, should be Dan Carpenter. Sorry about that...
> 
> And, I forgot to high-light this:
> 
> > v4 -> v5 changes
> > - driver for Analog Devices ADG792A/G, literally the first mux chip
> >   I found on the Internet with an i2c interface (that was not a
> >   dedicated i2c multiplexer like PCA9547) which I used to verify
> >   that the abstractions in the mux core are up to the task. Untested,
> >   just proof of concept that at least looks pretty and compiles...
> 
> Maybe the patches related to adg792 (last two patches in v12) should
> not be applied? I don't care much either way, your call Greg...

Give me a chance to catch up on reviews, your patch series is behind
400+ other emails...

greg k-h
