Return-Path: <lars@metafoo.de>
Message-ID: <52FB66DB.3080904@metafoo.de>
Date: Wed, 12 Feb 2014 13:19:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Paul Cercueil <paul.cercueil@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: ad5064: Explicitly configure whether to use
 external supply
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/12/2014 01:01 PM, Paul Cercueil wrote:
> Previously the driver would revert to internal supply if the
> external supply couldn't be found. This had multiple problems:
> - it caused silently ignored errors when a regulator was intended
>    to be supplied, but was not specified correctly.
> - if CONFIG_REGULATOR is disabled, regulator_get() will always
>    return a dummy regulator, which caused a device to always use
>    the external vref mode, even though there is none.
>
> This patch addresses the issue by adding a platform data structure,
> containing a boolean field use_external_ref. If the platform data
> structure is present and if that boolean is set, the external vref
> is used; otherwise the internal vref is used.
>
> In the case where an external vref is wanted but regulator_get()
> fails, the driver no longer reverts to using the internal vref,
> but returns an error instead.
>
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>

All three patches:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
