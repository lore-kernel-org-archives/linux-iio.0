Return-Path: <SRS0=jVJK=5P=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9959C43331
	for <linux-iio@archiver.kernel.org>; Mon, 30 Mar 2020 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECEE20780
	for <linux-iio@archiver.kernel.org>; Mon, 30 Mar 2020 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585591859;
	bh=j8+7+Qddrx8Pzj2DauRmg0CRX8GAK9npccrBeH7bqEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n2KV0F7e0Dt5NF3NryDxu9ik43+w4rYG2UPw8QwUM9W66f4WKTHTKoUxNBcSk/+mZ
	 76Un0Vn7D+MRPBTBA4ZSb8/sBbWMfpZ4vEmvqcQKUxjy9KAKqxJyJhxoZv+BfIanOf
	 7W0L383irhUz6YuWTzp4ecYRaoCj9s+C3bUkb/+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgC3SK4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:10:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36532 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgC3SK4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 14:10:56 -0400
Received: by mail-io1-f67.google.com with SMTP id n10so4758759iom.3;
        Mon, 30 Mar 2020 11:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IclrqcW8ysqtuVmS55rZcOs0qoTX1+BcxJZ+I1k0oLs=;
        b=Djn1A8ZVxIruhvRmXnV7nyWArn/frzvTy41ozQFE0UdfzUdoyotVbzgE8/ImA3b5VL
         y6XeHx3macMsvkpUiNQ+9i4H7hnCfydaF+HrIRTeqRzceyIx86iWccC4uC40QA/qXysW
         Vq6BGJMwIBAQAwDCf6zeSgsjW2zQx0KQw4S1bv0FU2xDilBUZDQdTAxDTRmKzLRi1l7j
         KNG3IWTy+bk7M1SQN4ksftiitttvg29x3DIsZ/dNSHM+ZkgMygOZD7DxbhdIuUa+iP/o
         aSpyWJXrSl71BsL8bx1Bnn6M4OhSMbSmpClJI1TIfqJAhTAHcY1k1i7f00VkioIPbp0K
         ZnSg==
X-Gm-Message-State: ANhLgQ28pKsUldQ8Iutud2kbStzun3vOC7Xw1RSBClY8FBlKA7V+WdMq
        cbfbAGgw6PmICC/Qxko3evgQwy8=
X-Google-Smtp-Source: ADFU+vtRD5i4b5WuUylbDfvEsPS/m7kyJL1kE9fsXtKCkDqfbgwFrDee2r1oGdFUeVl9G7yiIgiu4A==
X-Received: by 2002:a6b:d808:: with SMTP id y8mr11628918iob.121.1585591855212;
        Mon, 30 Mar 2020 11:10:55 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j23sm4248204ioa.10.2020.03.30.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:10:54 -0700 (PDT)
Received: (nullmailer pid 7604 invoked by uid 1000);
        Mon, 30 Mar 2020 18:10:52 -0000
Date:   Mon, 30 Mar 2020 12:10:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: convert rockchip saradc
 bindings to yaml
Message-ID: <20200330181052.GA7527@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313132926.10543-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 14:29:24 +0100, Johan Jonker wrote:
> Current dts files with 'saradc' nodes are manually verified.
> In order to automate this process rockchip-saradc.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
>  .../bindings/iio/adc/rockchip-saradc.yaml          | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
