Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46042 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaBHTkw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 14:40:52 -0500
Message-ID: <52F6885E.8060304@kernel.org>
Date: Sat, 08 Feb 2014 19:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes 3.14 set 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 6b89db36b3ab7c4b99027873e1de4be8d07387d4:

   wlags49_h2: Fix overflow in wireless_set_essid() (2014-02-07 11:10:08 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.14b

for you to fetch changes up to 55b40d37311807a6bb2acdae0df904f54a0da3ae:

   iio: max1363: Use devm_regulator_get_optional for optional regulator (2014-02-08 11:46:00 +0000)

----------------------------------------------------------------
Second round of IIO fixes for the 3.14 cycle.

Another mixed bag, including some that were not in round 1 because
they applied to elements that went in during the merge window whereas
round 1 predated that.  I have been effectively out of action for 3 weeks
so will take a little while to catch up with my backlog.

* mag3110 - report busy in read_raw / write_raw when buffered capture
   is underway to avoid either changing the characteristics of the capture or
   causing capture issues by reading data destined for the buffer.
* mag3110 - fix a failure to specify leading zeros when formatting a decimal
   number.
* lradc - fix a buffer overflow and incorrect reporting of scale for voltage
   channel 15
* lradc - drop some scale_available attributes for elements that don't actually
   exist.  These could otherwise cause some interesting issues for userspace.
* ad799x - a typo in the events information mask resulted in some nasty crashes
   on failed probes.
* ak8975 - fix scale attribute output to avoid incorrect intepretation of
   readings in userspace.
* adis16400 - make sure the timestamp is the last element in all channel_spec
   arrays as this assumption is made by the buffer filling code, but was not
   true previously.
* bma180 - correctly use modifiers to distinguish the channels rather than
   indexes.  This brings the abi inline with the standard option for 3 axis
   accelerometers.
* max1363 - use devm_regulator_get_optional instead of the non optional case
   to allow the device to successfully probe when a regulator is not specified.

----------------------------------------------------------------
Alexandre Belloni (2):
       iio: mxs-lradc: fix buffer overflow
       iio: mxs-lradc: remove useless scale_available files

Beomho Seo (1):
       iio: ak8975: Fix calculation formula for convert micro tesla to gauss unit

Guenter Roeck (1):
       iio: max1363: Use devm_regulator_get_optional for optional regulator

Hartmut Knaack (1):
       staging:iio:ad799x fix typo in ad799x_events[]

Marcus Folkesson (1):
       iio: adis16400: Set timestamp as the last element in chan_spec

Peter Meerwald (3):
       iio:magnetometer:mag3110: Report busy in _read_raw() / write_raw() when buffer is enabled
       iio:magnetometer:mag3110: Fix output of decimal digits in show_int_plus_micros()
       iio:accel:bma180: Use modifier instead of index in channel specification

  drivers/iio/accel/bma180.c            | 16 ++++++++--------
  drivers/iio/adc/max1363.c             |  2 +-
  drivers/iio/imu/adis16400.h           |  1 +
  drivers/iio/imu/adis16400_core.c      | 10 +++++-----
  drivers/iio/magnetometer/ak8975.c     | 16 +++++++++-------
  drivers/iio/magnetometer/mag3110.c    |  8 +++++++-
  drivers/staging/iio/adc/ad799x_core.c |  2 +-
  drivers/staging/iio/adc/mxs-lradc.c   |  6 +-----
  8 files changed, 33 insertions(+), 28 deletions(-)
