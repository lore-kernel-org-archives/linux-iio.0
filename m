Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40447 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbKUSZe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 13:25:34 -0500
Subject: Re: [PATCH 3/4] iio: adc: spmi-vadc: add missing of_node_put
To: Julia Lawall <Julia.Lawall@lip6.fr>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447884254-26336-4-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650B719.80004@kernel.org>
Date: Sat, 21 Nov 2015 18:25:29 +0000
MIME-Version: 1.0
In-Reply-To: <1447884254-26336-4-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/15 22:04, Julia Lawall wrote:
> for_each_available_child_of_node performs an of_node_get on each iteration,
> so a break out of the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
> 
>  for_each_available_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Thanks. Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> 
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 0c4618b..c2babe5 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -839,8 +839,10 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  
>  	for_each_available_child_of_node(node, child) {
>  		ret = vadc_get_dt_channel_data(vadc->dev, &prop, child);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(child);
>  			return ret;
> +		}
>  
>  		vadc->chan_props[index] = prop;
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

