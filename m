Return-Path: <jic23@kernel.org>
Message-ID: <4FEEF3B4.5080809@kernel.org>
Date: Sat, 30 Jun 2012 13:40:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio:dac:ad5064: Add support for the ad5629r and ad5669r
References: <1340701476-17374-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1340701476-17374-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/26/2012 10:04 AM, Lars-Peter Clausen wrote:
> The ad5629r and ad5669r are the I2C variants of the ad5628 and ad5668. Since the
> ad5064 driver currently only supports SPI based devices the major part of this
> patch focuses on adding support for I2C based devices. Adding support for the
> actual parts boils down to adding entries for them to the device id table.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 

merged and pull request sent.
