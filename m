Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1339401064-5218-1-git-send-email-michael.hennerich@analog.com>
References: <1339401064-5218-1-git-send-email-michael.hennerich@analog.com>
Date: Mon, 11 Jun 2012 14:32:57 +0530
Message-ID: <CAM=Q2ctNYnq9S9fr4K6sh+k3311nMON8Yho+-vAdd3dSdOXRHg@mail.gmail.com>
Subject: Re: [PATCH] iio: ad9523: Fix argument type mismatch
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: michael.hennerich@analog.com
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Michael,

On Mon, Jun 11, 2012 at 1:21 PM,  <michael.hennerich@analog.com> wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> drivers/iio/frequency/ad9523.c:378 ad9523_vco_out_map()
> =A0 =A0 =A0 =A0 warn: value 2 can't fit into 1 'out'
>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> =A0drivers/iio/frequency/ad9523.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad952=
3.c
> index 7272924..43f47d9 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -361,7 +361,7 @@ static int ad9523_io_update(struct iio_dev *indio_dev=
)
> =A0}
>
> =A0static int ad9523_vco_out_map(struct iio_dev *indio_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ch, bo=
ol out)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ch, un=
signed out)

Unsigned defaults to unsigned int right shouldnt it be a char?
Or am I missing something.
