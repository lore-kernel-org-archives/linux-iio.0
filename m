Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44596 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756321Ab1DLPUx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2011 11:20:53 -0400
Date: Tue, 12 Apr 2011 08:21:02 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
Message-ID: <20110412152102.GB20710@opensource.wolfsonmicro.com>
References: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 12, 2011 at 12:08:22PM +0100, Hennerich, Michael wrote:

Please fix your mail client to word wrap at less than 80 columns - see
Documentation/email-clients.txt for suggestions.  I've reflowed your
text for legibility.

> I wonder why the voltage and current regulator framework doesn't
> support negative voltages.  We like to use the framework to specify
> bipolar reference voltages used with converters.  However in various
> places negative voltages are treated as error codes, thus causing the
> regulator to exit on probe.

Basically just a lack of demand - there are few negative supplies in
the mobile systems that were looked at, and most of those are like the
charge pumps found in audio CODECs and not really visible as regulators
that could be used with other devices.

> As a workaround someone could say we specify positive and negative
> supply by label with absolute values and add the negative sign in the
> consumer driver.  However that doesn't work well, since the bipolar
> 'negative' supply may also occasionally be positive.

That'd probably work.  Or update the API to allow negative voltages to
be returned more easily; off the top of my head the only real issue is
get_voltage() and so on.  It'd not be great for usability, though.
