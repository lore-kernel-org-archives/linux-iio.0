Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUTY3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:24:29 -0400
Date: Wed, 21 Jun 2017 20:24:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: "=?UTF-8?B?QnLDvG5zLA==?= Stefan" <Stefan.Bruens@rwth-aachen.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 3/3] iio: adc: Fix polling of INA219 conversion ready
 flag
Message-ID: <20170621202423.26515ac7@kernel.org>
In-Reply-To: <72e8186a-101e-f1e3-b7f4-19a0805ff1af@ti.com>
References: <20170524000907.7788-1-stefan.bruens@rwth-aachen.de>
        <20170524205335.166b7085@kernel.org>
        <20170524205641.20252455@jic23.retrosnub.co.uk>
        <1598491.c75bYYbHRJ@sbruens-linux>
        <72e8186a-101e-f1e3-b7f4-19a0805ff1af@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 19 Jun 2017 13:30:31 -0500
"Andrew F. Davis" <afd@ti.com> wrote:

> On 06/19/2017 01:24 PM, Brüns, Stefan wrote:
> > On Mittwoch, 24. Mai 2017 21:56:54 CEST Jonathan Cameron wrote:  
> >> On Wed, 24 May 2017 20:53:35 +0100
> >>
> >> Jonathan Cameron <jic23@kernel.org> wrote:  
> >>> On Wed, 24 May 2017 02:09:07 +0200
> >>>
> >>> Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:  
> >>>> While the INA226 has a conversion ready flag (CVRF) in the R/W
> >>>> Mask/Enable
> >>>> register with read-to-clear semantics, the corresponding bit of the
> >>>> INA219
> >>>> (CNVR) is part of the bus voltage register. The flag is cleared by
> >>>> reading
> >>>> the power register.
> >>>>
> >>>> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>  
> >>>
> >>> Again, looks good to me, but I would like input form Marc or Andrew
> >>> who are more familiar with these devices than me!
> >>>
> >>> Ping me in a week or two if nothing is happening and I look to have
> >>> lost these!  
> >>
> >> Ah Marc's old email is bouncing.  If no one has a more up to
> >> data address I guess we'll be looking at Andrew to have a chance to
> >> respond (which is more likely if I actually cc him ;)  
> > 
> > Ping ;-)
> >   
> 
> As for me, my silence is approval, nothing looks incorrect to me.
Applied to the togreg branch of iio.git and pushed out as testing.
It's late enough in the cycle that any fixes will probably be post
merge window now.  Also this doesn't apply to my fixes-togreg branch
(presumably due to the earlier patches).

Thanks for the ping.

Jonathan
> 
> > Kind regards,
> > 
> > Stefan
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

