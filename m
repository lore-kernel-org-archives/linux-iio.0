Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.156]:48385 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJBCMv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 22:12:51 -0400
Date: Mon, 1 Oct 2018 21:33:39 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: [PATCH 2/2] staging: iio: cdc: ad7150: fix misaligned lines
Message-ID: <20181001193339.GF24866@x220.localdomain>
References: <20181001193223.GD24866@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181001193223.GD24866@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These lines were misaligned, but the checkpatch.pl didn't indicate them
as such.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/cdc/ad7150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 5b5b766a0405..bbbf05ca2624 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -183,8 +183,8 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_THRESH:
 		value = chip->threshold[rising][chan];
 		return i2c_smbus_write_word_data(chip->client,
-						ad7150_addresses[chan][3],
-						swab16(value));
+						 ad7150_addresses[chan][3],
+						 swab16(value));
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		sens = chip->mag_sensitivity[rising][chan];
 		timeout = chip->mag_timeout[rising][chan];
-- 
2.19.0
