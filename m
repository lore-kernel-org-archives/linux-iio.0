Return-Path: <sr@denx.de>
Message-ID: <532003CB.1000803@denx.de>
Date: Wed, 12 Mar 2014 07:50:51 +0100
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: Minor cleanups to spear ADC driver followed
 by staging graduation.
References: <1394570219-7672-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1394570219-7672-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11.03.2014 21:36, Jonathan Cameron wrote:
> This driver has been reasonably clean since it was first merged within the
> staging tree.  If it had been submitted after the IIO core was outside of
> staging we might have taken it as is. I did a final review and the first 4
> patches of this series rework various minor aspects of the driver.
>
> Whilst it is a slow driver, the device tree matches at the lowest level seemed
> a little unwise so the largest rework is concerned with centralising that
> logic using a classic ops structure of function pointers.  The other large
> change was to move to using the info_mask_shared_by_all approach to handle
> sampling frequency.  This is something I am slowly propogating across the
> whole tree, but might as well be done whilst we are looking at this driver.
>
> I don't have hardware and whilst I think these are all changes that are
> possible to easily verify by eye, a tested by would be most welcome!
>
> Note this is the first driver I'm suggesting moving out of staging following
> Greg's entirely reasonable question of 'What's wrong with the stuff that is
> left?'  Any help with this sort of final cleanup and move would be most
> welcome.

Jonathan, thanks for working on this. Really appreciated. I don't have a 
spear600 board at hand right now. But all your changes seem reasonable. So:

Ackey-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
