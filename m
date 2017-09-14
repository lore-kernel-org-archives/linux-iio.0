Return-Path: <SRS0=C1Lb=AP=lip6.fr=julia.lawall@kernel.org>
Date: Thu, 14 Sep 2017 07:10:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Joe Perches <joe@perches.com>
cc: Dan Carpenter <dan.carpenter@oracle.com>,
    Greg KH <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>,
    devel@driverdev.osuosl.org, daniel.baluta@gmail.com,
    Himanshi Jain <himshijain.hj@gmail.com>, Michael.Hennerich@analog.com,
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
    nick.desaulniers@gmail.com, outreachy-kernel@googlegroups.com,
    pmeerw@pmeerw.net, knaack.h@gmx.de, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [Outreachy kernel] Re: [PATCH v2 1/2] include: linux: sysfs:
 Add __ATTR_NAMED macro
In-Reply-To: <1505339903.8969.20.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1709140709450.2091@hadrien>
References: <cover.1505291907.git.himshijain.hj@gmail.com>  <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>  <20170913180310.27cbf1b1@archlinux> <20170913185805.GB26390@kroah.com>  <5e43ea4d-eab8-c4be-c5dc-2f862578d011@metafoo.de>
  <20170913212952.GD9288@kroah.com> <20170913214333.mcw4f24fkzndwh5k@mwanda> <1505339903.8969.20.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Wed, 13 Sep 2017, Joe Perches wrote:

> On Thu, 2017-09-14 at 00:43 +0300, Dan Carpenter wrote:
> > He was exagerating a bit to call it a "static checker" warning...
>
> Not really.
>
> False positives and false negatives exist in just about
> every static
> checker.
>
> > It's just checkpatch.pl complaining about adding spaces around the -
> > operator.
>
> checkpatch is a brain-damaged by design static checker.
> regexes can only be sensitive to patterns, not compiled code.
>
> > The sysfs file has a hyphen in the middle.
>
> Another option would be to use an underscore instead.

There are already underscores on either side.

julia

>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1505339903.8969.20.camel%40perches.com.
> For more options, visit https://groups.google.com/d/optout.
>
