Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53661 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932664Ab1DMRXy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2011 13:23:54 -0400
Date: Wed, 13 Apr 2011 10:24:04 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: michael.hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
Message-ID: <20110413172404.GB18008@opensource.wolfsonmicro.com>
References: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
 <20110412152102.GB20710@opensource.wolfsonmicro.com>
 <4DA59580.4010707@analog.com>
 <1302702201.3600.81.camel@odin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302702201.3600.81.camel@odin>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 13, 2011 at 02:43:21PM +0100, Liam Girdwood wrote:
> On Wed, 2011-04-13 at 14:22 +0200, Michael Hennerich wrote:

> > Contrast control for LC Displays typically use negative voltages, too
> > I agree that demand for this on typical mobile devices is low, however
> > we like

Yeah, that and the eInk displays are the only application I'm aware of.

> > to use the regulator framework in the IIO subsystem where negative voltages
> > are quite common.

Are these regulators software controlled?

> > Updating the core to allow negative and zero voltages, is not  straight
> > forward.
> > There are more issues with constrain checking and I currently can't
> > oversee all side

What are the issues that you see?

> > effects. I think we need to introduce a new constrains flag
> > (maybe add to valid_modes_mask?), indicating a bipolar regulator.
> > This flag is then used to keep the current implementation untouched for
> > unipolar positive
> > regulators.

> My preference is to keep it simple and the API consistent with unipolar
> regulators.

I agree, though if people do ever use the same regulators for both
polarities (with the polarity determined by supply) then we'll need a
way of dealing with this in the constraints as the regulators might not
know they're running negative voltages with respect to the system.

> One of the problem areas will be regulator_get_voltage() since it
> returns negative errors. It may be desirable to deprecate this API call
> in favour of a new call that we pass in an int for the voltage (e.g.
> get_voltage(reg, &voltage)).

I'm not sure deprecating it is ideal - it's quite a convenient API.  We
could just implement a new API and leave that one as an adaption layer.
Transition issues would mean that we'd want to do that for at least one
kernel release anyway.
