Return-Path: <vigneshr@ti.com>
From: Vignesh R <vigneshr@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Karol Wrona <k.wrona@samsung.com>,
        Jan Kardell
	<jan.kardell@telliq.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <fcooper@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] iio: ti_am335x_adc: Add optional DT properties for tscadc
Date: Tue, 31 Mar 2015 16:42:35 +0530
Message-ID: <1427800357-21680-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Hi,

This patch adds optional DT properties for tscadc to set open delay,
sample delay and number of averages per sample for each adc channel.
Open delay, sample delay and averaging are some of the parameters that
affect the sampling rate and accuracy of the tscadc. Decreasing delays
and averaging helps to achieve higher sampling rates, while increasing
this parameters provides greater accuracy. Hence, this patch provides DT
properties to set the initial values for delays and number of averages
per sample. User space control via sysfs can be added later.


Vignesh R (2):
  iio: adc: ti_am335x_adc: refactor DT parsing into a function
  iio: adc: ti_am335x_adc: make sample delay, open delay, averaging DT
    parameters

 .../bindings/input/touchscreen/ti-tsc-adc.txt      | 24 +++++++
 drivers/iio/adc/ti_am335x_adc.c                    | 83 +++++++++++++++++-----
 2 files changed, 91 insertions(+), 16 deletions(-)

-- 
1.9.1
