Return-Path: <SRS0=KyTF=B7=gmail.com=robherring2@kernel.org>
Date: Wed, 1 Nov 2017 16:54:04 -0500
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Jonathan Cameron <jic23@kernel.org>, Rick Altherr <raltherr@google.com>,
	Philipp Zabel <philipp.zabel@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: aspeed: Deassert reset in probe
Message-ID: <20171101215404.njw5zch55dxwmkgl@rob-hp-laptop>
References: <20171031021203.18248-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031021203.18248-1-joel@jms.id.au>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 31, 2017 at 12:42:03PM +1030, Joel Stanley wrote:
> The ASPEED SoC must deassert a reset in order to use the ADC peripheral.
> 
> The device tree bindings are updated to document the resets phandle, and
> the example is updated to match what is expected for both the reset and
> clock phandle. Note that the bindings should have always had the reset
> controller, as the hardware is unusable without it.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Ensure disabling path unwinds in opposite order as the enable path
>  - Note that the bindings were incorrect without the reset phandle,
>  and for the system to be usable we must update them. No one was
>  (successfully) using these bindings/driver before without out of tree
>  hacks in mach-aspeed, as it would not have worked.
> 
>  .../devicetree/bindings/iio/adc/aspeed_adc.txt     |  4 +++-
>  drivers/iio/adc/aspeed_adc.c                       | 25 ++++++++++++++++------
>  2 files changed, 22 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
