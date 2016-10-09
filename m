Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39898 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbcJIKsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 06:48:38 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:dac:max517 dac documentation.
Date: Sun,  9 Oct 2016 11:48:31 +0100
Message-Id: <20161009104831.9396-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver graduated a while back, btu this documentation file (which
mostly gives background info on the chips supported) got left behind.

I can't see any reason not to just move it out of staging.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 {drivers/staging/iio/Documentation => Documentation/iio}/dac/max517 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/dac/max517 b/Documentation/iio/dac/max517
similarity index 100%
rename from drivers/staging/iio/Documentation/dac/max517
rename to Documentation/iio/dac/max517
-- 
2.10.0

