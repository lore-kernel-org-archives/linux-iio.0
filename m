Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2881C282C4
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DFC217F9
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxZ23YJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfBDPPk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:15:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46063 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 10:15:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so235180ota.12;
        Mon, 04 Feb 2019 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NAE/zKZsacoEPE++MAvF2z+UCz3Zvk8CLDXZ87QMyw=;
        b=FxZ23YJSuzCCwudlApzUYXs6noO02KsNFV2IYaS4lzrO7N4VlVxx7XNiJNSQWXKEgF
         BNBFd8gudli6IgCJnphPE5I2WvKz9eWVmlV4+5LId710GD07tbpyonwaoapcKj6RO9bh
         77QdKr/O49aYWnKET7VODExDo7P83Mq/aKOrFyYTUqjESGvnr2F+iCBbPz9U+x2hEnRx
         uiM4ALIW7ew9iRKqeY0y6dgPLckx/6luojuwl/jNcxpU9K2VQleBVprGwZMWO2n2mzIn
         Rw5eUCO4l714yiXJX3GKDfXaBK7RSVoQiOyXeYgE36nS0gw4ZWfTC7SljA/UDx6yKhlq
         D4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NAE/zKZsacoEPE++MAvF2z+UCz3Zvk8CLDXZ87QMyw=;
        b=nXQacqnTqTBnRWmXAiLbxtKc+fSjAVYKZZRr8UuLT8cQ46dUFxTwK2uA4vvGesN80w
         mAWZqEO7b4pVX3KtCDs3Hgbb1cl1mpJ1l4RIo/6DY5amihgPODfHzTQmeaL3V1v998X2
         8PdmJzpg/qoYbnQ0r4FTTAbk6W8Z/1NlcvXwQe2j8guqKobLRy/e3OUfqHaeBzsRHFHb
         Z2wUzkWlPd10BQhCfBkdpNfXMuctiLZadI+hWroYFlz7rYKzo2ih7Z/T96fcwa/X8FDD
         7iYN5/YPO4J5sh7odnGuUDBNPYWkVCWeKlTpj8ha/jyAQXbRHWfnFrKxblGFV0S2Cyg3
         BeQQ==
X-Gm-Message-State: AJcUukc3sCG9seztmmIj42pw8RBq/vcwZs1YUzkt+aegQhcpgzFY5FLA
        gUyfv9XU0zh04tRPk9/epc+nrtIk0Fefi0vhNQ8=
X-Google-Smtp-Source: ALg8bN4KOFGo5bLWHvkYFT3W3D6xTtLC6kqoWYNQZnlDuHqu8Eu+qkuLRss8m/O8fgqTNGqRC5cHvyBS/ohenM0fffo=
X-Received: by 2002:aca:3092:: with SMTP id w140mr27220813oiw.237.1549293339636;
 Mon, 04 Feb 2019 07:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20190202215601.20275-1-martin@martingkelly.com>
 <20190202215601.20275-7-martin@martingkelly.com> <CAOMZO5DsbEhdW1dhcWxig7b5VB7qnkWtbU-SqY5cGJp2Ld0nuA@mail.gmail.com>
 <aff2e86e-a6be-24da-0f4a-add25a2cbee2@martingkelly.com>
In-Reply-To: <aff2e86e-a6be-24da-0f4a-add25a2cbee2@martingkelly.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 4 Feb 2019 13:15:34 -0200
Message-ID: <CAOMZO5BNK+v6t3qFYs5b+NpPHkrR4jiuy13DsM=AOQxAR3kY4g@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] iio:bmi160: use if (ret) instead of if (ret < 0)
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 2, 2019 at 10:30 PM Martin Kelly <martin@martingkelly.com> wrote:

> Jonathan Cameron pointed out that the check is for functions that return
> 0 on success. Thus, the check should be either "if (ret != 0)" or "if
> (ret)". Jonathan prefers "if (ret)", so I'm using that. By leaving it at
> "if (ret < 0)", technically a function could return positive numbers and
> not count as an error, which is a bug.

I fail to see how regmap_read()/regmap_write() functions could return
positive numbers on error.
