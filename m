Return-Path: <SRS0=1LQb=6X=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 20 Jul 2017 10:11:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Alan Tull <atull@kernel.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Andrew Lunn <andrew@lunn.ch>, Ben Skeggs <bskeggs@redhat.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Bin Liu <b-liu@ti.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen Feng <puck.chen@hisilicon.com>, Chen-Yu Tsai <wens@csie.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	David Airlie <airlied@linux.ie>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Felipe Balbi <balbi@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Heiko Stuebner <heiko@sntech.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jiri Slaby <jslaby@suse.com>, Joachim Eastwood <manabian@gmail.com>,
	John Youn <johnyoun@synopsys.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marc Dietrich <marvin24@gmx.de>,
	Marek Vasut <marek.vasut@gmail.com>,
	Mark Brown <broonie@kernel.org>, Mark Yao <mark.yao@rock-chips.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Peter Chen <Peter.Chen@nxp.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Philippe Cornu <philippe.cornu@st.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Rakesh Iyer <riyer@nvidia.com>, Ralf Baechle <ralf@linux-mips.org>,
	Richard Weinberger <richard@nod.at>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Rongrong Zou <zourongrong@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Tejun Heo <tj@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Abriou <vincent.abriou@st.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Xinliang Liu <z.liuxinliang@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Zhang Rui <rui.zhang@intel.com>, alsa-devel@alsa-project.org,
	ath10k@lists.infradead.org, devel@driverdev.osuosl.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
Message-ID: <20170720081157.GA11630@kroah.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 19, 2017 at 05:25:04PM +0200, Philipp Zabel wrote:
> The reset control API has two modes: exclusive access, where the driver
> expects to have full and immediate control over the state of the reset
> line, and shared (clock-like) access, where drivers only request reset
> deassertion while active, but don't care about the state of the reset line
> while inactive.
> 
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior.
> 
> This series converts all drivers that currently implicitly request
> exclusive reset controls to the corresponding explicit API call. It is,
> for the most part, generated from the following semantic patch:

Hey, I'm all for large api changes, but this really seems ackward, isn't
there a "better" way to do this?

Why not, as you say the "implicit" request is exclusive, just leave
everything alone and state that the "reset_control_get()" call is
exclusive and make the shared one the "odd" usage as that seems to not
be the normal case.

That should be a much smaller patch right?

That way you don't break everything here, and require 100+ patches to
just change the name of a function from one to another and do nothing
else.

thanks,

greg k-h
