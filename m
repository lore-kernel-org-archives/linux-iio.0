Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55072 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab1JMO1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2011 10:27:25 -0400
Date: Thu, 13 Oct 2011 15:27:22 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111013142722.GN1098@sirena.org.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <20111013113506.GJ1098@sirena.org.uk>
 <20111013121745.GU21648@n2100.arm.linux.org.uk>
 <201110131619.39303.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201110131619.39303.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 13, 2011 at 04:19:39PM +0200, Arnd Bergmann wrote:

> Of course, if the spmp8000 adc driver gets put into staging, all its
> dependencies (input, battery) also have to go there because no
> regular driver must link against interfaces provided by a staging
> driver.

Yes, that's the big problem with this - it blocks the actual drivers.
Putting it in drivers/misc would be another option that sidesteps that.
