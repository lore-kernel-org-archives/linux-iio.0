Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29991 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750902AbdBOQlb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 11:41:31 -0500
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
To: Mark Brown <broonie@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
CC: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
Date: Wed, 15 Feb 2017 17:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 02/14/2017 06:45 PM, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:
> 
> This looks basically fine as a system specific driver but as some 
> of the comments in here say there's bits of it could perhaps be 
> genericised but I'm not sure we need to do that right now.  I'm not
> sure the abstraction is exactly comfortable but having another bit
> of hardware doing a bridge to IIO might be the best way to figure
> out something better.
> 
Yes this is one point to clarify. I keep it as a specific API, as i
don't know if another hardware needs to support it...
I would say that objective of this version is to highlight interactions.
Then i can rework it in a way that could be  genericised in future (
i.e. using void* for params that would depend on platforms)...

Extend IIO customer API would be also another alternative, but i did
not find a generic way to do it. Some IIO attributes could be used for
Hw params but DMA and IRQs seems tricky to handle through this IIO
interface...




>> +	.period_bytes_min = 40, /* 8 khz 5 ms */ +	.period_bytes_max =
>>  4 * PAGE_SIZE, +	.buffer_bytes_max = 16 * PAGE_SIZE
> 
> What's the physical minimum period limit?  The comment makes this 
> sound like it's just made up.
I did not find physical minimum period limit, that why i considered
this value from a scheduling point of view. I will re-check these values.

> 
>> +	unsigned int shift = 24 -priv->max_scaling; +
> 
> Missing space after -.
> 
>> +	dev_dbg(dai->dev, "%s: enter\n", __func__); +	return 0; + 
>> return snd_pcm_hw_constraint_list(substream->runtime, 0, + 
>> SNDRV_PCM_HW_PARAM_RATE, +					  &priv->rates_const);
> 
> Looks like debug changes got left in?
yes exactly...
> 
>> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int
>>  clk_id, +				   unsigned int freq, int dir) +{ +	struct 
>> stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai); +	struct
>>  stm32_adfsdm_pdata *pdata = priv->pdata; + +	dev_dbg(dai->dev, 
>> "%s: enter for dai %d\n", __func__, dai->id); +	if (dir == 
>> SND_SOC_CLOCK_IN) { +		pdata->ops->set_sysclk(pdata->adc, freq); 
>> +		priv->dmic_clk = freq; +	} + +	/* Determine supported rate 
>> which depends on SPI/manchester clock */ +	return 
>> stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);
> 
> Since the DAI is unidirectional it doesn't matter but obviously if
>  it weren't then the fact that getting the supported rates involves
>  setting the hwparams means this could become disruptive.  If we're
>  going to genericise this to be a more general IIO/ASoC bridge that
>  could matter.
I think that the driver itself can not be generic. ST DFSDM is too
specific. Only API with IIO could be.

> 
>> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai) +{ +
>> dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id); +
>> +	return 0; +}
> 
> Remove empty functions, though in this case I think you want to
> add something to disconnect the XRUN callback just in order to be
> sure it can't be mistakenly called.

Yes Completely unnecessary here. Furthermore the driver should be
removed by the IIO driver.

Regards
Arnaud
