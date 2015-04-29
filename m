Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1430298111-20127-3-git-send-email-ao2@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	<1430298111-20127-3-git-send-email-ao2@ao2.it>
Date: Wed, 29 Apr 2015 18:08:41 +0300
Message-ID: <CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to polling_mode
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 29, 2015 at 12:01 PM, Antonio Ospite <ao2@ao2.it> wrote:
> The purpose of the variable is to remember when an interrupt cannot be
> requested and hence the driver must work in polling mode, so tell that
> instead of mentioning the specific case when this is needed.
>
> This makes the variable name to be still meaningful when some other
> devices requiring this show up.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/accel/kxcjk-1013.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 5b7a860..eccec0e 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -108,7 +108,7 @@ struct kxcjk1013_data {
>         bool motion_trigger_on;
>         int64_t timestamp;
>         enum kx_chipset chipset;
> -       bool is_smo8500_device;
> +       bool polling_mode;

I would prefer to call this field use_poll, as introduced in:

http://marc.info/?l=linux-iio&m=142980650422289&w=2

Also use_poll its it's a better suggestion on the type than polling_mode.

Other than that the patch looks good.


thanks,
Daniel.
