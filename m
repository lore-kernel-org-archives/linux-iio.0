Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38064 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbbG1N3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 09:29:46 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 5/7] iio:accel:stk8312: use appropriate variable types
Date: Tue, 28 Jul 2015 13:28:26 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4022187EAF@IRSMSX109.ger.corp.intel.com>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <84ecb786252220464167b49924c99067d15b3ada.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <84ecb786252220464167b49924c99067d15b3ada.1437955135.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Tuesday, July 28, 2015 1:49 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 5/7] iio:accel:stk8312: use appropriate variable types
> 
> Adapt some variable types to reduce unnecessary casting.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/accel/stk8312.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c index
> 8783f0bf7c53..e3624e2b3ec4 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -69,8 +69,8 @@ static const int stk8312_scale_table[][2] = {  };
> 
>  static const struct {
> -	u16 val;
> -	u32 val2;
> +	int val;
> +	int val2;
>  } stk8312_samp_freq_table[] = {
>  	{400, 0}, {200, 0}, {100, 0}, {50, 0}, {25, 0},
>  	{12, 500000}, {6, 250000}, {3, 125000} @@ -103,7 +103,7 @@ static
> const struct iio_chan_spec stk8312_channels[] = {  struct stk8312_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> -	int range;
> +	u8 range;
>  	u8 sample_rate_idx;
>  	u8 mode;
>  	struct iio_trigger *dready_trig;
> @@ -242,7 +242,7 @@ static const struct iio_trigger_ops stk8312_trigger_ops
> = {
>  	.owner = THIS_MODULE,
>  };
> 
> -static int stk8312_set_sample_rate(struct stk8312_data *data, int rate)
> +static int stk8312_set_sample_rate(struct stk8312_data *data, u8 rate)
>  {
>  	int ret;
>  	u8 masked_reg;
> --
> 2.4.6

