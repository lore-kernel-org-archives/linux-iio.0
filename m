Return-Path: <bp@alien8.de>
Date: Mon, 25 Nov 2013 18:13:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: randconfig build error with next-20131125, in drivers/iio/light
Message-ID: <20131125171301.GB11463@pd.tnic>
References: <CA+r1ZhinxJBB3dgCKxoMXV0ioVR0jrS7ha=SY-qT212AvDSkVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+r1ZhinxJBB3dgCKxoMXV0ioVR0jrS7ha=SY-qT212AvDSkVQ@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 25, 2013 at 10:04:44AM -0700, Jim Davis wrote:
> Building with the attached random configuration file,
> 
> drivers/iio/light/tcs3472.c: In function ‘tcs3472_trigger_handler’:
> drivers/iio/light/tcs3472.c:195:2: error: implicit declaration of
> function ‘iio_push_to_buffers_with_timestamp’
> [-Werror=implicit-function-declaration]
>   iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>   ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/iio/light/tcs3472.o] Error 1

Feel like giving it a try to write a fix for it? It seems to me
tcs3472.c should depend on IIO_BUFFER... :-)

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
