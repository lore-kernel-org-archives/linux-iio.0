Return-Path: <SRS0=gq1U=YU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C3CA9EAF
	for <linux-iio@archiver.kernel.org>; Sun, 27 Oct 2019 16:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F77021726
	for <linux-iio@archiver.kernel.org>; Sun, 27 Oct 2019 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572194430;
	bh=LfliSMpBBwJIsYbInVVUUbXNcUhWFJ3rAVpNRnxVzwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uYztUbb65LxiOafJbYHRS3PhTMvfTbBmk0DAdcRb6UKmLvB//3IMCtudRMJ1XPKrz
	 P2MAcKr2mehbIMAoa3xzHFA7phK0jaZMRYso2JgLjqF1tb4YcZoOyin5xstltUoPDP
	 6dlphsIrp2ANL6WxM9cak55+LvAbgU1aZXprUdlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfJ0Qk3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfJ0Qk3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:40:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EAF21726;
        Sun, 27 Oct 2019 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572194428;
        bh=LfliSMpBBwJIsYbInVVUUbXNcUhWFJ3rAVpNRnxVzwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWRVHYX5wnu5ZG3eMwVudakUITk+a72lAzSsCuHIUzDuj9UsMM8RLHQ9JnB6LOdWL
         w8CY4xTH+3Iawlnna9CNZwYHFVIqm+KQkhngsaag1I9Js+cJLCCC/aFUQ4MGeGVElT
         wyLcEaCaIFQ1fRosmTleIs2rf6l/lLPwNBVJF22w=
Date:   Sun, 27 Oct 2019 16:40:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx
 device bindings
Message-ID: <20191027164024.685c1ced@archlinux>
In-Reply-To: <1e96ac17ca6819cf8f35c757a63e11e815455225.1571931470.git.lorenzo@kernel.org>
References: <cover.1571931470.git.lorenzo@kernel.org>
        <1e96ac17ca6819cf8f35c757a63e11e815455225.1571931470.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Oct 2019 17:42:34 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.  If you get bored and feel like converting this over
to yaml at somepoint that would be great ;)

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index fc018ecba086..cef4bc16fce1 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -15,6 +15,7 @@ Required properties:
>    "st,ism330dhcx"
>    "st,lsm9ds1-imu"
>    "st,lsm6ds0"
> +  "st,lsm6dsrx"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

