Return-Path: <SRS0=T24/=3H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F47C33CB1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jan 2020 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F32469A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jan 2020 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579354597;
	bh=gS0FpdIGCTXsJZGpT65ekhWKidMVCXDvjjsVjOFw2WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TXrULrb91O+uL4Y6EdgkByk+8KASkQklg/NlhEKsPEuPR6/JWWHFEMNgY5w33+x2G
	 1/eJ6ngi4iU896+PcpqJ9NiX4HDZwUu8reiHaZ0Lv93MNIgNofJic7vpfQjy10L0Pj
	 4dMztqJ2F9HnuY2i4bY9BNk7NUvVkGgdR113Y4OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgARNgh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgARNgg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 08:36:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2F524696;
        Sat, 18 Jan 2020 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579354596;
        bh=gS0FpdIGCTXsJZGpT65ekhWKidMVCXDvjjsVjOFw2WA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJD9E9Mmu4lcx9+EWAu3bqjGQAyeG15sovjzS3r5OfKntg8DEoTKItOK4TgCBCXuZ
         z924H5UE3z8fwqzQrIRi5eGUk2JlQ/DnETNabdQqjKZcfFMuRyj4xosdMpztl/MSmp
         IyOwM8b1ncGRVR2cM5rGAHIbXR9s/Pkp1i7BvEhU=
Date:   Sat, 18 Jan 2020 13:36:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adis16480: add compatible entry
 for ADIS16490
Message-ID: <20200118133632.2b4b15e5@archlinux>
In-Reply-To: <20200116131148.18149-2-alexandru.ardelean@analog.com>
References: <20200116131148.18149-1-alexandru.ardelean@analog.com>
        <20200116131148.18149-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jan 2020 15:11:48 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds an entry for ADIS16490 in the list of compatible devices
> defined in the dt-bindings of the adis16480 driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> index ed7783f45233..cd903a1d880d 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> @@ -8,6 +8,7 @@ Required properties for the ADIS16480:
>  	* "adi,adis16480"
>  	* "adi,adis16485"
>  	* "adi,adis16488"
> +	* "adi,adis16490"
>  	* "adi,adis16495-1"
>  	* "adi,adis16495-2"
>  	* "adi,adis16495-3"

