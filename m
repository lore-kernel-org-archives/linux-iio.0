Return-Path: <ldewangan@nvidia.com>
Message-ID: <515A7A06.2090608@nvidia.com>
Date: Tue, 2 Apr 2013 11:56:14 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/4] iio:magnetometer:ak8975 cleanup and move out of staging.
References: <1364144310-32251-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1364144310-32251-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Sunday 24 March 2013 10:28 PM, Jonathan Cameron wrote:
> When I proposed moving this out of staging a while back, Lars-Peter
> pointed out a few 'unusual' elements in the driver.  This series
> addresses those and the interesting question of what the NOSTART flag
> was doing there in the read code (came up in the dicussion of one of
> Lars-Peter's points).
>
> The caching in the write is a little unnecessary, but isn't technically
> incorrect so I haven't touched that.
>
> If anyone has one of these to test and make sure the changes haven't
> broken anything that would be great!
>
> Thanks,

This series looks good.
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
