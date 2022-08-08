Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5EFC00140
	for <linux-iio@archiver.kernel.org>; Mon,  8 Aug 2022 21:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiHHVCS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 17:02:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B319C02
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 14:02:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i24so7389275qkg.13
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=dKcHH5wlOZm0l1VaxpWZV29aiJXInKxBaKsXa92RFz0=;
        b=TaHZ/X9axA+mfrAZWmUKgNktS17bV70joJoq9SQjyCpd7hdk8Vh7MKS4vSBuZwMku6
         FncpoaAK0mk0npCSYV6yT2HSeet9VKUqTh6pFNZKNTurT60TW/MtT1CSNPrq1FeDyQFp
         1bLtMyNapyMbpyPgW7WDzZIdGEzVoUr0FNeMea0Bqe5bWis8WU7aXkWcoOrCxT9PxKYc
         gctd0vIRMbXUjmupaLAmbpI4M/zqtJDcwefgasAXra5424YS/mrapuBOirMT5cLqByjj
         5go+z/we1qPJ3dC1S4zXqdiPdsVmofNZkbGiz8r51pgqfGEopCO84nsHDMJKoCXDjpNg
         0oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=dKcHH5wlOZm0l1VaxpWZV29aiJXInKxBaKsXa92RFz0=;
        b=f0sio1okqPhgyvAkOk4HWeaha1N4m3mcfn6zrPv9Ttvgu320mpkNzJh2CJQe0Lb6rq
         lztKARQB+GiomnnGerMEEEzZYJv1LGU5SJzv5jZB2Uciw6LGcAAfE3rmo+vHURZP6mab
         brm67FF9nN3Lb/uExKEDFHtNbu1HOWgsdfVwJZKaejuZ+ouvSS0r2/1wLDrS1Pz1PX+Z
         Y+DgJXd9BL6bsFzZXFPoZ1yy+jqf09hsLMcr3/wu9gYzcNCnBiBCyL7xGZAa4T3dqk38
         gPbgt+MYiL6NUU75DQP7xPrlgpME2j6XcYVKH7UCUr1d6Jj2WRNAW75GYue+Uts3NcHC
         zvCQ==
X-Gm-Message-State: ACgBeo0nYMlm2V7zXAm87sa/CX0X9PJFWYK3s9y4Rdvgk2qQic7WUihk
        M8BMpj6hGyu0x/3+6URhBjO6cFIr12Lqgfa48nc=
X-Google-Smtp-Source: AA6agR5WO6q5Uxy7jkcBlhiGJSRxKu3ATiq4S7QXh/G+QSEec86lZo75/f3SK9i9iDIZekj13lzbRaTSR+6SjhgBvC8=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr15614263qkp.504.1659992536364; Mon, 08
 Aug 2022 14:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de> <20220808204740.307667-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220808204740.307667-4-u.kleine-koenig@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 23:01:39 +0200
Message-ID: <CAHp75Vf=ab3AYn+9dys7vDOr7yBY0cdquE0bMVdZmSk31b5KKw@mail.gmail.com>
Subject: Re: [PATCH 04/13] iio: adc: ad9467: Benefit from devm_clk_get_prepared()
 to simplify
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 10:47 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Make use of devm_clk_get_prepared() to replace some code that effectively
> open codes this new function.

Copy'n'paste typo in the Subject.

--=20
With Best Regards,
Andy Shevchenko
