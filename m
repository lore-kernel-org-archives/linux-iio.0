Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6705C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A7820728
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587832156;
	bh=zfmcDGDJTWvjWb2zV92dJjkoLe+/9InCkpD8dYvCJMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ddbZloO0nhO4JnpZ6aOg8HEoG3kmv88eQ+rUWoLKDx4b0H6AToMoQxXvT8KXqbOv2
	 1fwQaBd7N7H62ctTmk79+BBPudNfoobt71O0DeJhkTAwm/E5Z2gt8BEB/wRHiyVbP4
	 wCmQSXoGAl33gFsW+UeMf33dDPsVgi+UU/e3DEL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDYQ3Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDYQ3Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:29:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEB720714;
        Sat, 25 Apr 2020 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832155;
        bh=zfmcDGDJTWvjWb2zV92dJjkoLe+/9InCkpD8dYvCJMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xWJM4tiB3mpq7UJf8nFvX2++XJpHkrXEcsyMb8pTgLCZk98h+G2H+h7CbJeXzj70s
         cDFHtrieqZ4N58oNpa+tdY3YwII68ahED3cFBa5j02HzeI+Vpv35KHHocBzLofT0gt
         MFamKyG+0jSfesoKv2tIBbYbQ8uXP/9lMZ65zcgI=
Date:   Sat, 25 Apr 2020 17:29:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use
 put_unaligned_be24()
Message-ID: <20200425172910.7720cd90@archlinux>
In-Reply-To: <BN6PR03MB33479ED0E14BF2341C93563A99D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-5-andriy.shevchenko@linux.intel.com>
        <BN6PR03MB33479ED0E14BF2341C93563A99D50@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 06:43:44 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Andy Shevchenko
> > Sent: Dienstag, 21. April 2020 02:31
> > To: Jonathan Cameron <jic23@kernel.org>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Lars-Peter
> > Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use put_unaligned_be24=
()
> >=20
> >=20
> > This makes the driver code slightly easier to read.
> >=20
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/dac/ad5624r_spi.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >  =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied with missing asm/unaligned header added.

Thanks,

J

