Return-Path: <SRS0=rjN2=C7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C00DC4727E
	for <linux-iio@archiver.kernel.org>; Tue, 22 Sep 2020 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD2F238A1
	for <linux-iio@archiver.kernel.org>; Tue, 22 Sep 2020 21:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yo/dZ0rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVVnm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 22 Sep 2020 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVVnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 17:43:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D00EC061755
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2020 14:43:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so2124687pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2020 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=53UukHq1kI2LdwgBLERIarUaHHt0dzvP8+s+/bYd0A4=;
        b=Yo/dZ0rKd7ba8E4CjQo7R++SRdvO91W2Be1bVaFPNpmftnEjeKNMhZyfqtTOHgkWss
         NA8eRjWJXrhuQbVpp/7JhT0BMEbSDuZUo44llHK33htMK3ZJX/eQ6LnsomI/f72O4GMa
         /+zTRQXI3bTC/qi3kJ4wNKx/TwM8xJxGFH2ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=53UukHq1kI2LdwgBLERIarUaHHt0dzvP8+s+/bYd0A4=;
        b=nsl7oaUpRdTKidxysdvMr8fJXqfWgoZgSgTspV2P4Y/WLpLNxUmL7bJ5c/+IBFc5yA
         79lPev6vi/MAqnl07gZfb8CwPf4t0ZeEFMb0DZy7LZAbhr9lMM7pVF9TaN0r1WlGOEAw
         J4W/RCpietKCHLjFVcusdzPTFtC5QbSYDVzDmlu/Y0KpuufzOC8NyCcMpQsxcVG3iMVE
         HLS8qUKmitv6j4hyJ/Sfw0ZUGmbMTIhEAZpqKsRiAEFaj6chHnJduSOESxF8TxglDy/w
         FMnkJsBaOzq/WGEmkBLiBQKT5dqLXZc7R49cQDYfSrjA3r7/mD6gFHZY/rvX4grIGXiq
         sj7w==
X-Gm-Message-State: AOAM533KLNHZAaPzbsfgbEadlcMYdx0HBUFfwc0A2lPpvyd3xNr6Z1Lr
        mVxYvaLHWK2cdVG2MEsylq8n9g==
X-Google-Smtp-Source: ABdhPJy9rBpspmhIKC5WF3bw8wowSoG4ZWVQC2GUasuY/7UVLzNqqUZ6h/5v8Wo5mE23MeV9k84F1g==
X-Received: by 2002:a17:90b:707:: with SMTP id s7mr5518349pjz.25.1600811021681;
        Tue, 22 Sep 2020 14:43:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y25sm15572761pfn.71.2020.09.22.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:43:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914210047.GA232617@bogus>
References: <20200903221828.3657250-1-swboyd@chromium.org> <20200914210047.GA232617@bogus>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 14:43:39 -0700
Message-ID: <160081101949.310579.13737183960958276765@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Rob Herring (2020-09-14 14:00:47)
> On Thu, Sep 03, 2020 at 03:18:28PM -0700, Stephen Boyd wrote:
> > +  semtech,cs1-gain-factor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [1, 2, 4, 8]
>=20
> Now that everyone is trained on 'allOf', you can drop it. json-schema=20
> draft8 changed this behavior.
>=20

Ok. Do I need $ref: still or that is implicit now?
