Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Wed, 16 Nov 2011 16:13:17 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/7] regmap: Make reg_config reg_defaults const
Message-ID: <20111116161316.GI29986@opensource.wolfsonmicro.com>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
 <1321457302-8724-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321457302-8724-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 04:28:17PM +0100, Lars-Peter Clausen wrote:
> The reg_defaults field usually points to a static per driver array, which should
> not be modified. Make requirement this explicit by making reg_defaults const.

You should've got reams of sparse warnings from that - the indexed cache
is writing to the defaults table (which is very naughty and i keep
thinking about deleting it as a result).
