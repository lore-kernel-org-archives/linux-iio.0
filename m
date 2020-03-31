Return-Path: <SRS0=NPSj=5Q=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A51C43331
	for <linux-iio@archiver.kernel.org>; Tue, 31 Mar 2020 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497120842
	for <linux-iio@archiver.kernel.org>; Tue, 31 Mar 2020 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691014;
	bh=xeIU8CnekmGO2q2LhviZKJ9WwzNWwaJ2LKgSp2XM1t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PGpLautfGAE47oOoHwAUtox/Kxk4taDg+Ye3VtEepLdmvj1e2qIewo5GOeOPqw8m+
	 nzYCBhRy2Meg/pwFe7nGOENhD6eZ58Ca+eDFlrViywcIVcjSwB5/JU5b4Y8iiTfAKD
	 /MxfIEstA9p1hZ21oIsFV1CWLxEtcAv13/Mp8Uo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCaVne (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:43:34 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43281 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaVne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 17:43:34 -0400
Received: by mail-il1-f195.google.com with SMTP id g15so20990661ilj.10;
        Tue, 31 Mar 2020 14:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FOWELNUzNyE6R0TOcZgVbCSQviORXKBI+NfnrJCZpN8=;
        b=LgPRRmLIIu5rOJITKwub/Id9H605fiGmkJvJbcUx0dQce2plItYgBPwO/li2Zx8BWI
         v8R8SsKduoi30DdwiSOaH5CrTHNMrRMy+3DCLca88BKMS22VS8iSuaYZJ1gxW3QhqxVZ
         UHFq/8yQaQqrjlidXv0H550OV6CG2jWnsj2kb1p6+zXq0NJBtRg5zWJLGIRaN9MikQJH
         VAKtdKlvJ46ApwELRy7QRpd1MZ5dqYwAXY6TQpDkg3Diidc76gLcViYXP3cfAXzVxdnH
         hfFi3jcA0Xopj8PFvItX12MlwpII29lDCXYH1vqH49jDvKJ0OgKnkXl38KEDqhi6lje6
         r+mg==
X-Gm-Message-State: ANhLgQ0FpzXgQgCnFhJCnBVrofWIaIFoo6RqygC2nVlW1hM/+FoP/6hI
        HTlwcKwgMH+JyFnZP4LuYA==
X-Google-Smtp-Source: ADFU+vtRkjBODuI5OicUuyguYdYMjVJrWcutlctPTcXk+R+eMfPmWVSXMQdYTBDtzmofkT5gFGII7g==
X-Received: by 2002:a92:790a:: with SMTP id u10mr1859253ilc.98.1585691013075;
        Tue, 31 Mar 2020 14:43:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e3sm25611iob.36.2020.03.31.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:43:32 -0700 (PDT)
Received: (nullmailer pid 24075 invoked by uid 1000);
        Tue, 31 Mar 2020 21:43:30 -0000
Date:   Tue, 31 Mar 2020 15:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: vcnl4000: convert bindings to
 YAML format
Message-ID: <20200331214330.GA24010@bogus>
References: <cover.1585134362.git.agx@sigxcpu.org>
 <513ead7fbdd58435420387729314acb6a5181251.1585134362.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <513ead7fbdd58435420387729314acb6a5181251.1585134362.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 12:09:05 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> Convert the vcnl4000 device tree bindings to the new YAML format.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/iio/light/vcnl4000.txt           | 24 ----------
>  .../bindings/iio/light/vishay,vcnl4000.yaml   | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
