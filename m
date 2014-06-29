Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56153 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbaF2Obe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 10:31:34 -0400
Message-ID: <53B023C4.70309@kernel.org>
Date: Sun, 29 Jun 2014 15:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 3.16 cycle
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e28642c04a19b934e6832a218ccc9e54977f0213:

   Merge tag 'iio-fixes-for-3.16a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2014-06-18 10:41:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.16b

for you to fetch changes up to a2c12493ed7e63a18cef33a71686d12ffcd6600e:

   iio: of_iio_channel_get_by_name() returns non-null pointers for error legs (2014-06-21 12:31:38 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 3.16 cycle.

* A fix for a bug in setting threshold levels within the ad799x driver
   which prevents correct setting of the thresholds.
* In ad7291 fix an case where a ERR_PTR value was returned directly
   instead of having PTR_ERR applied.  Hence it would report success
   instead of failure.
* of_iio_channel_get_by_name returned a non null pointer if it fails
   and the callee was expecting NULL to indicate failure.  Fixed by
   returning NULL in the error cases.

----------------------------------------------------------------
Adam Thomson (1):
       iio: of_iio_channel_get_by_name() returns non-null pointers for error legs

Dan Carpenter (1):
       staging: iio/ad7291: fix error code in ad7291_probe()

Peter Meerwald (1):
       iio:adc:ad799x: Fix reading and writing of event values, apply shift

  drivers/iio/adc/ad799x.c         | 8 ++++++--
  drivers/iio/inkern.c             | 6 ++++--
  drivers/staging/iio/adc/ad7291.c | 4 ++--
  3 files changed, 12 insertions(+), 6 deletions(-)
