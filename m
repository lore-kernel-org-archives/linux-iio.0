Return-Path: <rickard.strandqvist@spctrm.se>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: impedance-analyzer: ad5933: Change type in printf format string
Date: Tue, 27 Jan 2015 23:18:01 +0100
Message-Id: <1422397081-8832-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-ID: <linux-iio@vger.kernel.org>

Wrong type in printf format string, requires 'int'
but the argument type is 'unsigned int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b6bd609..4230a43 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -360,11 +360,11 @@ static ssize_t ad5933_show(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32) this_attr->address) {
 	case AD5933_OUT_RANGE:
-		len = sprintf(buf, "%d\n",
+		len = sprintf(buf, "%u\n",
 			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
 		break;
 	case AD5933_OUT_RANGE_AVAIL:
-		len = sprintf(buf, "%d %d %d %d\n", st->range_avail[0],
+		len = sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
 			      st->range_avail[3], st->range_avail[2],
 			      st->range_avail[1]);
 		break;
-- 
1.7.10.4
