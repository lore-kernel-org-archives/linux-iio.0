Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754877AbdJITzl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Oct 2017 15:55:41 -0400
Date: Mon, 9 Oct 2017 20:55:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: mcp320x: Add support for mcp3550/1/3
Message-ID: <20171009205533.15dcefdd@archlinux>
In-Reply-To: <20171009075416.GA26873@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
        <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de>
        <20170910171514.714abfdd@archlinux>
        <20171004195037.GB9195@wunner.de>
        <1EB45962-79DA-41DF-ACB7-68D820710B88@jic23.retrosnub.co.uk>
        <20171008113013.1b627589@archlinux>
        <20171009075416.GA26873@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 9 Oct 2017 09:54:16 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Oct 08, 2017 at 11:30:13AM +0100, Jonathan Cameron wrote:
> > On Wed, 04 Oct 2017 21:53:07 +0100 Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:  
> > > On 4 October 2017 20:50:37 BST, Lukas Wunner <lukas@wunner.de> wrote:  
> > > > Just a gentle reminder, this patch isn't on your kernel.org branches
> > > > yet. I assumed the reason was a dependency / merge conflict with my
> > > > two patches on the fixes-togreg branch and you were waiting for them
> > > > to be in upstream.
> > > > They have landed in Linus' tree yesterday, I'm not sure if anything
> > > > else is necessary (backmerge or some such).  
> >
> > OK.  Looks like you were correct - this is waiting on the fixes to work
> > their way back into my tree.  After the next rc is out (first one with these
> > in as they aren't in rc3) I'll ask Greg if he is willing to do a merge
> > with mainline as I have a load of ST patches queued up waiting for
> > some fixes as well.  Right now I'm deliberately not pushing out a non
> > rebasing branch like I normally would - so as to be able to rebase on
> > these fixes when they become available in Greg's tree.  
> 
> Greg merged 4.14-rc4 into staging-next 48 minutes ago, so ready to go now.
> 
Thanks.  I've rebased my (not yet public) togreg branch and pushed out
as testing with this patch applied.

Thanks,

Jonathan

> Thanks,
> 
> Lukas

