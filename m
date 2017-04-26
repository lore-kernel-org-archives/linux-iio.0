Return-Path: <SRS0=xTJC=4C=perches.com=joe@kernel.org>
Message-ID: <1493185750.18659.24.camel@perches.com>
Subject: Re: [PATCH v3 2/2] staging: iio: isl29028: move out of staging
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, Brian Masney
 <masneyb@onstation.org>,  linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, knaack.h@gmx.de,
  lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
 ldewangan@nvidia.com
Date: Tue, 25 Apr 2017 22:49:10 -0700
In-Reply-To: <6c005fd8-7fad-4887-601e-2f8756df2c89@kernel.org>
References: <20170425013434.1206-1-masneyb@onstation.org>
	 <20170425013434.1206-3-masneyb@onstation.org>
	 <6c005fd8-7fad-4887-601e-2f8756df2c89@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2017-04-26 at 06:30 +0100, Jonathan Cameron wrote:
> On 25/04/17 02:34, Brian Masney wrote:
> > Move ISL29028 ALS / Proximity Sensor out of staging and into mainline.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>

Hey Brian.

Next time it's better to use git format-patch -M
to reduce the patch size and show renames.

> Applied to the togreg branch of iio.git.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/light/Kconfig            |  10 +
> >  drivers/iio/light/Makefile           |   1 +
> >  drivers/iio/light/isl29028.c         | 723 +++++++++++++++++++++++++++++++++++
> >  drivers/staging/iio/light/Kconfig    |  10 -
> >  drivers/staging/iio/light/Makefile   |   1 -
> >  drivers/staging/iio/light/isl29028.c | 723 -----------------------------------
> >  6 files changed, 734 insertions(+), 734 deletions(-)
> >  create mode 100644 drivers/iio/light/isl29028.c
> >  delete mode 100644 drivers/staging/iio/light/isl29028.c

[quoted the entire patch]

And Jonathan, please trim your replies a bit more.

Thanks.
