Return-Path: <SRS0=q9Zg=NM=gmail.com=himanshujha199640@kernel.org>
Date: Thu, 1 Nov 2018 21:05:09 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Slawomir Stepien <sst@poczta.fm>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <20181101153508.GA5176@himanshu-Vostro-3559>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
 <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 31, 2018 at 09:30:36PM +0530, Nishad Kamdar wrote:
> Add device tree table for matching vendor ID.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index d3e7d5aad2c8..7c50def91a2b 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -701,6 +701,12 @@ static int ad2s1210_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad2s1210_of_match[] = {
> +	{ .compatible = "adi,ad2s1210", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);

I believe this needs to be documented at:

Documentation/devicetree/bindings/iio/resolver/ad2s1210.txt

Cc'ed to devictree list + Rob(DT Maintainer).

Just wondering why didn't it came up till now from the IIO reviewers ? v7!!


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
