Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F817C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79802186A
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552755254;
	bh=X/e5CiGv0bpKgfoAOKqE6UfbH0ccHP8lu6bZGZ/KPj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n96c+1zuIrDLSpTFiFWqzszhGFkKWHVY+rRozxM90ImbH1HrwwirwS0J9O2DuDCp6
	 hkMJqE3nX7beWo7K/JX1SRDTUT/EX2Gsp4NfsP7H79tB6rG0ycczQW7p4nVHqH8ohK
	 8hnvYmkbYpsE7NSel6+S8EsbZKUSEZwCMqvFy58g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfCPQyO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfCPQyO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 12:54:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A9B2075C;
        Sat, 16 Mar 2019 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552755253;
        bh=X/e5CiGv0bpKgfoAOKqE6UfbH0ccHP8lu6bZGZ/KPj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OmBB8UoJI+bzBHGQtpFY9nuU8Sir8/6kHRngSO8XxCbk83mLjNGCKOIUvKRiz24Vh
         1kDPBiXRwy8QRqy+/ytKR//riTHVV1HASgn1zrzuqzNFf/l0LOx+eS6HogG5vBmOdK
         3dr9bQXlIUJ7Ry9Yh7+HQrRtWH9sIRI7F4RujYwU=
Date:   Sat, 16 Mar 2019 16:54:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsox
 device bindings
Message-ID: <20190316165409.2d9e0cbf@archlinux>
In-Reply-To: <a633a5633b93d4a131a88b94d29ea263eea64fe9.1552643968.git.lorenzo@kernel.org>
References: <cover.1552643968.git.lorenzo@kernel.org>
        <a633a5633b93d4a131a88b94d29ea263eea64fe9.1552643968.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 11:08:25 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied,

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 8f1b09e39c72..4640a012c17a 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -9,6 +9,7 @@ Required properties:
>    "st,ism330dlc"
>    "st,lsm6dso"
>    "st,asm330lhh"
> +  "st,lsm6dsox"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

