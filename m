Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B3C433F5
	for <linux-iio@archiver.kernel.org>; Fri, 25 Mar 2022 23:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiCZABb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiCZABb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:01:31 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CC5C356
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:59:56 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-dda559a410so9606315fac.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ntPj7XTgIDSXQpvjym4YD4bqgMTawlJA9DZM7Wmz9bA=;
        b=iuDSQQpRT+Stj7+ssoaEOVA0qUnB2gjhGsVM+7cq9Xs6eqzXEfEtVKpJ77ks8/4Bxv
         ltwGXD7sGnVe5lY0T+ZvOhWmUiVcvqnduYgDaXtvy9sO6tN9QPHSNmn4h7yYqkv/VUdZ
         6goVTgZZILVQuBbzgh3zgQmKuvBRFnqLQTi6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ntPj7XTgIDSXQpvjym4YD4bqgMTawlJA9DZM7Wmz9bA=;
        b=nKCAo93bVUkBpUvAzRdCzZFzJRXTzwDPzCV5/OeHosOR009c6WqocqyO3S5yVrrrgp
         uMjC9R3QCxKrC3OIVNJnjpI/ohaWtrf/I5LS7nxWbA5lWAkYxXUBk/iqYZZeiMexBWa9
         8h/8IHP2NpEPDeTZJBlhEe+SJmyHFPBjqWFRW9jkrtiLf4AErjFjaMB4xciVRipQHbmA
         TI3Cja+CRubnva/cOQ1M7RWi+VDrtHbzy7rHvPghFG8pb3kyPAfkxX3yG1sUuPlePGL3
         UVduI6jD7O7AcUVmlUUPpF2f2kh4Y3izyJlWBk86tqoTWV0xlVHQKjJbGqLETE7YAeT9
         C9HA==
X-Gm-Message-State: AOAM532yWLn54/q7LXATSap6htVJAH6vYxykL7aJ/WYQe5dxyBeBuASN
        TE+WNILzaXlrvPzcXae14ahjaIBYA8WPJxJr85xMZg==
X-Google-Smtp-Source: ABdhPJxL7cQi4HgcWfC39v8JYHlFM6J1bdIJIFIBa5f5A5+pCwhxP4lfWSd9/d1JRXk3xNDjbiTnaNd0d6n2+iQrNWs=
X-Received: by 2002:a05:6870:46ac:b0:de:5d48:9d27 with SMTP id
 a44-20020a05687046ac00b000de5d489d27mr6188949oap.63.1648252794785; Fri, 25
 Mar 2022 16:59:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 18:59:54 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-5-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-5-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 18:59:54 -0500
Message-ID: <CAE-0n53b25b_-XDCR-xVGuYBCK_DUyO95bwuBXisgZ3ccd+0Hg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] iio: sx9324: Add precharge internal resistance setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:23)
> Add ability to set the precharge internal resistance from the device
> tree.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
