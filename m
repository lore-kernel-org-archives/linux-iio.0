Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34513 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756855AbdCUNaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 09:30:46 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH 0/2] IIO coding tasks
Date: Tue, 21 Mar 2017 19:00:17 +0530
Message-Id: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Patchseries of IIO coding tasks

Arushi Singhal (2):
  staging: ad7759: Replace mlock with driver private lock
  staging: iio: ade7759: Move header content to implementation file

 drivers/staging/iio/meter/ade7759.c   | 56 +++++++++++++++++++++++++++++++++--
 drivers/staging/iio/meter/ade7759.h   | 53 ---------------------------------
 2 files changed, 54 insertions(+), 57 deletions(-)

-- 
2.11.0

