Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753804AbeCYRRU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Mar 2018 13:17:20 -0400
Date: Sun, 25 Mar 2018 18:17:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 2/4] staging: iio: tsl2x7x: move
 IIO_CHAN_INFO_CALIB{SCALE,BIAS} to IIO_LIGHT channel
Message-ID: <20180325181715.648dc57f@archlinux>
In-Reply-To: <20180324200555.1403-3-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
        <20180324200555.1403-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 16:05:53 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The IIO_CHAN_INFO_CALIBSCALE and IIO_CHAN_INFO_CALIBBIAS masks are
> currently associated with the IIO_INTENSITY channel but should be
> associated with the IIO_LIGHT channel since these values are used to
> calculate the lux. Directory listing of the sysfs attributes for a
> TSL2772 with this patch applied:
They may be used to calculate the lux, but as far as I can tell
they are gain controls on the underlying intensity channels.

> 
> dev
> events
> in_illuminance0_calibbias
> in_illuminance0_calibrate
> in_illuminance0_calibscale
> in_illuminance0_calibscale_available
> in_illuminance0_input
> in_illuminance0_integration_time
> in_illuminance0_integration_time_available
I'd missed this before, but the integration time is also for
the two intensity readings.  An argument could be made
for it also being a parameter of illuminance but
it definitely needs to be on for the intensity channels.

> in_illuminance0_lux_table
> in_illuminance0_target_input
> in_intensity0_raw
> in_intensity1_raw
> in_proximity0_calibrate
> in_proximity0_calibscale
> in_proximity0_calibscale_available
> in_proximity0_raw
> name
> of_node
> power
> subsystem
> uevent

So for this one I'm unconvinced.

Jonathan

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8530bccdb317..d5a237fb0a0b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1491,14 +1491,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1531,14 +1531,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1580,14 +1580,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {

