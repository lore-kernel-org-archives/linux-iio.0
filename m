Return-Path: <SRS0=ElSe=5U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E14C2BA15
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12F82076C
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586010099;
	bh=7t82RrM++T30E89ZOhG5gQGEdfaKn84+qzeujIakTj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GPNqp0IWDulhb7U8FwND1dThP27ANli9/rn7cfjnb/1vs1MXZXWGYeuKLuCzjSrSA
	 IOYGjdX28Lmm2TRnk53Mqlyhm91oTRxIXNSaQAlAPIrW5KP6mmiQ8sIYFcKqFUk/A/
	 I3LtOLChHc620XNiKMqx3PC5NnklAwa4PdmlLfhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDDOVj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDOVj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:21:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4375206C3;
        Sat,  4 Apr 2020 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586010098;
        bh=7t82RrM++T30E89ZOhG5gQGEdfaKn84+qzeujIakTj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QI1PMeZ4PbbeA6Wp211RM+j9uwqkqCiW+K62B7GHmcRCR47xCrLEsT7epwk6ihJtG
         MFQ7zvLrXbo2RTUlu+V1GeOasysTob31U1wjQEev5A76znjVYIoPRkplJU1+S5/ICE
         j+Z7nCNof353uV40QkmFf7Ml7xGnWS/7PKbb+mKQ=
Date:   Sat, 4 Apr 2020 15:21:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, olivier.moysan@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-adc: fix id relative path
Message-ID: <20200404152132.62382a66@archlinux>
In-Reply-To: <20200330232115.GA17380@bogus>
References: <1584641907-8228-1-git-send-email-fabrice.gasnier@st.com>
        <20200330232115.GA17380@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 17:21:15 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 19 Mar 2020 19:18:27 +0100, Fabrice Gasnier wrote:
> > Fix id relative path that shouldn't contain 'bindings', as pointed out
> > when submitting st,stm32-dac bindings conversion to json-schema [1].
> > [1] https://patchwork.ozlabs.org/patch/1257568/
> > 
> > Fixes: a8cf1723c4b7 ("dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the fixes-togreg branch of iio.git
I will hopefully send a pull request for this around the time
the merge window closes.

Thanks,

Jonathan.
