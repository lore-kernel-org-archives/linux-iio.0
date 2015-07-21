Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56683 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754036AbbGUKoD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 06:44:03 -0400
Message-ID: <55AE2277.9040306@st.com>
Date: Tue, 21 Jul 2015 18:44:07 +0800
From: Denis Ciocca <denis.ciocca@st.com>
MIME-Version: 1.0
To: Giuseppe BARBA <giuseppe.barba@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH V4 2/5] iio: st-sensors: add support for single full scale
 device
References: <1437467745-18435-1-git-send-email-giuseppe.barba@st.com> <1437467745-18435-3-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437467745-18435-3-git-send-email-giuseppe.barba@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Denis Ciocca <denis.ciocca@st.com>


On 07/21/2015 04:35 PM, Giuseppe BARBA wrote:
> Some sensors could have only one full scale value. This means that the
> sensor hasn't a full scale register. This commit add a check on the
> configured full scale address to support such kind of sensors.
>
> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
> ---
>   drivers/iio/common/st_sensors/st_sensors_core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index d44bf16..2e7fdb5 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -126,6 +126,9 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
>   	int err, i = 0;
>   	struct st_sensor_data *sdata = iio_priv(indio_dev);
>   
> +	if (sdata->sensor_settings->fs.addr == 0)
> +		return 0;
> +
>   	err = st_sensors_match_fs(sdata->sensor_settings, fs, &i);
>   	if (err < 0)
>   		goto st_accel_set_fullscale_error;

