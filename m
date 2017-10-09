Return-Path: <SRS0=S0SL=BI=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 9 Oct 2017 09:54:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Phil Elwell <phil@raspberrypi.org>,
	Oskar Andero <oskar.andero@gmail.com>,
	Andrea Galbusera <gizero@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Michael Welling <mwelling@ieee.org>,
	Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: mcp320x: Add support for mcp3550/1/3
Message-ID: <20171009075416.GA26873@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
 <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de>
 <20170910171514.714abfdd@archlinux>
 <20171004195037.GB9195@wunner.de>
 <1EB45962-79DA-41DF-ACB7-68D820710B88@jic23.retrosnub.co.uk>
 <20171008113013.1b627589@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171008113013.1b627589@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 08, 2017 at 11:30:13AM +0100, Jonathan Cameron wrote:
> On Wed, 04 Oct 2017 21:53:07 +0100 Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> > On 4 October 2017 20:50:37 BST, Lukas Wunner <lukas@wunner.de> wrote:
> > > Just a gentle reminder, this patch isn't on your kernel.org branches
> > > yet. I assumed the reason was a dependency / merge conflict with my
> > > two patches on the fixes-togreg branch and you were waiting for them
> > > to be in upstream.
> > > They have landed in Linus' tree yesterday, I'm not sure if anything
> > > else is necessary (backmerge or some such).
>
> OK.  Looks like you were correct - this is waiting on the fixes to work
> their way back into my tree.  After the next rc is out (first one with these
> in as they aren't in rc3) I'll ask Greg if he is willing to do a merge
> with mainline as I have a load of ST patches queued up waiting for
> some fixes as well.  Right now I'm deliberately not pushing out a non
> rebasing branch like I normally would - so as to be able to rebase on
> these fixes when they become available in Greg's tree.

Greg merged 4.14-rc4 into staging-next 48 minutes ago, so ready to go now.

Thanks,

Lukas
