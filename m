Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41198 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbDOUyT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2015 16:54:19 -0400
Message-ID: <552ECFF8.2070501@kernel.org>
Date: Wed, 15 Apr 2015 21:54:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 20:11, Thomas Betker wrote:
> This patch series fixes some issues found by tests on our Zynq-7020 
> board; the issues usually result in incorrect voltage readings:
> 
> [1/5] iio: adc: xilinx: Fix register addresses
> [2/5] iio: adc: xilinx: Fix "vccaux" channel .address
> [3/5] iio: adc: xilinx: Fix VREFP scale
> [4/5] iio: adc: xilinx: Fix VREFN sign
> [5/5] iio: adc: xilinx: Set .datasheet_name instead of .extend_name
> 
> About [1]: The register addresses in question are currently not used by 
> the driver, but we do use them for extended tests. (I might provide a 
> patch to support lowest/highest values another time; see also [5].)
> 
> About [3], [4]: The transfer functions for VREFP and VREFN are 
> 	vrefp = unsigned(code) * 3.0 / 4096
> 	vrefn = signed(code) * 1.0 / 4096
> I know it's not consistent, but that's what UG480 says ... VREFP = 1.25 
> definitely needs the factor 3.0 to get reasonable values (a factor 1.0 
> will never get you more than 1.0V). As for VREFN = 0V, we did actually 
> see negative values on our boards.
> 
> About [5]: This may be a matter of debate on the IIO list, but I didn't 
> get the impression that extensions are intended to be used that way.
>     .extend_name = "vccint" means that the sysfs node names are 
> in_voltage0_vccint_raw/_scale, which is a bit unexpected. I would 
> rather see them called just in_voltage0_*, and reserve extensions for 
> things like in_voltage0_lowest_* and in_voltage0_highest_* (MIN_VCCINT, 
> MAX_VCCINT) -- that's what we do in our project.
It was always intended for labelling of channels with well defined
purposes.  That is ones that are hard wired to something rather than
simply exposed for general purpose use.  I'm guessing vccint is
the internal supply voltage, in which case that was pretty much
the intended use.

The datasheet name is only really there for binding consumers to individual
channels.  The thought being that you'd probably be sat there with a circuit
diagram in front of you specifying what is connected to which precise pin
of the ADC...

So I think the original approach is more in keeping with the intent.

The lowest/highest versions are interesting. Right now, the extended name
is the only way to specify them, but somehow it feels like we ought
to have something better.... We could treat them as a filter or simply
another aspect of the channel (like _scale etc), but that's also a little
ugly. Will think about this and see if anyone else has a better suggestion!

>     Note that .extend_name = "vccint", "vccaux", ... also has the side 
> effect of creating the sysfs nodes vccint_sampling_frequency, 
> vccaux_sampling_frequency, ... [due to .info_mask_shared_by_all = 
> BIT(IIO_CHAN_INFO_SAMP_FREQ)], which is probably not desired.
This last one sounds like a bug and definitely isn't the intended result!
The extended name should be ignored for shared_by values.
> 
> Best regards,
> Thomas Betker
> 

