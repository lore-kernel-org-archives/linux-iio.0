Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44289 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeJ0Dep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 23:34:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id i30so731032uae.11
        for <linux-iio@vger.kernel.org>; Fri, 26 Oct 2018 11:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
 <20181026004512.31012-6-matheus.bernardino@usp.br> <20181026100422.lvz2avowd6ddix54@mwanda>
In-Reply-To: <20181026100422.lvz2avowd6ddix54@mwanda>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Fri, 26 Oct 2018 15:56:21 -0300
Message-ID: <CAHd-oW5gePV54sEsrbcGdZo=hvcV5rqKVRS_Oq=vxvMCwzSwhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
To: dan.carpenter@oracle.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 26, 2018 at 7:04 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Oct 25, 2018 at 09:45:11PM -0300, Matheus Tavares wrote:
> > From: Victor Colombo <victorcolombo@gmail.com>
> >
> > This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> > implements the relative read behavior at ad2s90_read_raw.
> >
> > Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> > ---
>
> You should be adding your S-o-B here as well because the patch is
> passing through your hands.

Thanks for the review! I'll be sending a v2 with my S-o-B there.

> regards,
> dan carpenter
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181026100422.lvz2avowd6ddix54%40mwanda.
> For more options, visit https://groups.google.com/d/optout.
