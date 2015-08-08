Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57939 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbHHLXP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:23:15 -0400
Subject: Re: [PATCH v2 5/7] iio:accel:stk8312: use appropriate variable types
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438204273.git.knaack.h@gmx.de>
 <edc03b2d6ca2a5ffe767192a02f5cdd2ca021b34.1438204273.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E6A2.7070509@kernel.org>
Date: Sat, 8 Aug 2015 12:23:14 +0100
MIME-Version: 1.0
In-Reply-To: <edc03b2d6ca2a5ffe767192a02f5cdd2ca021b34.1438204273.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/15 22:39, Hartmut Knaack wrote:
> Adapt some variable types to reduce unnecessary casting.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied.
> ---
>  drivers/iio/accel/stk8312.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 8807927d4d0b..8b9b3815aac2 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -69,8 +69,8 @@ static const int stk8312_scale_table[][2] = {
>  };
>  
>  static const struct {
> -	u16 val;
> -	u32 val2;
> +	int val;
> +	int val2;
>  } stk8312_samp_freq_table[] = {
>  	{400, 0}, {200, 0}, {100, 0}, {50, 0}, {25, 0},
>  	{12, 500000}, {6, 250000}, {3, 125000}
> @@ -103,7 +103,7 @@ static const struct iio_chan_spec stk8312_channels[] = {
>  struct stk8312_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> -	int range;
> +	u8 range;
>  	u8 sample_rate_idx;
>  	u8 mode;
>  	struct iio_trigger *dready_trig;
> @@ -243,7 +243,7 @@ static const struct iio_trigger_ops stk8312_trigger_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -static int stk8312_set_sample_rate(struct stk8312_data *data, int rate)
> +static int stk8312_set_sample_rate(struct stk8312_data *data, u8 rate)
>  {
>  	int ret;
>  	u8 masked_reg;
> 

