Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE88C282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E92084A
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYSpptCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfBBXMb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:12:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39176 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfBBXMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 18:12:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so8803347oia.6;
        Sat, 02 Feb 2019 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGLmOhUeZMMRoWEXwLL073QQJcxbGqVF7NfXRB5nfdU=;
        b=hYSpptCUav5OYGuSXSWvIffjm1fE/8O2QPTJIxdELzx6hEyC3XBS6imq+v6BhK8By7
         NyQwoGpjkR43uGEle5MbPiT2XDBne5r4eNYJCkkb5JIzQAvGljYvDD/CZ0ClKj7sZtFZ
         oFHWQEoRqy3RL/mboPxC2B+LdEaPW+gx3AsEj1u6BX4RUE+BzbR+jO3lZyZPAMG5dUq2
         5tln1bA/eoUL1Aml2Yb8qmmE0VJJv7iUHydU4+2i+idw9d1nhBFB3+SftrwGGMKNoJHi
         1i1/df5eUXksjD2nrAfM/i8Z7KqlMhK+cVkHYYRBeO97LADD4OQr63yyWOpTNRF/qGIg
         J8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGLmOhUeZMMRoWEXwLL073QQJcxbGqVF7NfXRB5nfdU=;
        b=INTrU0zlG1T5tlAsYBLZfX5641sP6nf5u735EoLS+ZI2eUCTfJFU5QQuc61tgJ650o
         rEtQBl9Kr9eVS21XkjAXTve+qUGvBTAVSzz+KBezcEg/KNU9bBWJueIlr6oiuN6Yl5N2
         oE9uAkn5DHRJNfMPmQ9OC7PzQKgTE3rTgmsIZXX5DQZEctI+2Jao+kV+awE1ijrC6rEl
         72Gxa+Dgx+5ZTLVrKF4WgT7lXJ9xr+LgIOvEw0B6SZlGY3FaTzwT5kfL9OQIfXfFGrBw
         7daM5BOzyzdx2/q8KWhvKPYu7qbqQzD7VwFwFBLsDNvjs+drfZ4Pd+JgPyvqjDTJRgke
         IIeA==
X-Gm-Message-State: AHQUAuYLpe/nkhzkgDQTusAbgPmYlUb+XQIPrsQ+IjfQrCAjZC5uZ049
        GZ/Qx2zUQtWPPgyCTcVS51Zskxq7Yry2jyOYTe0=
X-Google-Smtp-Source: AHgI3IbGJG08HmeAgSOCBLIPEXhWunxSA5oZuIMkJCgMl/MEWFMuMx0y+AsM2JCB0vMLjW0BPdPyxvumK1ZeVzmi3Qo=
X-Received: by 2002:a05:6808:296:: with SMTP id z22mr23249758oic.67.1549149150559;
 Sat, 02 Feb 2019 15:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20190202215601.20275-1-martin@martingkelly.com> <20190202215601.20275-7-martin@martingkelly.com>
In-Reply-To: <20190202215601.20275-7-martin@martingkelly.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 2 Feb 2019 21:12:22 -0200
Message-ID: <CAOMZO5DsbEhdW1dhcWxig7b5VB7qnkWtbU-SqY5cGJp2Ld0nuA@mail.gmail.com>
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

On Sat, Feb 2, 2019 at 7:59 PM Martin Kelly <martin@martingkelly.com> wrote:
>
> From: Martin Kelly <martin@martingkelly.com>
>
> We are using "if (ret < 0)" in many places in which the function returns 0
> on success. Use "if (ret)" instead for better clarity and correctness.

What's wrong with "if (ret < 0)" ?
