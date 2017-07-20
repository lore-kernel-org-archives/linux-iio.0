Return-Path: <SRS0=nsSS=6X=free-electrons.com=maxime.ripard@kernel.org>
Date: Thu, 20 Jul 2017 08:56:42 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20170720065642.rk44kcjkzppg6uqr@flea>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7njpeniu6ypk76n"
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>


--r7njpeniu6ypk76n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 05:25:04PM +0200, Philipp Zabel wrote:
> The reset control API has two modes: exclusive access, where the driver
> expects to have full and immediate control over the state of the reset
> line, and shared (clock-like) access, where drivers only request reset
> deassertion while active, but don't care about the state of the reset line
> while inactive.
>=20
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior.
>=20
> This series converts all drivers that currently implicitly request
> exclusive reset controls to the corresponding explicit API call. It is,
> for the most part, generated from the following semantic patch:
>=20
> @@
> expression rstc, dev, id;
> @@
> -rstc =3D reset_control_get(dev, id);
> +rstc =3D reset_control_get_exclusive(dev, id);
> @@
> expression rstc, dev, id;
> @@
> -rstc =3D reset_control_get_optional(dev, id);
> +rstc =3D reset_control_get_optional_exclusive(dev, id);
> @@
> expression rstc, node, id;
> @@
> -rstc =3D of_reset_control_get(node, id);
> +rstc =3D of_reset_control_get_exclusive(node, id);
> @@
> expression rstc, node, index;
> @@
> -rstc =3D of_reset_control_get_by_index(node, index);
> +rstc =3D of_reset_control_get_exclusive_by_index(node, index);
> @@
> expression rstc, dev, id;
> @@
> -rstc =3D devm_reset_control_get(dev, id);
> +rstc =3D devm_reset_control_get_exclusive(dev, id);
> @@
> expression rstc, dev, id;
> @@
> -rstc =3D devm_reset_control_get_optional(dev, id);
> +rstc =3D devm_reset_control_get_optional_exclusive(dev, id);
> @@
> expression rstc, dev, index;
> @@
> -rstc =3D devm_reset_control_get_by_index(dev, index);
> +rstc =3D devm_reset_control_get_exclusive_by_index(dev, index);
>=20
> After all driver patches are applied, the temporary transition helpers
> can be removed.
>=20
> regards
> Philipp
>=20
> Philipp Zabel (102):
>   ARM: rockchip: explicitly request exclusive reset control
>   ARM: socfpga: explicitly request exclusive reset control
>   MIPS: pci-mt7620: explicitly request exclusive reset control
>   ahci: st: explicitly request exclusive reset control
>   ata: sata_gemini: explicitly request exclusive reset control
>   ata: ahci_tegra: explicitly request exclusive reset control
>   bus: sunxi-rsb: explicitly request exclusive reset control
>   bus: tegra-gmi: explicitly request exclusive reset control
>   clk: sunxi: explicitly request exclusive reset control
>   clk: tegra: explicitly request exclusive reset control
>   clocksource/drivers/timer-stm32: explicitly request exclusive reset
>     control
>   clocksource/drivers/sun5i: explicitly request exclusive reset control
>   crypto: rockchip: explicitly request exclusive reset control
>   crypto: sun4i-ss - request exclusive reset control
>   PM / devfreq: tegra: explicitly request exclusive reset control
>   dmaengine: stm32-dma: explicitly request exclusive reset control
>   dmaengine: sun6i: explicitly request exclusive reset control
>   dmaengine: tegra-apb: explicitly request exclusive reset control
>   drm: kirin: explicitly request exclusive reset control
>   drm/nouveau/tegra: explicitly request exclusive reset control
>   drm/rockchip: explicitly request exclusive reset control
>   drm/sti: explicitly request exclusive reset control
>   drm/stm: explicitly request exclusive reset control
>   drm/sun4i: explicitly request exclusive reset control
>   drm/tegra: explicitly request exclusive reset control
>   gpu: host1x: explicitly request exclusive reset control
>   i2c: mv64xxx: explicitly request exclusive reset control
>   i2c: stm32f4: explicitly request exclusive reset control
>   i2c: sun6i-pw2i: explicitly request exclusive reset control
>   i2c: tegra: explicitly request exclusive reset control
>   iio: adc: rockchip_saradc: explicitly request exclusive reset control
>   iio: dac: stm32-dac-core: explicitly request exclusive reset control
>   Input: tegra-kbc - request exclusive reset control
>   coda: explicitly request exclusive reset control
>   st-rc: explicitly request exclusive reset control
>   stm32-dcmi: explicitly request exclusive reset control
>   rc: sunxi-cir: explicitly request exclusive reset control
>   mmc: dw_mmc: explicitly request exclusive reset control
>   mmc: sdhci-st: explicitly request exclusive reset control
>   mmc: sunxi: explicitly request exclusive reset control
>   mmc: tegra: explicitly request exclusive reset control
>   mtd: nand: sunxi: explicitly request exclusive reset control
>   mtd: spi-nor: stm32-quadspi: explicitly request exclusive reset
>     control
>   net: dsa: mt7530: explicitly request exclusive reset control
>   net: ethernet: hisi_femac: explicitly request exclusive reset control
>   net: ethernet: hix5hd2_gmac: explicitly request exclusive reset
>     control
>   net: stmmac: explicitly request exclusive reset control
>   net: stmmac: dwc-qos: explicitly request exclusive reset control
>   ath10k: explicitly request exclusive reset control
>   nvmem: lpc18xx-eeprom: explicitly request exclusive reset control
>   PCI: dwc: pcie-qcom: explicitly request exclusive reset control
>   PCI: imx6: explicitly request exclusive reset control
>   PCI: tegra: explicitly request exclusive reset control
>   PCI: rockchip: explicitly request exclusive reset control
>   phy: berlin-usb: explicitly request exclusive reset control
>   PCI: mediatek: explicitly request exclusive reset control
>   phy: qcom-usb-hs: explicitly request exclusive reset control
>   phy: rockchip-pcie: explicitly request exclusive reset control
>   phy: rockchip-typec: explicitly request exclusive reset control
>   phy: rockchip-usb: explicitly request exclusive reset control
>   phy: sun4i-usb: explicitly request exclusive reset control
>   phy: sun9i-usb: explicitly request exclusive reset control
>   phy: tegra: explicitly request exclusive reset control
>   phy: qcom-qmp: explicitly request exclusive reset control
>   phy: qcom-qusb2: explicitly request exclusive reset control
>   pinctrl: stm32: explicitly request exclusive reset control
>   pinctrl: sunxi: explicitly request exclusive reset control
>   pinctrl: tegra: explicitly request exclusive reset control
>   pwm: hibvt: explicitly request exclusive reset control
>   pwm: tegra: explicitly request exclusive reset control
>   remoteproc/keystone: explicitly request exclusive reset control
>   remoteproc: qcom: explicitly request exclusive reset control
>   remoteproc: st: explicitly request exclusive reset control
>   soc: mediatek: PMIC wrap: explicitly request exclusive reset control
>   soc/tegra: pmc: explicitly request exclusive reset control
>   spi: stm32: explicitly request exclusive reset control
>   spi: sun6i: explicitly request exclusive reset control
>   spi: tegra20-slink: explicitly request exclusive reset control
>   spi: tegra114: explicitly request exclusive reset control
>   spi: tegra20-sflash: explicitly request exclusive reset control
>   staging: nvec: explicitly request exclusive reset control
>   thermal: rockchip: explicitly request exclusive reset control
>   thermal: tegra: explicitly request exclusive reset control
>   serial: 8250_dw: explicitly request exclusive reset control
>   serial: tegra: explicitly request exclusive reset control
>   usb: chipidea: msm: explicitly request exclusive reset control
>   usb: dwc2: explicitly request exclusive reset control
>   usb: host: ehci-tegra: explicitly request exclusive reset control
>   usb: host: xhci-tegra: explicitly request exclusive reset control
>   usb: musb: sunxi: explicitly request exclusive reset control
>   usb: phy: msm: explicitly request exclusive reset control
>   usb: phy: qcom-8x16-usb: explicitly request exclusive reset control
>   watchdog: asm9260: explicitly request exclusive reset control
>   watchdog: mt7621: explicitly request exclusive reset control
>   watchdog: rt2880: explicitly request exclusive reset control
>   watchdog: zx2967: explicitly request exclusive reset control
>   ASoC: img: explicitly request exclusive reset control
>   ASoC: stm32: explicitly request exclusive reset control
>   ASoC: sun4i: explicitly request exclusive reset control
>   ASoC: tegra: explicitly request exclusive reset control
>   Documentation: devres: add explicit exclusive/shared reset control
>     request calls
>   reset: finish transition to explicit exclusive reset control requests


