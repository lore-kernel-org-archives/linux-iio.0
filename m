Return-Path: <lars@metafoo.de>
Message-ID: <51D53B72.6020309@metafoo.de>
Date: Thu, 04 Jul 2013 11:08:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@cam.ac.uk>,
 jimwall@q.com, brian@crystalfontz.com,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>,
 Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv3 1/3] iio: Add Nuvoton NAU7802 ADC driver
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com> <1372094699-3832-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1372094699-3832-2-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/24/2013 07:24 PM, Alexandre Belloni wrote:
> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
> gain and sampling rates.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

One remark though. Multiline comments should be like

/*
 * foo
 * bar
 */

not

/* foo
 * bar
 */

But not need to resend the patch just for this

- Lars
