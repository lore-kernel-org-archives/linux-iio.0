Return-Path: <SRS0=mPBy=TH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA7C004C9
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 12:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7E6206BF
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utoZSJvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEGMhT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 7 May 2019 08:37:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41062 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGMhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 08:37:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id c13so18741787qtn.8
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2019 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BmUAXf3w3lUWjIG5MCP+ObcqnAZPTJqLAABuKptsGWI=;
        b=utoZSJvfs05uD4OUOqhPincz36/jF7KEYxS1N5u0jbxqxVffPWDOcJDJ5VwviBr9Df
         5mT1MDrRWVjA+fWJbzKQkM3W+IMxJRDuEhQnMEIq6KAGPoZgm9FndS2/ey2HKh6jQ+et
         wQcacxyvEVaqL5dg8yd3/YMTrSJFmkTfjBjF30WdzFQtys1MLz6gS/kVqkt3cdi+UB7/
         SaMy/O1wdfdlTTwmCj/zytMZyL/v022L+gHMmAsfEM+uATZAkzMAqqlYaJbvWNUhSp1v
         ScoLbrIAOLXlKxctfA+tBa/dcmLg0uS4ZIiz4oO11OCIh8AQcw9bj6fdqU11R/Ac4r+3
         prgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmUAXf3w3lUWjIG5MCP+ObcqnAZPTJqLAABuKptsGWI=;
        b=FlFrVVbkc2m6ZJj2POtRtOWaG9ktCqgV4bKuIpsMRaQ3HHXsaf5wuAJ2MSc14rDRY8
         ZgVhcz+3kYm7IAdA4tvGbK5ogBfmJQ1xfT82QCmdlqoaUn/qaZGLa+1afMjAxrgr4/oc
         thCR+7+AJ6Ag9gvHn5zf15nkhCkGokRSo2jUCVpjP27ppKI5OTh64GW9mwdrCOQwAhO1
         TWk3sSVpcb+U9lXEafAwAJjWuv1yB7c9q4712RszT0ugEbC23g6YT4kVTtWWvqfFZ046
         H/IqX3aWuQKLd/CIgs5IZxCbGJ/2ohMU7ygvnc3L54f5DA1HVM0LRtBjj0jNJn1L+9ym
         jivw==
X-Gm-Message-State: APjAAAWjD83sV3jXgALNdXS7Sd3y5GhWM2Etd3ewWNOHwpjsw48yJe5K
        xpHzCdmpc8yVkEPPMmQSGE7/To1uRJskOOJCamy17A==
X-Google-Smtp-Source: APXvYqxzEEY3udrVePkgazPG3496eLQSQxbvlpGQHKpnE9guF5wQuzNAbGB400oIN9bMhYCGv0HG/j0mBXlsHJYEl9o=
X-Received: by 2002:aed:306c:: with SMTP id 99mr25711109qte.38.1557232638409;
 Tue, 07 May 2019 05:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190507091224.17781-1-benjamin.gaignard@st.com> <20190507101729.GA3420@icarus>
In-Reply-To: <20190507101729.GA3420@icarus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 7 May 2019 14:37:07 +0200
Message-ID: <CA+M3ks4LhOFTeArnh3d=C02qLJWj_u6tWDDOhD8kZnJPRkXC8w@mail.gmail.com>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le mar. 7 mai 2019 =C3=A0 12:19, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > Quadrature feature is now hosted on it own framework.
> > Remove quadrature related code from stm32-trigger driver to avoid
> > code duplication and simplify the ABI.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Although this functionality is now provided by the Counter subsystem, we
> should keep the IIO Counter interface for this driver intact since
> existing user applications may depend on it; this is the same reason why
> the IIO Counter code in the 104-QUAD-8 device driver was not removed
> despite moving to the Counter subsystem.
>
> Once user applications have had enough time to migrate to the Generic
> Counter interface, we can consider removing the deprecated IIO Counter
> interface.

Hi William,

This SoC is not yet in production so their is no legacy on the old interfac=
e
and I would like to avoid to create one.

Benjamin

>
> William Breathitt Gray
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
