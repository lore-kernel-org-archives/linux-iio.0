Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AF457E7B;
	Sun, 20 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926729; cv=none; b=ggTJDgMCiG8efjdLnxK5R41476stneHRLxFMHQVN0LCY9Gup09TLq9IgQllabifbGYYxjfnQ0O6DqpXnD0MCdJ79Ld8tAOWc9lTT+7g29Zfcp7UhVdA+fwE3e1/KIuoDlSRctrQF0MQMedoP3rwYN0AZWqcq56FjYBzwTdkWwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926729; c=relaxed/simple;
	bh=wy6fpYqjJw2LNazFPIM6H66FUfN9eiqIP4oUk2cR/xI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad1xMetEIGRLd7gUawSoICfimVOY1UkMvlizl58HDBrXFY5Im0Z/xT+W2gieSbqhgBnPAAvfWpgfLOuBRNJKQ/yAjZR0ngHvc7zbKqWPLb2N4zlP+MS6f6mV4nNtFUeqvA+JNrTD01zuSdBFtfahg9mdYehzR4oN6G4w3ffUBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeEqQzNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeEqQzNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035331F000FF;
	Sun, 20 Sep 2026 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926726;
	bh=DPZ+jGxxeprlCFMxivwjFrT337J0vel1xUDltT9sfJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eeEqQzNb+aHeKtzUa8dKTnDhNsCUFa3L/PUYq3LbXnYJevmgXixr7GlG2FHZGT1C0
	 miZqioKnF7T/cdt8aqC6suUv8tNJnjByQnLMjrZ5wEFcAO+KUrn0Cf0W43zt134LiD
	 w7owu/cVCuE3C4XDfr6X66IQ+LaCXsk/qpHl+2aHHim6IQ6DtH/PPFYRS6LeOG/H4U
	 zkLYVv34D43JlKkW1gw6dMc9j9SrNx4tJzJ/z1cIiqTm+L9uqOpTE4kNGhfX61kAPe
	 IWIVG+HN6hwjDcdPYrebG/0/1iPC4f+GLEhff9LTTeaI+9nCVt2axOTJZ2OtMvwKYz
	 CtUIVgwXYRMew==
Date: Sun, 20 Sep 2026 18:52:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jaakko Koivisto <jmatko@utu.fi>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: sgp40: Implement
 turn_heater_off-command
Message-ID: <20260920185201.5a25dc05@jic23-hlaptop>
In-Reply-To: <aq3LDTnLuJm6vjFt@mail.your-server.de>
References: <20260918134019.1101308-1-jmatko@utu.fi>
	<20260918134019.1101308-4-jmatko@utu.fi>
	<aq3LDTnLuJm6vjFt@mail.your-server.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 01:36:45 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jaakko,
> 
> Jaakko Koivisto <jmatko@utu.fi> schrieb am Fr, 18. Sep 16:40:
> > -Turn the heating element off and enter idle mode.
> > -Present the functionality as device attribute,
> >  'echo 1 > turn_heater_off'.  
> 
> Instead of introducing a device specific attribute couldn't this be implemented
> as standard power management operations (RUNTIME_PM_OPS)?

May not apply in this case but normally the warm up time of these sorts of
heaters are in the seconds.  No one wants that latency when they want
a measurement.  As such normal runtime pm doesn't work - it needs to
be a specific userspace opt in.

We have defined ABI for this though and this isn't it
See Documentation/ABI/testing/sysfs-bus-iio (and more in -humidity)

Jonathan

> 
> Andreas
> 
> > Saves approx. 2.5 mA compared to regular operation. The heating element
> > is automatically turned back on when measurement is performed.
> > 
> > Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> > ---
> >  drivers/iio/chemical/sgp40.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> > index 28d5e737d1dc..a4fc5c778303 100644
> > --- a/drivers/iio/chemical/sgp40.c
> > +++ b/drivers/iio/chemical/sgp40.c
> > @@ -29,6 +29,7 @@
> >   * by writing to the out values of temp and humidityrelative.
> >   */
> >  
> > +#include "linux/device.h"
> >  #include <linux/delay.h>
> >  #include <linux/crc8.h>
> >  #include <linux/module.h>
> > @@ -259,6 +260,21 @@ static int sgp40_execute_self_test(struct sgp40_data *data)
> >  	}
> >  }
> >  
> > +static int sgp40_turn_heater_off(struct sgp40_data *data)
> > +{
> > +	int ret;
> > +	struct i2c_client *client = data->client;
> > +	struct sgp40_command turn_off = {.command = {0x36, 0x15}};
> > +
> > +	ret = i2c_master_send(client, (char*)&turn_off, sizeof(turn_off.command));
> > +	if (ret != sizeof(turn_off.command)) {
> > +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));
> > +		return -EIO;
> > +	}
> > +	msleep(1);
> > +	return 0;
> > +}
> > +
> >  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
> >  {
> >  	int ret;
> > @@ -417,10 +433,22 @@ static ssize_t serial_number_show(struct device *dev,
> >  	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
> >  }
> >  
> > +static ssize_t turn_heater_off_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t len)
> > +{
> > +	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
> > +	sgp40_turn_heater_off(data);
> > +
> > +	return len;
> > +}
> > +
> >  static IIO_DEVICE_ATTR_RO(serial_number, 0);
> > +static IIO_DEVICE_ATTR_WO(turn_heater_off, 0);
> >  
> >  static struct attribute *sgp40_attributes[] = {
> >  	&iio_dev_attr_serial_number.dev_attr.attr,
> > +	&iio_dev_attr_turn_heater_off.dev_attr.attr,
> >  	NULL
> >  };
> >  
> > -- 
> > 2.55.0
> >   
> 

