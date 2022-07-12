Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE04AC43334
	for <linux-iio@archiver.kernel.org>; Tue, 12 Jul 2022 10:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiGLKN7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiGLKNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 06:13:51 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21210575
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657620823; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywWribJTTZFbV3ApkjZ8ZgaJdnBPAexNA/5Lgp6iic4=;
        b=NQna0GEfixmlCngO4gAQ3g44Jt9WALqj3PSMV8tdYM6knJrZV1KZ3PkmjSTWEDaean7JnE
        wwjOqisSOnTW+PINGxs3if3wsiKjc5VJn/qc5rCcZatIN1+TGezjbC4rfToX5bWOWH3wA+
        aKueXtfVyFoGD6Kh0HD+sNdUrm9A+3E=
Date:   Tue, 12 Jul 2022 11:13:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RFC] iio: afe: rescale: Add support for converting scale avail
 table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Message-Id: <MEKWER.12CQ7QOMG6YC3@crapouillou.net>
In-Reply-To: <CAHp75VeLktz27cTDwpoBMUNkuyz-C_jXtgxQxjo=m1FFBWqQYw@mail.gmail.com>
References: <20220711193714.50314-1-paul@crapouillou.net>
        <CAHp75VeLktz27cTDwpoBMUNkuyz-C_jXtgxQxjo=m1FFBWqQYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Le mar., juil. 12 2022 at 10:24:02 +0200, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Mon, Jul 11, 2022 at 9:46 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  When the IIO channel has a scale_available attribute, we want the=20
>> values
>>  contained to be properly converted the same way the scale value is.
>=20
> Beside that not very readable `foo <<=3D x =3D=3D y;` line, I think this
> will look much better if we first convert the rescale driver to use
> struct s32_fract (or whatever is suitable).

More like a s64_fract since IIO uses two ints + a type to represent how=20
the value should be computed from the ints.

Is something like that already implemented somewhere in the kernel?

-Paul


