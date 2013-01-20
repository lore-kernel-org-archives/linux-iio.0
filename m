Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47521 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab3ATNes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jan 2013 08:34:48 -0500
Date: Sun, 20 Jan 2013 14:34:47 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, jbrenner@taosinc.com,
	amit.kucheria@verdurent.com
Subject: Re: [PATCH 0/5] iio:light:tsl2563 cleanup and move out of staging.
In-Reply-To: <50FBDE85.8040207@kernel.org>
Message-ID: <alpine.DEB.2.01.1301201432380.18128@pmeerw.net>
References: <1357986924-11471-1-git-send-email-jic23@kernel.org> <50FBDE85.8040207@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> Are you happy this this modified set?
> I always feel a little bit naughty pushing patches on without
> any acks or reviewed by tags...

changes look good as far as I am concerned, I voice a very humble 
Acked-by:

two nitpicks (comment and convention) for the Move-out-of-staging patch, 
sorry for not commenting earlier

regards, p.

> On 01/12/2013 10:35 AM, Jonathan Cameron wrote:
> > This series more or less consists of the original move patch after
> > some precursors fixing the various bits and bobs Peter found in his
> > review.  I also dropped a few other unnecessary bits spotted
> > whilst making Peter's changes.
> > 
> > Jonathan Cameron (5):
> >   staging:iio:light:tsl2563 drop unnecessary brackets around constants.
> >   staging:iio:light:tsl2563 clean comments up.
> >   staging:iio:tsl2563 Simplify exit path on error in
> >     read_interrupt_config.
> >   staging:iio:tsl2563 drop pointless forward declaration
> >   iio:light:tsl2563 move out of staging
> > 
> >  drivers/iio/light/Kconfig             |  10 +
> >  drivers/iio/light/Makefile            |   1 +
> >  drivers/iio/light/tsl2563.c           | 887 +++++++++++++++++++++++++++++++++
> >  drivers/staging/iio/light/Kconfig     |  10 -
> >  drivers/staging/iio/light/Makefile    |   1 -
> >  drivers/staging/iio/light/tsl2563.c   | 899 ----------------------------------
> >  drivers/staging/iio/light/tsl2563.h   |   9 -
> >  include/linux/platform_data/tsl2563.h |   9 +
> >  8 files changed, 907 insertions(+), 919 deletions(-)
> >  create mode 100644 drivers/iio/light/tsl2563.c
> >  delete mode 100644 drivers/staging/iio/light/tsl2563.c
> >  delete mode 100644 drivers/staging/iio/light/tsl2563.h
> >  create mode 100644 include/linux/platform_data/tsl2563.h
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
