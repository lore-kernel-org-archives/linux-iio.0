Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdK1M5K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Nov 2017 07:57:10 -0500
Date: Tue, 28 Nov 2017 13:57:07 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: hx711: add buffered trigger support
Message-ID: <20171128125707.GA31819@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This small patch series adds:
- support for buffered triggers
- fixes a bug in the reset functionality

Andreas Klinger (2):
  iio: hx711: add triggered buffer support
  iio: hx711: fix bug in hx711_reset

 drivers/iio/adc/hx711.c | 119 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 25 deletions(-)

-- 
2.1.4


-- 
