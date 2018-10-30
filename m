Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:34228 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeJaBv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Oct 2018 21:51:29 -0400
Received: by mail-io1-f68.google.com with SMTP id d80-v6so7705956iof.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Oct 2018 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181027020005.3140-1-matheus.bernardino@usp.br> <20181028165202.52ee89b3@archlinux>
In-Reply-To: <20181028165202.52ee89b3@archlinux>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Tue, 30 Oct 2018 13:57:00 -0300
Message-ID: <CAHd-oW58oc6=YOFdXDhPMJ9d1U19W3mc1essNzy1F8wakPLJnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve
 error handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 28, 2018 at 1:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 26 Oct 2018 22:59:59 -0300
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> > This patch set adds scale info to ad2s90's single channel, improve
> > error handling in it's functions and fix a possible race condition
> > issue.
> >
> > The goal with this patch set is to address the points discussed in the
> > mailing list in an effort to move ad2s90.c out of staging.
> Thanks,
>
> A good series in general.  A few suggested improvements.
> If I haven't commented on a patch, usually it means I'm happy with it
> and will pick it up with the rest of the series.
>
> Jonathan
>

Thanks for the review, Jonathan. We will address the necessary changes in v3!

Matheus

> >
> > Changes in v2:
> >  - Added my S-o-B in patch 5.
> >
> > Matheus Tavares (5):
> >   staging:iio:ad2s90: Make read_raw return spi_read's error code
> >   staging:iio:ad2s90: Make probe handle spi_setup failure
> >   staging:iio:ad2s90: Remove always overwritten assignment
> >   staging:iio:ad2s90: Move device registration to the end of probe
> >   staging:iio:ad2s90: Check channel type at read_raw
> >
> > Victor Colombo (1):
> >   staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
> >     read_raw
> >
> >  drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
> >  1 file changed, 37 insertions(+), 18 deletions(-)
> >
>
