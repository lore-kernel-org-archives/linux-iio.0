Return-Path: <alexandre.belloni@free-electrons.com>
Message-ID: <51D2BEA1.6010206@free-electrons.com>
Date: Tue, 02 Jul 2013 13:50:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@cam.ac.uk>,
 brian@crystalfontz.com, linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 jimwall@q.com, Rob Herring <rob.herring@calxeda.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
 Rob Landley <rob@landley.net>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com> <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com> <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com> <51D2BB05.9040201@free-electrons.com> <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 02/07/2013 13:45, Fabio Estevam wrote:

> Shouldn't this be
> 
>          i2c@1 {
>                  reg = <1>; ?
> 

No, we have 4 devices on that mux and 2 pins to select the muxing.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
