Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeKJKDS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Nov 2018 05:03:18 -0500
Date: Fri, 9 Nov 2018 16:20:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: festevam@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Victor Colombo <victorcolombo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
Message-ID: <20181110002018.GA3938@kroah.com>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br>
 <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
 <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 09, 2018 at 09:19:52PM -0200, Matheus Tavares Bernardino wrote:
> On Fri, Nov 9, 2018 at 8:13 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Matheus,
> >
> 
> Hi, Fabio
> 
> > On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > >
> > > This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> > > which solves the checkpatch.pl warning:
> > > "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> > >
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > >  drivers/staging/iio/resolver/ad2s90.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > > index 949ff55ac6b0..f439da721df8 100644
> > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> >
> > This should be:
> > // SPDX-License-Identifier: GPL-2.0
> 
> Hm, but it seems that the identifier "GPL-2.0" is deprecated, look:
> https://spdx.org/licenses/GPL-2.0.html. It has been updated to
> "GPL-2.0-only" in license list v3
> (https://spdx.org/licenses/GPL-2.0-only.html). Is there some other
> reason to use the deprecated "GPL-2.0" that I'm not aware of?

Yes, please read the in-kernel documentation for all of this at:
	Documentation/process/license-rules.rst

Long story short, we started the adding of these tags to the kernel
before the crazyness of the "-only" markings for GPL in spdx.  Let's
keep it this way for now, if we ever get the whole kernel finished, then
we can revisit the markings and maybe do a wholesale conversion, if it's
really needed.

thanks,

greg k-h
