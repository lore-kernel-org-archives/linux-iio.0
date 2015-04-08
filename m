Return-Path: <vlad.dogaru@intel.com>
Date: Wed, 8 Apr 2015 18:30:34 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: pressure: bmp280: fix temp compensation
Message-ID: <20150408153034.GA23781@vdogaru>
References: <1428506772-23710-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428506772-23710-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 08, 2015 at 06:26:12PM +0300, Irina Tirdea wrote:
> Temperature reads on bmp280 device always return 0,
> due to a missing step in the compensation formula
> (data->tfine is never initialized).
> 
> Initialize data->tfine value so we get correct
> temperature and pressure values.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>

Nice catch, this must have been lost during a refactoring.

Thanks,
Vlad
