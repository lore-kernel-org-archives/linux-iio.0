Return-Path: <SRS0=9885=NE=poczta.fm=sst@kernel.org>
Date: Wed, 24 Oct 2018 19:30:12 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: potentiometer: tpl0102: switch to using pointer
 to chip config
Message-ID: <20181024173012.GA10909@x220.localdomain>
References: <20181024103858.28201-1-matt.ranostay@konsulko.com>
 <20181024103858.28201-2-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181024103858.28201-2-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

On paź 24, 2018 11:38, Matt Ranostay wrote:
> More concise to have a pointer to tpl0102_cfg struct in the iio_priv
> data than an integer to an index of an array.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/potentiometer/tpl0102.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks good to me.

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

-- 
Slawomir Stepien
