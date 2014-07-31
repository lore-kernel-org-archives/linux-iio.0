Return-Path: <joe@perches.com>
Message-ID: <1406846509.9953.6.camel@joe-AO725>
Subject: Re: [PATCH 0/8] staging: iio: accel: multiple coding style fixes
From: Joe Perches <joe@perches.com>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jic23@kernel.org
Date: Thu, 31 Jul 2014 15:41:49 -0700
In-Reply-To: <1406846098-19866-1-git-send-email-mopsfelder@gmail.com>
References: <1406846098-19866-1-git-send-email-mopsfelder@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-07-31 at 19:34 -0300, Murilo Opsfelder Araujo wrote:
> The following patches fix (almost) all warnings reported by
> checkpatch.pl.
> 
> Murilo Opsfelder Araujo (8):
>   staging: iio: accel: adis16203_core.c: fix coding style
>   staging: iio: accel: adis16201_core.c: fix coding style
>   staging: iio: accel: adis16204_core.c: fix coding style
>   staging: iio: accel: adis16209_core.c: fix coding style
>   staging: iio: accel: adis16240_core.c: fix coding style
>   staging: iio: accel: lis3l02dq_core.c: fix coding style
>   staging: iio: accel: lis3l02dq_ring.c: fix coding style
>   staging: iio: accel: sca3000_core.c: fix coding style

Hi.

Next time it might be better to use patch subjects like

staging: <subsystem> Add blank lines between declarations and code

because "fix coding style" really isn't very descriptive.
