Return-Path: <martink@posteo.de>
Subject: Re: [PATCH v6 1/3] iio: mma8452: add freefall detection for
 Freescale's accelerometers
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1452954922-2266-1-git-send-email-martink@posteo.de>
 <1452954922-2266-2-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <56A26336.3030506@posteo.de>
Date: Fri, 22 Jan 2016 18:13:26 +0100
MIME-Version: 1.0
In-Reply-To: <1452954922-2266-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-iio@vger.kernel.org>

Am 2016-01-16 um 15:35 schrieb Martin Kepplinger:
> This adds freefall event detection to the supported devices. It adds
> the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
> freefall mode.
> 
> In freefall mode, the current acceleration magnitude (AND combination
> of all axis values) is compared to the specified threshold.
> If it falls under the threshold (in_accel_mag_falling_value),
> the appropriate IIO event code is generated.
> 
> This is what the sysfs "events" directory for these devices looks
> like after this change:
> 
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_period
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_value
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_period
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_value
> -r--r--r--    4096 Oct 23 08:45 in_accel_scale
> -rw-r--r--    4096 Oct 23 08:45 in_accel_x&y&z_mag_falling_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
> revision history
> ----------------
> v1:
>         initial post
> v2:
>         build all from correct event and channel spec structs
> v3:
>         rising and falling are treated as equal now. Until last time, I had
>         misunderstood the iio events' user API definition. This works and
>         values always reflect the current state of operation.
> v4:
> 	fix error that caused a build warning
> v5:
> 	changes according to Peter's review
> v6:
> 	changes according to Jonathan's review:
> 	improve set_freefall_mode(); fix error case
> 
> 

Any more thoughts, advice or objections on this?

thanks
                         martin
