Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20150527082425.GB19423@mwanda>
References: <20150527082425.GB19423@mwanda>
Date: Wed, 27 May 2015 12:31:26 +0300
Message-ID: <CAEnQRZABSZh+XtoufmS2n_oFeEgB6z0bx+CxXEk+f6=tOcSXDA@mail.gmail.com>
Subject: Re: [patch] iio: light: signedness bug in stk3310_write_raw()
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 27, 2015 at 11:24 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> "index" needs to be signed for the error handling to work.
>
> Fixes: be9e6229d676 ('iio: light: Add support for Sensortek STK3310')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi Dan,

Did you find this with a tool?

Daniel.
