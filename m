Return-Path: <SRS0=Tt4o=YD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C9C4360C
	for <linux-iio@archiver.kernel.org>; Thu, 10 Oct 2019 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A9A20B7C
	for <linux-iio@archiver.kernel.org>; Thu, 10 Oct 2019 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570732745;
	bh=vxtPEz3cxVqVIaU3VfcNy+kyageFLauK5Hy8GBfSjAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=twwbHHYZAiFSzy5o5C0s17AlWhoVEBSSNGYISOY4CI6EBd2U3eIPmBhSwmeTWRcKw
	 gkRyS9P6sW0I/Ws0jDRkAtlUKLXP3aPvZoACGMoaqLjcxEBgCWJCkoIpEtEyEvJtqm
	 Q8HmGV5vgPJ+kFEMFwbKg+msbs2hK7F08y0d3Rl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfJJSjF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:39:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41322 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJJSjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 14:39:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so5770448otp.8;
        Thu, 10 Oct 2019 11:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPe3CNBeA9mdKPCUL2HjUyFsNKAIvb+Cj0MjrNSB/fs=;
        b=Qgzykr8EVr6srsk4/HzE2c0BAoqsV3dk3rpnr5zUftelJrpQinx0TYchy0pkK7uegN
         98/hMNQaBfoNaQNwpGT5dYDk+9HYgIDIRgF36Ptgz5uIi6PHyaSkMc/HJAGA1c+qYsaL
         Fo3w6kp3+XrWVHXymicOiFRMVN3hCTc1yza8g/SV2157LFowrmxDbsqdc+aTbTQrgSHK
         60xSqt9MKAJiGyTiy22R0RI+pN9pILyixVVn4uFaECCSfRxCx44S0mrrdFkJuEj59HHR
         lnkS2Y1L6MiLjgUprdjlsNLwVrrZKjw8SJZJrv1VF/wvuHmNqOo0ebE9IQVHOwPrNLCY
         LImg==
X-Gm-Message-State: APjAAAX7c1sKvn+DsGU91v7brbIX5KvSMh0kslhaQPs1IDsnNgICD0sm
        tQ+DA3G85f9BcZ8L91ag1g==
X-Google-Smtp-Source: APXvYqxYcw9B57/Ieh5tyNy4SdHSeSnloFqiC96598LHfeCmd1oIIrpZ51CB95fIzcS+Wv40V78tPA==
X-Received: by 2002:a05:6830:1205:: with SMTP id r5mr8967766otp.294.1570732744266;
        Thu, 10 Oct 2019 11:39:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm1637720oic.24.2019.10.10.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:39:03 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:39:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7 v3] mfd: ab8500: augment DT bindings
Message-ID: <20191010183902.GA4633@bogus>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
 <20191001221356.19317-6-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001221356.19317-6-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 02, 2019 at 12:13:54AM +0200, Linus Walleij wrote:
> As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> the bindings to account for defining the ADC channels in the device
> tree.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Change "adc-channel@" to "channel@" as per preferred notation.
> - Add some full stops to the end of sentences.
> - Reference the new ADC-specific documentation for channel specifier
>   etc.
> - Collect Lee's ACK.
> - Rebased on v5.4-rc1

Humm, this is the 2nd v3. Can you address my comments in the 1st v3 you 
sent[1].

> ChangeLog v1->v2:
> - Rebased on v5.3-rc5
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)


[1] https://lore.kernel.org/linux-iio/20190903180034.GA20595@bogus/
