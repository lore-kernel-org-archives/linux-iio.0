Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F16C10F0E
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1D82084B
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAA3Hqu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDIObY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:31:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33296 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIObY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2019 10:31:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so1650651edq.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Apr 2019 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vyk3tJff1lc/Wy3qx6MArusXDkPhl6nYqnEafKnupf0=;
        b=TAA3Hqu4V7yaU6Jwd1n6SYXMpvtC17iFN9s3OOxC1hPoEoYc7uhstb7ln6im4f++67
         bGcilko6D/sXTJzhQX+djypdbPtQFA0UwYmoSchfBv4dr1lJ44MNwLL/mWFTvLxaWUnM
         UU4klxn0MSQ4PhD13tcSS22iiqfKYV4wVmshkZOAbSVQC2tplCD2tQ9qDM8N/rFbBQoy
         0cqkifbogKhaUt6lMLfT8/epEgrKE1IX4HWfhOcLZ6VHJKnB8bFn9SalqX7Q3te12La1
         Dhamoui0PD6xljIiyo61GmPvMlXy4z2y6d29vHaYjH2YLNpvdozwFt5tESQvtx/wPZel
         lXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vyk3tJff1lc/Wy3qx6MArusXDkPhl6nYqnEafKnupf0=;
        b=rJYzo7QFKVBPcXtEa/QTk/Z3eeTC4noSMLEkgUptOOqvtH8NGEsI1BY1nZjuCwNeje
         mSI0/Uq0WOfjx5gkuS/9Ja/P900x0a13KY9EQAgF+TIXY0xCgi/mwqe+SS48P5iyhUfj
         tpfojtmmS+NtZM5YtcR7/wjsRgj4DBTBgeZALEPE7m0nmLuC7OU+eyZaFHhbJvtj/J4P
         M31QiP9+9Km5ocUrDGlbiWF+9ij939Lir+/mIkAEf7LihMamQAnwg00G6NEKLGS53Rqa
         52HATG9wJoUvnPqCcGedxdadhoxtrwNxTOCAXymfT68ve/iMbXgzoO65+0vCwRqRVNpO
         MORQ==
X-Gm-Message-State: APjAAAXk1BATHLIgVRsNHkMqs7qPh1yTRMS65047OYLp07sM3CCix/1M
        y8RMafGPtVEPFlj3ckSSZyfC6gIy56GScEccL6M=
X-Google-Smtp-Source: APXvYqyTPWUc1hAPd7yxxxp1j4ZB0tqaVl1JGZ6Fid79QZp1p1mbYoa+OtErM1XGSbI+JTHRLSGFIS/xnqQiwSDn6k0=
X-Received: by 2002:a05:6402:144d:: with SMTP id d13mr23437714edx.64.1554820282772;
 Tue, 09 Apr 2019 07:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
 <CA+U=DsokFDLC+kO61iErM12xp6ZBteYyfhrFKxexRzuumiFDqg@mail.gmail.com> <20190409121655.qptymigvkitgo3iv@smtp.gmail.com>
In-Reply-To: <20190409121655.qptymigvkitgo3iv@smtp.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 9 Apr 2019 17:31:11 +0300
Message-ID: <CAEnQRZC0vHSyexVtRB=WHCpNTDnCFWq3yBPkZC3NxqDUkatWfQ@mail.gmail.com>
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 9, 2019 at 3:17 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/08, Alexandru Ardelean wrote:
> > On Sat, Apr 6, 2019 at 10:46 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Hello.
> > >
> > > My name is Marcelo Schmitt, I'm a computer science student learning
> > > how to contribute to the Linux Kernel in the IIO subsystem. I was told
> > > by a friend that Google was encouraging people who contribute to open
> > > source projects through the GSoC program and that there was a project
> > > for developing a new IIO driver. I intend to continue contributing to
> > > IIO and, if possible, engage in this GSoC project. As suggested by
> > > GSoC organization, I shared a draft proposal for the project here
> > > https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> > > It would be really great if anyone could comment on it.
> > > Sorry for sending it so close to dead line date.
> > >
> >
> > Overall doc looks good.
> > One note about the steps: ideally the AD7292 driver should not be put
> > into staging, it's a new driver.
> > Hence there is no reason to have a "move out-of-staging" step.
> >
> > The current IIO drivers in staging are there, because initially the
> > IIO framework was done in staging, and some drivers were not updated
> > because of time/priorities.
>
> Thanks Alexandru.
> OK, understood. But where one should commit code for a driver in
> development as will be the case for AD7292? iio main tree will
> probably not be a good idea. Does any development branch exists?
> testing2, compiletest?

Hi Marcello,

You wlll send the code for review to linux-iio list and when review done
Jonathan will merge it in his linux-iio tree then it will send it upstream
to Greg then Greg will send it to Linus.

Your code should be placed inside drivers/iio directory.

HTH,
Daniel.
