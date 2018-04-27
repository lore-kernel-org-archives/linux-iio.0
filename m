Return-Path: <SRS0=MLpZ=HQ=gmail.com=robherring2@kernel.org>
Date: Fri, 27 Apr 2018 09:29:17 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for
 voltage-divider
Message-ID: <20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
 <20180423210809.29586-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180423210809.29586-3-peda@axentia.se>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 23, 2018 at 11:08:07PM +0200, Peter Rosin wrote:
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, a "big" voltage measured with the help
> of a voltage divider.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

Reviewed-by: Rob Herring <robh@kernel.org>
