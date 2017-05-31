Return-Path: <SRS0=Wi5e=5F=gmail.com=robherring2@kernel.org>
Date: Wed, 31 May 2017 14:46:34 -0500
From: Rob Herring <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: use proper name for the R-Car SoC
Message-ID: <20170531194634.hs42qazk7y6uan7h@rob-hp-laptop>
References: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
 <20170528093051.11816-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170528093051.11816-4-wsa+renesas@sang-engineering.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, May 28, 2017 at 11:30:46AM +0200, Wolfram Sang wrote:
> It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive text.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> I suggest this trivial patch should be picked individually per susbsystem.
> 
>  Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
