Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:33410 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbcA3TLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 14:11:25 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: Abhilash Jindal <klock.android@gmail.com>,
	linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH] iio: dht11: Use boottime
In-reply-to: <56ACF7E4.7040603@kernel.org>
References: <1453934762-6290-1-git-send-email-klock.android@gmail.com> <56ACF7E4.7040603@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 30 Jan 2016 20:11:20 +0100
Message-Id: <E1aPavY-0000Rc-Gk@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron writes:
> On 27/01/16 22:46, Abhilash Jindal wrote:
> > Wall time obtained from ktime_get_real_ns is susceptible to sudden jumps due to
> > user setting the time or due to NTP.  Boot time is constantly increasing time
> > better suited for comparing two timestamps.
> > 
> > Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
> Seems sensible to me, but would like Richard / Harald to take a quick
> look before I apply it.

Reviewed-by: Harald Geyer <harald@ccbib.org>

I can't test this right now, but I think it will fix an odd issue I
have seen in a log file (apparently was completely off track debugging it).
As this very likely is a real world issue, I'd recommend applying the patch
to the fixes branch, so that it hopefully gets picked up for LTS kernels.

I used ktime_get_real_ns() because that is what iio_get_time_ns() uses.
I should have thought about this twice - sorry about being sloppy!

I just grepped the other iio drivers and none is using iio_get_time_ns() in
a comparision like dht11 did, so maybe the other uses are safe. However
I couldn't check variables containing timestamps that way, so maybe
reviewing the users of iio_get_time_ns(), whether wall time is actually
what is wanted, would be a worthwhile task if somebody has the time ...

Thanks for the patch!
Harald

> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/humidity/dht11.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> > index 1165b1c..cfc5a05 100644
> > --- a/drivers/iio/humidity/dht11.c
> > +++ b/drivers/iio/humidity/dht11.c
> > @@ -117,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11, int offset, int timeres)
> >  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
> >  		return -EIO;
> >  
> > -	dht11->timestamp = ktime_get_real_ns();
> > +	dht11->timestamp = ktime_get_boot_ns();
> >  	if (hum_int < 20) {  /* DHT22 */
> >  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
> >  					((temp_int & 0x80) ? -100 : 100);
> > @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
> >  
> >  	/* TODO: Consider making the handler safe for IRQ sharing */
> >  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> > -		dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
> > +		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
> >  		dht11->edges[dht11->num_edges++].value =
> >  						gpio_get_value(dht11->gpio);
> >  
> > @@ -164,7 +164,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> >  	int ret, timeres;
> >  
> >  	mutex_lock(&dht11->lock);
> > -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> > +	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
> >  		timeres = ktime_get_resolution_ns();
> >  		if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
> >  			dev_err(dht11->dev, "timeresolution %dns too low\n",
> > @@ -279,7 +279,7 @@ static int dht11_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
> > +	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
> >  	dht11->num_edges = -1;
> >  
> >  	platform_set_drvdata(pdev, iio);
> > 
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
