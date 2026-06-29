Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B38395D8E;
	Mon, 29 Jun 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758018; cv=none; b=bMfXtBUmbBy07lcTlpOghQv1cSisTc4gHjnpjh5Tx6FF/kuSqXMs+hgT9i9Z91momQgoNyESlSJpmMRq6J1aEyeg7mMD6e3VmdDvEQb2Uh9UQAGnoajYkOLIhusC95lxy9gFbldaedjtwJmz2jBXMj+6cQ+dNko3TJvgn5s+4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758018; c=relaxed/simple;
	bh=AVhbNqLgGXkgpDNX8YG5t5uRu/FdarAuRj9IdbN4edk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iync1cZSo3tobouEG+pRGnK3yWqiupVv6BgMmsHONpEAWQFowUWv5vvrIqZwiRIYx5JQORSFJ5fDBlUWv5Xax9zGj+BH0BswMdDXcrFQ9AH8vtR0UNDP/e34JkpBgYzaqT4rx1PKYz9cVIH1v68wtmVGyftpkNcWuBdQaBqS6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8VUAMfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8VUAMfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B041F00A3A;
	Mon, 29 Jun 2026 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758017;
	bh=Ay2Nlx6wvQozyUPJA5jNiItStCN3Va6g8eXdS9knUAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l8VUAMfUqYXUjtLXvVsEMRCQiLKuvBjiOMzSdq326V2dQWDE+z2A5LmBQefsQDzvf
	 cwQSEQf2KjN6KJi4fg/mKIHUEJrgR1WBNW+dLawBxLF+v9l10qVR1wRjpWBjwkdm3M
	 2UqV+CEMp9cBRIwA6THCxqQ0t7D+kGeyo2oSB4Bih5cOftIhGMNZKqmWYKEHdtfILk
	 /HBqKPpz9stcAqj2kVFsxAOJQHaSiklra4bGbBT/1Vl5PLpikoM5wTufyNqxup7VVp
	 pT+RVNAMi3UFHrEcxbHNUOkOrFQSfgCy0C8GPDzKMs8GQsqJw6L6YPIVNnQT9JKMyh
	 ivn+HKeU8OOvw==
Date: Mon, 29 Jun 2026 19:33:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260629193329.34fab6e3@jic23-huawei>
In-Reply-To: <5e96801b-50dc-4752-8e00-1a80984ed997@baylibre.com>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
	<20260622221550.374235-2-jakubszczudlo40@gmail.com>
	<5e96801b-50dc-4752-8e00-1a80984ed997@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 17:31:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/22/26 5:15 PM, Jakub Szczudlo wrote:
> > When device is suspended and it is in single mode then changing
> > datarate doesn't make it actual wait for new measurement, so to
> > be sure that read after change is correct functions that changes
> > datarate and gain will wait for new data.
> > 
> > Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
> > Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> > ---
> >  drivers/iio/adc/ti-ads1100.c | 74 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 70 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> > index 9fe8d54cce83..e3c801381434 100644
> > --- a/drivers/iio/adc/ti-ads1100.c
> > +++ b/drivers/iio/adc/ti-ads1100.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/i2c.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/mutex.h>
> >  #include <linux/property.h>
> >  #include <linux/pm_runtime.h>
> > @@ -43,6 +44,9 @@
> >  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> >  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
> >  
> > +/* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
> > +#define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
> > +
> >  struct ads1100_data {
> >  	struct i2c_client *client;
> >  	struct regulator *reg_vdd;
> > @@ -123,10 +127,49 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
> >  	return 0;
> >  }
> >  
> > +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
> > +{
> > +	int ret;
> > +	u8 buffer[3];
> > +
> > +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));  
> 
> Do we actually need the cast here? char * is like void * and should not need it.
Hi David,

Any more background on this?  The void * implicit cast thing is in the
c standard.  I don't think there is anything equivalent for char *

Thanks,

Jonathan
