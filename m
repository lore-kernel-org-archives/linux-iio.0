Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42651 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbcH2Sxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 14:53:35 -0400
Subject: Re: [PATCH -next] iio: adc: ti-ads1015: add missing of_node_put() in
 ads1015_get_channels_config_of()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Giorgio Dal Molin <giorgio.nicole@arcor.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crt Mori <cmo@melexis.com>
References: <1472221910-661-1-git-send-email-weiyj.lk@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <30d98e10-b65b-09ea-d625-a99eacd819ae@kernel.org>
Date: Mon, 29 Aug 2016 19:51:44 +0100
MIME-Version: 1.0
In-Reply-To: <1472221910-661-1-git-send-email-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/08/16 15:31, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> When terminating for_each_child_of_node() iteration with
> break or return, of_node_put() should be used to prevent
> stale device node references from being left behind.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Thanks,

Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play with it.

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 066abaf..cde6f13 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -522,6 +522,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  			if (pga > 6) {
>  				dev_err(&client->dev, "invalid gain on %s\n",
>  					node->full_name);
> +				of_node_put(node);
>  				return -EINVAL;
>  			}
>  		}
> @@ -532,6 +533,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  				dev_err(&client->dev,
>  					"invalid data_rate on %s\n",
>  					node->full_name);
> +				of_node_put(node);
>  				return -EINVAL;
>  			}
>  		}
> 
> 
> 

