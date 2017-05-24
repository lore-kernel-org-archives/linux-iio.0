Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937592AbdEXT1j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:27:39 -0400
Date: Wed, 24 May 2017 20:27:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
Message-ID: <20170524202735.3cf4e14e@kernel.org>
In-Reply-To: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 May 2017 11:08:30 +0300
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> Having all events enabled by default is misleading.
> Userspace should explicitly enable events they want to receive.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
I agree in principle, but this is a userspace ABI change.  Sadly we
can't do it with out risking breaking userspace code...

One of those we should have caught in review, but now it's there
we can't actually do anything about it unless we are absolutely
sure no one will notice!

Jonathan
> ---
>  drivers/iio/adc/hi8435.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index ef5c286c8e67..0331739f235c 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -506,8 +506,6 @@ static int hi8435_probe(struct spi_device *spi)
>  	idev->channels		= hi8435_channels;
>  	idev->num_channels	= ARRAY_SIZE(hi8435_channels);
>  
> -	/* unmask all events */
> -	priv->event_scan_mask = ~(0);
>  	/*
>  	 * There is a restriction in the chip - the hysteresis can not be odd.
>  	 * If the hysteresis is set to odd value then chip gets into lock state

