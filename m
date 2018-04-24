Return-Path: <SRS0=qFkR=HN=emutex.com=javier@kernel.org>
Date: Tue, 24 Apr 2018 20:33:04 +0100
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dan O'Donovan <dan@emutex.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc128s052: allow driver to be matched using
 ACPI
Message-ID: <20180424193304.yitnosi3vwirqlu7@localhost>
References: <20180419132036.27493-1-javier@emutex.com>
 <20180419132036.27493-2-javier@emutex.com>
 <20180421165441.0c64415d@archlinux>
 <20180421204157.y3zoejow7gfl3pj3@localhost>
 <20180424182330.000061a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180424182330.000061a5@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 24, 2018 at 06:23:30PM +0100, Jonathan Cameron wrote:
> Unless we know of ACPI firmwares out there that are doing this, drop the
> patch for now.  I don't want to see a flood of these based on a 'you can
> do it that' way argument.

Fair enough. I'll drop it for v3.
