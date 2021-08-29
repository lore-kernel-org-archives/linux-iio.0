Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04764C4320A
	for <linux-iio@archiver.kernel.org>; Sun, 29 Aug 2021 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C6C60F4C
	for <linux-iio@archiver.kernel.org>; Sun, 29 Aug 2021 14:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhH2Ov1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 29 Aug 2021 10:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhH2Ov0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:51:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7BA60F38;
        Sun, 29 Aug 2021 14:50:29 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:53:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Rob Herring <robh@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v4 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Message-ID: <20210829155344.370348d1@jic23-huawei>
In-Reply-To: <DEB9D606-6489-4993-A5E7-6E4F3226EE5A@aspeedtech.com>
References: <20210823070240.12600-1-billy_tsai@aspeedtech.com>
        <20210823070240.12600-2-billy_tsai@aspeedtech.com>
        <YSTiUPQa+HYSA63t@robh.at.kernel.org>
        <DEB9D606-6489-4993-A5E7-6E4F3226EE5A@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 00:06:47 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Hi Rob,
> 
> On 2021/8/24, 8:13 PM, "Rob Herring" <robh@kernel.org> wrote:
> 
>     On Mon, Aug 23, 2021 at 03:02:26PM +0800, Billy Tsai wrote:
>     >   > +properties:
>     >   > +  compatible:
>     >   > +    enum:
>     >   > +      - aspeed,ast2600-adc0
>     >   > +      - aspeed,ast2600-adc1  
> 
>     > What's the difference between 0 and 1?  
> 
> Their trimming data, which is used to calibrate internal reference volage,
> locates in different address of OTP.

At very least document that with a description: here to avoid anyone looking
at this later asking the same question! 

Jonathan

> 
> Best Regards,
> Billy Tsai
> 
>  
> 

