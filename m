Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0058AC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AA320776
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598723418;
	bh=7cfMJ1aLghIM1zB7bijBXeVr7/zLl6AWx52H8zBQYYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lrcqPVMGlHJ55Xs6uu9lBTdjs+0A/nVwqmWQz3trK8TPMbuhRUKPCATWx7N0BkwAA
	 tPcoqKfutnf7dwGEixibMI4M3N6gFgRw0s5Efw0TvwL8gsL55zMMaEKRE6Q+trzQW5
	 m7ADPwusuRgnnQDrrOO0l3qHaTS5CUwoEooHvH9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgH2RuR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgH2RuR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:50:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0032F2071B;
        Sat, 29 Aug 2020 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723417;
        bh=7cfMJ1aLghIM1zB7bijBXeVr7/zLl6AWx52H8zBQYYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hA3TyCKNM7oH5FHvpESVncYg7TS1ftW3FVUtkkVxkEVzRS1v7fh21EQvXvS7G9vCt
         gsbSOb6H+94FLhHZ56hD9eQiOGWPC3CDA/gW1sOkLz09pmTzbssvWxM7yG75q2jYW+
         VKRHdOMnIcsiFeuWhA7sKLpn2LrJoRUnQoBh8+cU=
Date:   Sat, 29 Aug 2020 18:50:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/13] dt-bindings: iio: adc: ti,adc108s102 yaml
 conversion
Message-ID: <20200829185013.4b413c01@archlinux>
In-Reply-To: <20200818022757.GA2167774@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-4-jic23@kernel.org>
        <20200818022757.GA2167774@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:27:57 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:43 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Very simple conversion of spi device with reference supply.
> > 
> > Added the #io-channel-cells property to allow for consumers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  .../bindings/iio/adc/ti,adc108s102.yaml       | 47 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-adc108s102.txt        | 18 -------
> >  2 files changed, 47 insertions(+), 18 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,

Jonathan
