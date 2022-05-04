Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C59C433EF
	for <linux-iio@archiver.kernel.org>; Wed,  4 May 2022 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378139AbiEDUlS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 4 May 2022 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355912AbiEDUlQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 16:41:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D049279;
        Wed,  4 May 2022 13:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC417B82945;
        Wed,  4 May 2022 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C5DC385A5;
        Wed,  4 May 2022 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696657;
        bh=x2k8eLmpAI5MhrBnDOm1e2daghSZLAuKoipmd98NfjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p6PPDNMR45buGLAqUlEo0R6GwTHIYs79XWGXpoLi589fZEP/Qqa/eZUhrK2UAEwQo
         7Z2YFBuTgCDFjuvhy9tdxQA8pccHhv3Pb+3NDAiXN9+xjbMxsLxkBU70uyz6Tbr9aF
         gPSFS1jw9aH8BJFn3zM6V6lEAZtIWlPCp16MMHUNYcGGcNVxLp5ScLRJieQpVVWpu2
         MlqhqkX3qMrM63SRLKORcpd4hSq9/fBk4J9bFBPDAwOlf3qqGoOiVpeohxFn7ipl2A
         roj8Ye6wjzgCiaJUAqTX2AprJXMcOsLgCajQHCwsHuDlqhxcNqIl8XMCww2HQtJITT
         rItsnS9Kk5T0g==
Date:   Wed, 4 May 2022 21:45:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: trigger: stm32-lptimer-trigger: Make use of
 device properties
Message-ID: <20220504214557.6a075da7@jic23-huawei>
In-Reply-To: <28627ccb-21ef-1b86-e5d7-460daf672d6d@foss.st.com>
References: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
        <20220428193304.016c46a3@jic23-huawei>
        <YnEB97YfPYpe2aCn@smile.fi.intel.com>
        <28627ccb-21ef-1b86-e5d7-460daf672d6d@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 May 2022 14:25:37 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 5/3/22 12:20, Andy Shevchenko wrote:
> > On Thu, Apr 28, 2022 at 07:33:04PM +0100, Jonathan Cameron wrote:  
> >> On Wed, 13 Apr 2022 21:56:56 +0300
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>  
> >>> Convert the module to be property provider agnostic and allow
> >>> it to be used on non-OF platforms.
> >>>
> >>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> >>
> >> MAINTAINERS entry for this one uses extensive wild cards so may
> >> escape scripts...
> >>
> >> +CC Fabrice.  
> > 
> > Thanks!
> > 
> > Not sure it might break anything, it's quite straightforward conversion.  
> 
> Hi Andy, Jonathan,
> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day see if it can find anything we missed.

Thanks,

Jonathan


> 
> Thanks,
> Best Regards,
> Fabrice
> 
> >   

