Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D0C433F5
	for <linux-iio@archiver.kernel.org>; Mon, 18 Oct 2021 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C13461077
	for <linux-iio@archiver.kernel.org>; Mon, 18 Oct 2021 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhJRRwp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234135AbhJRRwp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 13:52:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B7C61074;
        Mon, 18 Oct 2021 17:50:30 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:54:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: iio: stm32-adc: add generic channel
 binding
Message-ID: <20211018185445.3b6d9963@jic23-huawei>
In-Reply-To: <YW2mYKpWSPzGvzUa@robh.at.kernel.org>
References: <20211014131228.4692-1-olivier.moysan@foss.st.com>
        <20211014131228.4692-2-olivier.moysan@foss.st.com>
        <YW2mYKpWSPzGvzUa@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 11:52:48 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, 14 Oct 2021 15:12:22 +0200, Olivier Moysan wrote:
> > Add ADC generic channel binding. This binding should
> > be used as an alternate to legacy channel properties
> > whenever possible.
> > ADC generic channel binding allows to identify supported
> > internal channels through the following reserved label names:
> > "vddcore", "vrefint" and "vbat".
> > This binding also allows to set a different sampling time
> > for each channel.
> > 
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
> >  1 file changed, 93 insertions(+), 7 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks.  Series applied to the iio-togreg branch of iio.git and 
pushed out as testing to let 0-day take a look at it.

Thanks,

Jonathan
