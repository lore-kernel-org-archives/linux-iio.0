Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Wed, 16 Nov 2011 16:51:52 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/7] regmap: Make reg_config reg_defaults const
Message-ID: <20111116165151.GO29986@opensource.wolfsonmicro.com>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
 <1321457302-8724-2-git-send-email-lars@metafoo.de>
 <20111116161316.GI29986@opensource.wolfsonmicro.com>
 <4EC3E385.4060006@metafoo.de>
 <20111116162442.GL29986@opensource.wolfsonmicro.com>
 <4EC3E684.90109@metafoo.de>
 <20111116163908.GN29986@opensource.wolfsonmicro.com>
 <4EC3E9E5.7030909@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC3E9E5.7030909@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 05:50:45PM +0100, Lars-Peter Clausen wrote:

> Hu? which patches did you apply? If I have regmap/for-next plus patch 1 and
> patch 2 of this series there isn't even a reference to reg_defaults in regmap.c

None of them, I just changed the code to make the defaults const - I'm
just reviewing by eyeball as I'm well aware of the fact that this isn't
const.
