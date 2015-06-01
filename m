Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbFAVQ6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:58 -0400
Message-ID: <556C0B23.10204@kernel.org>
Date: Mon, 01 Jun 2015 08:34:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 25/32] tools:iio:iio_event_monitor: refactor events output
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <a8ecccf5a12d1ebbf0a5ee22d15fc3c1f7d0ff88.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <a8ecccf5a12d1ebbf0a5ee22d15fc3c1f7d0ff88.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Refactor the code in print_event() to reduce code duplication and better
> reflect that the type is output unconditionally, as well as cascade the
> dependency of the diff-channel. Saves a few lines of code, as well.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_event_monitor.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 17c27bf..8e682a7 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -213,23 +213,19 @@ static void print_event(struct iio_event_data *event)
>  		return;
>  	}
>  
> -	printf("Event: time: %lld, ", event->timestamp);
> +	printf("Event: time: %lld, type: %s", event->timestamp,
> +	       iio_chan_type_name_spec[type]);
>  
> -	if (mod != IIO_NO_MOD) {
> -		printf("type: %s(%s), ",
> -			iio_chan_type_name_spec[type],
> -			iio_modifier_names[mod]);
> -	} else {
> -		printf("type: %s, ",
> -			iio_chan_type_name_spec[type]);
> -	}
> +	if (mod != IIO_NO_MOD)
> +		printf("(%s)", iio_modifier_names[mod]);
>  
> -	if (diff && chan >= 0 && chan2 >= 0)
> -		printf("channel: %d-%d, ", chan, chan2);
> -	else if (chan >= 0)
> -		printf("channel: %d, ", chan);
> +	if (chan >= 0) {
> +		printf(", channel: %d", chan);
> +		if (diff && chan2 >= 0)
> +			printf("-%d", chan2);
> +	}
>  
> -	printf("evtype: %s", iio_ev_type_text[ev_type]);
> +	printf(", evtype: %s", iio_ev_type_text[ev_type]);
>  
>  	if (dir != IIO_EV_DIR_NONE)
>  		printf(", direction: %s", iio_ev_dir_text[dir]);
> 

