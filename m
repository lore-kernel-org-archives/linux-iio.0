Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49624 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcDPTVS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 15:21:18 -0400
Subject: Re: [PATCH v2 2/5] iio: accel: mxc4005: use regmap to retrieve struct
 device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <d537eefe0ed83b8fc4b33e94f3a1dab2cfe94708.1460314070.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Teodora Baluta <teodora.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571290AC.4080908@kernel.org>
Date: Sat, 16 Apr 2016 20:21:16 +0100
MIME-Version: 1.0
In-Reply-To: <d537eefe0ed83b8fc4b33e94f3a1dab2cfe94708.1460314070.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/16 20:06, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
> 
> Patch created using Coccinelle plus manual edits.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Again, I'm happy with this, but have cc'd Teodora whose driver this is
for info and comment.

Jonathan
> ---
>  drivers/iio/accel/mxc4005.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index c23f47a..013d511 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -60,7 +60,6 @@ enum mxc4005_range {
>  };
>  
>  struct mxc4005_data {
> -	struct device *dev;
>  	struct mutex mutex;
>  	struct regmap *regmap;
>  	struct iio_trigger *dready_trig;
> @@ -140,12 +139,13 @@ static const struct regmap_config mxc4005_regmap_config = {
>  
>  static int mxc4005_read_xyz(struct mxc4005_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
>  			       (u8 *) data->buffer, sizeof(data->buffer));
>  	if (ret < 0) {
> -		dev_err(data->dev, "failed to read axes\n");
> +		dev_err(dev, "failed to read axes\n");
>  		return ret;
>  	}
>  
> @@ -155,12 +155,13 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
>  static int mxc4005_read_axis(struct mxc4005_data *data,
>  			     unsigned int addr)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	__be16 reg;
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, addr, (u8 *) &reg, sizeof(reg));
>  	if (ret < 0) {
> -		dev_err(data->dev, "failed to read reg %02x\n", addr);
> +		dev_err(dev, "failed to read reg %02x\n", addr);
>  		return ret;
>  	}
>  
> @@ -169,13 +170,14 @@ static int mxc4005_read_axis(struct mxc4005_data *data,
>  
>  static int mxc4005_read_scale(struct mxc4005_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	unsigned int reg;
>  	int ret;
>  	int i;
>  
>  	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &reg);
>  	if (ret < 0) {
> -		dev_err(data->dev, "failed to read reg_control\n");
> +		dev_err(dev, "failed to read reg_control\n");
>  		return ret;
>  	}
>  
> @@ -189,6 +191,7 @@ static int mxc4005_read_scale(struct mxc4005_data *data)
>  
>  static int mxc4005_set_scale(struct mxc4005_data *data, int val)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	unsigned int reg;
>  	int i;
>  	int ret;
> @@ -201,8 +204,7 @@ static int mxc4005_set_scale(struct mxc4005_data *data, int val)
>  						 MXC4005_REG_CONTROL_MASK_FSR,
>  						 reg);
>  			if (ret < 0)
> -				dev_err(data->dev,
> -					"failed to write reg_control\n");
> +				dev_err(dev, "failed to write reg_control\n");
>  			return ret;
>  		}
>  	}
> @@ -321,13 +323,14 @@ err:
>  
>  static int mxc4005_clr_intr(struct mxc4005_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	/* clear interrupt */
>  	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
>  			   MXC4005_REG_INT_CLR1_BIT_DRDYC);
>  	if (ret < 0) {
> -		dev_err(data->dev, "failed to write to reg_int_clr1\n");
> +		dev_err(dev, "failed to write to reg_int_clr1\n");
>  		return ret;
>  	}
>  
> @@ -339,6 +342,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mxc4005_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	mutex_lock(&data->mutex);
> @@ -352,7 +356,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
>  
>  	if (ret < 0) {
>  		mutex_unlock(&data->mutex);
> -		dev_err(data->dev, "failed to update reg_int_mask1");
> +		dev_err(dev, "failed to update reg_int_mask1");
>  		return ret;
>  	}
>  
> @@ -381,16 +385,17 @@ static const struct iio_trigger_ops mxc4005_trigger_ops = {
>  
>  static int mxc4005_chip_init(struct mxc4005_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  	unsigned int reg;
>  
>  	ret = regmap_read(data->regmap, MXC4005_REG_DEVICE_ID, &reg);
>  	if (ret < 0) {
> -		dev_err(data->dev, "failed to read chip id\n");
> +		dev_err(dev, "failed to read chip id\n");
>  		return ret;
>  	}
>  
> -	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
> +	dev_dbg(dev, "MXC4005 chip id %02x\n", reg);
>  
>  	return 0;
>  }
> @@ -415,7 +420,6 @@ static int mxc4005_probe(struct i2c_client *client,
>  
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> -	data->dev = &client->dev;
>  	data->regmap = regmap;
>  
>  	ret = mxc4005_chip_init(data);
> 

