Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38460
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751651AbdCMVKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 17:10:24 -0400
Date: Mon, 13 Mar 2017 22:09:42 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Jonathan Cameron <jic23@kernel.org>
cc: Gargi Sharma <gs051095@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
In-Reply-To: <fcbaa813-6371-f27a-9790-9ca3ffcda460@kernel.org>
Message-ID: <alpine.DEB.2.20.1703132209350.4053@hadrien>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com> <alpine.DEB.2.20.1703122154130.7649@hadrien> <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com> <alpine.DEB.2.20.1703122235320.7649@hadrien> <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com> <alpine.DEB.2.20.1703132138040.4053@hadrien> <fcbaa813-6371-f27a-9790-9ca3ffcda460@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Mon, 13 Mar 2017, Jonathan Cameron wrote:

> On 13/03/17 20:40, Julia Lawall wrote:
> >>> I like the automated editing because it certainly cuts down on typos,
> >>> and even with this one, you can just move the new lock field upon
> >>> inspection.  Sadly, I don't think the script will apply too widely
> >>> because the use of "_state" for driver global data isn't a standard,
> >>> nor availability of that struct in the functions needing the locking.
> >> I only saw three files that had the mlock and they followed the structure
> >> with _state as suffix and only had mutex_lock for &indio_dev->mlock.
> >> Hence, I went ahead with the script even though I knew it wasn't probably
> >> very safe.
> >
> > If _state is useful, you can add a regular expression to the metavariable declaration to checkk for that.  I think it would be something like:
> >
> > identifier x =~ "_state$";
> >
> > but I don't actually know.  I would prefer to use some more semantic
> > concept to identify such a structure.  For example, structures are often
> > stored in other structures or passed to some generic function.  Then you
> > can get to the structure in a way that is based on its purpose rather than
> > its name.
> >
> > julia
> >
> This particular one is almost always equal (possibly always) to what comes
> from the struct iio_dev a when iio_priv(a) is applied.

That seems like a promising lead.

An issue with such assignments is that they might occur in a variable
declaration or in the rest of the function body.  If you write a pattern
like the following:

@@
struct foo *x;
@@

*x = y()

then it will match all of:

struct foo *a = y();
b = y();  // where b has the right type
if ((b = y()) < 0) return;
m = b = y();

but not b = m = y();

In this case, you want there to be a path from this initialization to the
thing you want to change.  And you want to change all occurrences that fit
some pattern, so the basic outline would be:

*x = y()
<...
- x
+ z
...>

julia
