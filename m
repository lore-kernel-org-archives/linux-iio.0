Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32898 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757071AbdCXOiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 10:38:07 -0400
Date: Fri, 24 Mar 2017 09:37:32 -0500
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
Subject: Re: [PATCH v3 04/11] IIO: add DT bindings for stm32 DFSDM filter
Message-ID: <20170324143732.nvq2wfra6q3hcrhs@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 17, 2017 at 03:08:17PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes Digital Filter for Sigma Delta
> Modulators. DFSDM allows to connect sigma delta
> modulators.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2->V3:
>    Fixes based on V2 comments
> 
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 120 +++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
