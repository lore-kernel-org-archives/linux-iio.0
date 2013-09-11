Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59202 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab3IKVHE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 17:07:04 -0400
Message-ID: <5230E992.4040808@kernel.org>
Date: Wed, 11 Sep 2013 23:07:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/18] staging:iio:hmc5843: Add pointer to i2c client
 to data struct
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net> <1378170320-27538-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>  static int hmc5843_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(client));
> +	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
This one has me a little confused.  The dev parameter should I think be the i2c dev here?
If so then dev_to_iio_dev will give th wrong one.
>  
> -	hmc5843_configure(client, data->operating_mode);
> +	hmc5843_configure(data->client, data->operating_mode);
>  
>  	return 0;
>  }
> 
