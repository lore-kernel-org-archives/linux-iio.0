Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759513AbcJaRIB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:01 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 0/6] staging: iio: regulator clean-up
Date: Tue,  1 Nov 2016 01:04:29 +0800
Message-Id: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rework regulator handling: 
* use supply names found on the datasheet
* fix regulator usage
* declare digital supplies previously missing

Semantic patch used to detect affected drivers:
@r1@
expression reg;
position p;
@@

reg = \(devm_regulator_get@p\|regulator_get@p\)(...);
if (IS_ERR(reg)) {
	...
	PTR_ERR(reg)
	...
}

@@
position p != r1.p;
@@

* \(devm_regulator_get@p\|regulator_get@p\)(...)

Eva Rachel Retuya (6):
  staging: iio: set proper supply name to devm_regulator_get()
  staging: iio: rework regulator handling
  staging: iio: ad7192: add DVdd regulator
  staging: iio: ad7192: rename regulator 'reg' to 'avdd'
  staging: iio: ad9832: add DVDD regulator
  staging: iio: ad9832: clean-up regulator 'reg'

 drivers/staging/iio/adc/ad7192.c                | 43 +++++++++++++------
 drivers/staging/iio/adc/ad7780.c                | 22 +++++-----
 drivers/staging/iio/frequency/ad9832.c          | 56 +++++++++++++++----------
 drivers/staging/iio/frequency/ad9832.h          |  6 ++-
 drivers/staging/iio/frequency/ad9834.c          | 19 +++++----
 drivers/staging/iio/impedance-analyzer/ad5933.c | 21 +++++-----
 6 files changed, 101 insertions(+), 66 deletions(-)

-- 
2.7.4

