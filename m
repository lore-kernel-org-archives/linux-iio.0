Return-Path: <SRS0=2YOI=5T=gmail.com=robherring2@kernel.org>
Date: Wed, 14 Jun 2017 10:30:08 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
	jic23@kernel.org
Subject: Re: [PATCH v4 2/4] Documentation: dt: iio: at91-sama5d2_adc: add hw
 trigger edge binding
Message-ID: <20170614153008.wgww2b5fweocqmmk@rob-hp-laptop>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
 <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 09, 2017 at 10:07:17AM +0300, Eugen Hristev wrote:
> Add property for the edge type of the hardware trigger pin ADTRG
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>   Changes in v4:
>  - Modified bindings to be similar with interrupts
> 
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
