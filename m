Return-Path: <robh@kernel.org>
Date: Thu, 14 Apr 2016 12:35:40 -0500
From: Rob Herring <robh@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH V3 1/2] thermal: generic-adc: Add DT binding for ADC
 based thermal sensor
Message-ID: <20160414173540.GA23807@rob-hp-laptop>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 14, 2016 at 08:11:17PM +0530, Laxman Dewangan wrote:
> Sometimes, thermal sensors like NCT thermistors are connected to
> the ADC channel. The temperature is read by reading the voltage
> across the sensor resistance via ADC and referring the lookup
> table for ADC value to temperature.
> 
> Add DT binding doc for the ADC based thermal sensor driver to
> detail the DT property and provide the example for how to use it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> Changes from V1:
> - Make the lookup table to two dimensional instead of single array of linear
>   step of temperature.
> - Remove detailing of IIO frameowrk and drivers.
> - Added proper braces, indenting and labels.
> 
> Changes from V2:
> - Handle comment from Rob for detailing the first and second value of the array
>   and remove @ in the node name.
> 
>  .../bindings/thermal/thermal-generic-adc.txt       | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

Acked-by: Rob Herring <rob@kernel.org>
