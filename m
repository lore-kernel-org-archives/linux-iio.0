Return-Path: <SRS0=EJXT=JV=gmail.com=robherring2@kernel.org>
Date: Thu, 5 Jul 2018 15:18:58 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
	mchehab@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180705211858.GA7441@rob-hp-laptop>
References: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 04, 2018 at 05:32:53PM +0300, Stefan Popa wrote:
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v5:
> 	- used a dac@0 as a more generic node name instead of ad5758@0.
> Changes in v4:
> 	- Nothing changed, just to follow the patch set version.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- range was replaced by range-microvolt and range-microamp
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Added units in the name of the properties.
> 	- Offered more explanation for the various modes of operation.
> 
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
> 
>  .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

Reviewed-by: Rob Herring <robh@kernel.org> 
