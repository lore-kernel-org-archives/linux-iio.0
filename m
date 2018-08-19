Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUVo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 16:21:44 -0400
Date: Sun, 19 Aug 2018 18:09:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180819180930.18f2dfc1@archlinux>
In-Reply-To: <20180810103856.GB20971@sirena.org.uk>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
        <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
        <20180810103856.GB20971@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 10 Aug 2018 11:38:56 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Aug 10, 2018 at 11:46:20AM +0300, Stefan Popa wrote:
> > From: Crestez Dan Leonard <leonard.crestez@intel.com>
> > 
> > The regmap API usually assumes that bulk read operations will read a
> > range of registers but some I2C/SPI devices have certain registers for
> > which a such a read operation will return data from an internal FIFO
> > instead. Add an explicit API to support bulk read without range semantics.  
> 
> Please don't resubmit patches that have already been applied, you should
> submit patches against current code in the tree you're expecting things
> to be applied to.  If any updates are needed to a patch that's already
> been applied you should submit incremental patches which make those
> updates.  This avoids having to change published git commits which could
> cause problems for people working against git.

I've merged the regmap branch in question into iio.git.  To add to Mark's
comment it would have been helpful to have the cover letter mention the
need to do that with a copy of what Mark replied with when he took this
patch (as it gives me the details I need to pick up that branch).

Jonathan
