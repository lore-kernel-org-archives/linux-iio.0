Return-Path: <SRS0=NnCZ=JW=gmail.com=robherring2@kernel.org>
Date: Fri, 6 Jul 2018 14:27:07 -0600
From: Rob Herring <robh@kernel.org>
To: Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add DT binding document
 for PMIC5 ADC
Message-ID: <20180706202707.GA3658@rob-hp-laptop>
References: <1530210611-16434-1-git-send-email-smohanad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530210611-16434-1-git-send-email-smohanad@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 28, 2018 at 11:30:11AM -0700, Siddartha Mohanadoss wrote:
> PMIC5 ADC has support for clients to measure voltage and current
> on inputs connected to the PMIC. Clients include reading voltage
> phone power and on board system thermistors for thermal management.
> ADC5 on certain PMIC has support to read battery current.
> 
> This change adds documentation.
> 
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 ++++++++++----
>  include/dt-bindings/iio/qcom,spmi-vadc.h           | 115 ++++++++++++++++++++-
>  2 files changed, 172 insertions(+), 20 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
