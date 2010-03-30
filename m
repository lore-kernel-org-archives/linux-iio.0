Return-Path: <jic23@cam.ac.uk>
Message-ID: <4BB20B3B.3090107@cam.ac.uk>
Date: Tue, 30 Mar 2010 15:31:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/13] staging:iio:max1363 move to new abi.
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk> <1269808879-28838-2-git-send-email-jic23@cam.ac.uk> <1269808879-28838-3-git-send-email-jic23@cam.ac.uk> <1269808879-28838-4-git-send-email-jic23@cam.ac.uk> <1269808879-28838-5-git-send-email-jic23@cam.ac.uk> <1269808879-28838-6-git-send-email-jic23@cam.ac.uk> <1269808879-28838-7-git-send-email-jic23@cam.ac.uk> <1269808879-28838-8-git-send-email-jic23@cam.ac.uk> <1269808879-28838-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-9-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

...
> +static ssize_t max1363_read_single_channel(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct max1363_state *st = iio_dev_get_devdata(dev_info);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct i2c_client *client = st->client;
> +	int ret = 0, len = 0;
> +	s32 data ;
> +	char rxbuf[2];
> +	long mask;
> +
> +	mutex_lock(&dev_info->mlock);
> +	/* If ring buffer capture is occuring, query the buffer */
> +	if (iio_ring_enabled(dev_info)) {
> +		mask = max1363_mode_table[this_attr->address].modemask;
> +		data = max1363_single_channel_from_ring(mask, st);
> +		if (data < 0) {
> +			ret = data;
> +			goto error_ret;
> +		}
> +	} else {
> +		/* Check to see if current scan mode is correct */
> +		if (st->current_mode !=
> +		    &max1363_mode_table[this_attr->address]) {
> +			/* Update scan mode if needed */
> +			st->current_mode
> +				= &max1363_mode_table[this_attr->address];
> +			ret = max1363_set_scan_mode(st);
> +			if (ret)
> +				goto error_ret;
> +		}
> +		/* Get reading */
> +		data = i2c_master_recv(client, rxbuf, 2);
> +		if (data < 0) {
> +			ret = data;
> +			goto error_ret;
> +		}
> +		data = rxbuf[1];

This is clearly wrong.  I'm only reading the lower 8 bits of the relevant channel.
Trivial fix, so I'll roll it into next version.  For reference that series will also have
patches add the remaining devices listed to be added to this driver on the iioutils wiki.


Jonathan

....
