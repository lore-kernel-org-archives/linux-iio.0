Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B68BC433EF
	for <linux-iio@archiver.kernel.org>; Tue, 15 Mar 2022 20:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbiCOUGx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351439AbiCOUGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 16:06:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43938D88
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 13:05:39 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b188so436804oia.13
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/o3xropamkzFBKoPxtFZcdplai1eBlHVrBe67ySlDPw=;
        b=JLsHnoJ1+BP7StMAJyFdbBu/1fjFr9cuCKBxFd4S1z/X3eH2LsIbcdWp0pnymDHOkb
         decoFea4hQgZNycvQeJRtOCJXk48+DqXeHoK08LV7/kW2DISenIpiDRQm5HZHG9PQZGV
         wqYHWL+hN7+jOGU9daeOM61ccLYopC/WuhxrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/o3xropamkzFBKoPxtFZcdplai1eBlHVrBe67ySlDPw=;
        b=n4+T+qwayWUeigHwjjRjC7VW2sucVU0sOZFeptSgTHo79M/GGrnIxy/Zy+VUxg3jpr
         egobhpu/DvL0JDeFpvgW8XdjAQNy70qjMYBvFZ3wsmcWm3IrdzVsxuiimmZdDRhtmur/
         vVu0I2e33MWJeXESlL+p2Ipxz440tO5GGkSznYVAgw7sdhXgZVZ/XYGeRf96aC2RTcM3
         Otz2KSVi03PJS69pn8w+VScJ9UoF8Wam88XZrxXjPXDy0UTIC7gjkwjP+PsdV+EgxNIh
         9IBPWo9A6eYLr8CBHbkb5h++CVwJ6pUduDbISpRtYWjRFTOn/NI6jpndX0ghzNIUN8Yp
         xkDw==
X-Gm-Message-State: AOAM533HhacyiFoqvs4go7YSgacgyMIy/O1fldB5S9o5bx4GSDoQMF3M
        /hZiRU6oXt53gLPK/TrPwg3IMVJhVzcHwLPAZCzL3iZe4Xo=
X-Google-Smtp-Source: ABdhPJzwxMSXgtiNKaV9w6N9EEl7NomfZoRdCu1gupIWYa8T+jMIeBOYHIntW0syvZTNE6KreyPn0CRVNQztgox+pOo=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr2347731oie.193.1647374738637; Tue, 15
 Mar 2022 13:05:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 13:05:38 -0700
MIME-Version: 1.0
In-Reply-To: <20220315173042.1325858-3-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org> <20220315173042.1325858-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 13:05:38 -0700
Message-ID: <CAE-0n52Lp9-F_DxHrb1aMQaiSU2qpuW6jKCp6qQ8FXyJ87WApg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: iio: sx9324: Add precharge resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-15 10:30:37)
> Allow configure the resistance used during precharge.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index b8a6ee16854ff..cd8ed50f2882a 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>
> +  semtech,input-precharge-resistor:

It is clearer when the units are in the name of the property.

	semtech,input-precharge-resistor-kohms
