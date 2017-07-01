Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdGAMLR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 08:11:17 -0400
Date: Sat, 1 Jul 2017 13:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: magnetometer: Only declare ACPI table when ACPI is
 enable
Message-ID: <20170701131112.7dbfa118@kernel.org>
In-Reply-To: <CACRpkdZGUDryau4SMHwa3QDG-vrDrB9bkB9iKrxAcs-R2YDLQw@mail.gmail.com>
References: <20170627002533.97293-1-mka@chromium.org>
        <CACRpkdZGUDryau4SMHwa3QDG-vrDrB9bkB9iKrxAcs-R2YDLQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Jun 2017 14:51:56 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jun 27, 2017 at 2:25 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Don't inflate the kernel size with data that isn't used. The conditional
> > declaration also fixes the following warning when building with clang:
> >
> > drivers/iio/magnetometer/ak8975.c:704:36: error: variable 'ak_acpi_match'
> >   is not needed and will not be emitted
> >   [-Werror,-Wunneeded-internal-declaration]
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I'm curious though... Can the compiler not optimize this away? 
I'd always assumed the main reason for these warnings was that the
presence of unused data might represent a bug rather than it actually
making any difference to the size...
