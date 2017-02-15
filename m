Return-Path: <SRS0=RxXl=Z4=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
To: Mark Brown <broonie@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE
	<alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
Date: Wed, 15 Feb 2017 14:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Hello Mark,

On 02/14/2017 06:16 PM, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
>> From: olivier moysan <olivier.moysan@st.com>
>> 
>> Add copy support in pcm damengine operations. As example, this
>> allows to: - process data before rendering (IEC status
>> insertion), - process captured sample ( sample mask and shift).
> 
> dmaengine with copy...  so not DMA at all?  I'm a bit confused
> about why we're extending the dmaengine code to have a copy
> operation rather than just writing driver code.
> 

For DFSDM we need to re-arrange samples after DMA transfer, before
sending them to application.
For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
in snd_pcm_ops struct.
This ops is not available at soc dma engine level, so at ASoC driver
level.
Aim of this patch is to expose the copy in driver. DMA is still used,
copy ops just allows to handle the copy_to_user in driver.
Advantage of this add-on is that we still able to take benefice of the
generic DMA in DFSDM driver.
Now if you estimate that it is too stm32 SOC specific, the other
solution is to handle directly the PCM platform device in DFSDM driver.

Regards
Arnaud
