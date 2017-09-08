Return-Path: <SRS0=uqYq=AJ=lip6.fr=julia.lawall@kernel.org>
Date: Fri, 8 Sep 2017 12:32:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
    Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
    Himanshi Jain <himshijain.hj@gmail.com>, outreachy-kernel@googlegroups.com,
    Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
    pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH] Staging: iio: adc: Added Space
 around binary op.
In-Reply-To: <9590dab0-5bd8-c4d0-1f34-934d3835fade@metafoo.de>
Message-ID: <alpine.DEB.2.20.1709081232370.3165@hadrien>
References: <20170908044752.GA6199@himanshi-Inspiron-5558> <DEB4AC67-43D5-40F9-9495-DB4966A07661@jic23.retrosnub.co.uk> <20170908103257.00002165@huawei.com> <2e3476f0-9e7e-2701-220a-5fb178d68d2e@metafoo.de> <alpine.DEB.2.20.1709081157590.3165@hadrien>
 <9590dab0-5bd8-c4d0-1f34-934d3835fade@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Fri, 8 Sep 2017, Lars-Peter Clausen wrote:

> On 09/08/2017 11:59 AM, Julia Lawall wrote:
> >
> >
> > On Fri, 8 Sep 2017, Lars-Peter Clausen wrote:
> >
> >> On 09/08/2017 11:32 AM, Jonathan Cameron wrote:
> >>> On Fri, 8 Sep 2017 07:29:06 +0100
> >>> Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> >>>
> >>>> On 8 September 2017 05:47:52 BST, Himanshi Jain <himshijain.hj@gmail.com> wrote:
> >>>>> Added space around(one on each side of) binary
> >>>>> operator(-) as preferred according to kernel
> >>>>> coding style.
> >>>>>
> >>>>> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
> >>>>
> >>>> Take a closer look at that macro. It isn't doing what you think...
> >>>> To give a hint, changing this breaks userspace.
> >>>
> >>> Ok, I'm bored of this particular one coming up. When you have
> >>> worked out what is going on Himanshi, would you mind putting
> >>> together a patch adding a comment describing why it is a bad
> >>> idea to 'fix' this?  That would be a very useful patch as
> >>> far as I'm concerned :)
> >>>
> >>> There aren't that many cases of this in IIO so adding a comment
> >>> on each of them is probably reasonable just to avoid wasting
> >>> people's time on fixing them! (I think we have had more than
> >>> 5 such goes this year so far...)
> >>>
> >>
> >> I'd much rather fix this API so that you have to put "" around the name so
> >> that it is clear that it is a string, rather than doing the implicit
> >> conversion to string using preprocessor magic. Better to have a
> >> self-documenting API then having to add a comment to each user of the API.
> >
> > All the DEVICE_ATTR macros use the same strategy.  And the non-IIO ones,
> > eg DEVICE_ATTR_RW, also use the provided name to construct the names of
> > the show and store functions, so I don't think a string would be
> > appropriate.
>
> I'm only suggesting to use a string for the _NAMED macros where the name is
> not used to construct the identifiers.
>
> In the case where the name is used to construct the identifiers we don't
> have the issue with false positives since the name must be a valid
> identifier on its own.

OK, it looks like a good project :)

julia
