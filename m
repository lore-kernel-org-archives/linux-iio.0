Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f54.google.com ([209.85.216.54]:35279 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbGYFMw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jul 2015 01:12:52 -0400
Received: by vnaa140 with SMTP id a140so15644890vna.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2015 22:12:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B28DB7.3050906@gmx.de>
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
	<1437751409-28837-2-git-send-email-jasaw@dius.com.au>
	<55B28DB7.3050906@gmx.de>
Date: Sat, 25 Jul 2015 15:12:51 +1000
Message-ID: <CA+0Dg4oT6_RjUL9rBPCKdQ-PJpo-UoGUSSySEMT12LcYkHEYgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: iio: Set caller's ci_array pointer to NULL
 after free
From: Joo Aun Saw <jasaw@dius.com.au>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jul 25, 2015 at 5:10 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>
> Joo Aun Saw schrieb am 24.07.2015 um 17:23:
> > From: Joo Aun Saw <jasaw@dius.com.au>
> >
> > On error, caller's ci_array is freed and set to NULL to avoid
> > potential double free. Counter is reset to zero for consistency.
> >
>
> Hi,
> I don't see a second attempt to free the array. In here, just dp gets
> closed and the scan_el_dir string freed.
> And in generic_buffer.c where it is accessed in the main function, there
> is a jump into the error handler in case of an error, which just frees a
> few strings (datardytrigger, trigger_name and dev_dir_name).
> Any opinion welcome.
> Thanks,
>
> Hartmut
>
Currently, there is no second free attempt in those examples, but
iio_utils is meant to be used as a library in the future, and
therefore should not leave a dangling pointer (the caller owns the
pointer in this case). There is no guarantee what other users of
iio_utils might do. For example, a caller may have a single clean up
routine that frees ALL pointers upon failure (to simplify error
handling), and will encounter double free problem if this is not
fixed. Additionally, it's good software engineering practice to set
pointers to NULL after free because the caller may still reference it
in the future.

Joo.

> > Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> > ---
> >  tools/iio/iio_utils.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> > index 1dcdf03..8731905 100644
> > --- a/tools/iio/iio_utils.c
> > +++ b/tools/iio/iio_utils.c
> > @@ -529,6 +529,8 @@ error_cleanup_array:
> >               free((*ci_array)[i].generic_name);
> >       }
> >       free(*ci_array);
> > +     *ci_array = NULL;
> > +     *counter = 0;
> >  error_close_dir:
> >       if (dp)
> >               if (closedir(dp) == -1)
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
