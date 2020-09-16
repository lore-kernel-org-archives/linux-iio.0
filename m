Return-Path: <SRS0=9OhX=CZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD986C31E40
	for <linux-iio@archiver.kernel.org>; Wed, 16 Sep 2020 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D353208E4
	for <linux-iio@archiver.kernel.org>; Wed, 16 Sep 2020 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600237078;
	bh=Le8cm9gE2z5pfDs8aVJuZRitFzE6151nR7wWrlWTopE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjvhetmPkxpuuKYwtp68eFP0yJJe0Xm1//GtKLEg5RuAR00NbLv8wh/6QHc3wABr6
	 0UYHyIH4gdLWgGQtVxy+udfApiryYMiEF6rKtaaTda6AeRcH2bTXKiGnOSLGBzc695
	 yhhwGZqpoGBm9lIgXV816kMaVcVlh2y1mkFOfHTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIPGRz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:17:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIPGRx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 02:17:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id m6so5618637wrn.0;
        Tue, 15 Sep 2020 23:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vW5SNbsYECBXjdZ1DGGkHYYubwmAc4H6dnKQMUSdNQ=;
        b=ZOIue+DuPibp02cAhjTcdne/FL6c/Ls7msxQVjIotiE4Yq+Ui9kQJvOmRtzrudZBoR
         fPG5u5c2U5cWsrCH0OkMP1CqpWgH+AzEAmwK3mJts0FiBQc0Kdbu5ybUAyfroIG4EBf+
         TJ9tJoUGmt2xgDlfK2DOgW8xNi8fKsBxiqQ+kXC78G2XL4As8UeS4kQ7TWW2N9XdGQZB
         cLv6jW5JEZWAoZLDpnOe/EhVGrg0uJXWLQtdJVr+5XlrxS63/Z8Y30ps8dBVeoQonT7Z
         N2/jMLJr5czqUdJxuOPxK/zmJEd7qO2tpWdPe9GT8crqA6aatVhRPLlx7rcsZkvL9Qww
         pjDA==
X-Gm-Message-State: AOAM531EENRzP/QLoZp/ceHW/T3r8USsuXG6VixdNXgBRvmiIH8Mo//5
        fzcjlcyX4lTLb3v42rfHWCk=
X-Google-Smtp-Source: ABdhPJzMLOJzsclIPzvuI83RUFmsd5HgaJ2eaBsTbqc3L06wuPMXJeI+OP+Ge57HQlUgAnZDDyL8RQ==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr26008097wrs.416.1600237070506;
        Tue, 15 Sep 2020 23:17:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id z19sm3344360wmi.3.2020.09.15.23.17.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 23:17:49 -0700 (PDT)
Date:   Wed, 16 Sep 2020 08:17:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
Message-ID: <20200916061747.GB5719@kozik-lap>
References: <20200910161933.9156-1-krzk@kernel.org>
 <20200915194444.GA2384148@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915194444.GA2384148@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 15, 2020 at 01:44:44PM -0600, Rob Herring wrote:
> On Thu, 10 Sep 2020 18:19:32 +0200, Krzysztof Kozlowski wrote:
> > The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> > screen.  In such case the second interrupt is required.  This second
> > interrupt can be anyway provided, even without touch screens.  This
> > fixes dtbs_check warnings like:
> > 
> >   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Fix if:has-touchscreen, as pointed by Rob.
> > 2. Add Ack.
> > ---
> >  .../bindings/iio/adc/samsung,exynos-adc.yaml       | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Jonathan,

Could you pick up these two?

Best regards,
Krzysztof

