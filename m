Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48174 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbaHBQde (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 12:33:34 -0400
Message-ID: <53DD12D9.8030000@kernel.org>
Date: Sat, 02 Aug 2014 17:33:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: iio: hmc5843_core: fix sparse warnings
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com> <1406546313-23031-4-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-4-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/14 12:18, Teodora Baluta wrote:
> Fix the following sparse warnings:
> 
>  CHECK   drivers/staging/iio/magnetometer/hmc5843_core.c
> drivers/staging/iio/magnetometer/hmc5843_core.c:138:70: warning:
> incorrect type in argument 3 (different signedness)
> drivers/staging/iio/magnetometer/hmc5843_core.c:138:70:    expected
> unsigned int *val
> drivers/staging/iio/magnetometer/hmc5843_core.c:138:70:    got int
> *<noident>
> drivers/staging/iio/magnetometer/hmc5843_core.c:215:64: warning:
> incorrect type in argument 3 (different signedness)
> drivers/staging/iio/magnetometer/hmc5843_core.c:215:64:    expected
> unsigned int *val
> drivers/staging/iio/magnetometer/hmc5843_core.c:215:64:    got int
> *<noident>
> drivers/staging/iio/magnetometer/hmc5843_core.c:354:72: warning:
> incorrect type in argument 3 (different signedness)
> drivers/staging/iio/magnetometer/hmc5843_core.c:354:72:    expected
> unsigned int *val
> drivers/staging/iio/magnetometer/hmc5843_core.c:354:72:    got int
> *<noident>
> drivers/staging/iio/magnetometer/hmc5843_core.c:362:72: warning:
> incorrect type in argument 3 (different signedness)
> drivers/staging/iio/magnetometer/hmc5843_core.c:362:72:    expected
> unsigned int *val
> drivers/staging/iio/magnetometer/hmc5843_core.c:362:72:    got int
> *<noident>
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index 914ae1a..fd171d8 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -131,7 +131,7 @@ static s32 hmc5843_set_mode(struct hmc5843_data *data, u8 operating_mode)
>  static int hmc5843_wait_measurement(struct hmc5843_data *data)
>  {
>  	int tries = 150;
> -	int val;
> +	unsigned int val;
>  	int ret;
>  
>  	while (tries-- > 0) {
> @@ -209,7 +209,7 @@ static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
>  						char *buf)
>  {
>  	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
> -	int val;
> +	unsigned int val;
>  	int ret;
>  
>  	ret = regmap_read(data->regmap, HMC5843_CONFIG_REG_A, &val);
> @@ -344,7 +344,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct hmc5843_data *data = iio_priv(indio_dev);
> -	int rval;
> +	unsigned int rval;
>  	int ret;
>  
>  	switch (mask) {
> 
