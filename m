Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58408 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbcJCT1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 16/18] staging:iio:accel:sca3000 small checkpatch fixes (alignment etc)
Date: Mon,  3 Oct 2016 20:27:00 +0100
Message-Id: <20161003192702.24361-17-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Tidied up where checkpatch warning suppressions doesn't effect the
readability of the code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index bb184eade558..58ec02fba3bd 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -274,8 +274,8 @@ static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 }
 
 static int sca3000_read_data_short(struct sca3000_state *st,
-			    u8 reg_address_high,
-			    int len)
+				   u8 reg_address_high,
+				   int len)
 {
 	struct spi_transfer xfer[2] = {
 		{
-- 
2.10.0

