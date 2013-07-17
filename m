Return-Path: <oleksandr.kozaruk@ti.com>
Message-ID: <51E668B4.1010000@ti.com>
Date: Wed, 17 Jul 2013 12:49:40 +0300
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: <tony@atomide.com>, <benoit.cousson@linaro.org>, <rnayak@ti.com>,
        <peter.ujfalusi@ti.com>, <kishon@ti.com>, <jic23@cam.ac.uk>,
        <grant.likely@linaro.org>, <rob.herring@calxeda.com>,
        <lars@metafoo.de>, <sameo@linux.intel.com>, <ch.naveen@samsung.com>,
        <poeschel@lemonage.de>, <milo.kim@ti.com>, <balajitk@ti.com>,
        <gg@slimlogic.co.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree-discuss@lists.ozlabs.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
References: <1373974023-23521-1-git-send-email-oleksandr.kozaruk@ti.com> <1373974023-23521-3-git-send-email-oleksandr.kozaruk@ti.com> <c8f86766-822b-4fe3-ae2a-e0b12412ef39@email.android.com>
In-Reply-To: <c8f86766-822b-4fe3-ae2a-e0b12412ef39@email.android.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

 >Two very quick comments based on quick glance as it may be a while 
before I can do a full review.

 >We still have channels that are only usable for temperature being 
output to user space as voltage channels? Is the conversion so very hard?

Can you please clarify what should return temperature channel for 
in_tempX_input (processed)? Is it voltage or Celsius degree?
in_tempX_raw should return ADC code? Right?

Regards,
OK.
