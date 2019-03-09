Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DFC43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA6720815
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155635;
	bh=ioLDc73A3Y7cW0CEwU6CbBTZ/2imaIbxoyKR/xoiHxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w8NvEcvVca+lXXZlNTff7ggauUUrXpkUX3bdGDDZ7x6fZ8w141+UrgedWFikH3tHR
	 Vh/pEI62ObiKxCnpiBeOuNa/W1vBCi74lZj3jnaPDsBuGhyic8iLpmVMtpTXiqxmnA
	 ZY8gK/JhySwxaDfj7hKIoLle6pWsDBqISu3ImqXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfCISUe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCISUe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:20:34 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0FA206DF;
        Sat,  9 Mar 2019 18:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155633;
        bh=ioLDc73A3Y7cW0CEwU6CbBTZ/2imaIbxoyKR/xoiHxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=skrkMOSM5d+gELal5ELI2vDSEvEP6t9wI6DRHVe20zoPJPj5+Yo9Z5lP338z9DyhV
         pTbeRhVo9dhMbmwzRrUiyaQSA6jhI+Zx7x4BUCj92TnvDOv0jkgCt/ZA/4cM4vBzXR
         DUbg3FhwRUU6fe5PMpEiudLYF8Q0Qi8tHWFqJd4c=
Date:   Sat, 9 Mar 2019 18:20:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device
 binding
Message-ID: <20190309182026.6866b037@archlinux>
In-Reply-To: <2671a590a8394e76bd795c6bb187bfd1@SFHDAG2NODE1.st.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
        <20190305203252.13647-2-rjones@gateworks.com>
        <2671a590a8394e76bd795c6bb187bfd1@SFHDAG2NODE1.st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Mar 2019 01:14:14 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks

Jonathan

> 
> Thanks,
> Denis
> 
> 
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
> Sent: Tuesday, March 5, 2019 12:33 PM
> To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones <rjones@gateworks.com>
> Subject: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index 52ee4ba..7f24b33 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -49,6 +49,7 @@ Accelerometers:
>  - st,lis2dw12
>  - st,lis3dhh
>  - st,lis3de
> +- st,lis2de12-accel
>  
>  Gyroscopes:
>  - st,l3g4200d-gyro

