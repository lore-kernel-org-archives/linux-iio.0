Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42235 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933522Ab3JOVNv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 17:13:51 -0400
Message-ID: <525DBE3E.3010005@kernel.org>
Date: Tue, 15 Oct 2013 23:14:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/10] staging:iio:hmc5843: Use SCALE instead of magn_range
References: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net> <1381786498-25954-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381786498-25954-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 22:34, Peter Meerwald wrote:
> v2:
> * use SCALE instead of CALIBSCALE to control the range/gain
>   of measurements
>
Only a couple of tiny little comments.  The function *_check_scale
does rather more than checking the scale is valid.  Perhaps
the name could reflect that?

Also, would it make more sense to move the shift into that function
rather than having it directly afterwards?  (I don't really mind
about this though!)
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Looking very nice.

...

hmc5843_get_scale_index?
or with the shift already applied
hmc5843_get_scale_regval
> +static int hmc5843_check_scale(struct hmc5843_data *data, int val, int val2)
> +{
> +	int i;
>
> -	if (range > HMC5843_RANGE_GAIN_MAX) {
> -		count = -EINVAL;
> -		goto exit;
> -	}
> +	if (val != 0)
> +		return -EINVAL;
>
> -	data->range = range;
> -	range = range << HMC5843_RANGE_GAIN_OFFSET;
> -	if (i2c_smbus_write_byte_data(data->client, this_attr->address, range))
> -		count = -EINVAL;
> +	for (i = 0; i < HMC5843_RANGE_GAINS; i++)
> +		if (val2 == data->variant->regval_to_nanoscale[i])
> +			return i;
>
> -exit:
> -	mutex_unlock(&data->lock);
> -	return count;
> +	return -EINVAL;
>  }
...
>
