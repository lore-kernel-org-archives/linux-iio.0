Return-Path: <SRS0=oNRe=FO=opensource.cirrus.com=ckeepax@kernel.org>
Date: Mon, 19 Feb 2018 11:43:29 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 5/5] regmap: Remove regmap_get_raw_read_max
Message-ID: <20180219114329.vx7e6jd2ujsbxonx@localhost.localdomain>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
 <20180215175220.2691-5-ckeepax@opensource.cirrus.com>
 <20180216120311.GG5886@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180216120311.GG5886@sirena.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 16, 2018 at 12:03:11PM +0000, Mark Brown wrote:
> On Thu, Feb 15, 2018 at 05:52:20PM +0000, Charles Keepax wrote:
> > Since the handling for max_raw_read is now inside regmap_raw_read there
> > should be no need for client drivers to query as max_raw_read.
> 
> No, they might need to know if things are going to be combined into a
> single transaction - some devices have weird sensitivities about bulk
> I/O and so the driver may need to know exactly what's going on when it
> interacts with the device.

True, no objections from me for dropping this one from the chain.

Thanks,
Charles
