Return-Path: <SRS0=P0AA=EG=gmail.com=robherring2@kernel.org>
Date: Thu, 11 Jan 2018 16:09:53 -0600
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
	linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
	lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 07/16] dt-bindings: iio: adc: axp20x_adc: add AXP813
 variant
Message-ID: <20180111220953.fk34fwpkahyd2ndk@rob-hp-laptop>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <64b538aadf075ba07e567d9a9db865b64c97fbfc.1515486346.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <64b538aadf075ba07e567d9a9db865b64c97fbfc.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 09, 2018 at 10:33:38AM +0100, Quentin Schulz wrote:
> AXP813 is now supported so add documentation for this compatible.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt |  9 +++++++++-
>  1 file changed, 9 insertions(+)

You can just squash this into the patch #2.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
