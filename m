Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdIPWFX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Sep 2017 18:05:23 -0400
Date: Sat, 16 Sep 2017 15:05:19 -0700
From: Jonathan Cameron <jic23@kernel.org>
To: Paolo Cretaro <melko@frugalware.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Brian Masney <masneyb@onstation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        simran singhal <singhalsimran0@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: tsl2x7x: clean up limit checks
Message-ID: <20170916150519.4564a279@archlinux>
In-Reply-To: <48e90a50-7fa1-8bef-368b-cffc0a6fcfd3@frugalware.org>
References: <20170908105343.tk3j36sgxd7xm222@mwanda>
        <e9f6e0a4-ad54-1fd4-d02c-39b5c3fd128f@frugalware.org>
        <20170916113759.3kp2kw2ev3f6ju27@mwanda>
        <48e90a50-7fa1-8bef-368b-cffc0a6fcfd3@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 16 Sep 2017 14:18:52 +0200
Paolo Cretaro <melko@frugalware.org> wrote:

> On 16/09/2017 13:37, Dan Carpenter wrote:
> > On Sat, Sep 16, 2017 at 01:11:29PM +0200, Paolo Cretaro wrote:  
> >> Hi Dan,
> >> just minor nitpicking on the commit message:
> >>
> >> On 08/09/2017 12:53, Dan Carpenter wrote:  
> >>> The background of this code is that we can either use the default
> >>> tables or load our own table with sysfs.  The default tables are three
> >>> element arrays of struct tsl2x7x_lux.  If we load the table with sysfs
> >>> then we can have as many as nine elements.  Which ever way we do it, the
> >>> last element is always zeroed out.
> >>>
> >>> The most interesting part of this patch is in the
> >>> in_illuminance0_lux_table_show() function.  We were using the wrong
> >>> limit, "TSL2X7X_MAX_LUX_TABLE_SIZE * 3", when it should have been just
> >>> "TSL2X7X_MAX_LUX_TABLE_SIZE".  This creates a static checker warning
> >>> that we are going of of bounds.  However, since the last element is  
> >> out of bounds
> >>
> >> Regards,
> >> P.
> >>  
> >>> always zeroed out, that means we hit the break statement and the code
> >>> works correctly despite the wrong limit check.  
> > 
> > What?  No no.  I meant it how I wrote it.  The last element is
> > always zeroed out meaning it's just a series of zeroes.  
> 
> Sorry, I meant the previous sentence "This creates a static checker warning
> that we are going of of bounds".

Double of fixed and patch applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> Regards,
> P.
> 
> > 
> > regards,
> > dan carpenter
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

