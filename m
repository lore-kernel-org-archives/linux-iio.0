Return-Path: <SRS0=nuQv=CI=gmail.com=robherring2@kernel.org>
Date: Fri, 10 Nov 2017 15:21:39 -0600
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Carlo Caione <carlo@caione.org>,
	Xingyu Chen <xingyu.chen@amlogic.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: adc: update the doc for SAR ADC
Message-ID: <20171110212139.ssh5kts3xo35hqeu@rob-hp-laptop>
References: <20171107141020.30419-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107141020.30419-1-yixun.lan@amlogic.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 07, 2017 at 10:10:20PM +0800, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Update the doc as the SAR ADC modules doesn't require "sana" clock.
> 
> Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
