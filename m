Return-Path: <lars@metafoo.de>
Message-ID: <53F441FF.9090304@metafoo.de>
Date: Wed, 20 Aug 2014 08:36:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sanjeev Sharma <sanjeev_sharma@mentor.com>, jic23@kernel.org,
 gregkh@linuxfoundation.org
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging:iio: moved platform_data into include/linux/iio
References: <1408516869-6099-1-git-send-email-sanjeev_sharma@mentor.com>
In-Reply-To: <1408516869-6099-1-git-send-email-sanjeev_sharma@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/20/2014 08:41 AM, Sanjeev Sharma wrote:
> This is a patch to the iio which will move all platform_data
> into include/linux/iio.

It should be moved together with the driver.
