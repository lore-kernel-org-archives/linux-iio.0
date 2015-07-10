Return-Path: <manfred.schlaegl@gmx.at>
Message-ID: <55A03142.1020106@gmx.at>
Date: Fri, 10 Jul 2015 22:55:30 +0200
From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, Michael Welling <mwelling@ieee.org>,
 Manfred Schlaegl <manfred.schlaegl@gmx.at>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: [PATCH] iio: mcp320x: Fix NULL pointer dereference
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On reading in_voltage_scale of we got an NULL pointer dereference Oops.

The reason for this is, that mcp320x_read_raw tries to access
chip_info->resolution from struct mcp320x, but chip_info is never set.

chip_info was never set since the driver was added, but there was no
acute problem, because it was not referenced.
The acute problem exists since
b12206e917ac34bec41b9ff93d37d8bd53a2b3bc
iio: adc: mcp320x. Add support for more ADCs

This patch fixes the issue by setting chip_info in mcp320x_probe.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/iio/adc/mcp320x.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 8d9c9b9..d819823 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -299,6 +299,8 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
+	adc->chip_info = chip_info;
+
 	adc->transfer[0].tx_buf = &adc->tx_buf;
 	adc->transfer[0].len = sizeof(adc->tx_buf);
 	adc->transfer[1].rx_buf = adc->rx_buf;
-- 
1.7.10.4
