Return-Path: <SRS0=hvNL=AN=gmail.com=robherring2@kernel.org>
Date: Tue, 12 Sep 2017 16:51:43 -0500
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Phil Elwell <phil@raspberrypi.org>, "Andrew F. Davis" <afd@ti.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: ti-dac082s085: Document new
 driver
Message-ID: <20170912215143.j3igltuldvqbo7hi@rob-hp-laptop>
References: <cceeb1a985343d36dc90d2708371f3e1a73264f6.1504602350.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cceeb1a985343d36dc90d2708371f3e1a73264f6.1504602350.git.lukas@wunner.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 05, 2017 at 11:27:00AM +0200, Lukas Wunner wrote:
> Add device tree bindings for Texas Instruments 8/10/12-bit 2/4-channel
> DAC driver.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../devicetree/bindings/iio/dac/ti-dac082s085.txt  | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt

Acked-by: Rob Herring <robh@kernel.org> 
