Return-Path: <SRS0=Y4uX=73=linux-mips.org=ladis@kernel.org>
Date: Fri, 25 Aug 2017 07:39:16 +0200
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2] iio: adc: ti-ads1015: add 10% to conversion wait time
Message-ID: <20170825053916.lbubxudnm3errnld@lenoch>
References: <20170824082708.6qkcmf6qt2wjvqd3@lenoch>
 <CAC5umyhkGSN5DYJM6Qp-05MASZLBNpcSna1pVGN4feR=_MH5fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAC5umyhkGSN5DYJM6Qp-05MASZLBNpcSna1pVGN4feR=_MH5fQ@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

As user's guide "ADS1015EVM, ADS1115EVM, ADS1015EVM-PDK, ADS1115EVM-PDK
User Guide (Rev. B)" (http://www.ti.com/lit/ug/sbau157b/sbau157b.pdf)
states at page 16:
"Note that both the ADS1115 and ADS1015 have internal clocks with a ±10%
accuracy. If performing FFT tests, frequencies may appear to be incorrect
as a result of this tolerance range.", add those 10% to converion wait
time.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: Add comment explaining why those 10% are needed

 drivers/iio/adc/ti-ads1015.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 034e48566ab5..ae29dd87c597 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -268,6 +268,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
 		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
 		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
+		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
 		usleep_range(conv_time, conv_time + 1);
 		data->conv_invalid = false;
 	}
-- 
2.11.0
