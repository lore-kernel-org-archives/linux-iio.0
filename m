Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Wed, 16 Nov 2011 17:35:08 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/7] regmap: Move initialization of regcache related
 fields to regcache_init
Message-ID: <20111116173508.GA31558@opensource.wolfsonmicro.com>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321457302-8724-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 04:28:16PM +0100, Lars-Peter Clausen wrote:
> Move the initialization regcache related fields of the regmap struct to
> regcache_init. This allows us to keep regmap and regcache code better
> separated.

Applied, thanks.
