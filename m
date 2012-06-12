Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD73C75.3090101@cam.ac.uk>
Date: Tue, 12 Jun 2012 13:56:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] iio: mark struct iio_enum elements with @
 in comment
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net> <1339504946-16171-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 1:42 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   include/linux/iio/iio.h |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 44b9660..a35aa58 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -131,10 +131,10 @@ struct iio_chan_spec_ext_info {
>
>   /**
>    * struct iio_enum - Enum channel info attribute
> - * items: An array of strings.
> - * num_items: Length of the item array.
> - * set: Set callback function, may be NULL.
> - * get: Get callback function, may be NULL.
> + * @items: An array of strings.
> + * @num_items: Length of the item array.
> + * @set: Set callback function, may be NULL.
> + * @get: Get callback function, may be NULL.
>    *
>    * The iio_enum struct can be used to implement enum style channel attributes.
>    * Enum style attributes are those which have a set of strings which map to
