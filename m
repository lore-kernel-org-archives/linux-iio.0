Return-Path: <SRS0=N3n8=5L=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] Revert "iio: accel: bma180: Add support for BMA250E"
Date: Tue,  6 Jun 2017 22:35:36 +0200
Message-Id: <20170606203538.15250-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg, et al.,

When I submitted my patch to add support for the BMA250E chip to
the bma180 driver, I completely missed that this chip is already supported
by the bmc150 driver (my bad).

Since the patches to wrongly add th BMA250E support to the bma180 driver
have already been added to staging-next, I'm submitting 2 reverts to undo
the damage. Alternatively the 2 offending commits could be dropped from
staging-next.

Regards,

Hans
