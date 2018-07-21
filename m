Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbeGURLs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:11:48 -0400
Date: Sat, 21 Jul 2018 17:18:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudh@xilinx.com>,
        <sgoud@xilinx.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name
 to 'iio_xadc_channels'
Message-ID: <20180721171828.55395acc@archlinux>
In-Reply-To: <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
        <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
        <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Jul 2018 10:22:07 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> > On 07/18/2018 01:12 PM, Manish Narani wrote:  
> >> This patch fix the following checkpatch warning in xadc driver.
> >> - Reusing the krealloc arg is almost always a bug.
> >>
> >> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
> >> warning.
> >>  
> > 
> > This is a bug in checkpatch and should be fixed in checkpatch. The code is
> > not actually re-using the parameter. channels and xadc_channels are
> > independent variables, just checkpatch somehow does not realize this.  
> 
> I think it should be fine to have this patch in tree. Change in commit
> message to reflect this should be enough. But that's just view.

Let's wait and see if Joe has time to take a look at this.  Might be better
to fix checkpatch if it's not too hard!

Jonathan
> 
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

