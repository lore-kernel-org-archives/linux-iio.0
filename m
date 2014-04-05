Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de,
	sr@denx.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V3 0/6] iio: Minor cleanups to spear ADC driver 
Date: Sat,  5 Apr 2014 17:45:09 +0100
Message-Id: <1396716315-2465-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Note that Hartmut Knaack has highlighted some additional improvements
to be made to this driver, but to keep things manageable I'm proposing
the following initial set and second series to make the other changes
and move the driver out of staging.

Changes since V1. Fixed the issues Harmuk Knaack pointed out in patch 4
by dropping the unused variables and ensure mask was as it should be.

Previous description:
This driver has been reasonably clean since it was first merged within the
staging tree.  If it had been submitted after the IIO core was outside of
staging we might have taken it as is. I did a final review and the first 4
patches of this series rework various minor aspects of the driver.

Whilst it is a slow driver, the device tree matches at the lowest level seemed
a little unwise so the largest rework is concerned with centralising that
logic using a classic ops structure of function pointers.  The other large
change was to move to using the info_mask_shared_by_all approach to handle
sampling frequency.  This is something I am slowly propogating across the
whole tree, but might as well be done whilst we are looking at this driver.

I don't have hardware and whilst I think these are all changes that are
possible to easily verify by eye, a tested by would be most welcome!

Note this is the first driver I'm suggesting moving out of staging following
Greg's entirely reasonable question of 'What's wrong with the stuff that is
left?'  Any help with this sort of final cleanup and move would be most
welcome.

Jonathan

Jonathan Cameron (6):
  staging:iio:adc:spear adc - prefix defines to avoid namespace clashes.
  staging:iio:adc:spear_adc drop initialization of unused scan_type
  staging:iio:adc:spear_adc use info_mask_shared_by_all for samp freq
  staging:iio:adc:spear rename device specific state structure to _state
  staging:iio:adc:spear rename iodev -> indio_dev to fit with current
    convention
  staging:iio:adc:spear rename spear_read_raw to spear_adc_read_raw

 drivers/staging/iio/adc/spear_adc.c | 313 ++++++++++++++++--------------------
 1 file changed, 141 insertions(+), 172 deletions(-)

-- 
1.9.0
