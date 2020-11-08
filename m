Return-Path: <SRS0=U73b=EO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E8EC388F9
	for <linux-iio@archiver.kernel.org>; Sun,  8 Nov 2020 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C6D206F9
	for <linux-iio@archiver.kernel.org>; Sun,  8 Nov 2020 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604847717;
	bh=nBBiYhyBMYyuzkFFQeyoQ/e7it2VeLtlzMDQFNcCHh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z16+EKQNkAc8qyStckYcT2aOvJonul376JB17wGnkJ3+hexEg/CFH8z7W2dQNx07Y
	 WXgXdJvf8uGsVtP0uopYXxTCAQCCRPqQCoqMenFEVeEg8oNpTGU8NNNyxPJP8e8tRT
	 tog7EplhU7NcziucwpPMfFAPqAq/agJptHnt4jHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKHPB5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 8 Nov 2020 10:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHPB4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:01:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0F0206F4;
        Sun,  8 Nov 2020 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604847716;
        bh=nBBiYhyBMYyuzkFFQeyoQ/e7it2VeLtlzMDQFNcCHh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eQgPSdvAh8GUN7n8TtjZKP681RH+ioT63ULA6v45ki0XMBUHoxP0HDpGf+Ak3fWBj
         jTkdqzGXnD2BF/rEic5iWwXun3vZ29Gronl6ZJ5Opt4LyeQc4FcDZmbUox6P/E64aL
         uYYGq55HWMjJDitchR0ZEDgBf0fLK1FCBah+2tro=
Date:   Sun, 8 Nov 2020 15:01:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH] MAINTAINERS: Fix 'W:' prefix in Invensense IMU entry
Message-ID: <20201108150157.077b3408@archlinux>
In-Reply-To: <20201108013738.1410528-1-j.neuschaefer@gmx.net>
References: <20201108013738.1410528-1-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 Nov 2020 02:37:38 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> The colon is missing, which can confuse scripts/parse-maintainers.pl.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Applied.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29d..80defad325f31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9160,7 +9160,7 @@ INVENSENSE ICM-426xx IMU DRIVER
>  M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -W	https://invensense.tdk.com/
> +W:	https://invensense.tdk.com/
>  F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
>  F:	drivers/iio/imu/inv_icm42600/
>=20
> --
> 2.28.0
>=20

