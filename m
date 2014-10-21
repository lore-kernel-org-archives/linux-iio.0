Return-Path: <alexandre.belloni@free-electrons.com>
Date: Tue, 21 Oct 2014 09:29:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Brian Vandre <bvandre@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Staging: iio: adc: Checkpatch.pl warning cleanups
Message-ID: <20141021072919.GH10616@piout.net>
References: <cover.1413858979.git.bvandre@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1413858979.git.bvandre@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

These are two patches with the same commit log, in the same file. You
can probably squash them.

On 20/10/2014 at 21:48:47 -0500, Brian Vandre wrote :
> This patch-set fixes 2 checkpatch.pl warnings
> dealing with lines over 80 characters.
> 
> Brian Vandre (2):
>   Staging: iio: adc: fix line over 80 characters
>   Staging: iio: adc: fix line over 80 characters
> 
>  drivers/staging/iio/adc/mxs-lradc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
