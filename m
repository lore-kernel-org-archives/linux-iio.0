Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56556 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2J1MBh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2012 08:01:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3674079pbb.19
        for <linux-iio@vger.kernel.org>; Sun, 28 Oct 2012 05:01:36 -0700 (PDT)
Message-ID: <1351425686.12461.1.camel@phoenix>
Subject: iio: at91_adc.c build error
From: Axel Lin <axel.lin@ingics.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Sun, 28 Oct 2012 20:01:26 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

hi Lars-Peter,

Seems there is no devm_kcalloc API available at this moment (in linux-next tree).

I got below build error:
drivers/iio/adc/at91_adc.c: In function 'at91_adc_channel_init':
drivers/iio/adc/at91_adc.c:126: error: implicit declaration of function 'devm_kcalloc'
drivers/iio/adc/at91_adc.c:127: warning: assignment makes pointer from integer without a cast
drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_init':
drivers/iio/adc/at91_adc.c:272: warning: assignment makes pointer from integer without a cast
drivers/iio/adc/at91_adc.c: In function 'at91_adc_probe_dt':
drivers/iio/adc/at91_adc.c:455: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/iio/adc/at91_adc.o] Error 1
make[2]: *** [drivers/iio/adc] Error 2
make[1]: *** [drivers/iio] Error 2
make: *** [drivers] Error 2

Regards,
Axel


