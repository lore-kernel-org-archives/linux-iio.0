Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbdKSO7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 09:59:15 -0500
Date: Sun, 19 Nov 2017 14:59:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v4 2/2] iio: accel: mma8452: Rename config structs for
 readability
Message-ID: <20171119145911.38ad7ded@archlinux>
In-Reply-To: <174aea53-99b0-e400-c2f3-8a7a9fd809d8@posteo.de>
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
        <1509904804-4608-3-git-send-email-harinath922@gmail.com>
        <174aea53-99b0-e400-c2f3-8a7a9fd809d8@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 5 Nov 2017 21:36:01 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> On 2017-11-05 19:00, Harinath Nampally wrote:
> > Rename structs holding event configuration registers
> > to more appropriate names. This naming is consistent
> > with the event config register names given in the
> > mma845x and fxls8471 datasheets.
> > 
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>  
> 
> Makes sense to me.
> 
> Acked-by: Martin Kepplinger <martink@posteo.de>
> 

Applied.  Thanks,

Jonathan
> 
> Hey Harinath,
> 
> I think it'd be great to have the "power_mode" iio ABI interface
> for mma8452 too, and I just found an old patch pf mine for this.
> 
> If you say you could test it and check for correct API usage and
> ABI provisioning in sysfs, I'd be happy to publish it for you to
> make any necessary corrections and submit it after testing.
> 
> Do we have a deal?
> 
> thanks
> 
>                              martin

