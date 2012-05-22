Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FBB83BD.4020509@cam.ac.uk>
Date: Tue, 22 May 2012 13:17:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Johan Hovold <jhovold@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: remove num_interrupt_lines from documentation
References: <1337682602-15105-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1337682602-15105-1-git-send-email-jhovold@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/22/2012 11:30 AM, Johan Hovold wrote:
> Commit 5aa9618896e0ba49 ("staging:iio: remove broken support for
> multiple event interfaces.") removed the num_interrupt_lines field from
> struct iio_info but the documentation was never updated.
>
Good catch.
> Signed-off-by: Johan Hovold<jhovold@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/Documentation/device.txt |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
> index 0338c7c..f03fbd3 100644
> --- a/drivers/staging/iio/Documentation/device.txt
> +++ b/drivers/staging/iio/Documentation/device.txt
> @@ -29,8 +29,6 @@ Then fill in the following:
>   	* info->driver_module:
>   		Set to THIS_MODULE. Used to ensure correct ownership
>   		of various resources allocate by the core.
> -	* info->num_interrupt_lines:
> -		Number of event triggering hardware lines the device has.
>   	* info->event_attrs:
>   		Attributes used to enable / disable hardware events.
>   	* info->attrs:
