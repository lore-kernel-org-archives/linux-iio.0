Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82528C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3B20829
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595086769;
	bh=A21zkqHie0c/lAiPqKuKHl7yFQhPCvHWm/szIOcC8P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x1G/wl6f5YBYnrrwnSELkSYew3khIiK6xVEIZQObmrySrRmQ9/0QrkxUbUdqW9XsL
	 GxXfPLBqognbsyEIRn0r1xvMr3wY6H5L5YId8rOI6w2GcqDHuIiFG+7pKUkmkxPa6Z
	 NFPvxmcy+NTJ96TGMzmetuJhIFOdL01gHnUnYpzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGRPj2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPj2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:39:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6A320734;
        Sat, 18 Jul 2020 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086768;
        bh=A21zkqHie0c/lAiPqKuKHl7yFQhPCvHWm/szIOcC8P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lO5ZVtAlOZaL6KKjNTNbJgYH0XFIWMLluoB8yA2/WNO/UxJzUB0IUXCGTyhkE/uCb
         2m0qSBTaqyydsys0ccpVJRz7LryF+wQdsg1AUhlChMTBzTBDQgPjuMV99XPGhoRagK
         wvIlIZRMutTBnzALdIoHdLs4EgmfAiES5vdpGkT4=
Date:   Sat, 18 Jul 2020 16:39:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: Re: [PATCH 06/30] iio: dac: ltc2632: Fix formatting in kerneldoc
 struct header
Message-ID: <20200718163923.07536fdd@archlinux>
In-Reply-To: <20200717165538.3275050-7-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-7-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:14 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'pow=
erdown_cache_mask' not described in 'ltc2632_state'
>  drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vre=
f_mv' not described in 'ltc2632_state'
>  drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vre=
f_reg' not described in 'ltc2632_state'
>=20
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Silvan Murer <silvan.murer@gmail.com>
> Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index f891311f05cfe..733f13d3e5df4 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -38,9 +38,9 @@ struct ltc2632_chip_info {
>  /**
>   * struct ltc2632_state - driver instance specific data
>   * @spi_dev:			pointer to the spi_device struct
> - * @powerdown_cache_mask	used to show current channel powerdown state
> - * @vref_mv			used reference voltage (internal or external)
> - * @vref_reg		regulator for the reference voltage
> + * @powerdown_cache_mask:	used to show current channel powerdown state
> + * @vref_mv:			used reference voltage (internal or external)
> + * @vref_reg:		regulator for the reference voltage
>   */
>  struct ltc2632_state {
>  	struct spi_device *spi_dev;

