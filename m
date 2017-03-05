Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44088 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752398AbdCETaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 14:30:19 -0500
Date: Sun, 5 Mar 2017 20:17:45 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
cc: Alison Schofield <amsfield22@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] staging: iio: accel: Group similar
 macros into enums
In-Reply-To: <20170305191459.GA20822@nati-X550JK>
Message-ID: <alpine.DEB.2.20.1703052017040.3052@hadrien>
References: <cover.1488730643.git.narcisaanamaria12@gmail.com> <20170305185828.GA3380@d830.WORKGROUP> <20170305191459.GA20822@nati-X550JK>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Sun, 5 Mar 2017, Narcisa Ana Maria Vasile wrote:

> On Sun, Mar 05, 2017 at 10:58:29AM -0800, Alison Schofield wrote:
> > On Sun, Mar 05, 2017 at 06:26:03PM +0200, Narcisa Ana Maria Vasile wrote:
> > > Group related macros into enums, for clarity.
> >
> > Hi Narcisa,
> >
> > Is this enum then used in a type declaration?
> >
> > BTW - I can see Jonathan is following right along and sweeping these up,
> > but for future reference, this patch depended on a previous patch sent hours
> > earlier, that was not yet in staging-testing.  When this happens, one option
> > is to give a note below the --- (as you would for version comments) stating the
> > dependency.  This way someone reviewing the patch doesn't simply reject
> > it as not applying to my tree.
> >
> > alisons
> >
>   Hi,
>
>   Do you mean whether there are any type declarations where I could
>   now replace the type with the enum type ? If so, I searched for
>   these type of situations, but didn't find any. If I missed one of
>   these cases, please let me know and I'll send a new patch.

Typically the constant would be stored in something, compared to
something, etc.  Are these constants not used at all?

julia


>
>   Thank you for the note about the patch dependencies. I was just about
>   to ask about this, cause I realized there might be a problem.
>   I'll keep in mind to make a note next time.
>
>   Narcisa
>
> > > Narcisa Ana Maria Vasile (2):
> > >   staging: iio: adis16209: Group similar macros into enums
> > >   staging: iio: adis16240: Group similar macros into enums
> > >
> > >  drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
> > >  drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
> > >  2 files changed, 18 insertions(+), 14 deletions(-)
> > >
> > > --
> > > 1.9.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1488730643.git.narcisaanamaria12%40gmail.com.
> > > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170305191459.GA20822%40nati-X550JK.
> For more options, visit https://groups.google.com/d/optout.
>
