Return-Path: <svarbanov@mm-sol.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
To: Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Fugang Duan <B38611@freescale.com>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Jean Delvare <jdelvare@suse.de>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	Lee Jones <lee.jones@linaro.org>,
	Josh Cartwright <joshc@codeaurora.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	David Collins <collinsd@codeaurora.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH 0/2] Intial support for voltage ADC
Date: Fri,  5 Sep 2014 15:14:32 +0300
Message-Id: <1409919274-13419-1-git-send-email-svarbanov@mm-sol.com>
List-ID: <linux-iio@vger.kernel.org>

Introduce inital support for VADC inside Qualcomm SPMI PMICs.
The vadc driver is reworked version of the same downstream
driver but now it is implemented through Industrial IO core.

Comments are welcome!

regards,
Stan

Stanimir Varbanov (2):
  iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
  DT: iio: vadc: document dt binding

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  110 ++
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/qcom-spmi-vadc.c                   | 1275 ++++++++++++++++++++
 include/dt-bindings/iio/qcom,spmi-pmic-vadc.h      |  119 ++
 5 files changed, 1516 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
 create mode 100644 drivers/iio/adc/qcom-spmi-vadc.c
 create mode 100644 include/dt-bindings/iio/qcom,spmi-pmic-vadc.h
