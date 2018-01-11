Return-Path: <SRS0=P0AA=EG=gmail.com=robherring2@kernel.org>
Date: Thu, 11 Jan 2018 13:46:33 -0600
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
	linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
	lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 12/16] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
Message-ID: <20180111194633.5gbvtok2w6q3ievu@rob-hp-laptop>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <538e93d723d7755928ad118564a571371cb337b6.1515486346.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <538e93d723d7755928ad118564a571371cb337b6.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 09, 2018 at 10:33:43AM +0100, Quentin Schulz wrote:
> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

You didn't add my R-by nor address Jonathan's comments on v1.

Rob
