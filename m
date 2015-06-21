Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44482 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbbFUPVE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 11:21:04 -0400
Message-ID: <5586D65D.6050706@kernel.org>
Date: Sun, 21 Jun 2015 16:21:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH v2 1/3] tools:iio:iio_event_monitor: check if event is
 fully read
References: <cover.1433721755.git.knaack.h@gmx.de> <52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
In-Reply-To: <52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/15 20:51, Hartmut Knaack wrote:
> Check that the read event is of the expected size.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Hartmut pointed out I hadn't picked this up.
I got lost in the thread, and missed that no one seemed
to actually have an issue with the patch, just related
questions!

Applied to the togreg branch of iio.git

Thanks

Jonathan
> ---
>  tools/iio/iio_event_monitor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 016760e..2559fba 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -299,6 +299,12 @@ int main(int argc, char **argv)
>  			}
>  		}
>  
> +		if (ret != sizeof(event)) {
> +			printf("Reading event failed!\n");
> +			ret = -EIO;
> +			break;
> +		}
> +
>  		print_event(&event);
>  	}
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
