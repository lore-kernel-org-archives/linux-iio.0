Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE07C10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5FA21738
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554633064;
	bh=tsk9nxYHNVbPOIWyLF1I91rMQuQi2bxrJY6ozXyis4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PunPO5idiqyCqzaY3zi3QZi+Ux1ivRZg6RnRdbbDGFjitk1dEK0nlbqGyETqcM7++
	 9RxW5bfKnoC18OQg++3ry2wgO0NI7ioMRt+tK1tL7qTBfY8C2+hjMqlrX+wo878bHE
	 CTitVqAbW5Ss4xDmDx1adN7CpVtsIz4qM+CxY8QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfDGKbD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfDGKbD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Apr 2019 06:31:03 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147EE213F2;
        Sun,  7 Apr 2019 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554633063;
        bh=tsk9nxYHNVbPOIWyLF1I91rMQuQi2bxrJY6ozXyis4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ysM5UKtsWHP7Tn+AAdulPPQyuweZF4kxnL4dDhwOjwcFfr0KJH3p+w9ODK2m1QOFR
         Fswg4oQEjHkmORTfSuvJeankR97k1kzoRb46tqbkuK1X+a82lbZjFGqzr8y45cUfRJ
         to9q4w8ZTaK5GRMe+Hn+UfiUDMFccjxa8ROlp/3Y=
Date:   Sun, 7 Apr 2019 11:30:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsr
 device bindings
Message-ID: <20190407113058.2a3ba17f@archlinux>
In-Reply-To: <d72fe86f431bbf68ebeec0b234f4c57881e86c82.1554393394.git.lorenzo@kernel.org>
References: <cover.1554393393.git.lorenzo@kernel.org>
        <d72fe86f431bbf68ebeec0b234f4c57881e86c82.1554393394.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 Apr 2019 18:02:35 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 4640a012c17a..efec9ece034a 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -10,6 +10,7 @@ Required properties:
>    "st,lsm6dso"
>    "st,asm330lhh"
>    "st,lsm6dsox"
> +  "st,lsm6dsr"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

