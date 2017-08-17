Return-Path: <SRS0=AYyI=7T=huawei.com=jonathan.cameron@kernel.org>
Date: Thu, 17 Aug 2017 07:30:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: Andreas Klinger <ak@it-klinger.de>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <wsa@the-dreams.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170817073019.0000051c@huawei.com>
In-Reply-To: <823ea9d0-0410-2d6d-813b-686582656d68@axentia.se>
References: <20170816193257.GA24393@arbeit>
	<823ea9d0-0410-2d6d-813b-686582656d68@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Wed, 16 Aug 2017 22:14:33 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2017-08-16 21:32, Andreas Klinger wrote:
> > This patch series adds support for:
> > - triggered buffer
> > - ultrasonic devices srf02 and srf10
> > 
> > Thanks for the review of Peter and Wolfram.
> > 
> > @Wolfram: please let me know, if you want a separate patch for [PATCH 1/5]  
> 
> I think what you should do is rebase to something fresher, such as the
> togreg branch in the iio repo. As you have discovered, master branch is
> lagging behind in that repo.
> 
> And I think Jonathan would like that as well, but perhaps it doesn't
> make a difference for him?
Ah.. I always forget to do anything with the master branch.  Should bring it
up to date on mainline releases but never remember to do so.

The togreg branch is a better bet certainly.  Most of the time latest
round numbered release i.e. an rcX or final release of Linus' tree
is fine as well.  Occasionally multiple people are working on the same
driver but it's fairly rare within a cycle.

Depending on HK airport wifi later I might see if I can push out
something sensible as master.  I think the nice web interface will
get annoyed if I remove the master branch entirely...

Jonathan
> 
> Cheers,
> peda
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
