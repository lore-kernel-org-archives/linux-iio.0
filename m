Return-Path: <SRS0=GCMY=NU=usp.br=matheus.bernardino@kernel.org>
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br> <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
In-Reply-To: <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Fri, 9 Nov 2018 21:19:52 -0200
Message-ID: <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To: festevam@gmail.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Victor Colombo <victorcolombo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Nov 9, 2018 at 8:13 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Matheus,
>

Hi, Fabio

> On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> > which solves the checkpatch.pl warning:
> > "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/staging/iio/resolver/ad2s90.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > index 949ff55ac6b0..f439da721df8 100644
> > --- a/drivers/staging/iio/resolver/ad2s90.c
> > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> This should be:
> // SPDX-License-Identifier: GPL-2.0

Hm, but it seems that the identifier "GPL-2.0" is deprecated, look:
https://spdx.org/licenses/GPL-2.0.html. It has been updated to
"GPL-2.0-only" in license list v3
(https://spdx.org/licenses/GPL-2.0-only.html). Is there some other
reason to use the deprecated "GPL-2.0" that I'm not aware of?

Thanks,
Matheus
