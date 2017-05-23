Return-Path: <SRS0=cE2T=45=atomide.com=tony@kernel.org>
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCHv2 0/3] Few non-critical cpcap ADC fixes
Date: Mon, 22 May 2017 17:51:43 -0700
Message-Id: <20170523005146.726-1-tony@atomide.com>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

Here are few fixes for cpcap ADC mostly to get temperature readings                                  produce sane values. AFAIK no need for urgency with these and they                                   can all wait for v4.13 merge window.

Regards,

Tony

Changes since v1:

- Rename CPCAP_ADC_AD0_BATTDETB to just CPCAP_ADC_AD0 based on
  Matt Ranostay's suggestion as it's the battery temperature

- Add ack from Sebastian Reichel

Tony Lindgren (3):
  iio: adc: cpcap: Fix default register values and battery temperature
  iio: adc: cpcap: Fix die temperature
  iio: adc: cpcap: Remove hung interrupt quirk

 drivers/iio/adc/cpcap-adc.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

-- 
2.13.0
