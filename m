Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36852 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdCXOzI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 10:55:08 -0400
Date: Fri, 24 Mar 2017 09:46:03 -0500
From: Rob Herring <robh@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@stlinux.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
Subject: Re: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
Message-ID: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:
> This patch adds documentation of device tree bindings for audio DMIC codec.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> new file mode 100644
> index 0000000..eb2a9d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -0,0 +1,11 @@
> +Device-Tree bindings for dmic codec

Please define what is and isn't a DMIC here. What's the interface?

> +
> +Required properties:
> +	- compatible: should be "dmic-codec".

DMICs don't have part numbers?

> +
> +Example node:
> +
> +	dmic_audio: dmic_audio@0 {

Don't use '_' and there's no reg property, so there should be no unit 
address.

> +		compatible = "dmic-codec";
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 1.9.1
> 
