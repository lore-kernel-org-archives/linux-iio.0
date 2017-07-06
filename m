Return-Path: <SRS0=gSXg=6J=chromium.org=mka@kernel.org>
Date: Thu, 6 Jul 2017 09:42:38 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: magnetometer: Only declare ACPI table when ACPI is
 enable
Message-ID: <20170706164238.GB95735@google.com>
References: <20170627002533.97293-1-mka@chromium.org>
 <CACRpkdZGUDryau4SMHwa3QDG-vrDrB9bkB9iKrxAcs-R2YDLQw@mail.gmail.com>
 <20170701131112.7dbfa118@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170701131112.7dbfa118@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

El Sat, Jul 01, 2017 at 01:11:12PM +0100 Jonathan Cameron ha dit:

> On Thu, 29 Jun 2017 14:51:56 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Tue, Jun 27, 2017 at 2:25 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > 
> > > Don't inflate the kernel size with data that isn't used. The conditional
> > > declaration also fixes the following warning when building with clang:
> > >
> > > drivers/iio/magnetometer/ak8975.c:704:36: error: variable 'ak_acpi_match'
> > >   is not needed and will not be emitted
> > >   [-Werror,-Wunneeded-internal-declaration]
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Yours,
> > Linus Walleij
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Thanks!

> I'm curious though... Can the compiler not optimize this away? 
> I'd always assumed the main reason for these warnings was that the
> presence of unused data might represent a bug rather than it actually
> making any difference to the size...

clang actually optimizes it away: "variable 'ak_acpi_match' is not
needed and will not be emitted", my argument about inflating the
kernel size is not valid.
