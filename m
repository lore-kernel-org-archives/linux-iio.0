Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771DC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F42082F
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 09:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqceXwJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRJEA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:04:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54666 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRJEA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 05:04:00 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so19256470itj.4
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCPZLaNgh2QqS7pjVrRMHuyUeSzrxQywBxGTM/DTF2o=;
        b=FqceXwJUsxa921JcMOQGynmZSZfe2IBycFsixxU3aIdSdy2Ibg8AxCgLNdVY9K8a80
         E2rdOClFLDmz1ffIcsjTWJA/8+1wAIefHlrbdYPbg/sF2/PRi/Q/pOXXR9/qTqfDMJHK
         cMo8qB7tiHnA4mzEeumq1KOkcd3uIFZ+8YE2z9qPmLNHq7RdlEBn32zPscm50jIbHuCK
         /RikASGTXdobGN5nV71E2RBOWJ1q695WfBPssF5tICUECBhMMr+m6hHfUm+LlZP1sO7Z
         6jOr2098T+ABbc+IffIwIT7gKTdsbdsZEc4N9q4oWD98PUVk0QDrY5IL3sQD0IymSht4
         ztag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCPZLaNgh2QqS7pjVrRMHuyUeSzrxQywBxGTM/DTF2o=;
        b=KwEZIyNjfnjMZO4RKDZUgZMSFIRxvOoVUamiIiAlDIzBQCLUlWv/XKtXLaoN89fi/4
         rDIhSO6jcNDMxwQFfXlPITIFTK3/0nSCbbmdfomX1CWj0sBuB0EEUaHdyUcbnr733fG9
         q5jImWdd4SO+zFFTovLzX0ZvNnA8qfzWbD3G/EKTNvQE4wcZoSKeA64gDkX/7rWbjgZZ
         gGtaYgxWuA+mJ+uMAJVV4thIxLKdjCn0y2bvGt9cDabNp3UGmQ7eVoq1AnHT0AMVTlRY
         ZqdZ+nI+LrkoRBRg71F7SHFm8ejsyU3OEe9hQy0JG0FxIBS5kN8JD7HH5J0On2sFI0U5
         IByA==
X-Gm-Message-State: APjAAAU6dkQhcHwj6Gx8G7Vlu8DDCY+QWleBNSlqCVY/dLESCeGU9aRP
        UlWu26EhyBIrEuBQuavRfscd1Fr04EBGIlB9t5A=
X-Google-Smtp-Source: APXvYqza1Zib9IyRUsAN+zLJGqNb8/SI5NqB7AHRA9bhvWgQpnJMI4WN/6/PM3n9yHxjrVHKHAPkK84YVmIYqWnXbpw=
X-Received: by 2002:a02:393:: with SMTP id e19mr10829961jae.95.1552899839308;
 Mon, 18 Mar 2019 02:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
 <20190317171848.GA7105@himanshu-Vostro-3559> <CA+U=Dspj8V13kGf0GFBbOgPwkSDnC+Oh43rDzmWvHgcKk2vmkg@mail.gmail.com>
In-Reply-To: <CA+U=Dspj8V13kGf0GFBbOgPwkSDnC+Oh43rDzmWvHgcKk2vmkg@mail.gmail.com>
From:   Karuna Grewal <karunagrewal98@gmail.com>
Date:   Mon, 18 Mar 2019 14:33:47 +0530
Message-ID: <CAHRz_yZhshBjq0Pgk-FzFghTtNC_VvsnM_A9HBorwN2r6vn9Gw@mail.gmail.com>
Subject: Re: [GSoC] AD7292 driver project
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 18, 2019 at 2:03 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Sun, Mar 17, 2019 at 7:19 PM Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> Curios.
> Is this project listed anywhere ?
> If so, can we get a link ?

Here's the link: https://wiki.linuxfoundation.org/gsoc/2019-gsoc-iio-driver

> > My personal opinion: Try to get atleast a small patchset accepted in
> > the kernel. It helps you get familiar with all the tools and how kernel
> > cycle moves. I strongly agree with Jonathan on 'setup', whatever
> > hardware you plan to use in the project say., how would you build/test
> > kernel on Rpi or beagle or QEMU or diolan ? dt-overlay, acpi
> > enumeration ?

I'll be using RPI w/ DT enumeration.
