Return-Path: <SRS0=AW8Q=O2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5571C43387
	for <linux-iio@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9D2146E
	for <linux-iio@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545058567;
	bh=2wDGpgWI2SiiV85khxVfy0JphS9KHxDQw6lySVjy4+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o3gNW6c3DevReY9RIEeVWqeeAT6C8VgDJNftzTw/dwrdpQRjBMVaxiAD01BC4K8Ih
	 xXwcLOak5s1TSH/j62jU8uQ13X77HBctbunlUr9SBNRFMDRhuzCoBUWnqkAGrvjJuT
	 OLxZnrtijsIHEG6ytcTryUg+0hVePYAQ9O21zi1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbeLQO4G (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeLQO4G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Dec 2018 09:56:06 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A786A206A2;
        Mon, 17 Dec 2018 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545058565;
        bh=2wDGpgWI2SiiV85khxVfy0JphS9KHxDQw6lySVjy4+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2khJL3B594nyDHrrePnd/0CO/5AHGa6L7PRAr1cFto63SdfCgFvRFhBVBDeCznk/a
         qBwe3+V726GnWgwYWGLbVIHd0vt0scbbVC34FQTHEYJJZCbyxCNGQq3nVbModRNEgC
         KS3wMKFD2HL+EnnxJPnJG1MHT6qa5tHYPXXlUCFo=
Received: by mail-qt1-f182.google.com with SMTP id t33so11588131qtt.4;
        Mon, 17 Dec 2018 06:56:05 -0800 (PST)
X-Gm-Message-State: AA+aEWZ4PRtVb3PixlTovwbwwMmdAi/2dsurdS03sM/8ABus9O+8FTlW
        IlhA+W70yK5wY2tW4SiqQoOzJxU0lnf+4r1oYA==
X-Google-Smtp-Source: AFSGD/UxbmXgqXahXjJeAK1MGc7SvJeZrQ5wPrlhre8TsaaC9ksbfQhnHoTMhfJwAHBtlDta6cIlcAKCU0lDyArpruE=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr13838610qtf.26.1545058564930;
 Mon, 17 Dec 2018 06:56:04 -0800 (PST)
MIME-Version: 1.0
References: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Dec 2018 08:55:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
Message-ID: <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: magnetometer: add dt-bindings
 for freescale mag3110
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        olivier moysan <olivier.moysan@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 16, 2018 at 10:47 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add Freescale MAG3110 dt-bindings and remove it from trivial-devices
> dt-bingding doc.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/iio/magnetometer/mag3110.txt          | 27 ++++++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.txt        |  1 -
>  2 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt

trivial-devices.txt is gone now as it's converted to json-schema. I
can take this patch thru my tree and fix it up.

Rob
