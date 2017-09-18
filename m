Return-Path: <SRS0=7Lr1=AT=gmail.com=robherring2@kernel.org>
Date: Mon, 18 Sep 2017 15:27:05 -0500
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Phil Elwell <phil@raspberrypi.org>,
	Oskar Andero <oskar.andero@gmail.com>,
	Andrea Galbusera <gizero@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Michael Welling <mwelling@ieee.org>,
	Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170918202705.xunpkrn7wllvzbp3@rob-hp-laptop>
References: <cover.1504807204.git.lukas@wunner.de>
 <f5899af5ef548c618ac14950301f6bc8eff6e9ba.1504807204.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f5899af5ef548c618ac14950301f6bc8eff6e9ba.1504807204.git.lukas@wunner.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 09, 2017 at 08:32:41PM +0200, Lukas Wunner wrote:
> All chips supported by this driver clock data out on the falling edge
> and latch data in on the rising edge, hence SPI mode (0,0) or (1,1)
> must be used.
> 
> Furthermore, none of the chips has an internal reference voltage
> regulator, so an external supply is always required and needs to be
> specified in the device tree lest the IIO "scale" in sysfs cannot be
> calculated.
> 
> Document these requirements in the device tree binding, add compatible
> strings for the newly supported mcp3550/1/3 and explain that SPI mode
> (0,0) should be preferred for these chips.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes since v1:
> - Move support for continuous conversion mode to separate patch
>   which is marked informational / not for merging. (Rob, Jonathan)
> 
>  Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
