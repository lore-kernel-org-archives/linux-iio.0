Return-Path: <ico@pruts.nl>
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: Crt Mori <cmo@melexis.com>
Cc: Johnathan Iain Cameron <jic23@kernel.org>, Linux Iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass checkpatch.pl
In-reply-to: <CAKv63usKoodnShr4Nw00F-X0qrhZ7s01yN8Az5rn3J-vJyE2VA@mail.gmail.com>
References: <20160909134026.12055-1-ico@pruts.nl> <CAKv63usKoodnShr4Nw00F-X0qrhZ7s01yN8Az5rn3J-vJyE2VA@mail.gmail.com>
Date: Fri, 09 Sep 2016 16:05:18 +0200
Message-Id: <1473429689-sup-9519@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>

* On 2016-09-09 15:56:31 +0200, Crt Mori wrote:
 
> You are missing Signed-off-by flag.

Sorry, first time around. Retry:

Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1cf6b79..5688b29 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -391,7 +391,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-- 
2.9.3
