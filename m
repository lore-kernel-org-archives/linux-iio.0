Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] tools: iio: print error message when buffer enable
 fails
Date: Fri, 24 Jul 2015 13:27:58 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0A8DD1@irsmsx105.ger.corp.intel.com>
References: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
 <1437672172-21189-3-git-send-email-irina.tirdea@intel.com>
 <55B17515.7030508@gmx.de>
In-Reply-To: <55B17515.7030508@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: 24 July, 2015 2:13
> To: Tirdea, Irina; Jonathan Cameron; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] tools: iio: print error message when buffer enab=
le fails
>=20
> Irina Tirdea schrieb am 23.07.2015 um 19:22:
> > Running generic_buffer without enabling any channel of the
> > sensor will fail without printing any error message.
> >
> > Add an error message that indicates buffer enable failed.
>=20
> Hi,
> please make use of the error code stored in ret (with negative sign), as
> in most cases the value of errno has already changed since the original
> error has occurred.
> Thanks,
>=20

Hi Hartmut,

Yes, you are right. Missed that. Will fix in v2.

Thanks,
Irina

> Hartmut
>=20
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  tools/iio/generic_buffer.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> > index 32f389eb..936469c 100644
> > --- a/tools/iio/generic_buffer.c
> > +++ b/tools/iio/generic_buffer.c
> > @@ -364,8 +364,11 @@ int main(int argc, char **argv)
> >
> >  	/* Enable the buffer */
> >  	ret =3D write_sysfs_int("enable", buf_dir_name, 1);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		fprintf(stderr,
> > +			"Failed to enable buffer: %s\n", strerror(errno));
> >  		goto error_free_buf_dir_name;
> > +	}
> >
> >  	scan_size =3D size_from_channelarray(channels, num_channels);
> >  	data =3D malloc(scan_size * buf_len);
> >
