Return-Path: <SRS0=wvAN=YF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBBC4360C
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE692190F
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570889367;
	bh=yhjv4gNucK6hAVURbYYazULVvJU9TPLkIhSRULYnJUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x3RN0yQWo6nGiZWoldhYnnCIpymrRF0eNNsZPPfH1VWBfhhkZwYfpX8LvODVzniSQ
	 kkz/qOH0o0gmczEF5VaTtI3otJ/rFMfLoh45g2yNGivDCffIxUBZlu6sTxAu6y/ZfE
	 N7+QpuoGxd9xsi0OuLUNxsF1jpKVNMq89Aj/2+R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfJLOJ0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Oct 2019 10:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfJLOJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 10:09:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021FF2087E;
        Sat, 12 Oct 2019 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570889366;
        bh=yhjv4gNucK6hAVURbYYazULVvJU9TPLkIhSRULYnJUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZ1u4QqC/EmGer2tn9h4PR2yz4ldnPlWF8eNhVstJ9C0aUL9mC7/rfUiT8HUj0982
         2R3JpBCyhU9ouAt90O40zt89jB3jCiv30HGWId6rK3VvI6Q28/VMj9fftdtN4KHd+U
         H3Cgn+fTc5UJ7QqcZdymdioDpH2zxSIADwIC7zfo=
Date:   Sat, 12 Oct 2019 15:09:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0
 device bindings
Message-ID: <20191012150921.6988ca5b@archlinux>
In-Reply-To: <86786d8de65eb1c2b16e8433aa673d217cc27dcd.1570441034.git.lorenzo@kernel.org>
References: <cover.1570441034.git.lorenzo@kernel.org>
        <86786d8de65eb1c2b16e8433aa673d217cc27dcd.1570441034.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Oct 2019 11:43:38 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

Now a yaml conversion would be cool if you happened to get bored ;)

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 1a07d38c813f..fc018ecba086 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -14,6 +14,7 @@ Required properties:
>    "st,lsm6ds3tr-c"
>    "st,ism330dhcx"
>    "st,lsm9ds1-imu"
> +  "st,lsm6ds0"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

