Return-Path: <SRS0=7Ar9=SK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B7FC282CE
	for <linux-iio@archiver.kernel.org>; Mon,  8 Apr 2019 07:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510EA20880
	for <linux-iio@archiver.kernel.org>; Mon,  8 Apr 2019 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE5t6IMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfDHHGq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:06:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40382 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHHGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Apr 2019 03:06:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so11041125otp.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Apr 2019 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4S+m4kyXLbobXNEB4oLGtePfboLUimTAaP5z0UOxws=;
        b=YE5t6IMQ6sHJzDJdk+ZFsFAHsBmpLanFeHG2yeHfG8wSyk1B/2JgfiVfj3OjichVZt
         u8fvhfE+ZR4pAVo2FJ0o/9xGClaGxao70ENoIsLx5W8zUpj2ipWRVbEgoShDvioKZICr
         6X0dymg56Vhst21s0WY0lEQYYvKSHzKP5u+Omb+2cCHSShCC1Ds5AKtfNzSJi1mZUu0k
         EP1llz5OlmtV1awPe9FQ1B1RJymPWKwdW7gLGXh1E3vcomJD+ea+UduedGHTLgxRimwo
         2X4jJSSLOz8Fxws+3lyTB8z74HgNmfYBM+DXeXzCiMJMbZnRG3iMxXskV2NqsDnO86nb
         9pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4S+m4kyXLbobXNEB4oLGtePfboLUimTAaP5z0UOxws=;
        b=ZfVptdnQyHL9RI1CrMBqW4MxJzizVNjyDW2piQk1H9+kgJLQfJmqL/nHw62hbmS1lu
         9jD7eJraf0oEc07MWyY2lKHTLOrqz6V78ZLRAAb0XsT742Nl7GdrNANl3Z7Yr2bRKdkd
         zqDax0bvlCrVhI62TAMcIaLvXOBGCf7+CbxDnFcssLMD14TRr4cq5hSVQIrR12ZVYthd
         KcAEfX1maMGlfEhGG1DuK8EPeqgpBy5vtH0DZ9Tf2LobcPS4Z6+lcW7WTEFxykY0bAjm
         SlG9iTfLjXGAJi4VLd1TApLvDsTYg98gmpgxMefnXEOX+wmRUPxL8n0r7iUG7Pdj0il7
         3J5g==
X-Gm-Message-State: APjAAAUSWBinXjWtp6shHLJsUgSZtJNk74Nb8TCJU/Mqi0+X2QbaR5xA
        WuKLn6KDU/wGG1V9NoK5NsToI0bokDvpqUO/y3s=
X-Google-Smtp-Source: APXvYqyKoMJ4GLv6UlNq2oFIO/KDZxIF6jEnVfq8RdfRae+Riip9WdnHcDKUFBq/wquU+Beg6KeIEjHFIk0fw0blupg=
X-Received: by 2002:a05:6830:1654:: with SMTP id h20mr18626754otr.149.1554707205641;
 Mon, 08 Apr 2019 00:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
In-Reply-To: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Apr 2019 10:06:34 +0300
Message-ID: <CA+U=DsokFDLC+kO61iErM12xp6ZBteYyfhrFKxexRzuumiFDqg@mail.gmail.com>
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     dragos.bogdan@analog.com,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 6, 2019 at 10:46 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hello.
>
> My name is Marcelo Schmitt, I'm a computer science student learning
> how to contribute to the Linux Kernel in the IIO subsystem. I was told
> by a friend that Google was encouraging people who contribute to open
> source projects through the GSoC program and that there was a project
> for developing a new IIO driver. I intend to continue contributing to
> IIO and, if possible, engage in this GSoC project. As suggested by
> GSoC organization, I shared a draft proposal for the project here
> https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> It would be really great if anyone could comment on it.
> Sorry for sending it so close to dead line date.
>

Overall doc looks good.
One note about the steps: ideally the AD7292 driver should not be put
into staging, it's a new driver.
Hence there is no reason to have a "move out-of-staging" step.

The current IIO drivers in staging are there, because initially the
IIO framework was done in staging, and some drivers were not updated
because of time/priorities.

> Thanks in advance,
>
> Marcelo
