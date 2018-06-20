Return-Path: <SRS0=QMXo=JG=gmail.com=robherring2@kernel.org>
Date: Wed, 20 Jun 2018 13:31:24 -0600
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC
 controller documentation
Message-ID: <20180620193124.GA8185@rob-hp-laptop>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 15, 2018 at 03:03:35PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series
> PMICs ADC controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - No updates.
> ---
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
