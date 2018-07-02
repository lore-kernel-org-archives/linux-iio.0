Return-Path: <SRS0=JNo/=JS=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: remove redundant variable 'shift'
Date: Mon,  2 Jul 2018 11:24:35 +0100
Message-Id: <20180702102435.16724-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable shift is being assigned but is never used hence it is
redundant and can be removed.

Cleans up two clang warnings:
warning: variable ‘shift’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ti-dac5571.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index dd21eebed6a8..e39d1e901353 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -97,9 +97,6 @@ static int dac5571_cmd_quad(struct dac5571_data *data, int channel, u16 val)
 
 static int dac5571_pwrdwn_single(struct dac5571_data *data, int channel, u8 pwrdwn)
 {
-	unsigned int shift;
-
-	shift = 12 - data->spec->resolution;
 	data->buf[1] = 0;
 	data->buf[0] = pwrdwn << DAC5571_SINGLE_PWRDWN_BITS;
 
@@ -111,9 +108,6 @@ static int dac5571_pwrdwn_single(struct dac5571_data *data, int channel, u8 pwrd
 
 static int dac5571_pwrdwn_quad(struct dac5571_data *data, int channel, u8 pwrdwn)
 {
-	unsigned int shift;
-
-	shift = 16 - data->spec->resolution;
 	data->buf[2] = 0;
 	data->buf[1] = pwrdwn << DAC5571_QUAD_PWRDWN_BITS;
 	data->buf[0] = (channel << DAC5571_CHANNEL_SELECT) |
-- 
2.17.1
