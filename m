Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752859AbdHQOku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:40:50 -0400
Date: Thu, 17 Aug 2017 15:40:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: Martin Kepplinger <martink@posteo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        lars@metafoo.de, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH] iio: accel: mma8452: Bugfix to enbale and allow
 different events to work parallely.
Message-ID: <20170817154041.6292ea19@archlinux>
In-Reply-To: <9202ac3c-cc5b-2b45-ba37-d6a24364b9e6@gmail.com>
References: <1502750644-8854-1-git-send-email-harinath922@gmail.com>
        <alpine.DEB.2.20.1708161455420.27224@vps.pmeerw.net>
        <0a512995-3fd5-e38e-73a6-417337515ce6@gmail.com>
        <13587F36-588D-4011-8E70-A8892F81887E@posteo.de>
        <9202ac3c-cc5b-2b45-ba37-d6a24364b9e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 07:55:45 -0400
Harinath Nampally <harinath922@gmail.com> wrote:

> > This patch fixes by detaching the event related information from
> > chip_info struct,  
> >>> and based on channel type and event direction the corresponding  
> > event configuration registers  
> >>> are picked dynamically. Hence multiple events can be handled in  
> > read/write callbacks.  
> >> which chip can have which event(s)?  
> > I am planning to add 'supported events' field in

One small point. Don't put the word bugfix in the title (and fix
spelling of enable!).  I know this is obviously a false restriction
on the driver, but it doesn't not work, it is just limited in features
without this.

This issue is that this is not really material that should be going
into stable kernels.  It's an improvement though so good to have it!

Jonathan

> >
> > struct mma_chip_info which indicates which chip can have which events.
> > During initialization in 'mma_chip_info_table' would set this
> > 'supported events' field for each chip.
> > But I wonder should I add those changes as part of this patch?
> > is it necessary or can it be documentation?  
> I think its not necessary as we only have Freefall and Transient events 
> for now.
> Ok I will just update the documentation.
> >
> > And this patch should have been called "v2". please include a persistent version history to v3 of this patch.  
> Sure I will send v3 patch, should I use '--in-reply-to' option of git 
> send-email to send v3 patch as reply to
> original thread?
> 
> On 08/17/2017 07:24 AM, Martin Kepplinger wrote:
> >>>> This patch fixes by detaching the event related information from  
> >> chip_info struct,  
> >>>> and based on channel type and event direction the corresponding  
> >> event configuration registers  
> >>>> are picked dynamically. Hence multiple events can be handled in  
> >> read/write callbacks.  
> >>> which chip can have which event(s)?  
> >> I am planning to add 'supported events' field in
> >>
> >> struct mma_chip_info which indicates which chip can have which events.
> >> During initialization in 'mma_chip_info_table' would set this
> >> 'supported events' field for each chip.
> >> But I wonder should I add those changes as part of this patch?  
> > is it necessary or can it be documentation?
> >
> > And this patch should have been called "v2". please include a persistent version history to v3 of this patch.  
> 

