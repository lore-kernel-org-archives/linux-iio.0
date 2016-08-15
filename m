Return-Path: <amsfield22@gmail.com>
Date: Mon, 15 Aug 2016 16:13:20 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Messed up the fixes-togreg-post-rc1 branch so cherry picking
 into fixes-togreg
Message-ID: <20160815231305.GA12216@d830.WORKGROUP>
References: <faaec59c-07d8-6618-cd0d-0614e690c3e2@kernel.org>
 <8bc6a47d-52e2-f1f0-5218-aff27c667bde@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8bc6a47d-52e2-f1f0-5218-aff27c667bde@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 15, 2016 at 03:43:59PM +0100, Jonathan Cameron wrote:
> On 15/08/16 15:37, Jonathan Cameron wrote:
> > Hi All,
> > 
> > Seems I messed up the base of the fixes-togreg-post-rc1 branch
> > (based on a random point in togreg rather than the last 
> > pull request as intended).  I'll drop that branch as
> > junk having cherry picked into an updated fixes-togreg branch.
> > 
> > Make a bit of a mess of dates, but otherwise should have no
> > real affect.
> > 
> > This is just in case anyone was basing on that branch which
> > will shortly disappear.
> > 
> > Jonathan
> Note this also involved dropping the thermocouple kconfig fix
> from Alison as that driver hasn't hit mainline yet.
> 
> Alison, would you mind resending that one part of the patch based
> on the togreg branch?  That way I won't forget it.

Done. Sent as an odd v2. Let me know if not ok.
alisons

> 
> Thanks
> 
> Jonathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
