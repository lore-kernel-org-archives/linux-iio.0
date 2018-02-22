Return-Path: <SRS0=6Sg8=FQ=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 22 Feb 2018 10:43:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Message-ID: <20180222074318.qsf7x4jnyhvasq5u@mwanda>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
 <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 21, 2018 at 11:01:50PM +0200, Daniel Baluta wrote:
> On Wed, Feb 21, 2018 at 9:28 PM, Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> > This patch fixes the checkpatch.pl warning:
> >
> > drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> > 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> 
> > ... Why this "..." :)?
> 
> Commit subject could be done better. It is pretty obvious from the code that
> we change S_IWUSR with 0200.
> 
> Better message:
> 
> iio:dummy: Fix poke_evN file permissions

Please stop telling people to say "Fix" when it's not a bug fix...

Also who cares?  The commit message is perfectly clear.

regards,
dan carpenter
