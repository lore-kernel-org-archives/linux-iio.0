Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:42079 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161490Ab3FUW1q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jun 2013 18:27:46 -0400
MIME-Version: 1.0
In-Reply-To: <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
Date: Fri, 21 Jun 2013 19:27:44 -0300
Message-ID: <CAOMZO5AbZVLH0rxP=iuumrDBxFe5XVGH9qK9PyUdxtucbOHzdg@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
From: Fabio Estevam <festevam@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	brian@crystalfontz.com, linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	jimwall@q.com, Rob Herring <rob.herring@calxeda.com>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	Rob Landley <rob@landley.net>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 20, 2013 at 3:57 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The ADCs connected to this bus have been experiencing some timeout
> issues when using the iMX28 i2c controller. Switching back to bitbanging
> solves this.

Could you please investigate this timeout issue?

The I2C timeouts I was having on mx28 when trying to access sgtl5000
codec, was due to the lack
of codec clock.

After I provided the codec clock I am able to use I2C without issues
and just sent a patch for it.
