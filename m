Return-Path: <ivo.g.dimitrov.75@gmail.com>
Message-ID: <52D30444.5070800@gmail.com>
Date: Sun, 12 Jan 2014 23:08:20 +0200
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
CC: jic23@kernel.org, pali.rohar@gmail.com, pavel@ucw.cz,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivaylo Dimitrov <freemangordon@abv.bg>
Subject: Re: [PATCH] iio: tsl2563: Initialize channels
References: <1389556464-692-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <alpine.DEB.2.01.1401122150210.9334@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1401122150210.9334@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12.01.2014 22:55, Peter Meerwald wrote:
>
> I think the fix should rather be
>
> 	if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
> 		chip->calib0 = calib_from_sysfs(val);
> 	else if (chan->channel2 == IIO_MOD_LIGHT_IR)
> 		chip->calib1 = calib_from_sysfs(val);
> 	else
> 		return -EINVAL;
>
> since only the INTENSITY channels have a CALIBSCALE info
>
> the light channel incorrectly sets .indexed = 1 and .channel = 0 which
> should be unnecessary since there is only one IIO_LIGHT channel
>
> regards, p.
>

I thought so when I was preparing the patch, but unfortunately couldn't 
find any documentation for iio subsystem structs and defines, besides 
what is in the header files (and it is not very descriptive), so I took 
the easy route.

However, I'll send a new patch with the above (and a little more) changes.

Thanks,
Ivo
