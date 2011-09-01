Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Warren <swarren@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Jonathan Cameron <jic23@cam.ac.uk>, Russell King <linux@arm.linux.org.uk>, Andrew Chew <achew@nvidia.com>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2 1/4] i2c: Add irq_gpio field to struct i2c_client.
Date: Thu, 01 Sep 2011 20:30:33 +0200
Message-ID: <1432590.4sqjD9XTYs@wuerfel>
In-Reply-To: <1314895964-15964-1-git-send-email-swarren@nvidia.com>
References: <1314895964-15964-1-git-send-email-swarren@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Thursday 01 September 2011 10:52:37 Stephen Warren wrote:
> Some devices use a single pin as both an IRQ and a GPIO. In that case,
> irq_gpio is the GPIO ID for that pin. Not all drivers use this feature.
> Where they do, and the use of this feature is optional, and the system
> wishes to disable this feature, this field must be explicitly set to a
> defined invalid GPIO ID, such as -1.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: This patch is new. This updated series based on Arnd's comments that
> this solution was a good idea.

Looks very good to me (the whole series).

	Arnd
