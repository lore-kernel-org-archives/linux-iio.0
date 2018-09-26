Return-Path: <SRS0=HVuF=MI=gmail.com=songqiang1304521@kernel.org>
Date: Wed, 26 Sep 2018 08:34:02 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180926003402.GA6020@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 24, 2018 at 03:23:52PM -0700, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 09:13:40PM +0800, Song Qiang wrote:
> > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > magnetometer, composed of 3 single sensors and a processing chip.
> > PNI is currently not in the vendors list, so this is also adding it.
> > 

...

> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 41f0b97eb933..5bf3395fe9ae 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -288,6 +288,7 @@ pine64	Pine64
> >  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> >  plathome	Plat'Home Co., Ltd.
> >  plda	PLDA
> > +pni     PNI
> 
> PNI doesn't stand for something?
> 

Hi Rob,

PNI should be 'PNI Sensor Corporation'. I saw that PLDA above mine and
thought I should write down its abbreviation, which apparently is wrong.

yours,
Song Qiang

> >  portwell	Portwell Inc.
> >  poslab	Poslab Technology Co., Ltd.
> >  powervr	PowerVR (deprecated, use img)
> 
