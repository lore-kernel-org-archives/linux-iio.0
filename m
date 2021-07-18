Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A090C636C8
	for <linux-iio@archiver.kernel.org>; Sun, 18 Jul 2021 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD361184
	for <linux-iio@archiver.kernel.org>; Sun, 18 Jul 2021 15:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhGRPKb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGRPKb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 11:10:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FD761183;
        Sun, 18 Jul 2021 15:07:30 +0000 (UTC)
Date:   Sun, 18 Jul 2021 16:09:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: st-sensors: Remove some unused includes and add
 some that should be there
Message-ID: <20210718160954.037c49fc@jic23-huawei>
In-Reply-To: <CACRpkdYmToL445kE5A53+sRitFxsn5e7sn+PPiQiPv1OocDopA@mail.gmail.com>
References: <20210608175149.4019289-1-jic23@kernel.org>
        <CACRpkdYmToL445kE5A53+sRitFxsn5e7sn+PPiQiPv1OocDopA@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Jun 2021 09:53:57 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jun 8, 2021 at 7:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The st-sensors drivers have changed in structure over time, and includes
> > have not always kept up with this.  Let's bring them back to nearer
> > the ideal.
> >
> > Identified with the  include-what-you-use tool and careful checking of
> > its suggestions.
> >
> > Note I haven't been particularly aggressive here, so this is just the
> > cases where the include obviously isn't needed rather than the more
> > subtle corners.
> >
> > Note I took the opportunity to add mod_devicetable.h as I generally
> > prefer to see that when acpi or of match tables are present.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>  
> 
> Looks good to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
This seems unaffected by the questions around kernel.h and the
splitting that Andy is working on for that.  Hence applied to the togreg
branch of iio.git and pushed out as testing to see if 0-day can find
anything I missed.

Thanks,

Jonathan


