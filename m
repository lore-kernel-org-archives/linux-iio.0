Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38221 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdBSO4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 09:56:10 -0500
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
To: Mark Brown <broonie@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a9cf136c-2c8c-eafc-d175-4977c7ea4925@kernel.org>
Date: Sun, 19 Feb 2017 14:56:05 +0000
MIME-Version: 1.0
In-Reply-To: <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/17 17:45, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:
> 
> This looks basically fine as a system specific driver but as some of the
> comments in here say there's bits of it could perhaps be genericised but
> I'm not sure we need to do that right now.  I'm not sure the abstraction
> is exactly comfortable but having another bit of hardware doing a bridge
> to IIO might be the best way to figure out something better.
Agreed.  To an extent we are fishing around in the dark at the moment.
Lets wait until we have a few more cases of similar hardware before trying
too much generalization.  This is acting as a good exploration of what
is needed.

Ideally Lars might upstream some of the other bits he has in his tree
to do with DSP processing on ADC streams and that might provide us with
more clues on generality (at least at the lowest layers)
(Apparently he's busy - though he always makes that excuse :)
Joking aside, the exploration Analog and in particular Lars does around
pushing the limits of how things interact is always useful!)

> 
>> +	.period_bytes_min = 40, /* 8 khz 5 ms */
>> +	.period_bytes_max = 4 * PAGE_SIZE,
>> +	.buffer_bytes_max = 16 * PAGE_SIZE
> 
> What's the physical minimum period limit?  The comment makes this sound
> like it's just made up.
> 
>> +	unsigned int shift = 24 -priv->max_scaling;
>> +	
> 
> Missing space after -.
> 
>> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
>> +	return 0;
>> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +					  SNDRV_PCM_HW_PARAM_RATE,
>> +					  &priv->rates_const);
> 
> Looks like debug changes got left in?
> 
>> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>> +				   unsigned int freq, int dir)
>> +{
>> +	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
>> +	struct stm32_adfsdm_pdata *pdata = priv->pdata;
>> +
>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>> +	if (dir == SND_SOC_CLOCK_IN) {
>> +		pdata->ops->set_sysclk(pdata->adc, freq);
>> +		priv->dmic_clk = freq;
>> +	}
>> +
>> +	/* Determine supported rate which depends on SPI/manchester clock */
>> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);
> 
> Since the DAI is unidirectional it doesn't matter but obviously if it
> weren't then the fact that getting the supported rates involves setting
> the hwparams means this could become disruptive.  If we're going to
> genericise this to be a more general IIO/ASoC bridge that could matter.
> 
>> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
>> +{
>> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
>> +
>> +	return 0;
>> +}
> 
> Remove empty functions, though in this case I think you want to add
> something to disconnect the XRUN callback just in order to be sure it
> can't be mistakenly called.
> 

