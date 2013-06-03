Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <Lars-Peter.Clausen@analog.com>,
	<dan.carpenter@oracle.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH RESEND V2 1/4] iio: frequency: ad4350: Fix bug / typo in mask
Date: Mon, 3 Jun 2013 15:30:46 +0200
Message-ID: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/frequency/adf4350.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index a884252..e76d4ac 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -212,7 +212,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 		(pdata->r2_user_settings & (ADF4350_REG2_PD_POLARITY_POS |
 		ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
 		ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
-		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
+		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x3)));
 
 	st->regs[ADF4350_REG3] = pdata->r3_user_settings &
 				 (ADF4350_REG3_12BIT_CLKDIV(0xFFF) |
-- 
1.7.9.5
