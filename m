Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25729C433F5
	for <linux-iio@archiver.kernel.org>; Sun, 27 Mar 2022 14:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiC0OaD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Mar 2022 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiC0OaB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 10:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F317668
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD606102A
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB05C340ED;
        Sun, 27 Mar 2022 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648391301;
        bh=8xt4w+NWLh5i3HPicQb7aqhUiVqhmdDAexin6Au8xKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pGmb7LU+E408hgmOA3agliGAs5zDvetsZwqfydq21yBtWow1t71es4J9A5sA0GRP9
         BL2OhqKT6up0kcfj09/C8ob0gC/zpIvL1TLbVH4tM8M+z90AHk6kxWFWQVPS5ZbOu4
         shSe/HuvxTIBqoLdZ8aVYhHzcApEUdFyPfXbGaRghisdSoYjlns69X5YY0uBqR27Nn
         y331Hh+QFe4Jgx2AUcJuOpuuNC93c+rwqIj/3UibnTzQ/uzJXOxPuJ5YdY/r9quJ0z
         U031V8HhaubwsUF0noD1HICP4ZLROOVzgrRfN3xsqHKSlvzJ1Vr4dsmJpskYWdKDc0
         ZthjqZw3B0/sQ==
Date:   Sun, 27 Mar 2022 15:35:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] MAINTAINERS: updated Lorenzo's email address
Message-ID: <20220327153555.289eddf4@jic23-huawei>
In-Reply-To: <c75f0e1c683b6ad0333d5504fb00c6f1b14dd1bf.1648114531.git.lorenzo@kernel.org>
References: <c75f0e1c683b6ad0333d5504fb00c6f1b14dd1bf.1648114531.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Mar 2022 12:05:43 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Using my kernel.org email for iio devices.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1dfb3fab5f8..2c4fa8eb1e9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8915,7 +8915,7 @@ S:	Maintained
>  F:	drivers/input/touchscreen/htcpen.c
>  
>  HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
> -M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> +M:	Lorenzo Bianconi <lorenzo@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	http://www.st.com/
> @@ -18399,7 +18399,7 @@ S:	Maintained
>  F:	arch/alpha/kernel/srm_env.c
>  
>  ST LSM6DSx IMU IIO DRIVER
> -M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> +M:	Lorenzo Bianconi <lorenzo@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	http://www.st.com/

