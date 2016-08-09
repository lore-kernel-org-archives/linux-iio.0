Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36014 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551AbcHINrV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2016 09:47:21 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so34528034wma.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Aug 2016 06:47:20 -0700 (PDT)
Date: Tue, 9 Aug 2016 14:48:47 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 3/4] mfd: mfd-core: reattach mfd of_node to cells
 without of_compatible
Message-ID: <20160809134847.GJ5243@dell>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-4-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1469519027-11387-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Jul 2016, Quentin Schulz wrote:

> When an MFD cell has an of_compatible (meaning it is present in the Device
> Tree), other nodes can reference it using a phandle.
> 
> However when the MFD cell is not declared in the Device Tree, the only way
> other nodes can reference it are by using a phandle to the MFD. Then when
> this MFD cell tries to register itself in one framework, the registration
> is denied by the framework because it is not matching the of_node of the
> node which is referenced by the phandle in one of the other nodes.
> 
> This reattaches the of_node of the MFD to the MFD cell device structure
> when the MFD cell has no of_compatible.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> We need this modification to register the thermal sensor in the thermal
> framework.
> 
> Added in v3.
> 
>  drivers/mfd/mfd-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Can you show me the DT code where this is used?

Is it used by a patch in this series?

> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 3ac486a..0b19663 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -175,12 +175,16 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (ret < 0)
>  		goto fail_res;
>  
> -	if (parent->of_node && cell->of_compatible) {
> -		for_each_child_of_node(parent->of_node, np) {
> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				pdev->dev.of_node = np;
> -				break;
> +	if (parent->of_node) {
> +		if (cell->of_compatible) {
> +			for_each_child_of_node(parent->of_node, np) {
> +				if (of_device_is_compatible(np, cell->of_compatible)) {
> +					pdev->dev.of_node = np;
> +					break;
> +				}
>  			}
> +		} else {
> +			pdev->dev.of_node = parent->of_node;
>  		}
>  	}
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
