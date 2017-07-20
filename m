Return-Path: <SRS0=Hj2D=6X=pengutronix.de=p.zabel@kernel.org>
Message-ID: <1500555312.2354.75.camel@pengutronix.de>
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Prashant
 Gaikwad <pgaikwad@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, Peter Chen
 <Peter.Chen@nxp.com>,  Linus Walleij <linus.walleij@linaro.org>,
 dri-devel@lists.freedesktop.org, Marc Dietrich <marvin24@gmx.de>,  Rakesh
 Iyer <riyer@nvidia.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 linux-clk@vger.kernel.org,  Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang
 <wsa@the-dreams.de>, Xinliang Liu <z.liuxinliang@hisilicon.com>, Chanwoo
 Choi <cw00.choi@samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Jiri
 Slaby <jslaby@suse.com>, Michael Turquette <mturquette@baylibre.com>,
 Guenter Roeck <linux@roeck-us.net>, Ohad Ben-Cohen <ohad@wizery.com>,
 linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,  Vincent
 Abriou <vincent.abriou@st.com>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-spi@vger.kernel.org, linux-crypto@vger.kernel.org,  Tejun Heo
 <tj@kernel.org>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Philippe
 Cornu <philippe.cornu@st.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Laxman
 Dewangan <ldewangan@nvidia.com>, Corentin Labbe
 <clabbe.montjoie@gmail.com>,  linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Lars-Peter Clausen <lars@metafoo.de>,
  Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Ben Skeggs <bskeggs@redhat.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, linux-media@vger.kernel.org, Richard Zhu
 <hongxing.zhu@nxp.com>, Alexandre Torgue <alexandre.torgue@st.com>, Mathias
 Nyman <mathias.nyman@intel.com>, linux-arm-msm@vger.kernel.org, Joachim
 Eastwood <manabian@gmail.com>, linux-gpio@vger.kernel.org,
 linux-mips@linux-mips.org,  Bjorn Helgaas <bhelgaas@google.com>, Giuseppe
 Cavallaro <peppe.cavallaro@st.com>,  linux-arm-kernel@lists.infradead.org,
 Patrice Chotard <patrice.chotard@st.com>,  Stanimir Varbanov
 <svarbanov@mm-sol.com>, Kyungmin Park <kyungmin.park@samsung.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org, Shawn Lin
 <shawn.lin@rock-chips.com>, linux-tegra@vger.kernel.org,
 linux-mtd@lists.infradead.org, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>,  Florian Fainelli <f.fainelli@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Xinwei Kong
 <kong.kongxinwei@hisilicon.com>,  ath10k@lists.infradead.org, Kishon Vijay
 Abraham I <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Chen Feng
 <puck.chen@hisilicon.com>, Mark Brown <broonie@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Felipe Balbi <balbi@kernel.org>, Salil Mehta
 <salil.mehta@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Thierry
 Reding <thierry.reding@gmail.com>, Cyrille Pitchen
 <cyrille.pitchen@wedev4u.fr>,  Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Maxime Ripard
 <maxime.ripard@free-electrons.com>, Brian Norris
 <computersforpeace@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 linux-remoteproc@vger.kernel.org, Bjorn Andersson
 <bjorn.andersson@linaro.org>,  linux-ide@vger.kernel.org, Lee Jones
 <lee.jones@linaro.org>,  devel@driverdev.osuosl.org, Yannick Fertre
 <yannick.fertre@st.com>, Ryder Lee <ryder.lee@mediatek.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>, Jaehoon
 Chung <jh80.chung@samsung.com>, Marek Vasut <marek.vasut@gmail.com>,
 linux-serial@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Alan Tull
 <atull@kernel.org>, John Youn <johnyoun@synopsys.com>, Eduardo Valentin
 <edubezval@gmail.com>, dmaengine@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>,  Mark Yao <mark.yao@rock-chips.com>, Moritz
 Fischer <moritz.fischer@ettus.com>, Vivien Didelot
 <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org, Peter De
 Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Rongrong Zou <zourongrong@gmail.com>, linux-fpga@vger.kernel.org, David
 Woodhouse <dwmw2@infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 20 Jul 2017 14:55:12 +0200
In-Reply-To: <20170720123640.43c2ce01@windsurf>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
	 <20170719211515.46a1196c@windsurf>
	 <1500543415.2354.37.camel@pengutronix.de>
	 <20170720123640.43c2ce01@windsurf>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Thomas,

On Thu, 2017-07-20 at 12:36 +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 20 Jul 2017 11:36:55 +0200, Philipp Zabel wrote:
> 
> > > I don't know if it has been discussed in the past, so forgive me if it
> > > has been. Have you considered adding a "int flags" argument to the
> > > existing reset_control_get_*() functions, rather than introducing
> > > separate exclusive variants ?
> > > 
> > > Indeed, with a "int flags" argument you could in the future add more
> > > variants/behaviors without actually multiplying the number of
> > > functions. Something like the "flags" argument for request_irq() for
> > > example.  
> > 
> > I can't find the discussion right now, but I remember we had talked
> > about this in the past.
> > Behind the scenes, all the inline API functions already call common
> > entry points with flags (well, currently separate bool parameters for
> > shared and optional).
> > One reason against exposing those as an int flags in the user facing API
> > is the possibility to accidentally provide a wrong value.
> 
> This is a quite strange argument. You could also accidentally use the
> wrong variant of the function, just like you could use the wrong flag.

You can't accidentally use no flag at all or a completely bogus value
with the "plethora of inline functions" variant.

> Once again, the next time you have another parameter for those reset
> functions, beyond the exclusive/shared variant, you will multiply again
> by two the number of functions ? You already have the  exclusive/shared
> and optional/mandatory variants, so 4 variants. When you'll add a new
> parameter, you'll have 8 variants. Doesn't seem really good.

I'd rather avoid adding more variants, if possible. The complexity
increases regardless of whether the API is expressed as a bunch of
functions or as a single function with a bunch of flags.

> What about reset_control_get(struct device *, const char *, int flags)
> to replace all those variants ?

While I like how this looks, unfortunately (devm_)reset_control_get
already exists without the flags, so we can't change to that with a
gentle transition.

regards
Philipp
