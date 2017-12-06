Return-Path: <SRS0=mYvj=DC=gmail.com=robherring2@kernel.org>
Date: Wed, 6 Dec 2017 15:16:59 -0600
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, mark.rutland@arm.com, wens@csie.org,
	linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
	jic23@kernel.org, lee.jones@linaro.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	icenowy@aosc.io, linux-sunxi@googlegroups.com,
	thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 4/8] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
Message-ID: <20171206211659.epe65eetp6gr4b7f@rob-hp-laptop>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 04, 2017 at 03:12:50PM +0100, Quentin Schulz wrote:
> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
