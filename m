Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdHQOaZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:30:25 -0400
Date: Thu, 17 Aug 2017 15:30:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: srf08: add device tree binding for srf02
 and srf10
Message-ID: <20170817153017.6615fc96@archlinux>
In-Reply-To: <20170814123725.GA2238@katana>
References: <20170814085941.GA9759@arbeit>
        <20170814091106.rvdvebcxfbpggmjd@ninjato>
        <20170814103918.GB3062@imap.1und1.de>
        <20170814123725.GA2238@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 14 Aug 2017 14:37:26 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Mon, Aug 14, 2017 at 12:39:18PM +0200, Andreas Klinger wrote:
> > Wolfram Sang <wsa@the-dreams.de> schrieb am Mon, 14. Aug 11:11:  
> > > On Mon, Aug 14, 2017 at 10:59:41AM +0200, Andreas Klinger wrote:  
> > > > add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> > > > 
> > > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++  
> > > 
> > > Again: This file has moved since v4.12-rc1. Please rebase to v4.12 or
> > > even v4.13-rc5.
> > >   
> > 
> > Then i split the patch series up in two parts:
> > - patch with only device tree binding against >= v4.12
> > - everything else as patch series against git tree of IIO
> > 
> > Ok?  
> 
> Wooha, the master branch of iio.git is at v4.11? I see. So, this is the
> culprit, sorry! @Jonathan: is that the branch people should develop on,
> or is it your testing branch?
> 
Yeah, that's a dead end really.  Mostly developing against latest
mainline is the best bet (or latest recentish version).

Last time I tried to delete the master branch I think it broke the
web interface on kernel.org as it didn't know what branch to default
to.  Not tried it for a while.

Anyhow, I just pushed out my upstream as master so it should now be
a fairly random pull I did of Greg's tree but will include everything
that is in linux-next from IIO.

I'll try and remember to do that when I fast forward after he
has taken a pull request.

Jonathan
