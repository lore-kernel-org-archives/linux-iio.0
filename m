Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27602 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbdLAOlo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Dec 2017 09:41:44 -0500
Date: Fri, 1 Dec 2017 22:41:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org, arnaud.pouliquen@st.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH v5 13/13] ASoC: stm32: add DFSDM DAI support
Message-ID: <201712012209.tM3mzVo9%fengguang.wu@intel.com>
References: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc1 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20171201-215409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:13,
                    from include/linux/clk.h:16,
                    from sound/soc//stm/stm32_adfsdm.c:23:
   sound/soc//stm/stm32_adfsdm.c: In function 'stm32_afsdm_pcm_cb':
>> sound/soc//stm/stm32_adfsdm.c:173:20: warning: format '%d' expects argument of type 'int', but argument 7 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
                       ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> sound/soc//stm/stm32_adfsdm.c:173:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
     ^~~~~~~

vim +/dev_dbg +173 sound/soc//stm/stm32_adfsdm.c

  > 23	#include <linux/clk.h>
    24	#include <linux/module.h>
    25	#include <linux/platform_device.h>
    26	#include <linux/slab.h>
    27	
    28	#include <linux/iio/iio.h>
    29	#include <linux/iio/consumer.h>
    30	#include <linux/iio/adc/stm32-dfsdm-adc.h>
    31	
    32	#include <sound/pcm.h>
    33	#include <sound/soc.h>
    34	
    35	#define STM32_ADFSDM_DRV_NAME "stm32-adfsdm"
    36	
    37	#define DFSDM_MAX_PERIOD_SIZE	(PAGE_SIZE / 2)
    38	#define DFSDM_MAX_PERIODS	6
    39	
    40	struct stm32_adfsdm_priv {
    41		struct snd_soc_dai_driver dai_drv;
    42		struct snd_pcm_substream *substream;
    43		struct device *dev;
    44	
    45		/* IIO */
    46		struct iio_channel *iio_ch;
    47		struct iio_cb_buffer *iio_cb;
    48		bool iio_active;
    49	
    50		/* PCM buffer */
    51		unsigned char *pcm_buff;
    52		unsigned int pos;
    53		bool allocated;
    54	};
    55	
    56	struct stm32_adfsdm_data {
    57		unsigned int rate;	/* SNDRV_PCM_RATE value */
    58		unsigned int freq;	/* frequency in Hz */
    59	};
    60	
    61	static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
    62		.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
    63		    SNDRV_PCM_INFO_PAUSE,
    64		.formats = SNDRV_PCM_FMTBIT_S32_LE,
    65	
    66		.rate_min = 8000,
    67		.rate_max = 32000,
    68	
    69		.channels_min = 1,
    70		.channels_max = 1,
    71	
    72		.periods_min = 2,
    73		.periods_max = DFSDM_MAX_PERIODS,
    74	
    75		.period_bytes_max = DFSDM_MAX_PERIOD_SIZE,
    76		.buffer_bytes_max = DFSDM_MAX_PERIODS * DFSDM_MAX_PERIOD_SIZE
    77	};
    78	
    79	static void stm32_adfsdm_shutdown(struct snd_pcm_substream *substream,
    80					  struct snd_soc_dai *dai)
    81	{
    82		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
    83	
    84		if (priv->iio_active) {
    85			iio_channel_stop_all_cb(priv->iio_cb);
    86			priv->iio_active = false;
    87		}
    88	}
    89	
    90	static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
    91					    struct snd_soc_dai *dai)
    92	{
    93		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
    94		int ret;
    95	
    96		ret = iio_write_channel_attribute(priv->iio_ch,
    97						  substream->runtime->rate, 0,
    98						  IIO_CHAN_INFO_SAMP_FREQ);
    99		if (ret < 0) {
   100			dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
   101				__func__, substream->runtime->rate);
   102			return ret;
   103		}
   104	
   105		if (!priv->iio_active) {
   106			ret = iio_channel_start_all_cb(priv->iio_cb);
   107			if (!ret)
   108				priv->iio_active = true;
   109			else
   110				dev_err(dai->dev, "%s: IIO channel start failed (%d)\n",
   111					__func__, ret);
   112		}
   113	
   114		return ret;
   115	}
   116	
   117	static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
   118					   unsigned int freq, int dir)
   119	{
   120		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
   121		ssize_t size;
   122	
   123		dev_dbg(dai->dev, "%s: Enter for freq %d\n", __func__, freq);
   124	
   125		/* Set IIO frequency if CODEC is master as clock comes from SPI_IN*/
   126		if (dir == SND_SOC_CLOCK_IN) {
   127			char str_freq[10];
   128	
   129			snprintf(str_freq, sizeof(str_freq), "%d\n", freq);
   130			size = iio_write_channel_ext_info(priv->iio_ch, "spi_clk_freq",
   131							  str_freq, sizeof(str_freq));
   132			if (size != sizeof(str_freq)) {
   133				dev_err(dai->dev, "%s: Failed to set SPI clock\n",
   134					__func__);
   135				return -EINVAL;
   136			}
   137		}
   138		return 0;
   139	}
   140	
   141	static const struct snd_soc_dai_ops stm32_adfsdm_dai_ops = {
   142		.shutdown = stm32_adfsdm_shutdown,
   143		.prepare = stm32_adfsdm_dai_prepare,
   144		.set_sysclk = stm32_adfsdm_set_sysclk,
   145	};
   146	
   147	static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
   148		.capture = {
   149			    .channels_min = 1,
   150			    .channels_max = 1,
   151			    .formats = SNDRV_PCM_FMTBIT_S32_LE,
   152			    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
   153				      SNDRV_PCM_RATE_32000),
   154			    },
   155		.ops = &stm32_adfsdm_dai_ops,
   156	};
   157	
   158	static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
   159		.name = "stm32_dfsdm_audio",
   160	};
   161	
   162	static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
   163	{
   164		struct stm32_adfsdm_priv *priv = private;
   165		struct snd_soc_pcm_runtime *rtd = priv->substream->private_data;
   166		u8 *pcm_buff = priv->pcm_buff;
   167		u8 *src_buff = (u8 *)data;
   168		unsigned int buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
   169		unsigned int period_size = snd_pcm_lib_period_bytes(priv->substream);
   170		unsigned int old_pos = priv->pos;
   171		unsigned int cur_size = size;
   172	
 > 173		dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
   174			__func__, &pcm_buff[priv->pos], priv->pos, size);
   175	
   176		if ((priv->pos + size) > buff_size) {
   177			memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
   178			cur_size -= buff_size - priv->pos;
   179			priv->pos = 0;
   180		}
   181	
   182		memcpy(&pcm_buff[priv->pos], &src_buff[size - cur_size], cur_size);
   183		priv->pos = (priv->pos + cur_size) % buff_size;
   184	
   185		if (cur_size != size || (old_pos && (old_pos % period_size < size)))
   186			snd_pcm_period_elapsed(priv->substream);
   187	
   188		return 0;
   189	}
   190	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
