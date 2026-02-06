Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B865346AD6
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364635; cv=none; b=FK7Bun/qSFdOflefkfJocaFagG2C6V8pgktpgxH3fZWy15KEZUUgMKiNWqxLosK3qBEFPlmqiodsc0aObojEbY9deJ15jCB6cKdWqrEHYohZ6PpER2JGCsAM5W8n+XsL4919NzAflkWDPtMFEaL6rU5DVZCw7HZWK+5OGEp9h6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364635; c=relaxed/simple;
	bh=Zrm6fZQNVwJWfNL4nHVEXclBkofR1eTPAkyBjFQeq0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYV922UEuDTAIypcywp/AnJ9BeGnO6rnTaSy4sWy0t1FdtCMLZbodJblhJeB5tmp5O7NK+z26YtTI1fECka4C1PP/wnXBgO7kkY7/P0MGOP6a2fqSU464LiwFsddVvf7JhG98XgfQH+3LeYtTj6jlzUTm9ITbWrZ7pz+UO4LB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1voGiD-0001ot-Ge; Fri, 06 Feb 2026 08:57:09 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1voGiC-004MvV-2F;
	Fri, 06 Feb 2026 08:57:08 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1voGiB-002Gt0-2x;
	Fri, 06 Feb 2026 08:57:07 +0100
Date: Fri, 6 Feb 2026 08:57:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYWe0-2KMLijFVh6@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
 <aYHLRvfJH54XumUA@pengutronix.de>
 <aYHhO7pJPEew7QMC@smile.fi.intel.com>
 <aYHjQhO92yxoy_9o@pengutronix.de>
 <aYIMgEEDd8ZfLv71@smile.fi.intel.com>
 <20260205204325.5bd09d97@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205204325.5bd09d97@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Thu, Feb 05, 2026 at 08:43:25PM +0000, Jonathan Cameron wrote:
> On Tue, 3 Feb 2026 16:56:00 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Feb 03, 2026 at 01:00:02PM +0100, Oleksij Rempel wrote:
> > > On Tue, Feb 03, 2026 at 01:51:23PM +0200, Andy Shevchenko wrote:  
> > > > On Tue, Feb 03, 2026 at 11:17:42AM +0100, Oleksij Rempel wrote:  
> > > > > On Tue, Feb 03, 2026 at 12:03:23PM +0200, Andy Shevchenko wrote:  
> > > > > > On Tue, Feb 03, 2026 at 10:34:26AM +0100, Oleksij Rempel wrote:  
> > 
> > ...
> > 
> > > > > > > -	indio_dev->name = id->name;  
> > > > > >   
> > > > > > > +	indio_dev->name = client->name;  
> > > > > > 
> > > > > > Isn't this an ABI breakage?  
> > > > > 
> > > > > I can't confirm it.
> > > > > 
> > > > > before all patches:
> > > > > root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
> > > > > ds4424
> > > > > 
> > > > > after:
> > > > > root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
> > > > > ds4424  
> > > > 
> > > > In ACPI case it might look differently, but I have no means to test this.
> > > > 
> > > > id->name comes strictly from an i2c table, while client->name is constructed
> > > > using specifics of the firmware enumeration. In DT due to some (historical?)
> > > > reasons the client->name has no vendor substring and hence matches 1:1 to
> > > > id->name. In ACPI, IIRC, the client->name is ACPI device instance name,
> > > > something like ABCD0123:00.  
> > > 
> > > Ok, I see. Should I revert this line?  
> > 
> > Just do not introduce that change (change of the ->name field) in the original
> > patch, in that case no revert churn would be needed.
> > 
> I think this got dealt with in discussion of next version but
> safest route is just have an extra copy of the name in the
> chip_info structure.  Then we know it's stable against different
> firmware types etc.

Something like this?

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index ccf36d3e0443..ffa65b22a1fd 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -50,6 +50,7 @@
 }
 
 struct ds4424_chip_info {
+	const char *name;
 	int vref_mV;
 	int scale_denom;
 	u8 result_mask;
@@ -57,6 +58,7 @@ struct ds4424_chip_info {
 };
 
 static const struct ds4424_chip_info ds4402_info = {
+	.name = "ds4402",
 	.vref_mV = 1230,
 	.scale_denom = 4,
 	.result_mask = DS4404_DAC_MASK,
@@ -64,6 +66,7 @@ static const struct ds4424_chip_info ds4402_info = {
 };
 
 static const struct ds4424_chip_info ds4404_info = {
+	.name = "ds4404",
 	.vref_mV = 1230,
 	.scale_denom = 4,
 	.result_mask = DS4404_DAC_MASK,
@@ -71,6 +74,7 @@ static const struct ds4424_chip_info ds4404_info = {
 };
 
 static const struct ds4424_chip_info ds4422_info = {
+	.name = "ds4422",
 	.vref_mV = 976,
 	.scale_denom = 16,
 	.result_mask = DS4424_DAC_MASK,
@@ -78,6 +82,7 @@ static const struct ds4424_chip_info ds4422_info = {
 };
 
 static const struct ds4424_chip_info ds4424_info = {
+	.name = "ds4424",
 	.vref_mV = 976,
 	.scale_denom = 16,
 	.result_mask = DS4424_DAC_MASK,
@@ -335,7 +340,7 @@ static int ds4424_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	indio_dev->name = id->name;
+	indio_dev->name = chip_info->name;
 	data->chip_info = chip_info;
 
 	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
