Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:46263 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab3IHPCK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:10 -0400
Date: Sun, 8 Sep 2013 17:02:06 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Move kernel-doc for iio_str_to_fixpoint() to
 iio.h
In-Reply-To: <5228D5E0.6070503@metafoo.de>
Message-ID: <alpine.DEB.2.01.1309081659440.16600@pmeerw.net>
References: <1378170374-27598-1-git-send-email-pmeerw@pmeerw.net> <5228D5E0.6070503@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Usually the kernel-doc is kept with the implementation

ok; it is one of the few undocumented functions in iio.h hence I 
suggested to move the documentation

> > ---
> >   drivers/iio/industrialio-core.c |   10 ----------
> >   include/linux/iio/iio.h         |   11 +++++++++++
> >   2 files changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c
> > b/drivers/iio/industrialio-core.c
> > index 2cb4841..b27c4b5 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -409,16 +409,6 @@ static ssize_t iio_read_channel_info(struct device
> > *dev,
> >   	}
> >   }
> > 
> > -/**
> > - * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> > - * @str: The string to parse
> > - * @fract_mult: Multiplier for the first decimal place, should be a power
> > of 10
> > - * @integer: The integer part of the number
> > - * @fract: The fractional part of the number
> > - *
> > - * Returns 0 on success, or a negative error code if the string could not
> > be
> > - * parsed.
> > - */
> >   int iio_str_to_fixpoint(const char *str, int fract_mult,
> >   	int *integer, int *fract)
> >   {
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 01edd67..d12518e 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -612,6 +612,17 @@ static inline struct dentry
> > *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> >   }
> >   #endif
> > 
> > +
> > +/**
> > + * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> > + * @str: The string to parse
> > + * @fract_mult: Multiplier for the first decimal place, should be a power
> > of 10
> > + * @integer: The integer part of the number
> > + * @fract: The fractional part of the number
> > + *
> > + * Returns 0 on success, or a negative error code if the string could not
> > be
> > + * parsed.
> > + */
> >   int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
> >   	int *fract);
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
