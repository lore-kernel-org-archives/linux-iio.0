Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752526AbdHINbe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 09:31:34 -0400
Date: Wed, 9 Aug 2017 14:31:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        eter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v1 1/2] iio: tools: move to tools buildsystem
Message-ID: <20170809143123.560732fb@archlinux>
In-Reply-To: <1501602838.29303.337.camel@linux.intel.com>
References: <20170729003605.73790-1-andriy.shevchenko@linux.intel.com>
        <20170730172854.57d1bd8b@kernel.org>
        <1501602838.29303.337.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 01 Aug 2017 18:53:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, 2017-07-30 at 17:28 +0100, Jonathan Cameron wrote:
> > On Sat, 29 Jul 2017 03:36:04 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > There is a nice buildsystem dedicated for userspace tools in Linux
> > > kernel tree.
> > > Switch iio target to be built by it.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Looks very nice to me (and very very similar to gpio tools
> > which makes checking it is sane easy ;)  
> 
> Thanks for review!
> 
> > Would like this to sit on the list a little while longer
> > in case someone with more Make foo than me wanders by
> > and spots something.  
> 
> Of course!
Long enough. Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> 

