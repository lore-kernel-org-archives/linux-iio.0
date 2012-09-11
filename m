Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Martin =?utf-8?q?Li=C5=A1ka?= <marxin.liska@gmail.com>
Subject: Re: ACPI ambient light sensor
Date: Tue, 11 Sep 2012 10:27:20 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 platform-driver-x86@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 joeyli <jlee@suse.com>,
 Len Brown <len.brown@intel.com>,
 pavel@denx.de,
 Jonathan Cameron <jic23@kernel.org>,
 Jon Brenner <jbrenner@taosinc.com>,
 Peter Meerwald <pmeerw@pmeerw.net>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com> <4FFADCC2.6080006@cam.ac.uk> <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
In-Reply-To: <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209111027.20392.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Martin Li=C5=A1ka,

[...]

> +
> + if (kfifo_is_empty(&kf->kf))
> + r->stufftoread =3D false;
> + /* verify it is still empty to avoid race */
> + if (!kfifo_is_empty(&kf->kf))
> + r->stufftoread =3D true;

I'd say the formating got pretty messed up, please repost the patch via git=
=20
send-email .

[...]
Best regards,
Marek Vasut
