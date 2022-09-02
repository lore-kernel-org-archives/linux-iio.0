Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC40C38145
	for <linux-iio@archiver.kernel.org>; Fri,  2 Sep 2022 11:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIBLhn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 2 Sep 2022 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiIBLhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2022 07:37:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C286DAEB;
        Fri,  2 Sep 2022 04:37:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s22so1462748qkj.3;
        Fri, 02 Sep 2022 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=X8xtrUCKqZajvHu5+7HuoJE7xw33jPFSJSluYQKlujk=;
        b=GItxyUUGsjQiIQCULMB992VpRkYQdUdHKsA+OXykiNHBcpCXrBfwLBmFBLzJrCcUev
         EljzItxO3wXmb3TI4bO+QZseuIQGwczf76XEJId5ZhXvsNDA1l5d6E9CGj90rFQSOXfl
         ztmAWhmZbz+1Uy7sPh2V5cQNu+QvQGIOiW3XtJYZEk/nYIl5BjNZkwfBuqbsu7XoAFny
         vmhVZyPr/0RbqtU4Ho6qsUKAYMlklj9frfEy+JnMjAiEnQIIFEqknr9XuR6Pd5LETAwu
         P9h9Z/I/MwT7JOPj0EzvxAraenVBMO+2EhVG1g2mhhTvjHjoq5yNPWooIEtHSg8DvR6w
         HGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=X8xtrUCKqZajvHu5+7HuoJE7xw33jPFSJSluYQKlujk=;
        b=CES8IqDLvC76uMEtOAUP3p+ImLq7LxTeAm9dsN9hiFY6SoBYp02V08pjxirHbYELRm
         qvtmAugBJAWjogWO6huwFNaSL7YHdw9lbEXzPMHNT6xMfNavATnVonA6S67mrbVpiDy+
         DtVv5f3kjm2Wt8C5Vd1xllrVS1wq95OYbcgFujEGvX4bRh2T4tPVCE6e8Fmshx7Xqt6Z
         fXFd2oIceeRKgfbObVke7Pnq0D6j7BMQpJkIHe+DOQRylLNmcAq1PW1Zhj1z8BZc+3nd
         +iQMH9grNrFgsNdQQNslgzGIi2OKpeNCRDp7dsNLPwfg64v9+bLTKFwY1idjGO5KQakc
         0Zuw==
X-Gm-Message-State: ACgBeo132yJuJ1onGw+TJ+Hv5cmoB+Olmqk7D0sTjGS6qVKcDwHrHs5A
        MqMPpKYhiL7nx92J/gBlHQvp+4JgqDPGOeEkB19TKVfLe2k=
X-Google-Smtp-Source: AA6agR7+U6uwe1PA7UjZ+XB9y3+G1dNuM7weiJvpRUp/HWEglNmD2Cz3AnHFcBk7ysDWr8oERmuizarE9B8SMnlbw8I=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr23202158qko.734.1662118659415; Fri, 02
 Sep 2022 04:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
 <20220901121700.1325733-4-ciprian.regus@analog.com> <4067432b-b5a6-f3eb-a707-5fa298ba846b@linaro.org>
 <20220902120611.000007a0@huawei.com>
In-Reply-To: <20220902120611.000007a0@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 14:37:03 +0300
Message-ID: <CAHp75Vfn_84-xww5w_oHf0zqm4dZxycSU1cDKw7-KQzDyoCHXw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 2, 2022 at 2:06 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Thu, 1 Sep 2022 16:23:09 +0300
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > On 01/09/2022 15:16, Ciprian Regus wrote:

...

> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> >
> > Missing blank line. Use standard Git tools for handling your patches or
> > be sure you produce the same result when using some custom process.
>
> My understanding is Datasheet is a standard tag as part of the main tag block.
> There should not be a blank line between that and the Sign off.
>
> +CC Andy who can probably point to a reference for that...

Yes, the idea to have a Datasheet as a formal tag. Which is, by the
way, somehow established practice (since ca.2020).

-- 
With Best Regards,
Andy Shevchenko
