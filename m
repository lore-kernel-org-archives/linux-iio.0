Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33339 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbcJLNDj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2016 09:03:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id 190so2736638pfv.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2016 06:03:38 -0700 (PDT)
Date: Wed, 12 Oct 2016 21:03:33 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [Outreachy kernel] Re: [PATCH v3 2/2] staging: iio: ad7606: fix
 improper setting of oversampling pins
Message-ID: <20161012130331.GA2726@Socrates-DK>
References: <cover.1475907512.git.eraretuya@gmail.com>
 <9018314d134e3e33f892ad78969e11bf5ffa0950.1475907512.git.eraretuya@gmail.com>
 <39a0c2c4-6fcb-21f2-f9b3-ddb360f58c75@metafoo.de>
 <20161012124217.GA18782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012124217.GA18782@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 12, 2016 at 02:42:17PM +0200, Greg KH wrote:
> On Sat, Oct 08, 2016 at 02:21:46PM +0200, Lars-Peter Clausen wrote:
> > On 10/08/2016 08:50 AM, Eva Rachel Retuya wrote:
> > > The oversampling ratio is controlled using the oversampling pins,
> > > OS [2:0] with OS2 being the MSB control bit, and OS0 the LSB control
> > > bit.
> > > 
> > > The gpio connected to the OS2 pin is not being set correctly, only OS0
> > > and OS1 pins are being set. Fix the typo to allow proper control of the
> > > oversampling pins.
> > > 
> > > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> > > Fixes: b9618c0 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
> > 
> > Looks good, thanks.
> > 
> > Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > Ideally you'd have but the patches in the opposite order, fix first, then
> > rework. As it is right now with the fix after the rework the fix no longer
> > applies cleanly to older versions.
> 
> Yes, please do that, so it can be applied to older kernels properly.
> 
> thanks,
> 
> greg k-h

Lars and Greg:

Thanks for the feedback. I got the v4 accepted using the proper order,
fix first then rework as suggested.

Eva
