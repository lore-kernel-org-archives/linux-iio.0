Return-Path: <thomas.betker@freenet.de>
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
Date: Wed, 15 Apr 2015 21:11:46 +0200
Message-Id: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
List-ID: <linux-iio@vger.kernel.org>

This patch series fixes some issues found by tests on our Zynq-7020 
board; the issues usually result in incorrect voltage readings:

[1/5] iio: adc: xilinx: Fix register addresses
[2/5] iio: adc: xilinx: Fix "vccaux" channel .address
[3/5] iio: adc: xilinx: Fix VREFP scale
[4/5] iio: adc: xilinx: Fix VREFN sign
[5/5] iio: adc: xilinx: Set .datasheet_name instead of .extend_name

About [1]: The register addresses in question are currently not used by 
the driver, but we do use them for extended tests. (I might provide a 
patch to support lowest/highest values another time; see also [5].)

About [3], [4]: The transfer functions for VREFP and VREFN are 
	vrefp = unsigned(code) * 3.0 / 4096
	vrefn = signed(code) * 1.0 / 4096
I know it's not consistent, but that's what UG480 says ... VREFP = 1.25 
definitely needs the factor 3.0 to get reasonable values (a factor 1.0 
will never get you more than 1.0V). As for VREFN = 0V, we did actually 
see negative values on our boards.

About [5]: This may be a matter of debate on the IIO list, but I didn't 
get the impression that extensions are intended to be used that way.
    .extend_name = "vccint" means that the sysfs node names are 
in_voltage0_vccint_raw/_scale, which is a bit unexpected. I would 
rather see them called just in_voltage0_*, and reserve extensions for 
things like in_voltage0_lowest_* and in_voltage0_highest_* (MIN_VCCINT, 
MAX_VCCINT) -- that's what we do in our project.
    Note that .extend_name = "vccint", "vccaux", ... also has the side 
effect of creating the sysfs nodes vccint_sampling_frequency, 
vccaux_sampling_frequency, ... [due to .info_mask_shared_by_all = 
BIT(IIO_CHAN_INFO_SAMP_FREQ)], which is probably not desired.

Best regards,
Thomas Betker
