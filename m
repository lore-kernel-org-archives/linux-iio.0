Return-Path: <SRS0=WF3d=3M=linaro.org=benjamin.gaignard@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	vilhelm.gray@gmail.com,
	mwelling@ieee.org
Cc: fabrice.gasnier@st.com,
	linaro-kernel@lists.linaro.org,
	benjamin.gaignard@linaro.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 0/2] iio: stm32 trigger: Add quadrature device and counter 
Date: Tue,  4 Apr 2017 09:47:50 +0200
Message-Id: <1491292072-8535-1-git-send-email-benjamin.gaignard@st.com>
List-ID: <linux-iio@vger.kernel.org>

A first encoder IIO driver (104-quad-8) with a count channel already exist.
STM32 driver have the same type of feature but with different counting modes.
Some parts, like counting direction (up/down) could be generalized so move the
corresponding documentation from driver file to sysfs-bus-iio.

version 4:
- fix indentation in documentation
- reword triggered description

version 3:
- fix typo in documentation
- change some functions names

version 2:
- since iio: Generalize counting direction modes commit of version has being
  pushed in iio.git testing branch I have remove it from this serie.
- split the original attribute in 2: one for quadrature modes and one for
  enable modes.
- add scale info
- change modes to more generic names to be able to merge them with 104-quad-8
  in the futur.


Benjamin Gaignard (2):
  iio: stm32 trigger: Add quadrature encoder device
  iio: stm32 trigger: Add counter enable modes

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  71 ++++-
 drivers/iio/trigger/stm32-timer-trigger.c          | 314 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |   2 +
 3 files changed, 377 insertions(+), 10 deletions(-)

-- 
1.9.1
