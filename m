Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38842 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 22:35:42 -0400
Date: Thu, 25 Oct 2018 23:31:44 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181025180139.GA8340@nishad>
References: <20181024145051.GA18490@nishad>
 <20181025064356.GA18633@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181025064356.GA18633@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 25, 2018 at 08:43:56AM +0200, Slawomir Stepien wrote:
> On paź 24, 2018 20:20, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v4:
> >  - Add spaces after { and before } in gpios[]
> >    initialization.
> >  - Check the correct pointer for error.
> >  - Align the dev_err msg to existing format in the code.
> > Changes in v3:
> >  - Use a pointer to pointer for gpio_desc in
> >    struct ad2s1210_gpio as it will be used to
> >    modify a pointer.
> >  - Use dot notation to initialize the structure.
> >  - Use a pointer variable to avoid writing gpios[i].
> > Changes in v2:
> >  - Use the spi_device struct embedded in st instead
> >    of passing it as an argument to ad2s1210_setup_gpios().
> >  - Use an array of structs to reduce redundant code in
> >    in ad2s1210_setup_gpios().
> >  - Remove ad2s1210_free_gpios() as devm API is being used.
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
> >  drivers/staging/iio/resolver/ad2s1210.h |  3 -
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> 
> Looks good to me.
> 
> Reviewed-by: Slawomir Stepien <sst@poczta.fm>
> 
> -- 
> Slawomir Stepien
Hi,

Thanks for the review.

I was thinking of adding the device tree support to this file as well.

Can you please tell me if I can submit the new patch in a patchset with
this patch as the first and the one adding device tree support as the second?

Thanks and regards,
Nishad
