Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752435AbdKSPFm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:05:42 -0500
Date: Sun, 19 Nov 2017 15:05:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: magnetometer: ak8975: Remove wrong ACPI ID
Message-ID: <20171119150538.2683f77c@archlinux>
In-Reply-To: <1510159119.25007.116.camel@linux.intel.com>
References: <20171103175640.33403-1-andriy.shevchenko@linux.intel.com>
        <1509732504.10233.205.camel@linux.intel.com>
        <1509732895.10233.209.camel@linux.intel.com>
        <1509734767.7135.67.camel@linux.intel.com>
        <1509885742.10233.229.camel@linux.intel.com>
        <1509933795.27882.0.camel@linux.intel.com>
        <1510159119.25007.116.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 08 Nov 2017 18:38:39 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, 2017-11-05 at 18:03 -0800, Srinivas Pandruvada wrote:
> > On Sun, 2017-11-05 at 14:42 +0200, Andy Shevchenko wrote:  
> > > On Fri, 2017-11-03 at 11:46 -0700, Srinivas Pandruvada wrote:  
> 
> > > > The AK8963 is using INVN6500. The reason is that this INVN 6500
> > > > has
> > > > another master mode where a secondary sensor can be connected to
> > > > it
> > > > as
> > > > an i2c slave.
> > > > So Windows config uses this mode and hence added in the same
> > > > package.
> > > > 
> > > > But Linux INVN driver is not capable of this master mode. We use
> > > > something called "bypass" mode. In this the second sensor will
> > > > also
> > > > be
> > > > directly connected to host i2c. We have another driver handling
> > > > this
> > > > sensor (ak8975), so we have to add this id.  
> > > 
> > > But ak8975 is enumerated. See above log. So, I think the INVN6500 ID
> > > in
> > > ak 8975 driver is simple not required.  
> > 
> > This is not true in all platforms. So this is required.  
> 
> Thanks for clarification. though it would be interesting to test a
> behaviour w/o this patch on platform I have and the one that has wrong
> data under CNF0 resources.
> 
As this discussion seems to have concluded the patch is a bad
idea I'm dropping it.

I'll add though that it would be possible to instantiate the ak8975 from
the mpu6050 driver if we wanted to avoid this nasty 'hack'.

Jonathan

