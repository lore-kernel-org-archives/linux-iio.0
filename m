Return-Path: <SRS0=wTBL=4Y=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC7C10F00
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC8E2070A
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl4UdSo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGUtk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:49:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43878 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCGUtk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 15:49:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id c144so2898220pfb.10
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2020 12:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHw+Jjs7dZ4GflEx8dUfxbRvk774mse1f+OtelHrQQ4=;
        b=Zl4UdSo5xBPYzmHqntch6EeozeqzYpO5i+G53QpFxvj2k+toK7cFPWoxNeEAowNXuK
         PiGnLPhuh10sZyamQ3njiXcHUTuqB9iIZZkK+ZjuFpXK4vDrDuyGgCTDCsYQY84qXFQc
         SvF2kRhtiWLQ9GOw+DyhwPhcbJWm6npwGtONJRsmAwzuHgM+mIchjbgcn/R9cm4QF7dH
         NC2qIcZPjXvoVocuGRHCzCXlC2WHWJonQ6VhnPLQ+jMhs11ys3Bs7BBo+SigXYRkGHUO
         Bmu63omZh+Z5bjKaml32PF7gOTSJ7m5q6khEH07w/xvWszILETYi/n96C0VMvxzljCRi
         9hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHw+Jjs7dZ4GflEx8dUfxbRvk774mse1f+OtelHrQQ4=;
        b=aXw6jFKjIp+feWz2p8o6w3MUILB+NIDsYAEhDXNGagJFLysyPTa2yG7KFZjRiMlvs+
         oB2ixbS5YFQjMFw1lU5v67hinoD5r0lUYw6hBE8rDH+3sVX67C6nK9zDnGFDozEnu/x+
         um3yae45XbCWrFCrDyCgufVGU1Nv0qIvreH4cXE6dUWZOcGULV6fG05ucAW5ipZUwBz9
         RHoPq2slnNHtTtItCnZJ6bXme1QdhUpdSkFJFZIgDWyf/cw4Rzt8SA+gm7S88R2zoYTc
         1RybjGDtir9Wv6q1aP4VAPi0HYTiWEoWqcigEx3mDccSiOgzUQogJ4ibzXy3MXnsIS1j
         1UTA==
X-Gm-Message-State: ANhLgQ1U0hgb1Ll3c+6z88c2Cm0dmntUbzMBV/KcT92hHPxAPV9qDJwn
        KpLWFZJlklG80B288j2GkiQBYmJHmGlkYA==
X-Google-Smtp-Source: ADFU+vs16FM2U60+dymvdQk68ZYbsmazKnHE2RPKErr8erBCc7hYFjEexT40CWoZAm3YS9H63BYDOQ==
X-Received: by 2002:a62:cf47:: with SMTP id b68mr10044198pfg.249.1583614179009;
        Sat, 07 Mar 2020 12:49:39 -0800 (PST)
Received: from SARKAR ([43.224.157.39])
        by smtp.gmail.com with ESMTPSA id 3sm13812159pjg.27.2020.03.07.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 12:49:38 -0800 (PST)
Message-ID: <5e6408e2.1c69fb81.8cd42.42cf@mx.google.com>
X-Google-Original-Message-ID: <20200307204933.GB12716@rohitsarkar5398@gmail.com>
Date:   Sun, 8 Mar 2020 02:19:33 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        jonathon.cameron@huawei.com, alexandru.ardelean@analog.com
Subject: Re: [PATCH v3] iio: adc: max1363: replace uses of mlock
References: <5e633519.1c69fb81.ec43c.6809@mx.google.com>
 <20200307135904.40e332f4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307135904.40e332f4@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 07, 2020 at 01:59:04PM +0000, Jonathan Cameron wrote:
> On Sat, 7 Mar 2020 11:15:58 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Replace usage indio_dev's mlock with either local lock or
> > iio_device_claim_direct_mode.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> 
> If sending patches for which there is already a version on the list
> which hasn't been commented on please do 2 things.
> 
> 1) Reply to the previous patch email to highlight what was wrong - stops
>    me missing the updated version and picking up the old one.
> 
> 2) change log below the ---

Will keep that in mind.
Thanks,
Rohit
