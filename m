Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:2649 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbbEDJNL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 May 2015 05:13:11 -0400
From: Antonio Ospite <ao2@ao2.it>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Antonio Ospite <ao2@ao2.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCHv2 0/2] iio: accel: kxcjk-1013: new ACPI id and
Date: Mon,  4 May 2015 11:13:02 +0200
Message-Id: <1430730785-17833-1-git-send-email-ao2@ao2.it>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

compared to the v1 I fixed the typo (s/DSTD/DSDT/) in patch 1 and
dropped the renaming of is_smo8500_device.

Thanks,
   Antonio

Antonio Ospite (2):
  iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
  iio: accel: kxcjk-1013: add some blank lines for readability

 drivers/iio/accel/kxcjk-1013.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
