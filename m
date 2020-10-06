Return-Path: <SRS0=IObS=DN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC4BC41604
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF50E20789
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 07:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601968130;
	bh=OxzGt1kFtMJ7gtU6zDQQYWvzhLcjesuXJvcefsYMV3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RevrLyMK6eKY5l0ZC98iy/CGbk5PFPhKOVf1faGfYqFb/kgF/JYOwwF5mvnljzaUL
	 T5Mxk6GRgQPDM8ngdlA4itKuv5Q1hIxpTuisPIIpVeKBWXuuhA6o0k+sovl+9+Lltv
	 U4uXxMEn9lsl4X+Dgdc+jh7rqHwpZhkK9cuViJWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgJFHIr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgJFHIr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 03:08:47 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C0120866;
        Tue,  6 Oct 2020 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601968126;
        bh=OxzGt1kFtMJ7gtU6zDQQYWvzhLcjesuXJvcefsYMV3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UfLg53ERF6V+iy5l7L5knqZ53sktCfmF3g+zDw2pZm8zfNGsdOpFg7q+ihwJmOMnb
         BCOxKLA9aa91HkT7X+c6DXPnwlijjpclvhrbRcvZWk5yQqroEUBXlSNxOwYHhB+CgS
         HyuqeYqOhZbFLR0RkU4vTjF4vLN2oLyHc0c3Te+E=
Received: by mail-ej1-f52.google.com with SMTP id dt13so6667173ejb.12;
        Tue, 06 Oct 2020 00:08:45 -0700 (PDT)
X-Gm-Message-State: AOAM530P9+T92f1o3Ly7clfQxaqDfs55rSWjDD5Bv+e3UOUnXAtDI++r
        dRPhqoPt0dA84Y4BLbU9kJ8Xe2oTZc3WeC2QUi0=
X-Google-Smtp-Source: ABdhPJzLhPEqvT6J5geGmoPrQ7IMn3x8MOdczLNtU8+s0aEKZxKZUoL/SxJbXP5Lz/uWo9ZtsXhlGuOCe+asmSXMEd0=
X-Received: by 2002:a17:907:43c0:: with SMTP id ok24mr3586572ejb.385.1601968124314;
 Tue, 06 Oct 2020 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201006041214.GA4145870@dtor-ws>
In-Reply-To: <20201006041214.GA4145870@dtor-ws>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 6 Oct 2020 09:08:32 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfgDcNOuO6RJpLjacvKVSPg5siLnC+2sKKhJmPgCrGpDA@mail.gmail.com>
Message-ID: <CAJKOXPfgDcNOuO6RJpLjacvKVSPg5siLnC+2sKKhJmPgCrGpDA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: exynos: do not rely on 'users' counter in ISR
To:     dmitry.torokhov@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Oct 2020 at 06:12, <dmitry.torokhov@gmail.com> wrote:
>
> The order in which 'users' counter is decremented vs calling drivers'
> close() method is implementation specific, and we should not rely on
> it. Let's introduce driver private flag and use it to signal ISR
> to exit when device is being closed.
>
> This has a side-effect of fixing issue of accessing inut->users
> outside of input->mutex protection.
>
> Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> v2: switched from ordinary read/write to READ_ONCE/WRITE_ONCE per Micha=
=C5=82
> Miros=C5=82aw
>
>  drivers/iio/adc/exynos_adc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
