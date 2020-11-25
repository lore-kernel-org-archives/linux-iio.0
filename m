Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA3AC64E7A
	for <linux-iio@archiver.kernel.org>; Wed, 25 Nov 2020 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9E62075A
	for <linux-iio@archiver.kernel.org>; Wed, 25 Nov 2020 11:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcWcNB2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKYLVJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgKYLVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:21:09 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CFC0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:21:02 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w187so2016214pfd.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5N3Za7cQkKeRuE+wCiMZI+hnOzeFuaTCXukSdiACsA=;
        b=WcWcNB2PHczUTALzgCszqD/xWM55NYYz321mddcL1YwM5/3Nly7kB2N6NEvoCmX03w
         zJHp9sHwzqH64yj/Niev0qfEHR/MUDxoyAMts+HQbDBM6JvBormyJVzSrA1He0qWspeZ
         IieIL59pIGK5SIXFO/elnbLdv7aoxVgvwjMDkXbMGG0AMno5oFIuyk9v4JBJGgnXMtPI
         NCYqYqx4mQxb3Gu+xIQZworiE+hC0wpaSyDdkEGQI92GVsHIN7tBdp7fJP/0OCd2LrBg
         pEXo9ru1ljCfSMZhwqLgDqNOjh14Tl2A2FCiUB9GPikRw2I/GR7sWvc3x/KJKEEVoCxp
         1jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5N3Za7cQkKeRuE+wCiMZI+hnOzeFuaTCXukSdiACsA=;
        b=EJGDUaX4yNBXmACKG6mydGwAMWLuAJQvIq/UpWd2vVtO3VzxNa4R3oCimvs1JEYd5r
         tKJ5K7AgVpchVwkv9Ls4nb7SkChauLuNrQx8NnmhW6tCm5CuCk7iH6pmiY0y93TdHttW
         aCjrTmQeH2p88IuzjOji8hhEwKUasuTPk7Kiq8cGY9mr8N9b2v4nx9piROQzlUJtBYIl
         HW9AQQmPSUtXp/0quIslSWN/s5xSTYrMMs05bMD3Blb+w5c2/muVyD+xHjtKo24QeL1V
         VfElPs1M1kQYwJyEEPz8BTW40exkG4jdo1E3HbNVhMAYeSs+ahoZiM3q7Gb8NNzQkVuL
         GYvA==
X-Gm-Message-State: AOAM531YBh78AlunozE4X/SRXV11IUSvrVGE01iJlFkjjOwm7vvw/KJ5
        nUAbzaz66eO3AfVef6cgKqvNnHkITZBAC72AkI0=
X-Google-Smtp-Source: ABdhPJz0ZwW1/GutL6WWrimFtlUqVLdS/UwCjKUyIadL6bBYJ3OiF5+6YdZk4Sern9I7CjjsHyD3sK8eHG1n8sGP/p0=
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr3699233pjh.228.1606303261748;
 Wed, 25 Nov 2020 03:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com> <20201125083618.10989-4-hdegoede@redhat.com>
 <CAHp75Vd5i7aErbRN9RVeH9H+OdKSqc_OKPnUtWR+cs7iP-Us2g@mail.gmail.com> <db0b5e1e-d643-9af8-a9e5-ad4aec089b0c@redhat.com>
In-Reply-To: <db0b5e1e-d643-9af8-a9e5-ad4aec089b0c@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 13:21:50 +0200
Message-ID: <CAHp75VebUNfQK1j465HN3VYY5LAg-R5qtxHcAfP_cukqVzOokA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: accel: bmc150: Get mount-matrix from ACPI
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 1:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/25/20 12:07 PM, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > I'm wondering if we can come up with some common code out of this and
> > existing apply_acpi_orientation().
>
> Honestly they are all different enough that I don't think it is worth
> the trouble (I did take a look at this, but it did not seem feasible
> without creating horrible code).

Okay!

-- 
With Best Regards,
Andy Shevchenko
