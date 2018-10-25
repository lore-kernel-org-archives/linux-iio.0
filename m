Return-Path: <SRS0=mkZ5=NF=emutex.com=dan@kernel.org>
From: Dan O'Donovan <dan@emutex.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Carlos Iglesias <carlos.iglesias@emutex.com>,
	Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 0/3] iio: adc128s052: add matching options
Date: Thu, 25 Oct 2018 16:35:39 +0100
Message-Id: <1540481742-23596-1-git-send-email-dan@emutex.com>
In-Reply-To: <20180423213805.12591-1-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

On some SKUs of AAEON's UP Squared board, there is an ADC124S101
enumerated via ACPI. This is a pin-compatible variant of ADC124S021,
which is already supported by the adc128s052 driver.

This patchset adds missing DT compatible strings for ADC124S021 (and
ADC122S021) variants, adds AAEON's allocated ACPI HID, and adds the
SPDX GPL identifier to the driver.

v2 was posted at:
https://lore.kernel.org/lkml/20180423213805.12591-1-javier@emutex.com/

Changes from v2:
* Added device-tree bindings documentation for new chip variants
* Simplified code to get ACPI match data
* Dropped redundant patch to facilitate OF matching via ACPI _DSD
* Added patch to replace GPL license text with SPDX identifier

Changes from v1:
* Improved patch descriptions and series title
* Added an initial commit introducing new compatible strings
  (as per Jonathan's suggestion)
* Moved of_match_ptr removal last as this patch is less important to us

Dan O'Donovan (1):
  iio: adc128s052: use SPDX-License-Identifier

Javier Arteaga (1):
  iio: adc128s052: Add pin-compatible IDs

Nicola Lunghi (1):
  iio: adc128s052: add ACPI _HID AANT1280

 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  9 ++++-
 drivers/iio/adc/ti-adc128s052.c                    | 39 +++++++++++++++++-----
 2 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.
