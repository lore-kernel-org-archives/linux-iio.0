Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeI2Rui (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Sep 2018 13:50:38 -0400
Date: Sat, 29 Sep 2018 12:22:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: Rob Herring <robh@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180929122228.54c0b5dc@archlinux>
In-Reply-To: <20180926003402.GA6020@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
        <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
        <20180926003402.GA6020@Eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 26 Sep 2018 08:34:02 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Mon, Sep 24, 2018 at 03:23:52PM -0700, Rob Herring wrote:
> > On Thu, Sep 20, 2018 at 09:13:40PM +0800, Song Qiang wrote:  
> > > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > > magnetometer, composed of 3 single sensors and a processing chip.
> > > PNI is currently not in the vendors list, so this is also adding it.
> > >   
> 
> ...
> 
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > index 41f0b97eb933..5bf3395fe9ae 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > @@ -288,6 +288,7 @@ pine64	Pine64
> > >  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> > >  plathome	Plat'Home Co., Ltd.
> > >  plda	PLDA
> > > +pni     PNI  
> > 
> > PNI doesn't stand for something?
> >   
> 
> Hi Rob,
> 
> PNI should be 'PNI Sensor Corporation'. I saw that PLDA above mine and
> thought I should write down its abbreviation, which apparently is wrong.

To answer more directly.  If PNI itself stands for anything the company
is deliberately making it non obvious!  I had a good search to try and
find out and got nowhere...

> 
> yours,
> Song Qiang
> 
> > >  portwell	Portwell Inc.
> > >  poslab	Poslab Technology Co., Ltd.
> > >  powervr	PowerVR (deprecated, use img)  
> >   
