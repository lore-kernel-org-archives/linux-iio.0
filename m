Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:38386 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934340AbcJRRyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2016 13:54:37 -0400
From: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v3 2/5] iio: dac: mcp4725: fix incorrect comment
Date: Tue, 18 Oct 2016 19:43:06 +0200
Message-Id: <1476812589-18333-3-git-send-email-tomas.novotny@tbs-biometrics.com>
In-Reply-To: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
References: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Tomas Novotny <tomas@novotny.cz>

Number 2 is referencing to the settings with the largest available
resistor.

No functional change.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 1f55d1b..e481f38 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -374,7 +374,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
 	data->powerdown = pd > 0 ? true : false;
-	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
+	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
 	err = iio_device_register(indio_dev);
-- 
2.1.4

