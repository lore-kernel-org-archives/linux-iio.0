Return-Path: <SRS0=fZBy=P5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E702C282F6
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70A20861
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="VdHDGV4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfAUImV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:42:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35338 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfAUImU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 03:42:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so22766827qtc.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 00:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF2QoYFePYcYKLKxBh0A2KIyN9VcodvhLxsKudI3zNA=;
        b=VdHDGV4sHXYAKWnCWGCc6YtzU8cAt8zTWAFvQafadmOFHYN0a13DGwnQF5geclXmp/
         ei8JfpwUTgA/e2FrpOSQpKS3tpukygDkkWP8Y6ty7JwfKYrBwxkA6jcqj7HbGX0/gkW3
         Z+ivBH6MgMwVIu3LsT8vv4+jqqxhTLc2BNQinxi4I8nOLY5m/h3Zi66l4ThOPQT5gVm9
         tzezAgoutOhQ3pI0VJJQ92W6wQkxO2fRz+wFpoR1r2iyZIv0t/oHQknlXicOepeqdmBo
         vHwbqC7lOjXSK4xWq+E4eGtJ8TYUxgERk6yL2ErOKWv4M3eJmDWh2Y2elieybyEvRND+
         iR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF2QoYFePYcYKLKxBh0A2KIyN9VcodvhLxsKudI3zNA=;
        b=ZT04Zwr35DKdqGVP2YjJrnJMONVvcpTD3yIh1elmZ2SJiCmsjBBl2G+ucoK+ZEHtaY
         s2vfE4PjpDzVn4qolqz5eBCOiW+2Ar4TzuHogxu76W6K9aTuUi57nVQQw8cRx5sPfqOD
         GqMxvkNxqLik2VLisAXII8D4HYMIoOJikWGqqrBfyO/TrDgTphS3qHmGGF+qzN2NT8oO
         Jbl/u5aZscoCJVr7QrT98npzNp8M042UfMvXCvM5ifAkIusQmTd3x23Cc1ULW8bZsiN+
         Didh9K2Uag6nKXw1Dq6Dad6XNRNVUj4+NTrl79uWBtyngdz1qGEy8Bxr5Ye8sbHbSEIe
         36fQ==
X-Gm-Message-State: AJcUukcb+24IjMXnro1NT4A1MgyRWHWWJfhOZTUTa1iraEj0n4OhzzqK
        2wMYKXFtmpSuT9MiySFmPi8Dcq/68R4yl8TONhRasQ==
X-Google-Smtp-Source: ALg8bN5NYLl4lAI6BLJ9MubkAk36y6wUj1tdtWbYLW6cxuVOi2d9AS+G3MGdy7HbSGvuleBF5imJYQDizNJmp1zSFJI=
X-Received: by 2002:a0c:8a29:: with SMTP id 38mr24417673qvt.222.1548060139696;
 Mon, 21 Jan 2019 00:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20181220065933.25964-1-drake@endlessm.com> <20190119164915.2475b713@archlinux>
In-Reply-To: <20190119164915.2475b713@archlinux>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 21 Jan 2019 16:42:08 +0800
Message-ID: <CAD8Lp46LStHJbLAdzC9haLdhsbMXvXS2=k=EoJJuOudVf8YSEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: drop const typing from iio_mount_matrix rotation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 20, 2019 at 12:49 AM Jonathan Cameron <jic23@kernel.org> wrote:
> Also, I didn't think that much about it until now, but I'm not sure
> why you need this change in the first place. It is an array of
> pointers to constant characters.  Given we allocate said array
> before setting this variable to it and don't modify it via this
> pointer, I believe we are fine with out this.
>
> Compiler certainly isn't complaining about patch 2 without this
> one.  Am I missing something?

Hmm, I definitely had a need for it, but I can't reproduce any
compiler errors without it now, as you say.

I think I changed approach somewhere along the way, and this patch is
no longer necessary.

Thanks
Daniel
