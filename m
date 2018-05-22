Return-Path: <SRS0=g9gq=IJ=gmail.com=robherring2@kernel.org>
Date: Tue, 22 May 2018 15:57:01 -0500
From: Rob Herring <robh@kernel.org>
To: Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, cdevired@codeaurora.org,
	rphani@codeaurora.org, sivaa@codeaurora.org
Subject: Re: [PATCH 2/2] iio: adc: Add Qualcomm SPMI PMIC5 ADC driver
Message-ID: <20180522205701.GA31572@rob-hp-laptop>
References: <1525815536-27781-1-git-send-email-smohanad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525815536-27781-1-git-send-email-smohanad@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 08, 2018 at 02:38:56PM -0700, Siddartha Mohanadoss wrote:
> This patch adds support for Qualcomm SPMI PMIC5 family
> of ADC driver that supports hardware based offset and
> gain compensation. The ADC peripheral can measure both
> voltage and current channels whose input signal is
> connected to the PMIC.
> 
> The register set and configuration has been refreshed
> compared to the prior Qualcomm PMIC ADC family. Register
> ADC5 as part of the IIO framework.
> 
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  drivers/iio/adc/Kconfig                  |  18 +
>  drivers/iio/adc/Makefile                 |   1 +
>  drivers/iio/adc/qcom-spmi-adc5.c         | 818 +++++++++++++++++++++++++++++++
>  drivers/iio/adc/qcom-vadc-common.c       | 241 +++++++++
>  drivers/iio/adc/qcom-vadc-common.h       |  51 ++

>  include/dt-bindings/iio/qcom,spmi-vadc.h | 115 ++++-

This belongs in the binding patch.

>  6 files changed, 1243 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
