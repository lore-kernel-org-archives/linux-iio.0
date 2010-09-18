Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C94B4A6.2060001@cam.ac.uk>
Date: Sat, 18 Sep 2010 13:46:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, m_brugger@web.de,
 Michael.Hennerich@analog.com, Robin.Getz@analog.com
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/06/10 16:16, Jonathan Cameron wrote:
> Mainly a rebase, but a couple of attribute naming fixes as well.
> 
> Note I don't have one of these so if anyone could test that would
> be great!
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Jonathan Cameron (2):
>   staging:iio:adis16260 add id table support
>   staging:iio:adis16260 add suppport for adis16255 and adis16250.
> 
>  drivers/staging/iio/gyro/Kconfig                   |    8 +-
>  drivers/staging/iio/gyro/adis16260.h               |    3 +
>  drivers/staging/iio/gyro/adis16260_core.c          |  139 ++++++++++++++------
>  drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
>  drivers/staging/iio/gyro/gyro.h                    |    9 ++
>  5 files changed, 136 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
> 
> 
Whilst I haven't tested these (don't have the hardware) I don't think there
is anything controversial, so my intent is to push these to Greg before the
next merge window.  This is primarily to remove the duplication we currently
have with two drivers that effectively cover the same parts.

Thanks,

Jonathan
