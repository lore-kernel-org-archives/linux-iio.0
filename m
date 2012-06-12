Return-Path: <jic23@kernel.org>
Message-ID: <4FD73C5F.8060503@kernel.org>
Date: Tue, 12 Jun 2012 13:55:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: clarify channel and indexed in struct iio_chan_spec
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net> <1339504946-16171-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 1:42 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   include/linux/iio/iio.h |    7 +++----
>   1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9d9b55a..44b9660 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -196,7 +196,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   /**
>    * struct iio_chan_spec - specification of a single channel
>    * @type:		What type of measurement is the channel making.
> - * @channel:		What number or name do we wish to assign the channel.
> + * @channel:		What number do we wish to assign the channel.
>    * @channel2:		If there is a second number for a differential
>    *			channel then this is it. If modified is set then the
>    *			value here specifies the modifier.
> @@ -227,9 +227,8 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>    *			channel2. Examples are IIO_MOD_X for axial sensors about
>    *			the 'x' axis.
>    * @indexed:		Specify the channel has a numerical index. If not,
> - *			the value in channel will be suppressed for attribute
> - *			but not for event codes. Typically set it to 0 when
> - *			the index is false.
> + *			the channel index number will be suppressed for sysfs
> + *			attributes but not for event codes.
>    * @differential:	Channel is differential.
>    */
>   struct iio_chan_spec {
