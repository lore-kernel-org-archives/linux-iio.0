Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43B1940B0;
	Fri, 25 Sep 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296930; cv=none; b=R8XJteFvVxO0Qsuse25E3297v2/Zh0uxKSzOtfn0cftuVzO04HDV9QlRNlwnF0OPNwVfDyQQ8keDT+7j/UKw1/KhL2qWOLng74rQxpQ6JnaJFhP1H1oZgQnjB4CykwzC0hs+Z53tMrA07c69BQKZirlAF5ldKwkehjHiaWbNSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296930; c=relaxed/simple;
	bh=KEVJ6rMIpvKl53nSX5YVx6fLfLuGg1hgPzGX4bYEUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8Q5km4lLocqnflUHL6McwkJLEAQ88WkQt7Cj6Sd9XwjIJPNPSqwZfruSAEEQqukLBS9KYVTyi7RC/ZrFo9QiwnsZl20+YyO/nPaCNibqbifh/Kl+hHa91TFH1z7qJbGxP+6fbE0hvolsgoRFHGIZAhQa+kGMj13j6oiKKJfz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDaW0g3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDaW0g3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7CB1F000FF;
	Fri, 25 Sep 2026 00:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790296929;
	bh=gnmElWGSlVHOj2f2vg7AU0fD66c2WCDk2AaQ31UoZoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JDaW0g3Ml1I24evCa0rOGZd3bSMp+x/IoWWbQHm9s90cXfLHHc6eYcamwnUKpJzHn
	 Z7485Gp6/SpUxJeIoY+gHiDhg/BndQcnOhLwIkHyeXcorSFBaB1yqXBZLGsBvQ5tUV
	 /xSA/Ahtl95eA78DLGmkC0EequkwgmXO3uZwTZ1LAHxxz9XrhAv9533pWKE8+DVZss
	 v0OuJVjx0RuvYvR6JCRiEBMRWZu76KfXLX7JYZbpM/WDkvFa42CpIZaXj+FtUwI4yC
	 o687lmWx8OTL8ZVanrNeulGcsxr/lOg18oq4GbCbRjM+Ysn/DG8f7WOYcOQSbuBzyV
	 lQx2tL2ucsj/g==
Date: Fri, 25 Sep 2026 01:42:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sgp40: Implement
 turn_heater_off-command
Message-ID: <20260925014203.07e0dce3@jic23-hlaptop>
In-Reply-To: <DLNE2OD7OJ8Y.HONYZ4LYDTQM@utu.fi>
References: <20260918134019.1101308-1-jmatko@utu.fi>
	<20260918134019.1101308-4-jmatko@utu.fi>
	<aq3LDTnLuJm6vjFt@mail.your-server.de>
	<20260920185201.5a25dc05@jic23-hlaptop>
	<DLNE2OD7OJ8Y.HONYZ4LYDTQM@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:04:21 +0300
Jaakko Koivisto <jmatko@utu.fi> wrote:

> On Sun Sep 20, 2026 at 8:52 PM EEST, Jonathan Cameron wrote:
> > On Sat, 19 Sep 2026 01:36:45 +0200
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >  
> >> Hi Jaakko,
> >> 
> >> Jaakko Koivisto <jmatko@utu.fi> schrieb am Fr, 18. Sep 16:40:  
> >> > -Turn the heating element off and enter idle mode.
> >> > -Present the functionality as device attribute,
> >> >  'echo 1 > turn_heater_off'.    
> >> 
> >> Instead of introducing a device specific attribute couldn't this be implemented
> >> as standard power management operations (RUNTIME_PM_OPS)?  
> >
> > May not apply in this case but normally the warm up time of these sorts of
> > heaters are in the seconds.  No one wants that latency when they want
> > a measurement.  As such normal runtime pm doesn't work - it needs to
> > be a specific userspace opt in.  
> 
> For SGP40 the heater must be on for 60 seconds for reliable data, and up
> to 60 minutes to reach all datasheet specs. These are very long times, so I
> would not want to turn the heater off automatically.
> 
> > We have defined ABI for this though and this isn't it
> > See Documentation/ABI/testing/sysfs-bus-iio (and more in -humidity)  
> 
> Thanks, missed that there was already ABI for heaters. I will change to
> use this instead.
> 
> While looking at this I noticed this driver is using mutex_lock() and
> mutex_unlock(). Recent commits, e.g. eb60a24b35bfb9e85a272e561379833e49a12a79,
> say using the newer guard() is the preferred way these days. Should this be
> updated as well?
> 
There is no universal right answer to this.  If guard() and related
give cleaner, easier to understand code then it may well be useful to
update to that whilst you are touching the driver.

Sometimes the code is such that they provide very little advantage
and in those cases we should just leave things as they are!

Jonathan

> >
> > Jonathan
> >  
> >> 
> >> Andreas
> >>   
> >> > Saves approx. 2.5 mA compared to regular operation. The heating element
> >> > is automatically turned back on when measurement is performed.
> >> > 
> >> > Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> >> > ---
> >> >  drivers/iio/chemical/sgp40.c | 28 ++++++++++++++++++++++++++++
> >> >  1 file changed, 28 insertions(+)
> >> > 
> >> > diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> >> > index 28d5e737d1dc..a4fc5c778303 100644
> >> > --- a/drivers/iio/chemical/sgp40.c
> >> > +++ b/drivers/iio/chemical/sgp40.c
> >> > @@ -29,6 +29,7 @@
> >> >   * by writing to the out values of temp and humidityrelative.
> >> >   */
> >> >  
> >> > +#include "linux/device.h"
> >> >  #include <linux/delay.h>
> >> >  #include <linux/crc8.h>
> >> >  #include <linux/module.h>
> >> > @@ -259,6 +260,21 @@ static int sgp40_execute_self_test(struct sgp40_data *data)
> >> >  	}
> >> >  }
> >> >  
> >> > +static int sgp40_turn_heater_off(struct sgp40_data *data)
> >> > +{
> >> > +	int ret;
> >> > +	struct i2c_client *client = data->client;
> >> > +	struct sgp40_command turn_off = {.command = {0x36, 0x15}};
> >> > +
> >> > +	ret = i2c_master_send(client, (char*)&turn_off, sizeof(turn_off.command));
> >> > +	if (ret != sizeof(turn_off.command)) {
> >> > +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));
> >> > +		return -EIO;
> >> > +	}
> >> > +	msleep(1);
> >> > +	return 0;
> >> > +}
> >> > +
> >> >  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
> >> >  {
> >> >  	int ret;
> >> > @@ -417,10 +433,22 @@ static ssize_t serial_number_show(struct device *dev,
> >> >  	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
> >> >  }
> >> >  
> >> > +static ssize_t turn_heater_off_store(struct device *dev,
> >> > +				     struct device_attribute *attr,
> >> > +				     const char *buf, size_t len)
> >> > +{
> >> > +	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
> >> > +	sgp40_turn_heater_off(data);
> >> > +
> >> > +	return len;
> >> > +}
> >> > +
> >> >  static IIO_DEVICE_ATTR_RO(serial_number, 0);
> >> > +static IIO_DEVICE_ATTR_WO(turn_heater_off, 0);
> >> >  
> >> >  static struct attribute *sgp40_attributes[] = {
> >> >  	&iio_dev_attr_serial_number.dev_attr.attr,
> >> > +	&iio_dev_attr_turn_heater_off.dev_attr.attr,
> >> >  	NULL
> >> >  };
> >> >  
> >> > -- 
> >> > 2.55.0
> >> >     
> >>   
> 
> 

