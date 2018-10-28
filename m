Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeJ2A35 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 20:29:57 -0400
Date: Sun, 28 Oct 2018 15:44:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: potentiometer: tpl0102: switch to using
 pointer to chip config
Message-ID: <20181028154456.2ebe9d3e@archlinux>
In-Reply-To: <20181024173012.GA10909@x220.localdomain>
References: <20181024103858.28201-1-matt.ranostay@konsulko.com>
        <20181024103858.28201-2-matt.ranostay@konsulko.com>
        <20181024173012.GA10909@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 Oct 2018 19:30:12 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> On pa=C5=BA 24, 2018 11:38, Matt Ranostay wrote:
> > More concise to have a pointer to tpl0102_cfg struct in the iio_priv
> > data than an integer to an index of an array.
> >=20
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/potentiometer/tpl0102.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-) =20
>=20
> Looks good to me.
>=20
> Reviewed-by: Slawomir Stepien <sst@poczta.fm>
>=20
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
