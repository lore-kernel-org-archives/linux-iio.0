Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 9 Feb 2012 10:12:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/6] staging:iio: Update iio_event_interface
 documentation
Message-ID: <20120209181240.GA1340@kroah.com>
References: <1328131074-2739-1-git-send-email-lars@metafoo.de>
 <1328131074-2739-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328131074-2739-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 01, 2012 at 10:17:49PM +0100, Lars-Peter Clausen wrote:
> The documentation for the iio_event_interface does not match the actual struct
> anymore. This patch removes the documentation for non-existing fields and adds
> documentation for missing fields.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/industrialio-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

This patch fails to apply to my tree, possibly because of your other
patches I accepted.

Care to redo this series against the next linux-next release and resend?

thanks,

greg k-h
