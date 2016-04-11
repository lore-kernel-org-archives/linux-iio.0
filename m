Return-Path: <hadess@hadess.net>
Message-ID: <1460384362.2370.0.camel@hadess.net>
Subject: Re: [PATCH] iio: add Capella CM3218 ambient light sensor driver.
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org
Cc: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron
 <jic23@kernel.org>,  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Date: Mon, 11 Apr 2016 16:19:22 +0200
In-Reply-To: <1460381347-26873-1-git-send-email-hadess@hadess.net>
References: <1460381347-26873-1-git-send-email-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2016-04-11 at 15:29 +0200, Bastien Nocera wrote:
> From: Kevin Tsai <ktsai@capellamicro.com>
> 
> Add Capella Microsystem CM3218 Ambient Light Sensor IIO driver.
> This driver will convert raw data to lux value under open-air
> condition, accessing the device via I2C.
> 
> More information is available at:
> http://www.capellamicro.com.tw/EN/product_c.php?id=52&mode=14&search=
> 
> The driver was tested on the second generation Lenovo X1 Carbon
> (20A7).

Not tested well enough it seems, as the sensor doesn't survive and
suspend/resume cycle.

Cheers
