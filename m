Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbeFXNwW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:52:22 -0400
Date: Sun, 24 Jun 2018 14:52:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "preid@electromag.com.au" <preid@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio:buffer: fix iio_dma_buffer_set_length() prototype
 mismatch
Message-ID: <20180624145217.131da6f2@archlinux>
In-Reply-To: <2126e135f7e414382131b4bbb8414d1eaac64f3a.camel@analog.com>
References: <20180622085942.24253-1-alexandru.ardelean@analog.com>
        <f836cf4b-96fe-a088-e13e-1b4545c0e5e8@electromag.com.au>
        <2126e135f7e414382131b4bbb8414d1eaac64f3a.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 22 Jun 2018 09:32:52 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2018-06-22 at 17:15 +0800, Phil Reid wrote:
> > On 22/06/2018 16:59, Alexandru Ardelean wrote: =20
> > > Fixes commit c043ec1ca5ba ("iio:buffer: make length types match kfifo
> > > types").
> > > When the length parameter's type was updated in the
> > > `iio_dma_buffer_set_length()` function, the prototype was omitted in
> > > the
> > > `include/linux/iio/buffer-dma.h` header.
> > >=20
> > > This causes a build error when running certain CFLAGS configurations
> > > that
> > > are a bit more pedantic. =20
> >=20
> > G'day Alexandru,
> >=20
> > I recently submitted a patch for the same issue.
> > see: https://patchwork.kernel.org/patch/10447649/
> >=20
> > Jonathan was holding of for a couple of weeks due to ordering issues.
> >  =20
>=20
> Sorry for the noise/duplication.
> I only looked into the iio/togreg tree and saw it wasn't there.
>=20
> Let's drop my patch.
>=20
> Thanks
> Alex

I've just applied Phil's patch and will try to send a pull request
out later today for that.

Thanks,

Jonathan

>=20
> >=20
> >  =20
> > >=20
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >   include/linux/iio/buffer-dma.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffe=
r-
> > > dma.h
> > > index 767467d886de..67c75372b691 100644
> > > --- a/include/linux/iio/buffer-dma.h
> > > +++ b/include/linux/iio/buffer-dma.h
> > > @@ -141,7 +141,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer,
> > > size_t n,
> > >   	char __user *user_buffer);
> > >   size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
> > >   int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer,
> > > size_t bpd);
> > > -int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
> > > +int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int
> > > length);
> > >   int iio_dma_buffer_request_update(struct iio_buffer *buffer);
> > >  =20
> > >   int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
> > >  =20
> >=20
> > N_____r__y____b_X____v_^_)__{.n_+____{__*"__^n_r___z_=1A__h_____&__=1E_=
G___h_=03(_______j"__=1A_=1Bm______z______f___h___~_ =20

