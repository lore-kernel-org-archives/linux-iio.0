Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35734 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754242AbdC3MqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 08:46:10 -0400
Date: Thu, 30 Mar 2017 18:16:03 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: replace comma with a semicolon
Message-ID: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace a comma between expression statements by a semicolon. This
changes the semantics of the code, but given the current indentation
appears to be what is intended.
A simplified version of the Coccinelle semantic patch that performs this
transformation is as follows:

// <smpl>
@r@
expression e1,e2;
@@

 e1
-,
+;
 e2;
// </smpl>

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/iio/adc/max11100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 23c060e1b663..1180bcc22ff1 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -124,8 +124,8 @@ static int max11100_probe(struct spi_device *spi)
 	indio_dev->name = "max11100";
 	indio_dev->info = &max11100_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = max11100_channels,
-	indio_dev->num_channels = ARRAY_SIZE(max11100_channels),
+	indio_dev->channels = max11100_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max11100_channels);
 
 	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(state->vref_reg))
-- 
2.11.0

