Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47164 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3LVQ5k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Dec 2013 11:57:40 -0500
Message-ID: <52B71A03.5000907@kernel.org>
Date: Sun, 22 Dec 2013 16:57:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes 3.13 - set 4
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c6236c0ce39c809c336ca929f68cf8ad02cf94e0:

  staging: comedi: drivers: fix return value of comedi_load_firmware() (2013-12-17 13:05:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.13d

for you to fetch changes up to 83d5f3246fc05a629278240c09688fd9960b97db:

  staging:iio:ad799x fix incorrect endianness specification for buffer elements (2013-12-17 21:50:54 +0000)

----------------------------------------------------------------
4th round of iio fixes for the 3.13 cycle.

* Another miss reported endian fix that missed the last pull request due
  to a bug in the first version posted (which made it look like a cleanup
  rather than a fix).

----------------------------------------------------------------
Jonathan Cameron (1):
      staging:iio:ad799x fix incorrect endianness specification for buffer elements

 drivers/staging/iio/adc/ad799x_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
