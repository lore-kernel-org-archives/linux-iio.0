Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2791C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8536320728
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587831171;
	bh=Xyzo62tdGwq75zc3DO+ELuTlysKMO428ySW3nIiog8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kLlS+IdcxE3oyWVSsQ5Zpxb/ej/7wq7PTujZohVPqrajQJF/UAS7277DwpgmKMQyr
	 PpzxDt9mN7MJPr3yUYFiv4IwxydwGbMEc4J9Eyig1QAruvEQXx4DFHE64fbD8p4F0J
	 GvVST8ajNf/iNaU2OKgYNrkOwuHBKqui3QvAiSl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDYQMv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQMu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:12:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625BD2071E;
        Sat, 25 Apr 2020 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587831170;
        bh=Xyzo62tdGwq75zc3DO+ELuTlysKMO428ySW3nIiog8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPU9is/r4La9pxwJvCH4aZ3b6jQTdmHatLY6GmbnSrkMKePTYR5MEjK70YbkqgQDv
         317W110curyOlGXlOb0zERCEhT54DhB+cbUJNzF0BHHHxjuR2s/nDGslA4+i9S8yBt
         YyhepN44FYjExZNQqaSf4DiWJ3sq/j08mTm5GMfE=
Date:   Sat, 25 Apr 2020 17:12:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use
 {get,put}_unaligned_be24()
Message-ID: <20200425171245.4ac8e83d@archlinux>
In-Reply-To: <BN6PR03MB3347CE880B5792D1C8BEE40999D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <BN6PR03MB3347CE880B5792D1C8BEE40999D50@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 06:41:32 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Andy Shevchenko
> > Sent: Dienstag, 21. April 2020 02:31
> > To: Jonathan Cameron <jic23@kernel.org>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Lars-Peter
> > Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use
> > {get,put}_unaligned_be24()
> >=20
> >=20
> > This makes the driver code slightly easier to read.
> >=20
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/adc/ad_sigma_delta.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >  =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
etc etc.

Jonathan


