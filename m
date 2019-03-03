Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE3C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0320842
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551629546;
	bh=sRQoTCJ3QYhE12rrZc8A47r/lHOpR8BNi9e7/LkPs9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lt7eZ+i0KOAruRCo3eMfd5vQSLejyxjyB/3zd6KuggMVg/ozwm4vKHVVMJ6c9HbW9
	 WLL9DTCQ6siM/Ghy/jFe+cGuxUSqxTG5xMBWlTRm5/D6eiPCSLHt5YOqf5ho82TJy7
	 duBkRWXMDQLUK72OvGNYI9NB6nIuagaYVOhv412I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCCQM0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfCCQMZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Mar 2019 11:12:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4782075B;
        Sun,  3 Mar 2019 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551629545;
        bh=sRQoTCJ3QYhE12rrZc8A47r/lHOpR8BNi9e7/LkPs9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rYQ1befc12AF/8AFpp+rYI7FMKz6H/0B2Lw38fIczPi4yhtiU2BySeeKMDME8vXZg
         CjiWCbo9NN5KG70S3+t2nrH3tJH0KE25cM2VhCAC06bFnfKMR6jP7fgC5PA8Z/Tdlh
         MSNQyeu+MyaiMjmsXvnwOp6yJUJIadQxEbQI0omc=
Date:   Sun, 3 Mar 2019 16:12:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhh
 device bindings
Message-ID: <20190303161220.6416e777@archlinux>
In-Reply-To: <1df29add6d5a0fcdd51594f8cf4366c9086f6fc9.1550753006.git.lorenzo@kernel.org>
References: <cover.1550753006.git.lorenzo@kernel.org>
        <1df29add6d5a0fcdd51594f8cf4366c9086f6fc9.1550753006.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Feb 2019 16:20:21 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.  Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 69d53d98d0f0..8f1b09e39c72 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -8,6 +8,7 @@ Required properties:
>    "st,lsm6dsm"
>    "st,ism330dlc"
>    "st,lsm6dso"
> +  "st,asm330lhh"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

