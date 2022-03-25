Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B00DC433FE
	for <linux-iio@archiver.kernel.org>; Fri, 25 Mar 2022 23:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiCYX7J (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Mar 2022 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiCYX7J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 19:59:09 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8645469F
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:57:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so6636309otj.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=y3WWMoX85h3QR2VN69rZfkaedQmbRJB8ojC0EO8mBpc=;
        b=OZH5okYRUida/dbqFK+eNnyIaUYXA4JdjJyOpWuANB9lKSGJW+mwmf9tG7lFuMiZ6f
         dmJHcLtR6k9InhUa0ELbBj5fivFv7xCsJU6QNjYJawI2+vOdInuwrdiW3ET7hd09cwj/
         ouX4UKQ+fAcImlWs9voHa+hWZ3n9SwU/+GM3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=y3WWMoX85h3QR2VN69rZfkaedQmbRJB8ojC0EO8mBpc=;
        b=xe8qofHrRjRlw9cKOXEFYL5F7+g/UuTHy5nj2pZevS0PZjCjN4vAokjvg7vO047gkd
         oXNUKmE1wdylprp56MIseKDtTIALYpqZ+xVrUPUbV4tlg+ZDqwjcKpKowcyrcjtQTGIm
         APhM/U9QmsIjdPIfyESiLCK9Ks3urYMlFhc9DPvLR9pacD8z2QpgunW4S6cGaf90Zdl4
         768Hv+78O3Ehzq+n8utgEa2roP1w/GoFlY/ezFIDGkgshi9InRP7Am3vGs+PzbqXE6BA
         FqQG+AyH/9yUr3cA7pLG/f1uBVID+qZjwMYABjxJ0F2lW94xy5y2R/8HuAT8eeYWKCgW
         jdAQ==
X-Gm-Message-State: AOAM533bjkz9c57eW6gzfeuJs3FZ3d7Vngp2H6+04IIaVO//Sw9FPLTS
        rgTK5k0YH8oYGRY1JQF37jlffb+ou1aIn8Odczj4XA==
X-Google-Smtp-Source: ABdhPJwodBDZWoPGXNj0YDgQwL4Lq0+AUwNvLMxJp5HhkV+gJwnCTR1g2bxGTyEtJZhuIRnE1H5r10eqJn52rvRDcTQ=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr5611012oth.77.1648252653902; Fri, 25 Mar
 2022 16:57:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 18:57:33 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-3-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 18:57:33 -0500
Message-ID: <CAE-0n53N5k89u-1bym2varmM=ZsA5L0VGTbbRxDrR=OzxUDYLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] iio: sx9324: Fix register field spelling
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:21)
> Field for PROX_CTRL4 should contain PROX_CTRL4.
>
> Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
