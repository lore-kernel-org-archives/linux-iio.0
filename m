Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A67C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E678C20834
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 19:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm2Ynxed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbeLBT41 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 14:56:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43473 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBT41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 14:56:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so5242712pfk.10
        for <linux-iio@vger.kernel.org>; Sun, 02 Dec 2018 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSL9g+UOqi0FLcuT0aw45TP35VAvbSYaq20lecHijPk=;
        b=rm2YnxedbtPPxlaLxXVBQXcVVMUldKGBTW6pa1rEn9UFl6kvxFNLw/V2mjCETJaX79
         BqownmEMSGA7ttnhWOKt0g7cS2iiEAU2ufGuN4DKfIWrhKOQYxVPQYLpasK/IkFbGT9s
         M/UDt83McLqhzH+gCJkVdEHrGH3fiQHCv8MMSl8dqQaO/a2z9l5p9JJwSLZWfp+ikMcN
         MsqxrCujDIbltw92/mRhelpNJZsUNIrEs/NbxKYb5Kco+HDdj7Pzl2COi+WkfKPSiDgC
         Hu2q85JGmFXTnVnNmDQRcQ6ZJU6hRTVpNw+kbhRPCXfVFicCrBaZ4hYG4UYWJl4vMy21
         z2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSL9g+UOqi0FLcuT0aw45TP35VAvbSYaq20lecHijPk=;
        b=Vw/ScDgRsaNHBD8TRuulfMWFOjAMX/JOMeBQF1805dMuAILhZnReoBYDiqJE0Gj03Q
         +JPmIGVsYgY80XkSQuOdiU3ykQqcsXgvGwNCkM99JSwqnYESGo4vjXSyJTBUwN/R16MT
         ecUL4FguWIqLAFhb6FTUyS7NwiqfjI9cm7P0knFSyUdGD0UzKCGSaQhZWxqNM0aAN67o
         yXTzfFy6ztaDMNpaX5xcZTOfe1Ww/XWFPAYeiYyHzfy6x2WXMCUVRmFRZnCi/cmvjrw5
         Mjt1KFmMstpwNTZCgpjeQyOxzDId29ehs5E36L2EwhjTa3JVAjhRAXEENwCX6ZVtzTd+
         IO+A==
X-Gm-Message-State: AA+aEWZ8odNt79j47x3PMWeH0+NZewiQye7lJaRauA4m1vWI6HYlIxdg
        V0gb6ESvu7iy5JLk+KUefk4=
X-Google-Smtp-Source: AFSGD/VAxZrv1Bpk3qHm62a/Q/kMtpE9Rxz/9wHhjZ1qM9raH/arBplSigLCaC+mRxH2m+2NYIVIVw==
X-Received: by 2002:a65:520a:: with SMTP id o10mr11453318pgp.276.1543780584057;
        Sun, 02 Dec 2018 11:56:24 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id n23-v6sm23671782pfg.84.2018.12.02.11.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 11:56:23 -0800 (PST)
Date:   Mon, 3 Dec 2018 01:26:17 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: Questions about the contributing process
Message-ID: <20181202195617.GB2007@himanshu-Vostro-3559>
References: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 01, 2018 at 02:51:07PM -0200, Matheus Tavares Bernardino wrote:
> Hello everyone
> 
> 2) Does iio have a test infrastructure? I know there are autobuilders
> playing with the iio.git testing branch, but how does it work?

https://01.org/lkp/documentation/0-day-test-service
https://github.com/fengguang/lkp-tests

> Also, if there is no test beyond building

+ booting
https://lists.01.org/pipermail/lkp/2018-December/009493.html
+ coccinelle
+ sparse
+ smatch
+ automatically sending fixes based on reports produced by 
  debugging tools
https://lore.kernel.org/lkml/20181127232130.GA28456@sof-kbuild01/

Earlier they used to also give performance + power tests too.

The build farm maintains around ~800 repos:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git/tree/repo/linux?id=91bb38c4ee4e95e57f1647446dc20d66cc53f92e

You can find `iio` in above list.

Build testing in around ~150 or more kernel configs in ~1-2 hours
And sending the report immediately to the author by bisecting the
commit on the first failure.

I don't work for Intel but I have experienced the power of the
beast ;)

Anyway, for other queries on the development process, I think Rodrigo
Siqueira can help you too with a quick feedback belonging to the
same university.


Thanks!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
