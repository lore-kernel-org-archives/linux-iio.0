Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46885 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3H2UWd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 16:22:33 -0400
Message-ID: <521FBB99.3040205@kernel.org>
Date: Thu, 29 Aug 2013 22:22:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.11 - set 4
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d8dfad3876e4386666b759da3c833d62fb8b2267:

  Linux 3.11-rc7 (2013-08-25 17:43:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11d

for you to fetch changes up to 947b8ec78610fdfd891da249629f79cfa8e5da57:

  iio: at91: fix adc_clk overflow (2013-08-29 21:42:11 +0100)

----------------------------------------------------------------
4th round of fixes for IIO in the 3.11 series.

Another one patch pull request, this one for an overflow issue that
can occur in the at91 adc driver.

----------------------------------------------------------------
Josh Wu (1):
      iio: at91: fix adc_clk overflow

 drivers/iio/adc/at91_adc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
