Return-Path: <SRS0=WEQd=NC=gmail.com=victorcolombo@kernel.org>
Date: Mon, 22 Oct 2018 17:41:27 -0300
From: Victor Colombo <victorcolombo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/2] staging: iio: ad5933: Remove unnecessary blank line
Message-ID: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warning:

WARNING: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 7a216ea90784..f9bcb8310e21 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -267,7 +267,6 @@ static void ad5933_calc_out_ranges(struct ad5933_state *st)
 
 	for (i = 0; i < 4; i++)
 		st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
-
 }
 
 /*
-- 
2.19.1
