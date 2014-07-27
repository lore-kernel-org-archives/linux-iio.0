Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53065 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbaG0NcZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 27 Jul 2014 09:32:25 -0400
Message-ID: <53D4FFF9.1040602@kernel.org>
Date: Sun, 27 Jul 2014 14:34:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad5933: fix sparse warnings
References: <1406278243-7135-1-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406278243-7135-1-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/14 09:50, Teodora Baluta wrote:
> Fix the following sparse warnings:
>
>    CHECK   drivers/staging/iio/impedance-analyzer/ad5933.c
> drivers/staging/iio/impedance-analyzer/ad5933.c:241:17: warning:
> incorrect type in assignment (different base types)
> drivers/staging/iio/impedance-analyzer/ad5933.c:241:17:    expected
> unsigned int [unsigned] [usertype] d32
> drivers/staging/iio/impedance-analyzer/ad5933.c:241:17:    got
> restricted __be32 [usertype] <noident>
> drivers/staging/iio/impedance-analyzer/ad5933.c:263:13: warning:
> incorrect type in assignment (different base types)
> drivers/staging/iio/impedance-analyzer/ad5933.c:263:13:    expected
> unsigned short [unsigned] dat
> drivers/staging/iio/impedance-analyzer/ad5933.c:263:13:    got
> restricted __be16 [usertype] <noident>
> drivers/staging/iio/impedance-analyzer/ad5933.c:271:13: warning:
> incorrect type in assignment (different base types)
> drivers/staging/iio/impedance-analyzer/ad5933.c:271:13:    expected
> unsigned short [unsigned] [addressable] dat
> drivers/staging/iio/impedance-analyzer/ad5933.c:271:13:    got
> restricted __be16 [usertype] <noident>
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:310:19: warning: cast to
> restricted __be32
> drivers/staging/iio/impedance-analyzer/ad5933.c:446:21: warning:
> incorrect type in assignment (different base types)
> drivers/staging/iio/impedance-analyzer/ad5933.c:446:21:    expected
> unsigned short [unsigned] dat
> drivers/staging/iio/impedance-analyzer/ad5933.c:446:21:    got
> restricted __be16 [usertype] <noident>
> drivers/staging/iio/impedance-analyzer/ad5933.c:454:21: warning:
> incorrect type in assignment (different base types)
> drivers/staging/iio/impedance-analyzer/ad5933.c:454:21:    expected
> unsigned short [unsigned] [addressable] dat
> drivers/staging/iio/impedance-analyzer/ad5933.c:454:21:    got
> restricted __be16 [usertype] <noident>
> drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
> restricted __be16
> drivers/staging/iio/impedance-analyzer/ad5933.c:548:23: warning: cast to
> restricted __be16
>
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Applied to the togreg branch of iio.git. Pushed out as testing for now
to let the autobuilders play with it.

Also cc'd Lars who looks after most of of the Analog Devices drivers in IIO.

Jonathan
> ---
>   drivers/staging/iio/impedance-analyzer/ad5933.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 2b96665..2cef4b9 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -220,7 +220,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>   {
>   	unsigned long long freqreg;
>   	union {
> -		u32 d32;
> +		__be32 d32;
>   		u8 d8[4];
>   	} dat;
>
> @@ -244,7 +244,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>
>   static int ad5933_setup(struct ad5933_state *st)
>   {
> -	unsigned short dat;
> +	__be16 dat;
>   	int ret;
>
>   	ret = ad5933_reset(st);
> @@ -297,7 +297,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
>   	int ret;
>   	unsigned long long freqreg;
>   	union {
> -		u32 d32;
> +		__be32 d32;
>   		u8 d8[4];
>   	} dat;
>
> @@ -402,7 +402,7 @@ static ssize_t ad5933_store(struct device *dev,
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>   	u16 val;
>   	int i, ret = 0;
> -	unsigned short dat;
> +	__be16 dat;
>
>   	if (this_attr->address != AD5933_IN_PGA_GAIN) {
>   		ret = kstrtou16(buf, 10, &val);
> @@ -521,7 +521,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>   			   long m)
>   {
>   	struct ad5933_state *st = iio_priv(indio_dev);
> -	unsigned short dat;
> +	__be16 dat;
>   	int ret = -EINVAL;
>
>   	mutex_lock(&indio_dev->mlock);
>

