Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17EC04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 21:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9415E20851
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fWI+Gvet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9415E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLBVJj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:09:39 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:40718 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVJj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 16:09:39 -0500
Received: by mail-io1-f42.google.com with SMTP id n9so8771678ioh.7
        for <linux-iio@vger.kernel.org>; Sun, 02 Dec 2018 13:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqRtHDu/9G4JGLYyr0qLIkxtEjmjKgZgaNs83J+4sEQ=;
        b=fWI+Gvetmgqp4PYm/d+Zw4gelucTiNGrLZSS09l3vb7vJxTWoKp1n0G9MlnlwIJ5TJ
         xfDzcZ3mbpcaBssRIpTA3gjJkbQeCdEvaPRO9gbH6cXbXxmoF9HRubgRdYyrzA9p+5u3
         Ce2BNHJ4kPvsRTbguhM74gNMp+IHbJDLvPRf19muDbfPDzi3Yp73aCNlb+z46JBL/2E+
         EuA+DNGuN9TCW1pBmfuIAFHaJmItTL3Mqkfmm7l9Hou2rERU+245fC0YnSmubbv8mX4D
         ZEhLAgESR95Z7NbPLBrEy6cEm2nGhu7TUXxKZaQCDKoI2pHYSf+UXKf1ypkUxqPK7lQW
         3/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqRtHDu/9G4JGLYyr0qLIkxtEjmjKgZgaNs83J+4sEQ=;
        b=RUQCfoJoG7AIcCgleA6Di7gI92mn8Ev1G17os8xjS49xjnMJuLaE+Q7Dp7mbfUEo+H
         VAvz7TR5Dh+p1/mpak+eAlkmSKedoNj4ttCIMFtNf15EpWZRGWYi2SPxYu/A9N+3k4ff
         E9EmTFNePfC2yEwcinIROt8zAgmDMqDjS8QEPrEzJiVkXCH8Co/xOHrs0M12L8b4AilC
         tIgmzAN0MaDUCjHza7OxUwSeTgCo3hrf7dO/Ie1UNHUWp6SJUO8uHT+Cm8XeX0M5xkKD
         iHy+kaZfp1oxtOo1rNXxbprEs0/A/WO87HWk+jur+xtWS4xCMktZBwiH3tHY/fk99Rbm
         gMQQ==
X-Gm-Message-State: AA+aEWZ4xW0ApQhhmIHSg/MNtWDagydp3L/eXcZ+/v1M2NpnYkiD7yCY
        mD8QAase7iwl8GiwwZu970fSMMHpQt9a4r+pBnXltQ==
X-Google-Smtp-Source: AFSGD/X5dIuJLQ0iC3ri6McBPkywr7/wCw//rlkQRn53B2C3n6uWrZfhv9XnocKggvF12LX5jUgudxnL/G/Q3qO9SIk=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr11700007ior.169.1543784975261;
 Sun, 02 Dec 2018 13:09:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
 <20181202195617.GB2007@himanshu-Vostro-3559>
In-Reply-To: <20181202195617.GB2007@himanshu-Vostro-3559>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 2 Dec 2018 19:09:23 -0200
Message-ID: <CAHd-oW5miJ-_9LyNje-wZc-PN1Yvy5OG3jeq5OVemeEHLTiLow@mail.gmail.com>
Subject: Re: Questions about the contributing process
To:     himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 2, 2018 at 5:56 PM Himanshu Jha <himanshujha199640@gmail.com> wrote:
>
> On Sat, Dec 01, 2018 at 02:51:07PM -0200, Matheus Tavares Bernardino wrote:
> > Hello everyone
> >
> > 2) Does iio have a test infrastructure? I know there are autobuilders
> > playing with the iio.git testing branch, but how does it work?
>
> https://01.org/lkp/documentation/0-day-test-service
> https://github.com/fengguang/lkp-tests
>
> > Also, if there is no test beyond building
>
> + booting
> https://lists.01.org/pipermail/lkp/2018-December/009493.html
> + coccinelle
> + sparse
> + smatch
> + automatically sending fixes based on reports produced by
>   debugging tools
> https://lore.kernel.org/lkml/20181127232130.GA28456@sof-kbuild01/
>
> Earlier they used to also give performance + power tests too.
>
> The build farm maintains around ~800 repos:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git/tree/repo/linux?id=91bb38c4ee4e95e57f1647446dc20d66cc53f92e
>
> You can find `iio` in above list.
>
> Build testing in around ~150 or more kernel configs in ~1-2 hours
> And sending the report immediately to the author by bisecting the
> commit on the first failure.
>

Nice! Thanks for all the references and information. I didn't know how
powerful those tests are!

> I don't work for Intel but I have experienced the power of the
> beast ;)
>
> Anyway, for other queries on the development process, I think Rodrigo
> Siqueira can help you too with a quick feedback belonging to the
> same university.
>

Thank you. He's helping me a lot, but regarding Co-Developed-by usage,
he wasn't entirely sure, either, and that's why I asked here. But
Jonathan already helped me.

>
> Thanks!
> --
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
>

Thanks
Matheus

> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181202195617.GB2007%40himanshu-Vostro-3559.
> For more options, visit https://groups.google.com/d/optout.
