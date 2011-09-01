Return-Path: <broonie@sirena.org.uk>
Date: Thu, 1 Sep 2011 18:37:56 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Warren <swarren@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Ben Dooks <ben-linux@fluff.org>, Jonathan Cameron <jic23@cam.ac.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	Andrew Chew <achew@nvidia.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2 1/4] i2c: Add irq_gpio field to struct i2c_client.
Message-ID: <20110901173756.GA13417@sirena.org.uk>
References: <1314895964-15964-1-git-send-email-swarren@nvidia.com>
 <1314895964-15964-5-git-send-email-swarren@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314895964-15964-5-git-send-email-swarren@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 01, 2011 at 10:52:41AM -0600, Stephen Warren wrote:
> Some devices use a single pin as both an IRQ and a GPIO. In that case,
> irq_gpio is the GPIO ID for that pin. Not all drivers use this feature.
> Where they do, and the use of this feature is optional, and the system
> wishes to disable this feature, this field must be explicitly set to a
> defined invalid GPIO ID, such as -1.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

SPI could also benefit from this.
