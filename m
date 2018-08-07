Return-Path: <SRS0=dKk1=KW=gmail.com=robherring2@kernel.org>
Date: Tue, 7 Aug 2018 08:54:09 -0600
From: Rob Herring <robh@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
	sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v6 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180807145409.GA32028@rob-hp-laptop>
References: <20180807102704.1652656-1-pn@denx.de>
 <20180807102704.1652656-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807102704.1652656-2-pn@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 07, 2018 at 12:27:04PM +0200, Parthiban Nallathambi wrote:
> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> 
> Changelog in v3:
> - removed interrupt-parent property reference in documentation
> - renamed vcnl4035 to light-sensor
> 
> Changelog in v4:
> - commit message fix
> - same indexing/space in binding
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt         | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

Reviewed-by: Rob Herring <robh@kernel.org>
