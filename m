Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:52225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdK3VnK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Nov 2017 16:43:10 -0500
Date: Thu, 30 Nov 2017 22:42:56 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: hx711: add buffered trigger support
Message-ID: <20171130214256.GA27300@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

changes in v2:
- in Kconfig it's needed to select IIO_BUFFER and IIO_TRIGGERED_BUFFER to
  compile cleanly with buffered triggers

This small patch series adds:
- support for buffered triggers
- fixes a bug in the reset functionality

Andreas Klinger (2):
  iio: hx711: add triggered buffer support
  iio: hx711: fix bug in reset functionality

 drivers/iio/adc/Kconfig |   2 +
 drivers/iio/adc/hx711.c | 119 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 96 insertions(+), 25 deletions(-)

-- 
2.1.4


-- 
