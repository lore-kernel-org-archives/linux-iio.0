Return-Path: <SRS0=LfIq=YJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB4FA372B
	for <linux-iio@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C924218DE
	for <linux-iio@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230548;
	bh=rbNfYXot6B4phReyHmLnQcdB4k3mkqDFtqJzuIKNx7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bGwKJ3jbfbvVrF7DGC6hN/LTtGR3/NqyCRFvdGsgBi1xbgLfZwYS7Z7Qce+gb0GAu
	 YnDhpcrRM2yH4MEydOv54HwY4r/sD5jIWQDXgGkR/1NyRBjqZwxJG0dIGefSGiv/ur
	 oHNIX3njJym1hfBxvhc5eb3427cRrD6U9KGszm90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbfJPMzr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbfJPMzr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Oct 2019 08:55:47 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BA621928;
        Wed, 16 Oct 2019 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571230546;
        bh=rbNfYXot6B4phReyHmLnQcdB4k3mkqDFtqJzuIKNx7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XdSjKEi9tZBvfFVluQBY8ZfCuOD+oIR57IeVyfwjlx6GIgIi3A+DhZkxbR/h1DASb
         1ctAvNbkHWVLFXCpiRE7G5GbHBKiI1I4PaowB7mc/J2DnT1sjm30bW8acSAmRzvp4t
         arDx5HApCJcjpawgUhzMuhiVHzeJ7c6Nmi/p7YAQ=
Received: by mail-qk1-f172.google.com with SMTP id e66so2039022qkf.13;
        Wed, 16 Oct 2019 05:55:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWjRqzxT2mKsLXqhGAxBxuCqsKc/0Q8UKmlISABSsEH8/1FMbUs
        hV6IIpPB4SABZeyLkGOu1sVio+A7Twj+2BvBdQ==
X-Google-Smtp-Source: APXvYqyHpwl4TJsuFh51VNkoTIXF81m9R20b8MuJFddby8fvhPaJ+qBhaekdeVTmRlfflsNXkX7+A/Hlapw8uVeC2/0=
X-Received: by 2002:a37:98c1:: with SMTP id a184mr5337384qke.119.1571230545772;
 Wed, 16 Oct 2019 05:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191010175648.10830-1-rjones@gateworks.com> <20191014184921.22524-1-rjones@gateworks.com>
 <20191014184921.22524-2-rjones@gateworks.com>
In-Reply-To: <20191014184921.22524-2-rjones@gateworks.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Oct 2019 07:55:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+yspnFz5PTW9WU1LRgKv5SpmsBuPs-4qCgjYfaLvoWwg@mail.gmail.com>
Message-ID: <CAL_Jsq+yspnFz5PTW9WU1LRgKv5SpmsBuPs-4qCgjYfaLvoWwg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
To:     Robert Jones <rjones@gateworks.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 14, 2019 at 1:49 PM Robert Jones <rjones@gateworks.com> wrote:
>
> This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> device-tree bindings.
>
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
