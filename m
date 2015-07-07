Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <cover.1436220932.git.cristina.opriceana@gmail.com>
References: <cover.1436220932.git.cristina.opriceana@gmail.com>
Date: Tue, 7 Jul 2015 11:10:28 +0300
Message-ID: <CAEnQRZAiM6-LtMNyHTapymbWtqx_KLzLZp=NAHfjot908nk_pg@mail.gmail.com>
Subject: Re: [PATCH 0/4] tools: iio: Send error messages to stderr
From: Daniel Baluta <daniel.baluta@intel.com>
To: Cristina Opriceana <cristina.opriceana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 7, 2015 at 1:46 AM, Cristina Opriceana
<cristina.opriceana@gmail.com> wrote:
> This patchset indends to make some cleanup and send printf
> error messages to stderr.
> The changes were performed with coccinelle for failiure
> messages and manual for other cases. The following script
> was used:
>
> @r@
> expression e1, e2, stdout;
> @@
> (printf(e1);
> |
> printf(e1, e2);
> |
> fprintf(stdout, e1);
> |
> fprintf(stdout, e1, e2);
> )
> @script: python get_string@
> e << r.e1;
> tdres;
> @@
> if 'could not' in e.lower() or 'fail' in e.lower() \
> or 'problem' in e.lower() or 'not set' in e.lower():
> coccinelle.tdres = e
> else:
> cocci.include_match(False)
> @r_match@
> expression r.stdout, r.e1, r.e2;
> identifier get_string.tdres;
> @@
> (
> - printf(e1);
> + fprintf(stderr, tdres);
> |
> - printf(e1, e2);
> + fprintf(stderr, tdres, e2);
> |
> - fprintf(stdout, e1)
> + fprintf(stderr, tdres)
> |
> - fprintf(stdout, e1, e2)
> + fprintf(stderr, tdres, e2)
> )

Nit: s/failiure/failure this appears in several places.

With this fixed:

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

thanks,
Daniel.
