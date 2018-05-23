Return-Path: <SRS0=XA61=IK=gmail.com=silvan.murer@kernel.org>
Message-ID: <1527059859.7868.3.camel@gmail.com>
Subject: Re: [PATCH v3] iio: dac: Add support for external reference voltage
 through the regulator framework.
From: Silvan Murer <silvan.murer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: lars@metafoo.de, jic23@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Date: Wed, 23 May 2018 09:17:39 +0200
In-Reply-To: <20180522171903.GA24256@rob-hp-laptop>
References: <1526775557.32235.33.camel@gmail.com>
	 <20180522171903.GA24256@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Thanks Rob for the review and the feedback!
In the next patches, I split the bindings to a separate patch.

On Die, 2018-05-22 at 12:19 -0500, Rob Herring wrote:
> On Sun, May 20, 2018 at 02:19:17AM +0200, Silvan Murer wrote:
> > 
> > Add support for external reference voltage through the regulator
> > framework.
> > 
> > Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > Changes in v3:
> > 	- remove extra spaces and tab
> > Changes in v2:
> > 	- Add 'optional properties' documentation
> > 	- Return an error when a regulator is specified
> > 	- Use internal reference when no regulator is specified
> > 	- Use iio_device_register instead of devm_iio_device_register
> > 
> >  .../devicetree/bindings/iio/dac/ltc2632.txt        | 14 +++++
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> In the future, please split bindings to separate patch.
> 
> > 
> >  drivers/iio/dac/ltc2632.c                          | 70
> > +++++++++++++++++++---
> >  2 files changed, 75 insertions(+), 9 deletions(-)
