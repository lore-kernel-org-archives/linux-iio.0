Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 20 Jul 2015 17:14:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Teodora Baluta <teodora.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        daniel.baluta@intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add mmc34160 magnetometer
 driver
Message-ID: <20150720141424.GJ5422@mwanda>
References: <1437400350-25960-1-git-send-email-teodora.baluta@intel.com>
 <1437400350-25960-3-git-send-email-teodora.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437400350-25960-3-git-send-email-teodora.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 20, 2015 at 04:52:30PM +0300, Teodora Baluta wrote:
> +static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo,
> +				  int index, int *val)
> +{
> +	switch (index) {
> +	case AXIS_X:
> +		*val = (raw[AXIS_X] - nfo) * 1000 / sens[AXIS_X];
> +		break;
> +	case AXIS_Y:
> +		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y];
> +		break;
> +	case AXIS_Z:
> +		*val = (raw[AXIS_Z] - nfo) * 1000 / sens[AXIS_Z];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

We never pass invalid indexes here so this could be replaced with:

static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo,
				  int index, int *val)
{
	*val = (raw[index] - nfo) * 1000 / sens[index];
	return 0;
}

regards,
dan carpenter
