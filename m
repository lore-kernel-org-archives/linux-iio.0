Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39210 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBHMCD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:02:03 -0500
Message-ID: <54D75037.2090407@kernel.org>
Date: Sun, 08 Feb 2015 12:01:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: Change type
 in printf format string
References: <1422397081-8832-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397081-8832-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:18, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Sorry, you were beaten to this one by Asaf Vertz a few weeks back.

Jonathan
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index b6bd609..4230a43 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -360,11 +360,11 @@ static ssize_t ad5933_show(struct device *dev,
>  	mutex_lock(&indio_dev->mlock);
>  	switch ((u32) this_attr->address) {
>  	case AD5933_OUT_RANGE:
> -		len = sprintf(buf, "%d\n",
> +		len = sprintf(buf, "%u\n",
>  			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
>  		break;
>  	case AD5933_OUT_RANGE_AVAIL:
> -		len = sprintf(buf, "%d %d %d %d\n", st->range_avail[0],
> +		len = sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
>  			      st->range_avail[3], st->range_avail[2],
>  			      st->range_avail[1]);
>  		break;
> 

