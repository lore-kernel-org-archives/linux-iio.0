Return-Path: <SRS0=wpQW=F6=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 9 Mar 2018 00:41:12 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v4] Staging: iio: adis16209: Change some macro names
Message-ID: <20180308191111.GA2041@himanshu-Vostro-3559>
References: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 08, 2018 at 11:46:17PM +0530, Shreeya Patel wrote:
> Make some of the macro names according to the names
> given in the datasheet of the adis16209 driver and
> have slight indentation in field definitions to make
> them clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
> 
> Changes in v4
>   -Have slight indentation in field definitions.
> 
>  drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index eb5c878..19636e2 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -68,21 +68,21 @@
>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>  
> -#define ADIS16209_STAT_REG			0x3C
> -#define  ADIS16209_STAT_ALARM2			BIT(9)
> -#define  ADIS16209_STAT_ALARM1			BIT(8)
> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> +#define ADIS16209_DIAG_STAT_REG			0x3C
> +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
> +#define  ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> +#define  ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2

#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT    2
?
It represents flash update fail bit!

-- 
Thanks
Himanshu Jha
