Return-Path: <SRS0=IeKv=CP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188DDC43461
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB792075A
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599404616;
	bh=0a+El6Hu2G19QLat7l/IFDJ+dLadCsCadebv+Wnnbug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1HFk2NNdf1Va1kCQvcwWUGrbSKKH0vyLvQ9bRTNpcte0Qp+XzO1VaJWwYJW8OdABF
	 IxxqVq0WyKb+j15ONNXXk6UTKHn0rNc4TM8bT2RA/dCfVVqauSH8GZywaB8GlKreM9
	 uwZo6Pt3xOKS1e+qpJ0M0yq9Kjq4+GFHnjI9DQtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgIFPDa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgIFPDX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:03:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4B920714;
        Sun,  6 Sep 2020 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599404603;
        bh=0a+El6Hu2G19QLat7l/IFDJ+dLadCsCadebv+Wnnbug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SxJv2acXn0LGN7AkCm/9QXZ3Ff7ISVlvngFTN2IN8yL1+LSUnd+Ia+fAObRp81ARV
         jgOhvzwg29mGUDLn52tTx0RdRpnDcOLKmVM8ceVPfgTpLWYIGC0udKzugT5Fr+1Gqi
         Ad/gzcEk8ezHwcBPxqvBHY4jdHtIsjZMoKSIDT20=
Date:   Sun, 6 Sep 2020 16:03:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: gyro: adxrs290: Add debugfs register access
 support
Message-ID: <20200906160318.13b83634@archlinux>
In-Reply-To: <CAHp75Vc2UhW5yDhXs0RJZUmXABAqTX12N1NA3CWeSirHWfPCng@mail.gmail.com>
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
        <20200903130950.6274-4-nish.malpani25@gmail.com>
        <CAHp75VfReT-EjCV=cW8mV1MmoMPPdY9q1scoPwbD_DEHpQHd3g@mail.gmail.com>
        <CAEtfd9ZPkyk9_GV3h-CXFT_j=PYU66SHoYaaE7tytQxb+Q5rVA@mail.gmail.com>
        <CAHp75Vc2UhW5yDhXs0RJZUmXABAqTX12N1NA3CWeSirHWfPCng@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Sep 2020 16:59:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Sep 3, 2020 at 4:57 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
> > On Thu, Sep 3, 2020 at 6:55 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> 
> ...
> 
> > Umm, I'm sorry, I don't see why'd it be favourable for us to do it
> > this way. Also, I *think* Jonathan is fine with how it's being done
> > now.  
> 
> I have no strong opinion, so whatever Jonathan thinks better.
> 

Andy's suggestion is a little bit nicer, so as you are doing a v3,
might as well roll that change in as well :)

Jonathan
