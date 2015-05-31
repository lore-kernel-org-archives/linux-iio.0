Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35756 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbbFAVQx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:53 -0400
Message-ID: <556B54A5.6050304@kernel.org>
Date: Sun, 31 May 2015 19:36:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 20/32] tools:iio:iio_event_monitor: check if event is
 fully read
References: <cover.1433072539.git.knaack.h@gmx.de> <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Check that the read event is of the expected size.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Is this a meaningful thing to do?  Something has gone horribly wrong if this occurs..
Perhaps just dropping out entirely is a better bet?

> ---
>  tools/iio/iio_event_monitor.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 1316527..ecee8ac 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -304,6 +304,11 @@ int main(int argc, char **argv)
>  			}
>  		}
>  
> +		if (ret != sizeof(event)) {
> +			printf("Reading event failed, trying again\n");
> +			continue;
> +		}
> +
>  		print_event(&event);
>  	}
>  
> 

