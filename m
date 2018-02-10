Return-Path: <SRS0=DZUT=FE=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Sat, 10 Feb 2018 15:57:34 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring  <elfring@users.sourceforge.net>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina
 <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: Software evolution around =?UTF-8?B?4oCcY2hlY2twYXRjaC5wbA==?=
 =?UTF-8?B?4oCdPw==?=
Message-ID: <20180210155734.708d01b6@archlinux>
In-Reply-To: <1518274783.6579.2.camel@perches.com>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
	<20180204112346.0977e938@archlinux>
	<9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
	<87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
	<f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
	<20180210145336.233c721d@archlinux>
	<1518274783.6579.2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, 10 Feb 2018 06:59:43 -0800
Joe Perches <joe@perches.com> wrote:

> On Sat, 2018-02-10 at 14:53 +0000, Jonathan Cameron wrote:
> > While it would be great to improve checkpatches false
> > positive rate, it's very nature as a string matcher makes
> > this hard. =20
>=20
> true.
>=20
> what are the false positives you see?
>=20
This particular case is only 'sort of' a false positive
in the warning that a message printed on a memory allocation
failure 'may' not add any information over the generic case.

Very hard to judge on whether it is useful to know more than
an allocation failed somewhere or not.

Message makes this clear:
>=E2=80=9CWARNING: Possible unnecessary 'out of memory' message=E2=80=9D
>(from the script =E2=80=9Ccheckpatch.pl=E2=80=9D) =20

We also have the balance between any changes to existing code
adding 'some' maintenance overhead vs changing this stuff
in a new driver - which is what checkpatch is really intended
for.

So I think checkpatch is striking the right balance here in
how it warns.  Obviously if it could assess the text
and come to an informed decision that would be great but
we are some way from that ;)

Jonathan
