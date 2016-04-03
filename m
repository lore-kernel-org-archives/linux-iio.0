Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51316 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcDCUXj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 16:23:39 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First set of IIO fixes for the 4.6 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57017BC6.3040107@kernel.org>
Date: Sun, 3 Apr 2016 21:23:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.6a

for you to fetch changes up to 655048a0b98bc6288ce87cb95a18bf4cada6c1a9:

  iio: light: apds9960: correct FIFO check condition (2016-03-20 10:33:33 +0000)

----------------------------------------------------------------
First round of IIO fixes for the 4.6 cycle.

Again I've ended up with two early fix sets, depending on whether they are
dependent on elements of the merge window or simply came in after I had
patches with that dependency already, vs older fixes that were just too
late for the last cycle.  This first set is for the older ones.

- max1353
  * Add a missing adc to max1363_id - the driver has supported the
    max11644-11647 for a while, but as they weren't in the id table there
    was no way of actually initializing it.
  * Fix a wrong reference voltage for the above models.  Given you couldn't
    initialize the driver for these parts without patching, no one noticed
    that the reference voltage used in computing the scaling was wrong.
 - apds9960
   * The fifo last enelement was read twice (and hence pushed out twice) due
     to a small logic bug.

----------------------------------------------------------------
Matt Ranostay (1):
      iio: light: apds9960: correct FIFO check condition

Stefan Eichenberger (2):
      iio: adc: max1363: add missing adc to max1363_id
      iio: adc: max1363: correct reference voltage

 drivers/iio/adc/max1363.c    | 12 ++++++++----
 drivers/iio/light/apds9960.c |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)
