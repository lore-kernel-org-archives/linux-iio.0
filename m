Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33523 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcADMR5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 07:17:57 -0500
Subject: Re: [PATCH 5/5] Staging: iio: cdc: ad7150: Fix alignment should match
 open parenthesis
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
 <1451388451-10342-6-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A62F4.4050206@kernel.org>
Date: Mon, 4 Jan 2016 12:17:56 +0000
MIME-Version: 1.0
In-Reply-To: <1451388451-10342-6-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/15 11:27, Shraddha Barke wrote:
> Fix the checkpatch warning of alignment should match open
> parenthesis.
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 0b934f7..f6b9a10 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -160,8 +160,9 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>  
>  /* lock should be held */
>  static int ad7150_write_event_params(struct iio_dev *indio_dev,
> -	 unsigned int chan, enum iio_event_type type,
> -	 enum iio_event_direction dir)
> +				     unsigned int chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
>  {
>  	int ret;
>  	u16 value;
> @@ -209,8 +210,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  }
>  
>  static int ad7150_write_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, int state)
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
>  {
>  	u8 thresh_type, cfg, adaptive;
>  	int ret;
> @@ -302,11 +304,11 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
>  }
>  
>  static int ad7150_write_event_value(struct iio_dev *indio_dev,
> -				   const struct iio_chan_spec *chan,
> -				   enum iio_event_type type,
> -				   enum iio_event_direction dir,
> -				   enum iio_event_info info,
> -				   int val, int val2)
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
>  {
>  	int ret;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> @@ -365,9 +367,9 @@ static ssize_t ad7150_show_timeout(struct device *dev,
>  }
>  
>  static ssize_t ad7150_store_timeout(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				    struct device_attribute *attr,
> +				    const char *buf,
> +				    size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> @@ -580,7 +582,7 @@ static const struct iio_info ad7150_info = {
>   */
>  
>  static int ad7150_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +			const struct i2c_device_id *id)
>  {
>  	int ret;
>  	struct ad7150_chip_info *chip;
> 

