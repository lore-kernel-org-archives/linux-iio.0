Return-Path: <SRS0=rAUl=F7=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 9 Mar 2018 20:45:50 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging:iio:ad2s1210: Remove end of line with '['
Message-ID: <b87fdd8b09ebee3fd29a8b65257e37eff7d8532b.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl check:

iio/resolver/ad2s1210.c:202: CHECK: Lines should not end with a '['

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f8baab061eba..0cdcd71e285b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -165,9 +165,10 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 
 static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 {
-	return ad2s1210_resolution_value[
-		(gpio_get_value(st->pdata->res[0]) << 1) |
-		gpio_get_value(st->pdata->res[1])];
+	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
+			  gpio_get_value(st->pdata->res[1]);
+
+	return ad2s1210_resolution_value[resolution];
 }
 
 static const int ad2s1210_res_pins[4][2] = {
-- 
2.16.2
