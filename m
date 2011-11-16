Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-055.synserver.de ([212.40.185.55]:1301 "HELO
	smtp-out-054.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1756241Ab1KPRBc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2011 12:01:32 -0500
Message-ID: <4EC3EC74.9040706@metafoo.de>
Date: Wed, 16 Nov 2011 18:01:40 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/7] regmap: Make reg_config reg_defaults const
References: <1321457302-8724-1-git-send-email-lars@metafoo.de> <1321457302-8724-2-git-send-email-lars@metafoo.de> <20111116161316.GI29986@opensource.wolfsonmicro.com> <4EC3E385.4060006@metafoo.de> <20111116162442.GL29986@opensource.wolfsonmicro.com> <4EC3E684.90109@metafoo.de> <20111116163908.GN29986@opensource.wolfsonmicro.com> <4EC3E9E5.7030909@metafoo.de> <20111116165151.GO29986@opensource.wolfsonmicro.com>
In-Reply-To: <20111116165151.GO29986@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/16/2011 05:51 PM, Mark Brown wrote:
> On Wed, Nov 16, 2011 at 05:50:45PM +0100, Lars-Peter Clausen wrote:
> 
>> Hu? which patches did you apply? If I have regmap/for-next plus patch 1 and
>> patch 2 of this series there isn't even a reference to reg_defaults in regmap.c
> 
> None of them, I just changed the code to make the defaults const - I'm
> just reviewing by eyeball as I'm well aware of the fact that this isn't
> const.

So you only applied part of the patch and are complaining that it you get an
error?
