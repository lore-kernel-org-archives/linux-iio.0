Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BF23393E;
	Thu, 20 Aug 2026 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191485; cv=none; b=Uk5oPkN6Sm9AJyUg2QsjTWRWZS5cD47D9XNEDURJ0OXoT4gOscUFaHO2YnnyCRnHAhtctSdQgyt55wDA8yOmam3xGZkVlc4w9GOsY/DMKaRi8CrOi1OsIWN7Jm9PgkMVhSAMOM9Bewa1XKxuibFHGA08EC1WIJhHfDjj+gVKG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191485; c=relaxed/simple;
	bh=moj2C2KCpdZOteDf2BHLhz0HTA7l+fjOqSTXggcqq2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6kHTQaOXCR5Vzu9S/ODEWzEeu/T8BYYb0y0UPgFwGFr+vSmDevpAV3qiT1DDDT0sGKyllBZSU4+M9qDEr3Yr14B8F6iwSA36ga/rCdxqv6WZzZnSTjkSD2Mb4Pib+6VUrzjvpTvfTBb/XY5AdkM4vF/yJUWqGwIPrkemJPxwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvyBQkOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvyBQkOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A1A1F000E9;
	Thu, 20 Aug 2026 02:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787191484;
	bh=w5IaFzYsTxOJxoqnPZPcEwcwOjeL0ggdhlfOwS5n/es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HvyBQkODJj+hXZ5yI2LmAPAXzHR+gol5OymHvGWlZe+hSx34jHevsV1Ui7mct9gYm
	 OLGjKRzFwPt1BJnDQYGBA+qDJkeY3DW0hQ2WdbQ2WWKmb84cyRUhcd48QynqniebM+
	 SgYKKgeQ/x5MW2OLP4d0vhgbBMfmV15SPmodYo5uLYNtoRQZoFwuQ6zkbY1I1iXxxY
	 BLTkEY1Qtg1oZJDzm8sz9LzvNGWeMbn5Io5nUrKdcxA8AEh6Ro0IDFFAQLCO+OYofk
	 s3HrojAXleaIme2d4sGs4+I4oXtaqmdDx5kRgIN8mXzwRnKU1NZweKGCLN01kMdrrK
	 VqQFSKAWPgX1g==
Date: Thu, 20 Aug 2026 03:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gabriel Rondon <grondon@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: kionix-kx022a: use scan struct for
 one-shot and trigger reads
Message-ID: <20260820030438.736b67e1@jic23-huawei>
In-Reply-To: <aoVYjc1ZRTj0OvTc@ashevche-desk.local>
References: <20260818215122.52715-1-grondon@gmail.com>
	<20260818215122.52715-2-grondon@gmail.com>
	<aoVYjc1ZRTj0OvTc@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 10:17:33 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 18, 2026 at 10:51:21PM +0100, Gabriel Rondon wrote:
> > The driver kept two separate staging areas that hold the same thing:
> > buffer[8], a DMA-aligned area used by the one-shot read in
> > kx022a_get_axis() and by the triggered handler, and the scan struct,
> > used by the FIFO flush path. Both are three __le16 channels plus room
> > for the timestamp.
> > 
> > Drop buffer and route the one-shot read and the triggered handler
> > through scan.channels, so the driver has a single staging area. Move the
> > IIO_DMA_MINALIGN alignment onto scan, since it now backs the regmap bulk
> > reads that buffer used to.
> > 
> > No functional change. get_axis() only runs via read_raw() under
> > iio_device_claim_direct(), so it cannot run while the triggered buffer is
> > active, and the triggered handler only runs while it is; the two never
> > touch scan concurrently, exactly as they previously shared buffer.  
> 
> ...
> 
> > static int kx022a_get_axis(struct kx022a_data *data,  
> 
> >  {  
> 
> I would rather do this
> 
> 	__le16 *buf = &data->scan.channels[0];
> 
> >  	int ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
> > -			       sizeof(__le16));
> > +	ret = regmap_bulk_read(data->regmap, chan->address,
> > +			       &data->scan.channels[0], sizeof(__le16));  
> 
> 	ret = regmap_bulk_read(data->regmap, chan->address, buf, sizeof(*buf));
> 
> >  	if (ret)
> >  		return ret;
> >  
> > -	*val = (s16)le16_to_cpu(data->buffer[0]);
> > +	*val = (s16)le16_to_cpu(data->scan.channels[0]);  
> 
> 	*val = (s16)le16_to_cpup(buf);
True - that is nicer. Tweaked.  Diff just to check I didn't get it wrong:

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 86f17431aa23..8f2810c8ffeb 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -610,14 +610,15 @@ static int kx022a_get_axis(struct kx022a_data *data,
                           struct iio_chan_spec const *chan,
                           int *val)
 {
+       __le16 *buf = &data->scan.channels[0];
        int ret;
 
        ret = regmap_bulk_read(data->regmap, chan->address,
-                              &data->scan.channels[0], sizeof(__le16));
+                              buf, sizeof(*buf));
        if (ret)
                return ret;
 
-       *val = (s16)le16_to_cpu(data->scan.channels[0]);
+       *val = (s16)le16_to_cpup(buf);
 
        return IIO_VAL_INT;
 }



> 

