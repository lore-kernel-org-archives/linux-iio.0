Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF57BC433F5
	for <linux-iio@archiver.kernel.org>; Tue,  3 May 2022 19:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiECTPs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 May 2022 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiECTPr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 15:15:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88813F8BD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 12:12:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so23208630ljr.9
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=tJjnhYGcI+mMwArUfLaUSAPbfKh4IgFOE/sc6ziZKg0=;
        b=KHuzPdFZ3hXKOaWI5MNsDoVc4us1o8b72/7eGFY1FLlX/BbNjqcmQGr4YZ49GGr8WX
         mXLKIHs3zoVq7kd0H4pt9AvCiAIEDhvfPmFBNb9MuMEjzQXbeROOVMxvJlfDM1Aty/gu
         u5302tPiX+JVBkVA1zuRj2JhlihOXaOarXfJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=tJjnhYGcI+mMwArUfLaUSAPbfKh4IgFOE/sc6ziZKg0=;
        b=zfmS6RTY7Fe3xi2Jg6HjVFglGuRICPRH2Cp/ZlhY3Hbi0kbJwlpOOL0tF65K2RU3Nd
         wijdo9cZqd8RiMbxZxueTenzh80SnnySGdlitPrJfYW/ncoyy3lfrmNGInEa03t/zlxx
         tAb/lzXq1/Xm0YeiGAy9kfyDbPLTsHsmXDhxLcIeQVCYYcxQaDvs2SYJrdJLPt4jrfA8
         /o+BOoCnTarK5F8mnIcncrASRWDMFfpSq4sK9pfe9+49GRa1VJKa5J7jrduFWRhsU1fh
         SjUhwXTSvy2pUeyWpYkpNmSeo6G/RFeHd5WdxP8l4/3siNq9X7P75NYk0Xr7bh8lKFIQ
         tCGw==
X-Gm-Message-State: AOAM531D5ENbPK2lUxdi6PXoSvniCCt90W0R4yp5PG4E/rWs9FmAJqRl
        ECY1J1TZcZ9OUtkbdpDoxXKOScHgIV/X8OE1GPabDg==
X-Google-Smtp-Source: ABdhPJxCl40O4i9zh2oU06fO0CeXR1pEWgYaqzyn+joymhqK3oh7mddDnE60sau0vFQ8O2BS/HVSpBvH+YgCXOktHCc=
X-Received: by 2002:a2e:800f:0:b0:24f:1449:90b7 with SMTP id
 j15-20020a2e800f000000b0024f144990b7mr10762735ljg.431.1651605130301; Tue, 03
 May 2022 12:12:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 12:12:09 -0700
MIME-Version: 1.0
In-Reply-To: <20220429220144.1476049-9-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org> <20220429220144.1476049-9-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 12:12:09 -0700
Message-ID: <CAE-0n53PATjL-w5cWCO1YkCz8oP6jg-FuergskxBd6fsjCMXxg@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] iio: sx9324: Add Setting for internal analog gain
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-04-29 15:01:42)
> Based on device tree setting, set the internal analog gain.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
