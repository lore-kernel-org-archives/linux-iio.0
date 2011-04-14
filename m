Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34086 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757200Ab1DNOCo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2011 10:02:44 -0400
Date: Thu, 14 Apr 2011 15:02:29 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
Message-ID: <20110414140229.GC7890@opensource.wolfsonmicro.com>
References: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
 <20110412152102.GB20710@opensource.wolfsonmicro.com>
 <4DA59580.4010707@analog.com>
 <1302702201.3600.81.camel@odin>
 <20110413172404.GB18008@opensource.wolfsonmicro.com>
 <4DA6D01B.9080202@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DA6D01B.9080202@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 14, 2011 at 12:44:43PM +0200, Michael Hennerich wrote:
> On 04/13/2011 07:24 PM, Mark Brown wrote:

Please cut irrelevant context from your replies.

> >>> Updating the core to allow negative and zero voltages, is not  straight
> >>> forward.
> >>> There are more issues with constrain checking and I currently can't
> >>> oversee all side

> > What are the issues that you see?

> In case the output voltage can be negative, the input voltage may be
> negative as well.
> In functions drms_uA_update() and regulator_set_optimum_mode(), the
> input supply voltage
> is checked for being > 0, if that fails it uses the constrains->input_uV
> instead...

None of this seems particularly complicated to deal with, it's not a
massive change in the architecture of the code or anything - it's all
just refactoring interfaces and implementations a bit.

> BTW: Function drms_uA_update() looks suspicious.

>     /* get input voltage */
>     input_uV = 0;
>     if (rdev->supply)
>         input_uV = _regulator_get_voltage(rdev);

> it checks for rdev->supply but later uses rdev, which will ultimately
> mean input_uV == output_uV.

There's very few users of supplies in mainline and no users at all of
the optimal mode stuff.
