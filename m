Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35537 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbHEMWZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 08:22:25 -0400
MIME-Version: 1.0
In-Reply-To: <1438776912-25798-1-git-send-email-lars1.svensson@sonymobile.com>
References: <1438776912-25798-1-git-send-email-lars1.svensson@sonymobile.com>
Date: Wed, 5 Aug 2015 15:22:24 +0300
Message-ID: <CAEnQRZBLXpPn_i8LJ1=844rUBRMZa9GAY0gKOU1rH8k4MFdZKg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio_simple_dummy: Fix indentation errors
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars Svensson <lars1.svensson@sonymobile.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	driverdev <devel@driverdev.osuosl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 5, 2015 at 3:15 PM, Lars Svensson
<lars1.svensson@sonymobile.com> wrote:
> Fixing indentation errors in
> drivers/staging/iio/iio_simple_dummy_events.c.
>
> Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>

Good catch.

Acked-by: Daniel Baluta <daniel.baluta@intel.com>


> ---
>  drivers/staging/iio/iio_simple_dummy_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
> index ecc563c..73108ba 100644
> --- a/drivers/staging/iio/iio_simple_dummy_events.c
> +++ b/drivers/staging/iio/iio_simple_dummy_events.c
> @@ -120,7 +120,7 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
>                                       const struct iio_chan_spec *chan,
>                                       enum iio_event_type type,
>                                       enum iio_event_direction dir,
> -                                         enum iio_event_info info,
> +                                     enum iio_event_info info,
>                                       int *val, int *val2)
>  {
>         struct iio_dummy_state *st = iio_priv(indio_dev);
> @@ -143,7 +143,7 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>                                        const struct iio_chan_spec *chan,
>                                        enum iio_event_type type,
>                                        enum iio_event_direction dir,
> -                                          enum iio_event_info info,
> +                                      enum iio_event_info info,
>                                        int val, int val2)
>  {
>         struct iio_dummy_state *st = iio_priv(indio_dev);
> --
> 1.8.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
