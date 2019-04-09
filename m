Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832D2C10F0E
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C720857
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQfiJ8rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIMRB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:17:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43646 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2019 08:17:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so19334098qtc.10
        for <linux-iio@vger.kernel.org>; Tue, 09 Apr 2019 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=692vbIpumhmbollLVtl9AZHe2OEmvy2J1znZtDfs5Zg=;
        b=sQfiJ8rVGETdbU9ewDejue10Fg7gHo/UrsgrDugqE5Ej7LHYAPLsO3rbpT75onXP3d
         ewEs6OWCWMB+D5nz8wQEG0futf7IsYwENRaEhQuUc2kpi40sFiUeFCS1p7jRNBT26VMm
         jgaWbBxRuhaIeAWuGBQrkwyhZ0smUDhMVZ+4vhby89vUegz2JkDMjyNilXEveAFhr+Bu
         pmTvoljUNzP9DVAiTvKpPIcK2dt3pc+fAw6J/ois4uHvNpmj+N3A7ZOTNOJqVAqrBEvP
         3M/NqdTg12MHWPKM4Ur6PLryr2REE0b3pNwj0f8vCcjQ9E3T+lLUzeEPNJcyjHUO2mTe
         eedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=692vbIpumhmbollLVtl9AZHe2OEmvy2J1znZtDfs5Zg=;
        b=m24XsZStJzDkCo/51fzSmJ+PvJY6FnfpatQTLTX3N/ATFCxOuQkfILHgE5WHqSOSiX
         tjf+KP97IGbEeWELBoi4Ifwiil8T+j4oo9KdQKwug1vVCC7AvgaOzf5tvg98HTaPsOBp
         9DtVdQTYckN10sYmMpRnw2wB7ugEbSZTcKEnOK1KFpCX+06XmkzAWuNT+/tr4FTkfpEp
         RnDlcE9LPjV+Nl9C+tF1WpcZ0lJ0fBZoi6yqM+w6+dAf0GwMlMuU+agJwgB69qPS+jx/
         p6wHEj3YlKr+DbLR2FpAfnoBPQRaQ1vKxulM1TLKkmKq6ZZVuSfwZVTloW3ntPskp+ix
         9cCQ==
X-Gm-Message-State: APjAAAV/obWzPU+8wSa9FJXMA7VuxyW66+21afiAnhBmFAn0rjC7HpwI
        VHCKLwoVLYgll/a67qWMzElJJF4cgKE=
X-Google-Smtp-Source: APXvYqzngJYETIeWket2Z3PStJpxr/FUhsNbmmDOXnmi9tMyNSOk8rsVzyPsTzlaad0THXbKCHb6mw==
X-Received: by 2002:ac8:1acf:: with SMTP id h15mr29000988qtk.85.1554812219745;
        Tue, 09 Apr 2019 05:16:59 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l59sm19619989qte.6.2019.04.09.05.16.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 05:16:59 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:16:55 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     dragos.bogdan@analog.com,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
Message-ID: <20190409121655.qptymigvkitgo3iv@smtp.gmail.com>
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
 <CA+U=DsokFDLC+kO61iErM12xp6ZBteYyfhrFKxexRzuumiFDqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsokFDLC+kO61iErM12xp6ZBteYyfhrFKxexRzuumiFDqg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/08, Alexandru Ardelean wrote:
> On Sat, Apr 6, 2019 at 10:46 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hello.
> >
> > My name is Marcelo Schmitt, I'm a computer science student learning
> > how to contribute to the Linux Kernel in the IIO subsystem. I was told
> > by a friend that Google was encouraging people who contribute to open
> > source projects through the GSoC program and that there was a project
> > for developing a new IIO driver. I intend to continue contributing to
> > IIO and, if possible, engage in this GSoC project. As suggested by
> > GSoC organization, I shared a draft proposal for the project here
> > https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> > It would be really great if anyone could comment on it.
> > Sorry for sending it so close to dead line date.
> >
> 
> Overall doc looks good.
> One note about the steps: ideally the AD7292 driver should not be put
> into staging, it's a new driver.
> Hence there is no reason to have a "move out-of-staging" step.
> 
> The current IIO drivers in staging are there, because initially the
> IIO framework was done in staging, and some drivers were not updated
> because of time/priorities.

Thanks Alexandru.
OK, understood. But where one should commit code for a driver in
development as will be the case for AD7292? iio main tree will
probably not be a good idea. Does any development branch exists?
testing2, compiletest?

> 
> > Thanks in advance,
> >
> > Marcelo
