Return-Path: <SRS0=QEvZ=WB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE28C433FF
	for <linux-iio@archiver.kernel.org>; Mon,  5 Aug 2019 16:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30996214C6
	for <linux-iio@archiver.kernel.org>; Mon,  5 Aug 2019 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565023225;
	bh=ziM0yeHQLS5E+0hRqzHWZbqv3KArpseVpW7RQ5DsrAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k816EeJkHev9ybOamhhemG7DXHUMywdZwUTcxYRU2A8kXx6UWrX8LDe1geGkVhZTG
	 jI842P03/appoctgWuvYwdYqg17RaykkliUNNXWOrqcbehxzeuWBpQOKkYNr9O7m2O
	 5XjSoQ/w3Y7dBkrH4Sna2SHC+MP46Lo4GrLYD3HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHEQkY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHEQkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 12:40:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC132064A;
        Mon,  5 Aug 2019 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565023223;
        bh=ziM0yeHQLS5E+0hRqzHWZbqv3KArpseVpW7RQ5DsrAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lZsv1FVi/FMLRUyJrfV5eljUeoo/bSQbWIUvvXHEJB1/9j7tba6JqCYpVs1qtgqfm
         4GM8PDexoWXqE/ECmjnXEBM/+qnIRe61NyVyvA/tOAtCBNvBEiNPWjprtnLm1fT7+R
         KP1OVK1B+3bWJdoV10lcT5h7U1w4AKi1uZ42epv4=
Date:   Mon, 5 Aug 2019 17:40:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: frequency: adf4371: Fix output frequency setting
Message-ID: <20190805174013.6d261056@archlinux>
In-Reply-To: <1565016763.13789.4.camel@analog.com>
References: <20190805133716.7808-1-nuno.sa@analog.com>
        <1565016763.13789.4.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 14:52:44 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> > The fract1 word was not being properly programmed on the device leading
> > to wrong output frequencies.
> >=20
> > Fixes: 7f699bd14913 (iio: frequency: adf4371: Add support for ADF4371
> > PLL)
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/frequency/adf4371.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-) =20
>=20
> Reviewed-by: Stefan Popa <stefan.popa@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

