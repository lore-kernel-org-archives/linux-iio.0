Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C89698F.8000108@cam.ac.uk>
Date: Fri, 10 Sep 2010 00:11:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, manuel.stahl@iis.fraunhofer.de
Subject: Re: [PATCH 3/4] staging:iio:adis16350 Add optional event support
References: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk> <1283725218-15157-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283725218-15157-4-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/05/10 23:20, Jonathan Cameron wrote:
> This is fairly complex.  The device provides two alarms
> which can be configured as rising or falling thresholds
> on the magnitude or the rate of change of any channel.
Oops.  This patch doesn't actually contain adis16350_event.c
that is the actual event code. Sorry about that.

Jonathan
> 
> I have made things a little more manageable by restricting
> things so you can't set both alarms to the same setting.
> 
> This also rolls in some name changes etc to make possible
> use of macros for some elements.
> 
> Note there is an issue with event codes for ADC channels (there
> are now too many of them) that will need fixing before this merges.
> 
> Various other minor fixes are also in here.
> ---
>  drivers/staging/iio/adc/adc.h            |    8 +++-
>  drivers/staging/iio/gyro/gyro.h          |   31 ++++++++++----
>  drivers/staging/iio/imu/Kconfig          |    7 +++
>  drivers/staging/iio/imu/Makefile         |    1 +
>  drivers/staging/iio/imu/adis16350.h      |   62 ++++++++++++++++++++++++-----
>  drivers/staging/iio/imu/adis16350_core.c |   17 ++++++--
>  drivers/staging/iio/imu/adis16350_ring.c |   10 ++--
>  drivers/staging/iio/sysfs.h              |   17 ++++++++-
>  8 files changed, 122 insertions(+), 31 deletions(-)
