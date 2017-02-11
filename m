Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbdBKHR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 02:17:57 -0500
Date: Sat, 11 Feb 2017 08:17:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Ken Lin <ken.lin@advantech.com>, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 4.10 set 3 - a couple of regression fixes.
Message-ID: <20170211071753.GB1345@kroah.com>
References: <1485981657-14586-1-git-send-email-peda@axentia.se>
 <1485981657-14586-2-git-send-email-peda@axentia.se>
 <2648bf01-840e-d555-8a65-03d1d13c6ed2@kernel.org>
 <c080d4bb-9359-7218-cf30-1ea727b56184@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c080d4bb-9359-7218-cf30-1ea727b56184@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 10, 2017 at 11:35:35PM +0100, Peter Rosin wrote:
> > On Sun, Feb 05, 2017 at 10:35:02AM +0000, Jonathan Cameron wrote:
> >> The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:
> >> 
> >>   iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)
> >> 
> >> are available in the git repository at:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10c
> > 
> > It's a bit late for 4.10 for me, can I just pull this into my -next
> > branch and will they get to 4.10.1 properly?  Meaning, do that have cc:
> > stable markings on them?  Or do you want to fix that up and resend this
> > request?
> 
> Hi Greg,
> 
> You should ask Ken Lin who has the HW and who is apparently affected.
> I think it's bad that you are willing to have a known regression hit
> v4.10 when all was fine in v4.9. Or perhaps you didn't realize that
> the regression was from this cycle?
> 
> The fixes are obvious. I don't understand your hesitation.

My "hesitation" is that I'm about to get on a plane for a day or so and
don't have the time to get this to Linus before 4.10-final is out this
Sunday.  Getting it in a week later should be ok, we all make mistakes,
as long as we fix them it's all good, and for 4.10.1 should be ok.

thanks,

greg k-h
