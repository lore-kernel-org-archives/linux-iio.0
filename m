Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35183 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdLDVvN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 16:51:13 -0500
Date: Mon, 4 Dec 2017 15:51:12 -0600
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
        alsa-devel@alsa-project.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v6 12/13] ASoC: add bindings for stm32 DFSDM filter
Message-ID: <20171204215112.upkujy6grec6urae@rob-hp-laptop>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
 <1512150020-20335-13-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512150020-20335-13-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 01, 2017 at 06:40:19PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes audio settings to support
> Digital Filter for pulse density modulation(PDM) microphone.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

Acked-by: Rob Herring <robh@kernel.org>
