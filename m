Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E26D2D4.5010407@analog.com>
Date: Wed, 20 Jul 2011 15:06:28 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: "greg@kroah.com" <greg@kroah.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/2] iio: core: deconstify members of struct iio_chan_spec
References: <1311166990-32310-1-git-send-email-michael.hennerich@analog.com> <1311166990-32310-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1311166990-32310-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

sorry for the noise - please ignore the duplicated patches without 
Jonathan's Acked-by...

On 07/20/2011 03:03 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> Allow dynamic allocation and population of channel spec.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> ---
>   drivers/staging/iio/iio.h |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 7a6ce4d..a9d7730 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -121,9 +121,9 @@ struct iio_chan_spec {
>   		u8	storagebits;
>   		u8	shift;
>   	} scan_type;
> -	const long		info_mask;
> -	const long		event_mask;
> -	const char		*extend_name;
> +	long			info_mask;
> +	long			event_mask;
> +	char			*extend_name;
>   	unsigned		processed_val:1;
>   	unsigned		modified:1;
>   	unsigned		indexed:1;


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
