Return-Path: <SRS0=rcf9=2W=lip6.fr=julia.lawall@kernel.org>
Date: Mon, 13 Mar 2017 21:40:43 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Gargi Sharma <gs051095@gmail.com>
cc: Alison Schofield <amsfield22@gmail.com>,
    Julia Lawall <julia.lawall@lip6.fr>, outreachy-kernel@googlegroups.com,
    lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
    knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
In-Reply-To: <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703132138040.4053@hadrien>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com> <alpine.DEB.2.20.1703122154130.7649@hadrien> <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com> <alpine.DEB.2.20.1703122235320.7649@hadrien> <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

> > I like the automated editing because it certainly cuts down on typos,
> > and even with this one, you can just move the new lock field upon
> > inspection.  Sadly, I don't think the script will apply too widely
> > because the use of "_state" for driver global data isn't a standard,
> > nor availability of that struct in the functions needing the locking.
> I only saw three files that had the mlock and they followed the structure
> with _state as suffix and only had mutex_lock for &indio_dev->mlock.
> Hence, I went ahead with the script even though I knew it wasn't probably
> very safe.

If _state is useful, you can add a regular expression to the metavariable declaration to checkk for that.  I think it would be something like:

identifier x =~ "_state$";

but I don't actually know.  I would prefer to use some more semantic
concept to identify such a structure.  For example, structures are often
stored in other structures or passed to some generic function.  Then you
can get to the structure in a way that is based on its purpose rather than
its name.

julia
