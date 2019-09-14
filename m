Return-Path: <SRS0=BP1q=XJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0CC49ED6
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 05:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF27E2084F
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 05:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfINF5u (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Sep 2019 01:57:50 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32187 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfINF5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 01:57:50 -0400
X-IronPort-AV: E=Sophos;i="5.64,503,1559512800"; 
   d="scan'208";a="401705630"
Received: from 81-65-53-248.rev.numericable.fr (HELO hadrien) ([81.65.53.248])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 07:57:48 +0200
Date:   Sat, 14 Sep 2019 07:57:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jay Aurabind <jay.aurabind@gmail.com>
cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
In-Reply-To: <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909140756470.5193@hadrien>
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR> <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Sat, 14 Sep 2019, Jay Aurabind wrote:

> Hi Rohit,
>
> The required config options need to the objects in that folder to be
> build. Apparently there is no way to automatically set the required
> configs. You can look at the Kconfig files inside drivers/iio/accel
> and see what are the dependencies for building various drivers.

It looks like some of the drivers are individual files.  So you can also
just compile them one at a time make staging/drivers.iio/accel/foo.o.

julia

>
> On Sat, 14 Sep 2019 at 00:58, Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >
> > On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
> > > Hi,
> > > I was trying to compile a particular folder in my kernel tree.
> > >
> > > AFAIK the way to do this is:
> > > `make drivers/staging/iio/` from the kernel base directory.
> > >
> > > This gives me the following output:
> > > `
> > >   CALL    scripts/checksyscalls.sh
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   DESCEND  objtool
> > > `
> > >
> > > No object files are generated.
> > > I feel like I am missing something.
> > >
> > > Thanks,
> > > Rohit
> >
> > I ran `make clean` in the `drivers/iio/accel` directory which removed
> > all object files in the first place. However running make after that
> > doesnt seem to compile the modules.
> >
> > Thanks,
> > Rohit
>
>
>
> --
>
> Thanks and Regards,
> Jay
>
