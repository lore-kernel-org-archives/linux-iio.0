Return-Path: <SRS0=Yt+1=7Q=pengutronix.de=p.zabel@kernel.org>
Message-ID: <1502696198.2287.7.camel@pengutronix.de>
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, lkml <linux-kernel@vger.kernel.org>,
  Andrew Lunn <andrew@lunn.ch>, Prashant Gaikwad <pgaikwad@nvidia.com>,
 Heiko Stuebner <heiko@sntech.de>,  Peter Chen <Peter.Chen@nxp.com>, DRI
 <dri-devel@lists.freedesktop.org>, Marc Dietrich <marvin24@gmx.de>,  Rakesh
 Iyer <riyer@nvidia.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 linux-clk <linux-clk@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
 Xinliang Liu <z.liuxinliang@hisilicon.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby
 <jslaby@suse.com>, Michael Turquette <mturquette@baylibre.com>, Guenter
 Roeck <linux@roeck-us.net>, Ohad Ben-Cohen <ohad@wizery.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>, Vincent Abriou <vincent.abriou@st.com>, Bin Liu
 <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list
 <linux-usb@vger.kernel.org>, linux-wireless
 <linux-wireless@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 linux-spi <linux-spi@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, David Airlie
 <airlied@linux.ie>,  nouveau@lists.freedesktop.org, Philippe Cornu
 <philippe.cornu@st.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Laxman
 Dewangan <ldewangan@nvidia.com>, Corentin Labbe
 <clabbe.montjoie@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Boris Brezillon
 <boris.brezillon@free-electrons.com>,  Lars-Peter Clausen
 <lars@metafoo.de>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Hunter
 <jonathanh@nvidia.com>, "open list:ARM/Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, MyungJoo Ham
 <myungjoo.ham@samsung.com>,  Ben Skeggs <bskeggs@redhat.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Mathias Nyman
 <mathias.nyman@intel.com>,  "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, Joachim Eastwood <manabian@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Patrice Chotard
 <patrice.chotard@st.com>,  Stanimir Varbanov <svarbanov@mm-sol.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan
 Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Benjamin
 Gaignard <benjamin.gaignard@linaro.org>, Florian Fainelli
 <f.fainelli@gmail.com>,  Jonathan Corbet <corbet@lwn.net>, Xinwei Kong
 <kong.kongxinwei@hisilicon.com>,  ath10k@lists.infradead.org, Kishon Vijay
 Abraham I <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Chen Feng
 <puck.chen@hisilicon.com>, Mark Brown <broonie@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Felipe Balbi <balbi@kernel.org>, Salil Mehta
 <salil.mehta@huawei.com>, linux-mmc <linux-mmc@vger.kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Maxime Ripard
 <maxime.ripard@free-electrons.com>, Brian Norris
 <computersforpeace@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 linux-remoteproc@vger.kernel.org, Bjorn Andersson
 <bjorn.andersson@linaro.org>,  "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Yannick Fertre
 <yannick.fertre@st.com>, Ryder Lee <ryder.lee@mediatek.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>, Jaehoon
 Chung <jh80.chung@samsung.com>, Marek Vasut <marek.vasut@gmail.com>,
 linux-serial <linux-serial@vger.kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Alan Tull <atull@kernel.org>,  John Youn
 <johnyoun@synopsys.com>, Eduardo Valentin <edubezval@gmail.com>,
 dmaengine@vger.kernel.org,  "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,  Mark Yao <mark.yao@rock-chips.com>, Moritz
 Fischer <moritz.fischer@ettus.com>, Vivien Didelot
 <vivien.didelot@savoirfairelinux.com>, netdev <netdev@vger.kernel.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>,  Vinod
 Koul <vinod.koul@intel.com>, Rongrong Zou <zourongrong@gmail.com>,
 linux-fpga@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Lucas
 Stach <l.stach@pengutronix.de>
Date: Mon, 14 Aug 2017 09:36:38 +0200
In-Reply-To: <20170812114357.v4ru75dw5hq7wemx@ninjato>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
	 <20170719211515.46a1196c@windsurf>
	 <1500543415.2354.37.camel@pengutronix.de>
	 <20170720123640.43c2ce01@windsurf>
	 <1500555312.2354.75.camel@pengutronix.de>
	 <CAKdAkRTx8jd8UToz5_EgMmdW3V47i2uo++YvVB_yzytqSA=P1Q@mail.gmail.com>
	 <CACRpkdaXOv7mX+b-q1K34CB5w0SWPXCKa21wHaxL7qjf91PJXQ@mail.gmail.com>
	 <1500885221.2391.50.camel@pengutronix.de>
	 <20170812114357.v4ru75dw5hq7wemx@ninjato>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2017-08-12 at 13:43 +0200, Wolfram Sang wrote:
> > Thanks for the hint and the references. It seems this turned out
> > okay,
> > but I wouldn't dare to introduce such macro horror^Wmagic.
> > I'd rather have all users converted to the _exclusive/_shared
> > function
> > calls and maybe then replace the internal __reset_control_get with
> > Thomas' suggestion.
> 
> I didn't follow the discussion closely. Shall I still apply the i2c
> patches?

Yes, please.

regards
Philipp
