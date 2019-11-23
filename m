Return-Path: <SRS0=9Qmd=ZP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6D0C432C0
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 12:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635892071B
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574513220;
	bh=aUEfRbvT0/W6nAuMnX8s9amFoP9GvVhbOH+w/M9bSVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AFuc71vHnhPV4HZmOK1mEnnzY2QL8Q6nSNqgSm6nibzPRSgol9CuwLcNg8NY5xqyn
	 SAb1fvDv5jF6q/irQmjN/ikg3A7uYxEFvpb8VFxUhqz0XdAQdrsH78bUtWZo+e9Fz3
	 5iu39c9RD8NNQJP82VHU5Q4Mz4OqpTHYjKdvOKm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKWMq7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 23 Nov 2019 07:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMq7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:46:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897FB20714;
        Sat, 23 Nov 2019 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574513218;
        bh=aUEfRbvT0/W6nAuMnX8s9amFoP9GvVhbOH+w/M9bSVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bjYbDztnevddhghLSJXY+W5YvpjAeOXBtj1BY15oiEqKevfBFyv01hC7l5c6sdBo1
         sLz7xp6nSSnQjXdr01j74RvKS8xTeK5/gA8jEeahXu4kT4+p7+7/ZppLmOBbMwv8jL
         hIy4TInYI0p4ngrSjN7/3yTAzDfVItHOtd5/eW/Y=
Date:   Sat, 23 Nov 2019 12:46:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [v3 9/9] dt-bindings: iio: maxim_thermocouple: document new
 'compatible' strings
Message-ID: <20191123124653.4d08445d@archlinux>
In-Reply-To: <20191120144756.28424-10-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-10-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:56 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Now the maxim_thermocouple has new, more specific, 'compatible' strings for
> better distinguish the various supported chips.
> 
> This patch updates the DT bindings documentation accordingly
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied,

Thanks,

Jonathan

> ---
>  .../bindings/iio/temperature/maxim_thermocouple.txt        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> index 28bc5c4d965b..bb85cd0e039c 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> @@ -5,7 +5,10 @@ Maxim thermocouple support
>  
>  Required properties:
>  
> -	- compatible: must be "maxim,max31855" or "maxim,max6675"
> +	- compatible: must be "maxim,max6675" or one of the following:
> +	   "maxim,max31855k", "maxim,max31855j", "maxim,max31855n",
> +	   "maxim,max31855s", "maxim,max31855t", "maxim,max31855e",
> +	   "maxim,max31855r"; the generic "max,max31855" is deprecated.
>  	- reg: SPI chip select number for the device
>  	- spi-max-frequency: must be 4300000
>  	- spi-cpha: must be defined for max6675 to enable SPI mode 1
> @@ -15,7 +18,7 @@ Required properties:
>  Example:
>  
>  	max31855@0 {
> -		compatible = "maxim,max31855";
> +		compatible = "maxim,max31855k";
>  		reg = <0>;
>  		spi-max-frequency = <4300000>;
>  	};

