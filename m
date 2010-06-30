Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-2-git-send-email-jic23@cam.ac.uk> <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 30 Jun 2010 12:21:32 +0800
Message-ID: <AANLkTil-mtacW-cCMOJhGMvYjxXg4K1vd9Tcx7ZUC17u@mail.gmail.com>
Subject: Re: [PATCH 2/6] staging:iio:lis3l02dq remove unused set_ring_length
	function
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c | =C2=A0 =C2=A08 -------=
-
> =C2=A01 files changed, 0 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index 69e2787..a33599d 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -591,12 +591,4 @@ void lis3l02dq_uninitialize_ring(struct iio_ring_buf=
fer *ring)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_ring_buffer_unregister(ring);
> =C2=A0}
>
> -int lis3l02dq_set_ring_length(struct iio_dev *indio_dev, int length)
> -{
> - =C2=A0 =C2=A0 =C2=A0 /* Set sensible defaults for the ring buffer */
> - =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_length)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return indio_dev->ring=
->access.set_length(indio_dev->ring, 500);
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
>
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
