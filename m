Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbdLBOwu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 09:52:50 -0500
Date: Sat, 2 Dec 2017 14:52:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v6 05/13] IIO: Add DT bindings for sigma delta adc
 modulator
Message-ID: <20171202145245.7802378c@archlinux>
In-Reply-To: <1512150020-20335-6-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
        <1512150020-20335-6-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 1 Dec 2017 18:40:12 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Add documentation of device tree bindings to support
> sigma delta modulator in IIO framework.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.txt   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> new file mode 100644
> index 0000000..e9ebb8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -0,0 +1,13 @@
> +Device-Tree bindings for sigma delta modulator
> +
> +Required properties:
> +- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> +	as a generic SD modulator if modulator not specified in compatible list.
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +
> +Example node:
> +
> +	ads1202: adc@0 {
> +		compatible = "sd-modulator";
> +		#io-channel-cells = <1>;
> +	};

