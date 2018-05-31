Return-Path: <SRS0=HUMy=IS=onstation.org=masneyb@kernel.org>
Date: Thu, 31 May 2018 05:28:01 -0400
From: Brian Masney <masneyb@onstation.org>
To: Colin King <colin.king@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: tsl2x7x/tsl2772: avoid potential division by
 zero
Message-ID: <20180531092801.bsmqujkfnge3xhpo@0dcddc0a723b>
References: <20180530181936.17902-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530181936.17902-1-colin.king@canonical.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 30, 2018 at 07:19:36PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It may be possible for tsl2772_get_lux to return a zero lux value
> and hence a division by zero can occur when lux_val is zero. Check
> for this case and return -ERANGE to avoid the division by zero.
> 
> Detected by CoverityScan, CID#1469484 ("Division or modulo by zero")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Brian Masney <masneyb@onstation.org>
