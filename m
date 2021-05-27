Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C231C47089
	for <linux-iio@archiver.kernel.org>; Thu, 27 May 2021 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507BB6128B
	for <linux-iio@archiver.kernel.org>; Thu, 27 May 2021 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhE0QSM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 27 May 2021 12:18:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:48300 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236119AbhE0QRw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 May 2021 12:17:52 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 12:17:52 EDT
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C28A02B7;
        Thu, 27 May 2021 16:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C28A02B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622131754; bh=SHD3f2phNx3RQy0BeoJkPi5F8ovNBRDQqpw2shszU+c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nW/vDELVdwjFjxZ7Ho+auafF7LPov1jpZI4DERbqsJkSwLGUxF3paV8KaJQhxr2Ef
         I2Zev7p1O7YnJgc6NtZ41RFYCKRpjjUr+jSK8Ot5geMd0xptK+owkq0OKzWqSNIrjn
         4Mdt6pSQEi6rXqxE33rD/+xjuoj255pp+XMVJAJtHBbfMeSbWMLoaYQO5AxRyOQumk
         UesCVTzq4DQBdEo+x8SN30IY9TqIh8BNW4VnTPu2Od9rDlI20jYn4dV5p+eRlscVfP
         HL9/1yXbGifkclso2Ssbzutg+uVnjEhrgtZffTRpn3XsJgKaAwLsZrzo9cj6SToyLd
         LJO/EzoBVbciw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] doc: add a couple fixups for IIO ABI files
In-Reply-To: <20210526175908.42db03a0@jic23-huawei>
References: <cover.1621944866.git.mchehab+huawei@kernel.org>
 <20210526175908.42db03a0@jic23-huawei>
Date:   Thu, 27 May 2021 10:09:14 -0600
Message-ID: <87zgwg2m6t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> writes:

> On Tue, 25 May 2021 14:23:51 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
>> Patch 1 was already submitted as patch 10/10 on this series:
>> 	https://lore.kernel.org/linux-doc/87wnrtnpko.fsf@meer.lwn.net/
>> 
>> However, it generated a new warning, due to a separate issue.
>> 
>> So, resend it together with a warning fix patch.
>> 
>> As these patches are independent from the other ones, I guess it
>> can either be applied via IIO or via docs tree, whatever works
>> best for the doc and IIO maintainers.
>> So, I should leave such decision to Jonathan & Jonathan ;-)
>
> Either works for me, but on basis I got here first.
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Jon, if you'd prefer I picked these up, then let me know.

I've applied them, thanks; I took the liberty of fixing the spelling of
"specify" in the second one :)

jon
