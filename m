Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9CACCA480
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jul 2022 16:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGPQzb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQzb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 12:55:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FF1EEC5;
        Sat, 16 Jul 2022 09:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA763B80B04;
        Sat, 16 Jul 2022 16:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1818C34114;
        Sat, 16 Jul 2022 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657990527;
        bh=7Bl73wYbx3fceHD3aHMi9YdJdovzhBgxVjvC17TvrEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkPCdqQrZbiWc5CL5h3FYBwArX+w4roN5dP3ZflfcDw6DAPowv9xO7DfWuuXYLuxL
         LbNRvBR1hBGOsm9LlxHkwN1T3BoIU9dMQJQOPwQXlIlPdM1fnJE9Cq6Ptx1IHG92P9
         C7iFIknBt1surhD1nJzkV/Oak3FDwbRKNdA9zz4tVB5xbOjkrFUFFn5PPmH3Udd6dI
         GAqLKqCzYQDgPeV4xErOnYO3cZ2bT8lLfAfv0gmNYWPtBSjkG3yI6+zqq0uObYrfSC
         5CcMPkbLRS6Y1u+wpEU0nq7fNc3l6epxduBRbI8bxQZNbGVpmL3pkx0B/hCuhVxope
         MBaqEAUS64mlw==
Date:   Sat, 16 Jul 2022 18:05:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 00/10] Add support for magnetometer Yamaha YAS537
Message-ID: <20220716180519.05a4b93a@jic23-huawei>
In-Reply-To: <CACRpkdZSeX-TPk4+_EEdZFMDH4bmgSZcm7vyX_d4+K4hGSbWXA@mail.gmail.com>
References: <cover.1656883851.git.jahau.ref@rocketmail.com>
        <cover.1656883851.git.jahau@rocketmail.com>
        <CACRpkdZSeX-TPk4+_EEdZFMDH4bmgSZcm7vyX_d4+K4hGSbWXA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Jul 2022 01:31:48 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> 
> > This patchset adds YAS537 variant to the already existing driver for
> > Yamaha YAS magnetometers.
> >
> > Patch 1 is a fix on the current driver.
> > Patches 2-9 are cleanups and refactoring.
> > Patch 10 finally adds the YAS537 variant.  
> 
> This patch set is really nice and getting nicer.
> 
> Maybe Jonathan could apply patches 1-5 so you don't have to
> resend so much code and get more focus on the top 5 patches?
> They are anyway nice in their own right.
> 
Given I'm running way behind (at least I'm in the right month now ;)
and my tree isn't stable currently (I'll rebase after rc1) and only
pushed out as testing as a result that isn't a good idea right now.
It would be at any other timing though.

So, please keep all the patches for v5.

Thanks,

Jonathan

> Yours,
> Linus Walleij

