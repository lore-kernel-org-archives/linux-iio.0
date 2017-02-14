Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51324 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbdBNRqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 12:46:37 -0500
Date: Tue, 14 Feb 2017 17:45:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xpdpdov767mccfpp"
In-Reply-To: <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--xpdpdov767mccfpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:

This looks basically fine as a system specific driver but as some of the
comments in here say there's bits of it could perhaps be genericised but
I'm not sure we need to do that right now.  I'm not sure the abstraction
is exactly comfortable but having another bit of hardware doing a bridge
to IIO might be the best way to figure out something better.

> +	.period_bytes_min =3D 40, /* 8 khz 5 ms */
> +	.period_bytes_max =3D 4 * PAGE_SIZE,
> +	.buffer_bytes_max =3D 16 * PAGE_SIZE

What's the physical minimum period limit?  The comment makes this sound
like it's just made up.

> +	unsigned int shift =3D 24 -priv->max_scaling;
> +=09

Missing space after -.

> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
> +	return 0;
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  &priv->rates_const);

Looks like debug changes got left in?

> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				   unsigned int freq, int dir)
> +{
> +	struct stm32_adfsdm_priv *priv =3D snd_soc_dai_get_drvdata(dai);
> +	struct stm32_adfsdm_pdata *pdata =3D priv->pdata;
> +
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +	if (dir =3D=3D SND_SOC_CLOCK_IN) {
> +		pdata->ops->set_sysclk(pdata->adc, freq);
> +		priv->dmic_clk =3D freq;
> +	}
> +
> +	/* Determine supported rate which depends on SPI/manchester clock */
> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);

Since the DAI is unidirectional it doesn't matter but obviously if it
weren't then the fact that getting the supported rates involves setting
the hwparams means this could become disruptive.  If we're going to
genericise this to be a more general IIO/ASoC bridge that could matter.

> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +
> +	return 0;
> +}

Remove empty functions, though in this case I think you want to add
something to disconnect the XRUN callback just in order to be sure it
can't be mistakenly called.

--xpdpdov767mccfpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlijQj4ACgkQJNaLcl1U
h9BceAf+IvJatEdQ7QRh76mi+W8+GmO6mh2PfrVZkp85nnwYhtrGUefHTceCm0Ro
0n5QebpVR2vC2E/8NkCoCFrl3LWiZ32dQ4CE60JsQg/BTrLGYTmhUhfUTE74ydaL
GRvBj7+nfhdkJOoc11pu+GhrCL4JjBU3H4XrRXXnA6u4E8c0mh970lEsC484UyIn
Baac1qM8ezLQc5k/pMNcjMdTcF8HbovyFm7Ih/jdDS8wzh2BGBU7MukrJwfeSCHy
4GtPf/BaQnnYzlWc/Ncj82Kk28lt8ndZ8uAASpfkNEv2Be6gARtxB0fQoQSX0dhK
fwhp0sOulo5MObScqlDiVwFkLGKinA==
=FHM7
-----END PGP SIGNATURE-----

--xpdpdov767mccfpp--
