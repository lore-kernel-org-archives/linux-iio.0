Return-Path: <SRS0=YjWr=ZG=intel.com=fengguang.wu@kernel.org>
Date: Tue, 24 Jan 2017 10:14:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: kbuild-all@01.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, arnaud.pouliquen@st.com,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [alsa-devel] [PATCH 5/7] ASoC: dmaengine_pcm: add copy support
Message-ID: <201701241000.457WwRYd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <1485189145-29576-6-git-send-email-arnaud.pouliquen@st.com>
List-ID: <linux-iio@vger.kernel.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi olivier,

[auto build test WARNING on iio/togreg]
[cannot apply to asoc/for-next ljones-mfd/for-mfd-next v4.10-rc5 next-20170123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170124-065537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> include/sound/dmaengine_pcm.h:152: warning: No description found for parameter 'copy'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'id[64]'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_root'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_info_entry'
   include/sound/core.h:323: warning: No description found for parameter '...'
   include/sound/core.h:334: warning: No description found for parameter '...'
   include/sound/core.h:387: warning: No description found for parameter '...'

vim +/copy +152 include/sound/dmaengine_pcm.h

28c4468b Lars-Peter Clausen 2013-04-15  136  struct snd_dmaengine_pcm_config {
28c4468b Lars-Peter Clausen 2013-04-15  137  	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
28c4468b Lars-Peter Clausen 2013-04-15  138  			struct snd_pcm_hw_params *params,
28c4468b Lars-Peter Clausen 2013-04-15  139  			struct dma_slave_config *slave_config);
553a8492 olivier moysan     2017-01-23  140  	int (*copy)(struct snd_pcm_substream *substream, int channel,
553a8492 olivier moysan     2017-01-23  141  		    snd_pcm_uframes_t pos,
553a8492 olivier moysan     2017-01-23  142  		    void __user *buf, snd_pcm_uframes_t count);
c999836d Lars-Peter Clausen 2013-04-15  143  	struct dma_chan *(*compat_request_channel)(
c999836d Lars-Peter Clausen 2013-04-15  144  			struct snd_soc_pcm_runtime *rtd,
c999836d Lars-Peter Clausen 2013-04-15  145  			struct snd_pcm_substream *substream);
c999836d Lars-Peter Clausen 2013-04-15  146  	dma_filter_fn compat_filter_fn;
194c7dea Stephen Warren     2013-12-03  147  	struct device *dma_dev;
194c7dea Stephen Warren     2013-12-03  148  	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
28c4468b Lars-Peter Clausen 2013-04-15  149  
28c4468b Lars-Peter Clausen 2013-04-15  150  	const struct snd_pcm_hardware *pcm_hardware;
28c4468b Lars-Peter Clausen 2013-04-15  151  	unsigned int prealloc_buffer_size;
28c4468b Lars-Peter Clausen 2013-04-15 @152  };
28c4468b Lars-Peter Clausen 2013-04-15  153  
28c4468b Lars-Peter Clausen 2013-04-15  154  int snd_dmaengine_pcm_register(struct device *dev,
28c4468b Lars-Peter Clausen 2013-04-15  155  	const struct snd_dmaengine_pcm_config *config,
28c4468b Lars-Peter Clausen 2013-04-15  156  	unsigned int flags);
28c4468b Lars-Peter Clausen 2013-04-15  157  void snd_dmaengine_pcm_unregister(struct device *dev);
28c4468b Lars-Peter Clausen 2013-04-15  158  
21585ee8 Lars-Peter Clausen 2013-11-28  159  int devm_snd_dmaengine_pcm_register(struct device *dev,
21585ee8 Lars-Peter Clausen 2013-11-28  160  	const struct snd_dmaengine_pcm_config *config,

:::::: The code at line 152 was first introduced by commit
:::::: 28c4468b00a1e55e08cc20117de968f7c6275441 ASoC: Add a generic dmaengine_pcm driver

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKmvhlgAAy5jb25maWcAjDzZcuO2su/nK1jJfZhU3cxie3ycuuUHCAQlRCTBIUBJ9gtL
I2tmVLElHy3JzN/fboAUt4bmpCqJhW6svTca/PVfvwbsdNy9LI+b1fL5+Ufwdb1d75fH9VPw
ZfO8/r8gVEGqTCBCad4CcrzZnr6/21zf3QY3b/94+/73/epjMF3vt+vngO+2XzZfT9B7s9v+
61fA5iqN5Li8vRlJE2wOwXZ3DA7r47+q9sXdbXl9df+j9bv5IVNt8oIbqdIyFFyFIm+AqjBZ
YcpI5Qkz97+sn79cX/2Oq/qlxmA5n0C/yP28/2W5X3179/3u9t3KrvJg91A+rb+43+d+seLT
UGSlLrJM5aaZUhvGpyZnXAxhSVI0P+zMScKyMk/DEnauy0Sm93eX4Gxx/+GWRuAqyZj56Tgd
tM5wqRBhqcdlmLAyFunYTJq1jkUqcslLqRnCh4DJXMjxxPR3xx7KCZuJMuNlFPIGms+1SMoF
n4xZGJYsHqtcmkkyHJezWI5yZgTQKGYPvfEnTJc8K8ocYAsKxvhElLFMgRbyUTQYdlFamCIr
M5HbMVguWvuyh1GDRDKCX5HMtSn5pEinHryMjQWN5lYkRyJPmeXUTGktR7HooehCZwKo5AHP
WWrKSQGzZAnQagJrpjDs4bHYYpp4NJjDcqUuVWZkAscSggzBGcl07MMMxagY2+2xGBi/I4kg
mWXMHh/KsfZ1L7JcjUQLHMlFKVgeP8DvMhEturuZchUy06JGNjYMTgPYciZifX/VYEe1OEoN
8v3uefP53cvu6fS8Prz7nyJliUDeEEyLd297AizzT+Vc5S0ijQoZh3AkohQLN5/uSK+ZAIvg
YUUK/lMaprGzVWBjqw2fUWmdXqGlHjFXU5GWsEmdZG2VJU0p0hkcE648keb++rwnngPtrZhK
oP8vvzTqsWorjdCUlgTCsHgmcg381enXBpSsMIrobAViCuwp4nL8KLOeqFSQEUCuaFD82FYL
bcji0ddD+QA3DaC7pvOe2gtqb6ePgMu6BF88Xu6tLoNviKMEpmRFDHKqtEEOvP/lzXa3Xf/W
ooh+0DOZcXJsR38QCpU/lMyANZmQeNGEpWEsSFihBahNH5mtcLICLDWsA1gjrrkYRCI4nD4f
fhyO65eGi8/KHyTGSjJhFwCkJ2re4nFoAbPLQbs4uemoF52xXAtEato4mlStCugDaszwSaj6
CqmN0tUQbcgMbEaIJiNmqIkfeEys2Mr5rDmAvt3B8UDbpEZfBKKpLVn4Z6ENgZcoVH64lvqI
zeZlvT9Qpzx5RDsiVSh5m9FThRDpo7QFk5AJ2GNQftruNNdtHOdzZcU7szz8FRxhScFy+xQc
jsvjIViuVrvT9rjZfm3WZiSfOiPJuSpS42h5ngppbc+zAQ+my3kR6OGuAfehBFh7OPgJGhgO
g9JyuoeMWlhjF/IQcChwyOIYlWeiUhLJ5EJYTOu1ecfBJYHMiHKklCGxrAEB1yq9okVbTt0f
PsEswJV1dgfcltCxWXuvfJyrItO02pgIPs2UBPMPRDcqpzfiRkYjYMeiN4ueFr3BeArqbWYN
WB4S2+D87FWg9CNHW9875aKzkR4aOmfEaCwFgyVTcOl1z1IUMvzQigFQjE0MFOIis+6VpWSv
T8Z1NoUlxczgmhqo47X2+hLQ3xKUaE6fIXhVCbBdWWkPGulBR/oixhQA+iGhyZnlQMmph8vG
dJfu/ui+4AmVUeFZUVQYsSAhIlO+fcpxyuIopCULVY8HZvWnBzbKosuHOwH7SEKYpC02C2cS
tl4NSp85Etyabs+qYM4Ry3PZZYt6OxgjhCLsMx0MWZ7tiNWEVRScrfdfdvuX5Xa1DsTf6y2o
XgZKmKPyBRPRqMjuEOfVVD45AmHh5Syxrjm58Fni+pdWO/eMQce9xMgwp9lOx4zyKHRcjNrL
0rEaefuXEahadNXLHJwXRZMQaGQgOET7XoLXKiPJbczkkRMVybhncNoEUA6jpQzqljJNpOPQ
9vr/LJIMHIeRoDmvCmVoi4vz2RwGRLQgFqhoORda+9YmItibRMJAqNLp0fN7kMBoXMBaliM9
Z333XIK6xwAfFmd6oGk/9nKtuTAkANQy3cG1YigTUcoVzrLXYhduUSdKTXtAzDHAbyPHhSoI
DwvCJevzVL4jEeRCUPoA3jV6clYV2xxQb5ZcjDUYkdDlZKqjLVnWXyquBlqdSPVgkzlIhGDO
tPZgiVwAxRqwtjP2TRVoFWg3RZ6Ct2aAndsJqr6SIA7SQomBa9HPq+2FRdLnC3taDUcPMiSO
cKVmkQBnNcN8TH+Eii3d+doUQA+j6ueiTA8sVIUnmQFRUOligTpyJXagBUflVILUmsHhjcGZ
yOJiLNOOemw1+8QPMOzJodQIDi5Tz0XpAmlvp4sDBE77jk4PAwhZxIx2LIbYcOzKr9vcMUoz
AbXgeCDKIeDsMwrhnntkNcW4TFQ5pi6tExUWMSgAVEUiRoYcspN2EKvah+m2YT6zhyAWoDlJ
ge/2uutSUWUPdWrGxB0eaKaFtdFRNCY0R4VVChSBY6AnOE18Omd52FqvAj8fPJ8qXXc9ADCb
j+5wAkRPEKw1Kj+KLlgRu+gZ7trSdRBNjbma/f55eVg/BX85d+J1v/uyee5EbWeqIHZZW71O
uOskqFK6TilPBHJAKyuGLqNG7+L+Q8sXcuxAnFnNKDaqikH1F53EzQiDGqKbTUHCRBnwcpEi
Ujc7UMEtmR38EozsO88xevN0bgO7vbu5TGYUGp08mfcwUDA+FaJAZQmbsPkIP0o+rxEa7xsO
7LHrW1paZ/vdan047PbB8ceri9S/rJfH0359aF+ePCKrhp5sF9hTsh3zt5FgYJzAEqDq8GNh
LqVGxQwkjToGAYikR9hwHLEwIDGYNL8Up1R5ZZlLehoXxgIljFN5pbW/nnht8gCmEtx/0Kfj
gs6dgmRiVO9S0Q2T39zd0pHAxwsAo2kvHGFJsqBE5tZeaDWYoFQg/kykpAc6gy/D6aOtoTc0
dOrZ2PTfnvY7up3nhVZ0DiKxSlB4PPpkLlM+Ab/As5AKfO2L0WLmGXcsVCjGiw8XoGVMh78J
f8jlwnveM8n4dUnnoS3Qc3Yc3HZPL1QzXsmoFLbnptQKAiZNqusvPZGRuf/YRok/9GCd4TMw
FSDqKadyMoiAeswi2aSTLlq5FASDAHQbKjfw9qbfrGbdlkSmMikSaywjcO7jh+66rYPOTZzo
jq8GS0HPHv0lEYPjRFlyGBF0uD2clv2rmy19O3fMNYQlIYEOIsSKfAiwPlQiIHKlxioS7tob
1ZQJ42JQkthhQnklqb1t1GCOz/sXIsnMwPus22cqBreP5XRSr8LychseQiZpnWaJ1uUTZ7Na
yY2X3XZz3O2da9LM2op54IxBgc89h2AZVoBL9QAekUfvegFGAYuPaKMo7+hMB06YC7QHkVz4
8q3gBADXgZT5z0X79wP0k7QCSxUm7nvprZpbHOSmk3yvGm9vqDBhlugsBiN53enStGK87zlQ
h3JF5xob8E9H+ECty96UK3CBhbl//52/d//09tnzniJwGKC1FCkjLs5tEOkHW71Q36qBi9pW
AjJG9oprHwLvjwpxf17Nxb71ohKWFjb8bVyU84ocjDiFqnN3tNKqbtevFc83w0FEYGRLw7pU
hEhGXb+201wN2h7QFb5IzSGyaXfvBiKVV+QuvdMeu5+XhnTOjJ3IaqabXlaR+/N3kweQ/zDM
S+Mt/5nJHJSkwjitcwWsKRmpb19tyOgu58L8/ub9H7ftC59hpEvp2XZtx7TjGfJYsNSaUDqQ
97jhj5lSdF7xcVTQ+uBRDxO7ta9dxW22kqLOAfpLOCKR591Mjr3H6euSzPhVmrX3EIQrLFDI
8yLr07WjQTV43RgCzu9vWwyRmJzWi3a9F/LCOCgchj+QsbYd/Fvah6uSSHSE8Fh+eP+e0riP
5dXH950jeiyvu6i9Uehh7mGYfvgyyfFelb4bEgvhKw9gemJzfZRaBWmSHFQZ6IgcNeuHSrG2
7/YUZ/aW8VJ/m/aD/le97tUdwSzU9DULT0IbTY98fA7qU0YPZRwa6oKnzQlOj9dqd6IMZvPq
O5Rs9896H4B/sfy6fllvjzYqZjyTwe4Vqwo7kXGVpaH1j+cOIuo4XvWFeRDt1/85rberH8Fh
tXzuuTTWa83FJ7KnfHpe95G9t/r2AFD96DMe3t1ksQgHg49Oh3rTwZuMy2B9XL39reNqcTpu
qXJfVDLGlflVqfJ2B080joxCglTsKXMBDqPlNBXm48f3dJSWcbRWfu3woKPR4IDE9/XqdFx+
fl7bUtXAOqbHQ/AuEC+n5+WAXUZg6xKDqUz6btKBNc9lRlkrl79TRUexVp2w+dKgifTkDjBS
9Mi8m89lpaRyFqB9mIPzCNd/b8AtD/ebv909Y1PBtllVzYEailHh7hAnIs584YqYmSTz5DVB
JaUhw4SqLwqxw0cyT+Zgml0xBYkazcGosNCzCLSWc1ulQB1aa614fRrmcubdjEUQs9yTFXMI
mAqrhgHlChGtp+4C3JwmD0WnzuqqIZB4mFZyMr3axsIyjrogqxUzMlcZGsIRRhGRUESN8WSZ
oEPfxNDHrSJiGS4tjyW/5wJfcKiqaueGqK5psIJkc1hRSwBqJQ+YfSUXIlIeK435R/Qs+ufT
HHXOaKXOr8jFCAFnmASH0+vrbn9sL8dByj+u+eJ20M2svy8PgdwejvvTi72+P3xb7tdPwXG/
3B5wqAAMxDp4gr1uXvHPWtTY83G9XwZRNmagkfYv/0C34Gn3z/Z5t3wKXPlqjSu3x/VzALJt
qeaEs4ZpLiOieaYyorUZaLI7HL1Avtw/UdN48Xev5/S0Pi6P6yBpjPIbrnTyW1/T4PrOwzVn
zScel2IR2zsIL5BFRS2AKvNe9snwXIOnuZYV97WofrZlWqKX0gnlsM2XWk8YB8dToVNmFzGs
tJPb19NxOGFjVtOsGLLlBChhOUO+UwF26fo0WCr438mlRe1cjbJEkJLAgYGXK2BOSjaNodNH
oKp8xTgAmvpgMktk6UpYPVn7+aVgIJ35pDzjd/++vv1ejjNPKVCquR8IKxq7KMeflTMc/vU4
jhCB8P4Nl2OCK07S3lMqqDPaZ9NZQgMmeuixZiAOxJxZNuRRbKue9OxsfWrdy0FNFqyed6u/
+gCxtX4VxA1Yb4xOOHgcWFWPoYQ9QjD7SYb1OccdzLYOjt/WwfLpaYPuxfLZjXp4214e0qZX
vXyGzT1+ISYPSzbz1NJZKMajtPPl4BgpxzSLT+be0tGJyBNGhzp1DTOVMdGj9hMPp5V2283q
EOjN82a12waj5eqv1+flthM0QD9itBEHk98fbrQHY7LavQSH1/Vq8wU8O5aMWMfP7WUpnGU+
PR83X07bFdKn1llPZwXeaL0otP4VrRIRmCtdemJYhIvFQwoYcca05x7coEsB4ei1d4ypSDKP
j4jgxNxe/+G5egGwTnxhBhstPr5/f3l/GL36brAAbGTJkuvrjwu8DWGh/xxM4tFErlDEeJzF
RISS1dmdARXH++XrN+QmQvrD7pWr80h4Frxhp6fNDgz6+b75t8FLPYsc7Zcv6+Dz6csXMBTh
0FBEtOhiFUVsDVPMQ2rlTeZ4zDDH6XGkVZFSlccFiJSacFnG0hgIlyHgl6xVTYTwwXs8bDxX
SUx4x+gXehhKYpv17J66Lg22Z99+HPBtZBAvf6AFHcoMzgZqkTZKKrPwBRdyRmIgdMzCsUeJ
IbiIM9mP6BuEOU2XJPEwp0i0Nz+VCojBREjP5Ors5EgCKR4IUomQ8TpihTC6aD1Qs6CGTI13
CO3ESDnoCDAVTX9sSPiHm9u7D3cVpBEogy83fOoG3Dsi6HIBc8IgkiIzSw8px6o0TxanWIRS
Z75i+sIj+Dbd7fMlZ5s9rILiLuwmFZCzO2wVb632u8PuyzGY/Hhd73+fBV9Pa4gCCPUAkjfu
ldN2cix12QYVojZu+QTiJnHGHW7j7Nzq183WOhY9ieK2Ue9O+479qcePpzrnpby7+tiqvYJW
MTNE6ygOz60NdUwi4jKTtDiBO28dwJInP0FITEHf4Z8xTEI/ThFJhQBy5gktZDxSdJpMqiQp
vAYgX7/sjmsMzShW0UbYe6ykzPHqfNj79eXwtU8RDYhvtH2+E6gtxAqb198a56IX4529D73j
5AqKdCH9kTrMVXrOJLOc10+zNme6MF6zbDPJ9GF6RDGbU1dMDLh/DLorYYsyzdtVcTLDIkyf
BrYeqC17zlXsC3uiZEgPNBrtt1ODlJHPqqATni1YeXWXJhgh0Jq+gwV2hGZncBfLqUqZxfDP
iL4091zSJHxoUolKAUot5WyoRNj2ab/bPLXRIGDMle9m3RunauOJUe2FkpkMZrapm45zBPQZ
rNliDbrWCZ9wKBUi9CQ865wobMB3ARaKOC7zEa1pQh6OmK9gT41jcZ6CWC/Ed47zWgo4dOVD
EOm1Xiw069UYjsgFgOjQSCxQawGau5xWnhoLW6+KGD6DFGlbUe9JTFyASQcrvW+8Inah96dC
GToZZCHc0LvGdG2kb0pPgjzCsioPTIEzAH5ED+x4Z7n61nPA9eBm2onaYX162tlLkIagjeSC
JfBNb2F8IuMwF7RyxRfRvsQ/voSjQzz3fYLL0LJ/O994GfZ/wEWeAfA2xfKQe1FEI6Xx8Eir
F1rfIATvPoO1X/WQ+acoZmPd8lNtr9f9Znv8yyZBnl7WYEAbh/FsgbTGa/cYRW4GqqUqVri/
qUi5e3kF4vxuX+QCVVd/HexwK9e+p1xQdwuB5Rm0pLlbVBBt/DpKlgsOgZXnQV514VrYz1cI
skrbFdviaPcf3l/dtFVoLrOS6aT0PmnE8mw7A9O0ui1SkACMrJOR8jzRc3VD8/TinU1EJoEF
3hhpt7PhOzot3BdkgGcSzNvQnNxDcseq0piKcpo3Lp0K5V7J989ql6sdKfsoXrBpXY/i8RfR
LQFu716gdIZyny6oeTYBP3H/A6L4z6evX/sVenjWtlxb+6p3et8F8ZMMtqhV6lPjbhg1+hPO
15vAr5YPJjCGcxhSsIZcmMG9kSm0T6E4rJkvmW2BEGUVnoSfw6gKFrC05gLWhSK/ZrN2vaj6
o9h+WoHaTg32jWTZEM9mwPjnxksnNuldxlU3yMAuQQwR2unVaajJcvu1o5bQahcZjDJ8PNWa
AoGg51P3jJ/Oon4iE6kt9kqB50EoFX3504H3S/scEIMwvK8fFOh4taoDO3bCz/X87BhxhqkQ
GfVhBDzGRgCDN4cqIj78b/ByOq6/r+EPLOl42y3qqOhTvTS5xI/4qPviFfZ87pDw7e48Y4ZW
fg7X+msXhD1Xs8sumx0A03sXJqlzQzEc2U/WAtPYp5taxJH/VYqdFNjw/HjFEwbUX+66MOnU
qalLy5Ke8SttKX+GoS9pyfoJ6SWC8lyE+MiDEb4NfimDVveWdL4PaVQfbMHvYFwyVz89YzsA
ln5fxPivhvnJ1zo+VZ+tusT41SdqytxvU+vzLkWeqxxUwp/CX83qSk9JnNrHOb/X9Xwizirt
qEh58x2L/ovXM3Sc/38fV9PcJgxE/0p/gl13Or0iAYkaIjMgOiYXJu34kFNn3OSQf9/9wAjE
ro72W2wBq9Vqte8V7aNscydHi2TtLUgMUolgPMPPRBoFAwu7vcRk7uHjMTAHOqUAzxfyr0QQ
r8DJKxR7692bZc9FVRpIjMP133viu9SEQ7oCvXaoYOIjR5Kq7lmGiIsqzrHp+7cl4sjzAAf0
WF3U9iMywKTZP8wdVfKEJrsnMAxKHZAMSC1Eblcj3Lig1Q0IHzQ2AqEdsmd3LaPJvWoE2w23
PjOCUhWdgTRFD9nFcyvTUFfJz0O5OQfAz1q+judAg+kLD78MCRzq0zBfNr7/KEDAhv48eU1Q
hSxy/8XNE5PruW2t2radgHtAfpRpsMCCPOR/5txzp74i6MMN4hlJGSrsB3RW/dAz2mQiKgv3
6bNnjruyK7NKAMXQXC7VmLoZNDo3V8VhCuuqG3hCogRfd2aZySmMbTUdLj8OMVdMMXhXRxlj
X44qhVuUSFqnHUZ/tu61jYCyX18sMnNnsfFJ3+XySOclaz3EdSJs2yIzdRcRp7uAZOa9QUKi
VN8XZt9UK4twO6BiIobe/WD4cOL65+P29v4pVUieqlEpTFV26FwYIUZVPZXnacJlbeXaAgmF
FB0kXbAtwCWeRAkoTS5YV2IXlXbmW+pNAmZeXbyLYkUKStGtkGQ3thkVyF8bqsu843UvugiP
cb7oRmEV4g3O2+/b6+3zy+3vB6zb11U9bFF7CZ238MBq7LbEWxYEYcCkqbyC1s7f9VmNE4T4
WuuW3ugEUr8W1C2IA0/aYG3jtrJBtrOTtS7I3gPoUeYn4nXheCidvHoj7ALkuhp6kg9rAJEb
Xxpn6CqNXGJlOjepRc4ajEwBETjIMYeivr3T13yOdHlBveYMNBn7U3TSHt/amjfHX2Es33Lc
aIklXdJV0bgrlWGXpbypId1LVf9s5r9pYMr4Sn2qx9PywnnB3XChmmitA/A/4TbttoJbAAA=

--mP3DRpeJDSE+ciuQ--
