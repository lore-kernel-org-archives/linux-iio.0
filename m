Return-Path: <SRS0=ysYS=AZ=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	<linux-kernel@vger.kernel.org>, Manivannan Sadhasivam
	<manivannanece23@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v3 0/4] Currently, the vl6180 driver reports bogus in_illuminance_scale values
Date: Sun, 24 Sep 2017 23:59:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <4c228333-df88-4fd4-86f7-90a7668a3ac3@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

when the integration time or hardware gain are changed from its default
value, i.e. it always reports a fixed value.

To avoid readback of the register values in case integration time, gain
or scale is queried, save the register values. Use the saved values
to report the correct scale value.

Changes in v3:
- Drop whitespace change
- Use IIO_VAL_FRACTIONAL for integration time return value

Changes in v2:
- Removed redundant parenthesis
- Add missing spaces

Stefan Brüns (4):
  iio: light: vl6180: Move range check to integration time setter,
    cleanup
  iio: light: vl6180: Avoid readback of integration time register
  iio: light: vl6180: Cleanup als_gain lookup, avoid register readback
  iio: light: vl6180: Correct ALS scale for non-default gain/integration
    time

 drivers/iio/light/vl6180.c | 126 +++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 57 deletions(-)

-- 
2.14.1
