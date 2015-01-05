Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58909 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbAEU25 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jan 2015 15:28:57 -0500
Message-ID: <54AAF406.6040203@kernel.org>
Date: Mon, 05 Jan 2015 20:28:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.19 set 1
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9e8e228f2bf066c37eeee7c25b810cad3235427a:

  iio: accel: bmc150: set low default thresholds (2014-11-16 20:25:00 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.19a

for you to fetch changes up to 65de7654d39c70c2b942f801cea01590cf7e3458:

  iio: iio: Fix iio_channel_read return if channel havn't info (2015-01-01 12:46:48 +0000)

----------------------------------------------------------------
First round of IIO fixes for the 3.19 cycle.

* ad799x fix ad7991/ad7995/ad7999 setup as they do not have a configuration
  register to write to.  It is written during the convesion sequence. As
  such we don't want to write to it at other times.
* Fix iio_channel_read utility function to return to ensure it is apparent
  if the relevant element is not there. This avoids using a wrong value
  if some channels have the element and others do not.

----------------------------------------------------------------
Fabien Proriol (1):
      iio: iio: Fix iio_channel_read return if channel havn't info

Lars-Peter Clausen (1):
      iio: ad799x: Fix ad7991/ad7995/ad7999 config setup

 drivers/iio/adc/ad799x.c | 15 +++++++++++++--
 drivers/iio/inkern.c     |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)
