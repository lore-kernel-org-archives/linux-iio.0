Return-Path: <sudipm.mukherjee@gmail.com>
Date: Fri, 13 Feb 2015 13:57:20 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Tolga Ceylan <tolga.ceylan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Staging: iio: meter: ade7854-i2c: code style
 improvements
Message-ID: <20150213082720.GA6088@sudip-PC>
References: <1423810186-28774-1-git-send-email-tolga.ceylan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423810186-28774-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 12, 2015 at 10:49:46PM -0800, Tolga Ceylan wrote:
> Code reformatting based on checkpatch.pl with --strict:
> 1) Lines over 80 characters were fixed
> 2) Alignment should match open paranthesis cases corrected
> 3) Comparison to NULL rewritten as !indio_dev

you are doing three different types of changes here. one patch should have only one type of change.

regards
sudip
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 39 +++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
>  
