Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38874 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3IHP3m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 11:29:42 -0400
In-Reply-To: <alpine.DEB.2.01.1309081659440.16600@pmeerw.net>
References: <1378170374-27598-1-git-send-email-pmeerw@pmeerw.net> <5228D5E0.6070503@metafoo.de> <alpine.DEB.2.01.1309081659440.16600@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: Move kernel-doc for iio_str_to_fixpoint() to iio.h
From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 08 Sep 2013 16:29:37 +0100
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Message-ID: <ccf91f8e-29d4-481e-bdb7-38dd73e03c48@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
>> Usually the kernel-doc is kept with the implementation
>
>ok; it is one of the few undocumented functions in iio.h hence I 
>suggested to move the documentation

My fault as I did the others all wrong in the first place.  There are good arguments either way but Lars is right that with the implementation is the most common choice.

Now, it would be good to clean this up once and for all if anyone wants to do the patches to move all docs to where they are implemented... It will be a lot of churn but right now I think the core is pretty quiet.
>
>> > ---
>> >   drivers/iio/industrialio-core.c |   10 ----------
>> >   include/linux/iio/iio.h         |   11 +++++++++++
>> >   2 files changed, 11 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/drivers/iio/industrialio-core.c
>> > b/drivers/iio/industrialio-core.c
>> > index 2cb4841..b27c4b5 100644
>> > --- a/drivers/iio/industrialio-core.c
>> > +++ b/drivers/iio/industrialio-core.c
>> > @@ -409,16 +409,6 @@ static ssize_t iio_read_channel_info(struct
>device
>> > *dev,
>> >   	}
>> >   }
>> > 
>> > -/**
>> > - * iio_str_to_fixpoint() - Parse a fixed-point number from a
>string
>> > - * @str: The string to parse
>> > - * @fract_mult: Multiplier for the first decimal place, should be
>a power
>> > of 10
>> > - * @integer: The integer part of the number
>> > - * @fract: The fractional part of the number
>> > - *
>> > - * Returns 0 on success, or a negative error code if the string
>could not
>> > be
>> > - * parsed.
>> > - */
>> >   int iio_str_to_fixpoint(const char *str, int fract_mult,
>> >   	int *integer, int *fract)
>> >   {
>> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> > index 01edd67..d12518e 100644
>> > --- a/include/linux/iio/iio.h
>> > +++ b/include/linux/iio/iio.h
>> > @@ -612,6 +612,17 @@ static inline struct dentry
>> > *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>> >   }
>> >   #endif
>> > 
>> > +
>> > +/**
>> > + * iio_str_to_fixpoint() - Parse a fixed-point number from a
>string
>> > + * @str: The string to parse
>> > + * @fract_mult: Multiplier for the first decimal place, should be
>a power
>> > of 10
>> > + * @integer: The integer part of the number
>> > + * @fract: The fractional part of the number
>> > + *
>> > + * Returns 0 on success, or a negative error code if the string
>could not
>> > be
>> > + * parsed.
>> > + */
>> >   int iio_str_to_fixpoint(const char *str, int fract_mult, int
>*integer,
>> >   	int *fract);
>> > 
>> > 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
