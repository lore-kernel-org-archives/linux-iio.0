Return-Path: <SRS0=n2n1=W6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D4C3A5A2
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30C22CF8
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567533086;
	bh=Wwe6P4toIYLSuehdOuJJ0grghcwnXhOfhFcpI9jZG/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yF1UbVyNQB0TkJ2YFKEfpiPlPtJlA1LaZ8w0+vnD+5MMtynMFTtg9oqRIaZik1fNa
	 7EnF0xREJqnOc2uIKydCxSqHySrOEn+ps3Fn/KRpOgYLSNnzK04uyM9K1A+Zik7NL/
	 iFFLn42v6VBti94POr1P0WCcA6rtYC2qtcGTPZeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfICRv0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfICRvZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 13:51:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9B322CED;
        Tue,  3 Sep 2019 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567533085;
        bh=Wwe6P4toIYLSuehdOuJJ0grghcwnXhOfhFcpI9jZG/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z0f3/w0vPtvU1rebP/PVPPXRC1UQbBCqUVZuIwvrvq9fd4SnRUGe+wUQEZC35AzZN
         5aWLHl95vdsHIdO7wE9I/2BQBT+UVwRqe+alx0IGeYKGXv3hZkdYzAnLfp4BJP70tp
         551+aD8VlczggGpWJJ4NyG8Az+GST5G9Sgytm0Zk=
Date:   Tue, 3 Sep 2019 18:51:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190903185119.2328cf86@archlinux>
In-Reply-To: <20190902131301.GI2680@smile.fi.intel.com>
References: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
        <20190330153140.7bfecadf@archlinux>
        <20190902131301.GI2680@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 16:13:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 30, 2019 at 03:31:40PM +0000, Jonathan Cameron wrote:
> > On Tue, 26 Mar 2019 16:51:38 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > From: Vincent Pelletier <plr.vincent@gmail.com>
> > > 
> > > Exposes the ADC device present on, at least, Intel Merrifield platform.
> > > 
> > > Based on work done by:
> > >   Yang Bin <bin.yang@intel.com>
> > >   Huiquan Zhong <huiquan.zhong@intel.com>
> > >   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > >   Pavan Kumar S <pavan.kumar.s@intel.com>
> > > 
> > > Though it has been heavily rewritten for upstream.
> > > 
> > > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Hmm. There is a very small ordering issue in probe vs remove, which
> > I'll probably just fix up.
> > 
> > However I don't yet have the header in my upstream so will wait
> > until that is there before applying.  If Lee or whoever is dealing
> > with that patch set puts out an immutable branch with it in then
> > let me know.
> > 
> > Give me a poke if I seem to have forgotten it.  
> 
> Hi, Jonathan.
> 
> Lee applied the main driver to his tree [1].
> Should I do anything for this one or is it applicable clean?
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=b9a801dfa591
> 
Hmm. It's very late in the cycle and Lee doesn't have that in an immutable
branch (presumably because it's very late or it wasn't clear there was
a need to do so).  In theory I've done my last pull request to Greg
(though I messed it up so that's not quite true).

Will have to pick this up towards the start of the next cycle now I think.

Sorry, sometimes timing is against us!

Jonathan


