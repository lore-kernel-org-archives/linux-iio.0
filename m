Return-Path: <SRS0=ObhF=PX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB63C43387
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 03:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC4920659
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 03:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ttyrk1+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfAODKF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:10:05 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34359 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAODKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jan 2019 22:10:05 -0500
Received: by mail-qt1-f176.google.com with SMTP id r14so1548917qtp.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Jan 2019 19:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJQZktiEsGxt2XiXVCTJqlD5Se3gK2kh1PX1CI++hdQ=;
        b=ttyrk1+Uy5BfC+oGG0lrSxMolqgY+2TqmklDeqxiJxxnprXhTeYGNWX4AUQJ3o2sIB
         C/KvVI3nDbqfw7s/nctMAH8w0yI0Yt/JdTGJ4Y9habLdGb5du3MDMoIcXb9b2fbfH1gU
         nSqYeiW/9UrJ1qmfl3lzEDM+cbiLJ4CFTOPDngavPMHYiAQPw/uMWSRVGPEQmfLymHvd
         PCAGhyDafACWOYY0UoSLy206Un60YSfDJkNBVmpkzL7oUAbrV45ELizwERF2JRBaBlFb
         Xicd5IaZnS0vdqAmdPfeHQjK74mEz3wCbaEcvZcfQ0WtZf5ZbaZnuLB1Buu1Mpwd7fYx
         jW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJQZktiEsGxt2XiXVCTJqlD5Se3gK2kh1PX1CI++hdQ=;
        b=N8CYb8GvPLole4+HC4BMkuI9TwNmZg2Y9pRl/Mcjp9JkQ3y5RVO5kieAkvesXzgGQ1
         Bh6SyqcWBL8rYVkweczUYvlQ/PkBdpN8KUDP6zbO6/yJXVAYBUip6pmCzLlvcsqka1Q1
         TTCjA0dRHtPeEK/IOtyyRBL1gvU7bMGDTOCCUCuELyrdCDjl8rCv+y3HCgJfvUIQDsqE
         Isj0rsBiKZCAzQZ5Cow6dj0+7SrLvGDUM3Yip5fjMSBqRq5W9TClQS36eb6zzz7SD7Dk
         ZB6SqFzFr0GptftDnXBhIOjFqauX+v1iCTm9UgWgGogIZfjIw0lz+m1xMAhmab3pXX8N
         eTsg==
X-Gm-Message-State: AJcUukdwyAEmltLnNlaGyNAovKKJ+SYVF/dVjKr4q16xmeM8KTefE0et
        f2sv1j4Dnrg8XWU0cieI8+DPn5f6ZKA+lCbwTSr8eQ==
X-Google-Smtp-Source: ALg8bN5ZOXPEg1RbjenDojCBJeQFspbE2zvFv+JuP061MdCViEp1sKTFRrQUzMXeiAYo9OJ+uBxQyLsLArbgVQ8ELA8=
X-Received: by 2002:aed:2185:: with SMTP id l5mr1286749qtc.276.1547521803667;
 Mon, 14 Jan 2019 19:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181220065933.25964-1-drake@endlessm.com> <20181220065933.25964-2-drake@endlessm.com>
 <20181222180914.6d3b5e5e@archlinux> <20190112191305.103daa46@archlinux> <49fe1df26d70489ca3b3c52cb5cf561c@SFHDAG2NODE1.st.com>
In-Reply-To: <49fe1df26d70489ca3b3c52cb5cf561c@SFHDAG2NODE1.st.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 15 Jan 2019 11:09:51 +0800
Message-ID: <CAD8Lp47XPzqQrVpAMnyHKE92Zj7XB8fZnj5HW_TTddgHzUCmOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: st_accel: use ACPI orientation data
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Denis,

On Tue, Jan 15, 2019 at 8:18 AM Denis CIOCCA <denis.ciocca@st.com> wrote:
> I am not familiar with ACPI and I am not sure why axis orientation is not=
 following the standard there.
> What I wonder is if this is related to SMO8840, Acer or in general to ST =
accelerometers integration. Your patch seems to be fine technically but are=
 you able to confirm it will works even outside the 3 parts tested? The oth=
er accel supported by ACPI probing SMO8A90 is affected also?

The _ONT data format was explained to us by a vendor support contact
at ST. (however, the fact that the _ONT transformation must be applied
after first applying another translation was determined experimentally
by me).

We have seen this _ONT data present in ACPI tables from multiple
product vendors, on SMO8820, SMO8821 and SMO8840 devices, so I believe
there is no doubt that it is a ST-specific thing.

The specific transformation behaviour in my patch has only been tested
on products with SMO8840 though, since those are the only ones we have
on hand.

Daniel
