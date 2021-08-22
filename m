Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB8C4338F
	for <linux-iio@archiver.kernel.org>; Sun, 22 Aug 2021 02:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B575C6127B
	for <linux-iio@archiver.kernel.org>; Sun, 22 Aug 2021 02:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhHVCEY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Aug 2021 22:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhHVCEW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Aug 2021 22:04:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E961C061575;
        Sat, 21 Aug 2021 19:03:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i21so12150324pfd.8;
        Sat, 21 Aug 2021 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3cvWZiQJNDhvVotuhqFVoSuEfSpJeFSijwgz7uZHHio=;
        b=H7I6kIPMHfgoRUgfUG2h6TcSxH98jOHmeiCAkQLoLO4tFFlUJ8Xu2gGcdnu7B34m6E
         weSYJmrD3i7b5O1bZyGH/dTUbZri0L7VPY13G871+AbBNODvKFOIsHBZjGguCAjq6a8/
         x3l8ku4sZotj3HCdlHGU5QXc18fy11WpQCw1IW+C+K1Ot3irOAjn3VHGfqYvFyAQQtSJ
         ICVg1qyGvnqY9Qi7P6xj21NA52LpOPt1ZchQRQKV3gwHmx+zmN1h29c5q7T0WVS+C7YA
         t5CIrIsQKTXtkd2Y9o8CnXZPfrjA9f8ZnKx3ByreK3RaF1T6QXvUtO5CYuobs9/sTmIn
         c60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cvWZiQJNDhvVotuhqFVoSuEfSpJeFSijwgz7uZHHio=;
        b=hKlQZqPzct2HHwqOxTYNXPYkbwXaozhLX/HasWxKe/ivYqRFKq/FchE5+GlwDupz/a
         eT1PTNnahmTVVUEb1nuUwzTowxz4rssLXHw3S1txldr2Cm8n3eD9D1LWkPX+oKkJd8xr
         P+sYJ2dZts6+D5Em/rG098DYCAB8Vz4EuFW5ZjvJ9iZ9hHdDAMcegTTG0JATYk5ZHtca
         Ic78tAldqo2tv92uTZr4aruB35w0w01CxN2qbnATswlhrnjMeznX8RH3wZw0nqm8QWgy
         v+zeWkO4UCEjuYXPpYAplkPzta7FASf4JVUfHpt9v2IpMzasVhXbOWgNtNApIBvtJ6m8
         fRUA==
X-Gm-Message-State: AOAM533QH2jKhmaXxqn+G9zyML5Y5ha7WJOfnEVEryOti6uKDp1pvyF7
        nK7c74fzbh7H+UBk5CpYVeM=
X-Google-Smtp-Source: ABdhPJxoFivrZ6MnqK7C9Hhz0C1i4p4l1QQDWxCpRA7QFLhQolRgMKVl3h82KyiT37dV85Lv8QGwoA==
X-Received: by 2002:aa7:8298:0:b029:338:340:a085 with SMTP id s24-20020aa782980000b02903380340a085mr26917000pfm.46.1629597821901;
        Sat, 21 Aug 2021 19:03:41 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k6sm13330689pgk.1.2021.08.21.19.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 19:03:41 -0700 (PDT)
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <YSDa667n6pi4O8iT@shinobu>
Subject: Re: [PATCH v15 07/13] docs: counter: Document character device
 interface
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <f6930072-c487-a102-931c-53a79515d5fa@gmail.com>
Date:   Sun, 22 Aug 2021 11:03:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSDa667n6pi4O8iT@shinobu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(dropped most CCs)

Hello William,

I spotted a minor error while browsing documentation updates.

On Sat, 21 Aug 2021 19:52:27 +0900, William Breathitt Gray wrote:
> On Sun, Aug 15, 2021 at 05:51:02PM +0100, Jonathan Cameron wrote:
>> On Mon,  9 Aug 2021 21:37:32 +0900
>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
...
>> > +
>> > +Counter events can be configured by users to report various Counter
>> > +data of interest. This can be conceptualized as a list of Counter
>> > +component read calls to perform. For example:
>> > +
>> > +        +-------------------------------------------------+

This needs to be:

              +------------------------+------------------------+

, so that the table structure can be properly recognized by Sphinx
(kernel-doc tool).

        Thanks, Akira

>> > +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
>> > +        +========================+========================+
>> > +        | Channel 0              | Channel 0              |
>> > +        +------------------------+------------------------+
>> > +        | * Count 0              | * Signal 0             |
>> > +        | * Count 1              | * Signal 0 Extension 0 |
>> > +        | * Signal 3             | * Extension 4          |
>> > +        | * Count 4 Extension 2  +------------------------+
>> > +        | * Signal 5 Extension 0 | Channel 1              |
>> > +        |                        +------------------------+
>> > +        |                        | * Signal 4             |
>> > +        |                        | * Signal 4 Extension 0 |
>> > +        |                        | * Count 7              |
>> > +        +------------------------+------------------------+
>> > +
