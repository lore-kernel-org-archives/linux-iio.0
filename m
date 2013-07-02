Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
Date: Mon, 1 Jul 2013 23:45:53 -0300
Message-ID: <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
Subject: Re: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
From: Fabio Estevam <festevam@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@cam.ac.uk>, brian@crystalfontz.com,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, jimwall@q.com,
	Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Alexandre,

On Mon, Jun 24, 2013 at 2:24 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The ADCs connected to this bus have been experiencing some timeout
> issues when using the iMX28 i2c controller. Switching back to bitbanging
> solves this.

Are you able to use the mxs i2c controller instead of bitbang if you
use this patch?
http://www.spinics.net/lists/stable/msg13202.html

Regards,

Fabio Estevam