For all sunxi patches:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--r7njpeniu6ypk76n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZcFQqAAoJEBx+YmzsjxAgwxEQAKaA2PoiKgEsYRpaVjOFH5dP
l8MoHlOl2ACw1Bcvb1uos6F4QxR6DqX1vZCIEZcuPzwJsF4gmwQdA70BxFUP53Ec
zUPP2txp1pHYft+zBbzXIrTT5oWC6kJ8S1e9QowDdSZNvi59c0ux0ai7sbCZtXA9
x/h58qsTYOqiWZAld1uC2+PWte2edFvmp97pfooG7UZZOyhGQJa3EFxWFWENC80m
9NwFkjXZXrtCwsioXfaBbkkbSy+Gejogh7HpVw7bk6nHJqm/rpCS4aFfFsd/72Fz
H8vE4yhnY616G3JrMS8c0u7RKG0pEvfu47IU3IlAdK/WWDK99mC9sjhcc1fHT3st
r6T0abU9Bf2WFmgg+lYwHV1/KUDKO6+2U/I5Vybj/TehRMzqlyHkDr8isJ4XjZLh
Q32np3ChPOdDa5yl+RFL32ICpVKv2iEdfwOPBPCAFyfnlOIDvt8yxLyzaIcDxcL8
76GhA5g/gNmNr/XUUOY6HznbpyrBtsHYKzRRyk8j6RBowVQlG/7ZNhE7cMF1aYIk
LnXgccb7XvEWvuNT0/5XOg6I1LrnBs8Pu9ox0N8aMIaJvBMlLqP38ur2EcxwpfuK
PJxqTzLfErn0NwJrAgQtAMJwDt0gGcEgs46tHLh4SJalVyMH7BFtSDLKRN6Yx3OS
8tJMPtQfcXBSZ/fWFOkD
=0VL8
-----END PGP SIGNATURE-----

--r7njpeniu6ypk76n--
