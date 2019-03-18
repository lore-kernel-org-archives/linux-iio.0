Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFFC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4D2083D
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTTOQbWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCRIzH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:55:07 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:42097 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRIzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 04:55:07 -0400
Received: by mail-io1-f42.google.com with SMTP id c4so13715046ioh.9
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgskdyDtcM1KSlqFhdzgKZ2A3FZZy3h7BdCnWHyudwI=;
        b=RTTOQbWZFnXZyoLsiu+EWHQNfQMurLMySx6P0TdnWXvt+RS1MB8x7/HZzgZxfnVwFq
         5ssyzOp9fii6uFfKDfTMjBVpDeJWHIdCUkXK6HUWVVFN4LEMO352yetmXDmoUoQ5KccR
         HE6XNbp/f1Lo/8fb6zsrh5rcBMngtgrYbEBWnkGab3jYml0WUCakJ5COjIurKI2UK5mJ
         RTBgB60b7Hk2E0TcgWGEGdo5A1Ccgh9chyuZPnxasgjuUKS2mhyx3YGGc9QaZfhQnn7G
         G6aq0Uh3LLpsV1mWBatgGSF90IC00ZoxghhPjjB9Kv1thfRUoNZ9yLoeHJWc6bTSP5sn
         gxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgskdyDtcM1KSlqFhdzgKZ2A3FZZy3h7BdCnWHyudwI=;
        b=UT8EJ1XoJrKnDTKt/zuL34qfKjD3lf8exEn7H2ko637A37D71m8fSj0QZproh349gm
         0m7foRGMLrcc0ybp9DWcpnI4SIsbI7F6frZtA+YvvE6e05DX8/6z86zemmG/vdbr0dNS
         useqduFEkqiaKlVB6L1XLBJDDYJ4JT+72e6QdXZZ9sNsCMCGZB6Lk97jpkJuhMIfWXOg
         MsCdksWiALeo5TJFe1eNRqcLzVwr6vw59YfpP+CsEEouT3UoZ8oBtV2VDzS1EyeKuSjM
         BtXmM/MVGtofZlYiaOUiYzqLoH4ukdMWYAceShjuL57HwuyaYC6hrGCzTTtvea3RJ1OS
         WNhw==
X-Gm-Message-State: APjAAAWnivT+Mz0i3HdC9Z3Vb4AKy5I8PLJUiRXeKj9c/q0T8Sk3dH/r
        0tSFAnY6e1INH2BP1f5NDT5NoPU+QqiQK8Zzij47cgpH
X-Google-Smtp-Source: APXvYqw3KgXxypAqA6HsIZX8Ha1Xu7rtC41HX2HBT3LNy/bAUJUEglbDMlJ7tMXr+3eUIB0bSdoScaEezcaCFHyucys=
X-Received: by 2002:a6b:4e13:: with SMTP id c19mr9286731iob.96.1552899306679;
 Mon, 18 Mar 2019 01:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
 <20190316191351.2373d46d@archlinux>
In-Reply-To: <20190316191351.2373d46d@archlinux>
From:   Karuna Grewal <karunagrewal98@gmail.com>
Date:   Mon, 18 Mar 2019 14:24:54 +0530
Message-ID: <CAHRz_yZTRvz1zxHdZU9v9_RCw6k=ThgU4Qs5FKps7vxMD1=Xfg@mail.gmail.com>
Subject: Re: [GSoC] AD7292 driver project
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Apologies for the delayed response.

On Sun, Mar 17, 2019 at 12:43 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> We have been trying to remove all direct use of the mlock mutex
> in struct iio_dev from drivers.  It has one very specific and tightly
> defined purpose to protect drivers from trying to do things they
> shouldn't when changing from a polled mode to one which is interrupt
> driven (DIRECT to BUFFERED).  Unfortunately we weren't great at
> enforcing the distinction in the early days of IIO.

> The solution is almost always to replace the use of mlock with
> either calls to iio_claim_direct_mode (if it is an open coded
> version of what the mlock is intended for) or to introduce a
> lock within the driver itself with well defined scope covering
> whatever mlock was incorrectly being used for.
>
> Another traditional area for people first getting involved in IIO is
> to look at the drivers that are still in drivers/staging/iio
> but to be honest there are not many left there now so that isn't
> as fruitful as it used to be.  If you do want to look at those, do
> send a message to the list to confirm no one else is currently
> looking a the same driver.
Thanks for your suggestions.
I'd tried this staging driver cleanup long time back and I didn't find
much of the cleanup patches.
So, preferably I'll go ahead with the former suggestion on "removal of
mlock_mutex".
Meanwhile, I'll get started with testing this on a sensor as well.
I'll get back to you with any doubts while working on these.

Regards,
Karuna
