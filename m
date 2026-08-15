Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52F25C818;
	Sat, 15 Aug 2026 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757721; cv=none; b=lrzEdQGMlctLiWqQNQaqUZYPXIN7P6hctpBZoFS6mLNHkHGb4eSEpK+kNWOCL9ZayQstOnnC1A8M+698mXiSdUsq4xkCBedocDPH4OVSU8n+huIuRR3LRtF9uQYkEuzvfIGwJw+NkeyRdVeH3RBwrUijBw4NHUb84GfU0eHe654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757721; c=relaxed/simple;
	bh=xP91E46WXNRwi1W2JbJ8kkf+i7/ZrIEUc48wb+uk7V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFFYfmrshb2cR+jRif2bnUx9EuWavuJ5CCc/j/oNRa48TcHIbT1wbqcjipoQR3Ny+TJRr1P0b2zF76OwhH21faKOnn6g9qa+au/sUxwJ1yT3Ov0RspkHZEQVzWbDTDE8Blfz6g9ma5FkZNeHjhqzY2FcciPgLzk5WCru7z1fxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCvbR3s4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCvbR3s4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479651F000E9;
	Sat, 15 Aug 2026 01:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786757720;
	bh=FeVrpopnbiQC+3EHMs1QWOS5qhnwYfmurPv/YU8rqGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oCvbR3s4yQYRjYpOQhuvCXyU304lLE35QB+7NkJvBrEiLZ2ZhbyWciO4lzoAJ+TeG
	 C5JsSpjE6aWYteDgKa/pFiEdRj9nevxsi4lY5euUcvEqbp84ujrBaQig9gMzflp+tY
	 E18WbtrvA+E/fZ+4wJt/6e3zUYWpRfftDJlvzHUmuqesGx4xzPvFzCtd1z1cqbg2NF
	 jdkK+cPG9uX7RlmPkpATBT28Nsaj/fhft9GLGtCUjPy3Y2/Wl2XnQIu3az+6sS7M/A
	 zUElADdMsIeiEhaku6OjvpgegYJDWt/nEkKgIuoFJDLKGs/EoDDaryNGakxMpRAsRS
	 A4c/dhA777Wng==
Date: Sat, 15 Aug 2026 02:35:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Message-ID: <20260815023508.3c8df8d2@jic23-huawei>
In-Reply-To: <05baac51-bb6c-4a2a-9587-4ae3e30aee21@baylibre.com>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
	<20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
	<anUwKGyjjwYxQ8NI@ashevche-desk.local>
	<05baac51-bb6c-4a2a-9587-4ae3e30aee21@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 16:18:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/6/26 8:08 PM, Andy Shevchenko wrote:
> > On Mon, Jul 27, 2026 at 09:09:50AM -0500, David Lechner (TI) wrote:  
> >> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
> >> data integrity of all I2C transactions with the device.
> >>
> >> For now, it is always enabled, but it could be made optional in the
> >> future if needed (e.g. for higher-speed data acquisition).  
> > 
> > ...
> >   
> >> +static int ads112c14_i2c_add_driver(struct i2c_driver *driver)
> >> +{
> >> +	crc8_populate_msb(ads112c14_crc8_table, ADS112C14_I2C_CRC8_POLYNOMIAL);
> >> +
> >> +	return i2c_add_driver(driver);
> >> +}
> >> +
> >>  static struct i2c_driver ads112c14_driver = {
> >>  	.driver = {
> >>  		.name = "ads112c14",
> >> @@ -1217,7 +1347,7 @@ static struct i2c_driver ads112c14_driver = {
> >>  	.probe = ads112c14_probe,
> >>  	.id_table = ads112c14_id,
> >>  };
> >> -module_i2c_driver(ads112c14_driver);
> >> +module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);  
> > 
> > This is not needed if you call crc8_populate_msb() from the probe using
> > DO_ONCE_SLEEPABLE().
> >   
> 
> Good idea, but this series got picked up already.
> 
Follow up is fine.  DO_ONCE_SLEEPABLE() is a new one to me, and indeed looks rather
useful for this sort of thing.

Jonathan


