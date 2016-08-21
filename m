Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51275 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbcHULYm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 07:24:42 -0400
Subject: Re: [PATCH] staging: iio: ade7854: checkpatch fixes
To: Johanna Abrahamsson <johanna@mjao.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20160816130254.GA9657@fedora-21-dvm>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f405eb36-0d8b-f6a8-8676-a300e9b7bb74@kernel.org>
Date: Sun, 21 Aug 2016 12:24:26 +0100
MIME-Version: 1.0
In-Reply-To: <20160816130254.GA9657@fedora-21-dvm>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:02, Johanna Abrahamsson wrote:
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Johanna Abrahamsson <johanna@mjao.org>
Hi Johanna,

I'd have preferred the title to mention that this was alignment
fixups. Otherwise, nice little cleanup.

Applied to the togreg branch of iio.git - which
will initially be pushed out as testing for the autobuilders to
play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7854.c | 40 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 75e8685..24edbc3 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -23,8 +23,8 @@
>  #include "ade7854.h"
>  
>  static ssize_t ade7854_read_8bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	int ret;
>  	u8 val = 0;
> @@ -40,8 +40,8 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  }
>  
>  static ssize_t ade7854_read_16bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	int ret;
>  	u16 val = 0;
> @@ -57,8 +57,8 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  }
>  
>  static ssize_t ade7854_read_24bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	int ret;
>  	u32 val;
> @@ -74,8 +74,8 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  }
>  
>  static ssize_t ade7854_read_32bit(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	int ret;
>  	u32 val = 0;
> @@ -91,9 +91,9 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  }
>  
>  static ssize_t ade7854_write_8bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -112,9 +112,9 @@ error_ret:
>  }
>  
>  static ssize_t ade7854_write_16bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -133,9 +133,9 @@ error_ret:
>  }
>  
>  static ssize_t ade7854_write_24bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -154,9 +154,9 @@ error_ret:
>  }
>  
>  static ssize_t ade7854_write_32bit(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 

