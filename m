Return-Path: <jacob.jun.pan@linux.intel.com>
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	IIO <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Cc: Carlo Caione <carlo@caione.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/3] axp20x minor fixes
Date: Tue, 11 Nov 2014 11:30:07 -0800
Message-Id: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

A few fixes based on mfd/ib-mfd-iio-3.19.


Aaron Lu (1):
  iio: adc: Add module device table for autoloading

Jacob Pan (2):
  mfd/axp20x: avoid irq numbering collision
  iio/axp288_adc: remove THIS_MODULE owner

 drivers/iio/adc/axp288_adc.c |  9 ++++++++-
 drivers/mfd/axp20x.c         | 18 +++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.9.1
