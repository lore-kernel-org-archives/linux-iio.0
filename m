Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1330776551-20301-4-git-send-email-jic23@kernel.org>
References: <1330776551-20301-1-git-send-email-jic23@kernel.org>
	<1330776551-20301-4-git-send-email-jic23@kernel.org>
Date: Wed, 7 Mar 2012 15:57:37 +0100
Message-ID: <CACRpkdYucJ7-_Qg+NX58J34=kQE=0i-=Sfa0jr27AapYAZ_sEw@mail.gmail.com>
Subject: Re: [PATCH 3/3] staging:iio: Proof of concept input driver.
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, greg@kroah.com, dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com, w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 3, 2012 at 1:09 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jic23@cam.ac.uk>
>
> This is no where near ready to merge. =A0Lots of stuff missing.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Overall this is looking very interesting, this is definately where we
want to go with this IMO.

> +static int iio_input_store_to(u8 *data, void *private)
> +{
> + =A0 =A0 =A0 struct iio_input_state *st =3D private;
> +
> + =A0 =A0 =A0 /* DUMMY - need to put boiler plate conversion code
> + =A0 =A0 =A0 =A0* in place */
> + =A0 =A0 =A0 input_report_abs(st->idev, ABS_X, data[0]);
> + =A0 =A0 =A0 input_sync(st->idev);
> +
> + =A0 =A0 =A0 return 0;
> +}

If I have understood correctly, a lot of contemporary input handling
is in need of strict timestamping such as available in IIO. (Strict
control feedback loops etc.)

I guess these applications should use the "real" IIO interfaces,
whereas the input interface should be kept as-is?

Or ... is it possible to get the input subsystem to propagate the
timestamps to userspace?

Yours,
Linus Walleij
