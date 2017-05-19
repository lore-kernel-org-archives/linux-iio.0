Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36603 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbdESOsc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 10:48:32 -0400
Received: by mail-lf0-f48.google.com with SMTP id h4so2322584lfj.3
        for <linux-iio@vger.kernel.org>; Fri, 19 May 2017 07:48:32 -0700 (PDT)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 3/4] iio: hi8435: make in_voltage_sensing_mode_available visible
Date: Fri, 19 May 2017 17:48:01 +0300
Message-Id: <20170519144802.14427-3-nikita.yoush@cogentembedded.com>
In-Reply-To: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Possible values of sensing_mode are encoded with strings and actual
atrings used are not obvious.

Provide a hint by enabling in_voltage_sensing_mode_available attribute.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 45a92e3e8f2b..d09cb6ff8044 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -356,6 +356,7 @@ static const struct iio_enum hi8435_sensing_mode = {
 
 static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
 	IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
+	IIO_ENUM_AVAILABLE("sensing_mode", &hi8435_sensing_mode),
 	{},
 };
 
-- 
2.11.0

