Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE58C4361B
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 13:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B866B2311F
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 13:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgLPN4r (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLPN4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 08:56:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B7C061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 05:56:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id bj5so12963789plb.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCxnR2OW5Ed1GUJFpLI5+NtLjiW+T/+HOOF4cJogMM0=;
        b=iwlEu6HJyGMVLps+Ara07SJM4rkRIRRdcPNl3ewWc9hmzXD4t3qGvyhQc0zTum3Pgy
         wi1oWa6O+vPSvhs8C0nX+mFNJSl0zTdeiZyA8NiPductUZVpMiK+6LuajBHjdfedcHq7
         9BmVaXxyhj1PuV57Y75ZeEw+Kn82jATLHc2qXkJvTV4Zc6mpdziK1Qw2Oib3ZeeAp9jj
         JBG+9BRnSVPsOZMCRdAZs1fHjP5+27mGiqoiIPFfIVQeNO0M7rVQqIOtn4xjEFs4Hurd
         sRRVtvjZiNMkEx0WmDsfKIn3y2Vr2xNPQNhqkZYFyB5leRjlcfD2HL7wQ6iRmTtbmBwZ
         8MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCxnR2OW5Ed1GUJFpLI5+NtLjiW+T/+HOOF4cJogMM0=;
        b=iCj5IfAkXruQE7Zc3Hnqqj8VmRmBC8SnEosLYNeW81MgE0+UWyNgEgj/2KfUrObzTn
         UYihiGI5QUKek2tMnrzjW1h+j3YtlA0eL3v5HaqI5iMil20QEmnWxPrMS19aVNxARatQ
         S7Yeb/+ijrnFpntZ0UbP21+puqQTKWCpZQTzV+On9SULysOoVcjPdlfLFD9sVlHL6Ibd
         CX94BLiwFM3e06mPXCUNjz4iS3vYyMlMx5kj0/OwKnu40VPSIr3fYAieOdr+ocNP7TfH
         rW7CA+XIG0DpIWB5eifVyuK2MxHy1lJP9JxgHAIuuLAQCk8Ka/kxQNWeIxyyW/rIjWZe
         Eg0w==
X-Gm-Message-State: AOAM5336tZrLgTTo6sf4p1foahNhGvVme/tC33Ayn/1qcKXmodkzyzfA
        oLKVDWNvOWetMruBbey7Y41QMA+GpJxDtHWjans=
X-Google-Smtp-Source: ABdhPJw9tarObLXU9kHW993AEBDLeePfTtS5TLmv60/SXS/v1FolWPb6qE+MZ7lR+GIJoXecd8HqA4WFJhXsRz9fimE=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr3202998pjt.228.1608126965783;
 Wed, 16 Dec 2020 05:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20201216060233.597689-1-gwendal@chromium.org> <20201216060233.597689-4-gwendal@chromium.org>
In-Reply-To: <20201216060233.597689-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Dec 2020 15:56:54 +0200
Message-ID: <CAHp75VdKCEQ11Kk=zBynd1g7gWhFyMCo-x=grntLSEY_U29PFA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: acpi_als: Add trigger support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 8:02 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> As some firmware does not notify on illuminance changes, add a
> trigger to be able to query light via software (sysfs-trigger or
> hrtrigger).
>
> Check iio_info reports the sensor as buffer capable:
>   iio:device0: acpi-als (buffer capable)
>
> To test, check we can get data on demand on an Intel based chromebook:

+ blank line

>   echo 1 > iio_sysfs_trigger/add_trigger
>   cat trigger2/name > iio\:device0/trigger/current_trigger
>   for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
>     echo 1 > $i
>   done
>   od -x /dev/iio\:device0&

space before &

>   echo 1 > trigger2/trigger_now

You may improve readability by using a temporary variable:

  IIO_DEV="iio:device0"
  ...
  cat trigger2/name > $IIO_DEV/trigger/current_trigger
  for i in $IIO_DEV/scan_elements/*_en $IIO_DEV/buffer/enable ; do
  ...
  od -x /dev/$IIO_DEV &

Commit message keeps silent about the side effect of these changes on
the old setups.
Is there any?

...

>  drivers/iio/light/acpi-als.c | 88 +++++++++++++++++++++++++++---------

Question here, does it need a documentation update?

...

>  #include <linux/iio/kfifo_buf.h>

Is it still in use?

-- 
With Best Regards,
Andy Shevchenko
