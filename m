Return-Path: <SRS0=hdYa=NG=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 26 Oct 2018 13:04:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Victor Colombo <victorcolombo@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
Message-ID: <20181026100422.lvz2avowd6ddix54@mwanda>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
 <20181026004512.31012-6-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181026004512.31012-6-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 25, 2018 at 09:45:11PM -0300, Matheus Tavares wrote:
> From: Victor Colombo <victorcolombo@gmail.com>
> 
> This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> implements the relative read behavior at ad2s90_read_raw.
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> ---

You should be adding your S-o-B here as well because the patch is
passing through your hands.

regards,
dan carpenter
