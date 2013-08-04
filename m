Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47485 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3HDPhv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 11:37:51 -0400
Message-ID: <51FE8366.8030207@kernel.org>
Date: Sun, 04 Aug 2013 17:37:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.11 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 78077256bc08348d587e318957ceb41fe4d4afae:

  Merge tag 'iio-fixes-for-3.11a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus
(2013-07-16 22:41:38 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11b

for you to fetch changes up to b1451e546899bc8f450773b2af02e0cd000cf1fa:

  iio: ti_am335x_adc: Fix wrong samples received on 1st read (2013-07-21 18:27:35 +0100)

----------------------------------------------------------------
Second round of IIO fixes for the 3.11 cycle.

1) Fix a long term race in the IIO trigger handling.
   This only effects cases where a single trigger is in use
   by multiple devices.
2) ti_am335x fix an issue with incorrect data due to reading before
   the sequencer is finished.

----------------------------------------------------------------
Lars-Peter Clausen (1):
      iio:trigger: Fix use_count race condition

Patil, Rachna (1):
      iio: ti_am335x_adc: Fix wrong samples received on 1st read

 drivers/iio/adc/ti_am335x_adc.c      | 30 ++++++++++++++++++++++--------
 drivers/iio/industrialio-trigger.c   | 34 ++++++++++++++++++++++------------
 include/linux/iio/trigger.h          |  3 ++-
 include/linux/mfd/ti_am335x_tscadc.h | 16 ++++++++++++++++
 4 files changed, 62 insertions(+), 21 deletions(-)
