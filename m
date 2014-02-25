Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46671 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbaBYS2y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2014 13:28:54 -0500
Message-ID: <530CE112.1080903@kernel.org>
Date: Tue, 25 Feb 2014 18:29:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.14 round 4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e194fd8a5d8e0a7eeed239a8534460724b62fe2d:

   staging: binder: Fix death notifications (2014-02-21 12:30:54 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/fixes-for-3.14d

for you to fetch changes up to 760dbe1dcb6d3dd3ead73dc69b23f206b52273bb:

   staging:iio:adc:MXS:LRADC: fix touchscreen statemachine (2014-02-24 21:55:50 +0000)

----------------------------------------------------------------
Fourth set of IIO fixes for the 3.14 kernel.

A single line patch fixing a regression that was introduced in 3.13 in the
reworking of the mxs touch screen and ADC drivers to be interrupt rather
than polling driven.  It resulted in a stray double reporting of the release
coordinate in the touch screen driver.  The bug lay in the adc side
of the driver which left the statemachine in the wrong state.

----------------------------------------------------------------
Juergen Beisert (1):
       staging:iio:adc:MXS:LRADC: fix touchscreen statemachine

  drivers/staging/iio/adc/mxs-lradc.c | 1 +
  1 file changed, 1 insertion(+)
