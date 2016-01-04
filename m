Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:46217 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbcADOte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 09:49:34 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 3/3] iio: dht11: Improve logging
In-reply-to: <568A5D53.5010703@kernel.org>
References: <1451485605-3441-1-git-send-email-harald@ccbib.org> <1451485605-3441-3-git-send-email-harald@ccbib.org> <568A5D53.5010703@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 04 Jan 2016 15:49:27 +0100
Message-Id: <E1aG6Rr-0000N7-CY@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron writes:
> On 30/12/15 14:26, Harald Geyer wrote:
> > * Unify log messages
> > * Add more DEBUG messages
> > 
> > Apparently this driver is working unreliably on some platforms that I can't
> > test. Therefore I want an easy way for bug reporters to provide useful
> > information without making the driver too chatty by default.
> > 
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> Basically fine, though I'd loose the #ifdefs.
> 
> Jonathan
> > ---
> >  drivers/iio/humidity/dht11.c | 40 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> > index cd1477d..f0cb28c 100644
> > --- a/drivers/iio/humidity/dht11.c
> > +++ b/drivers/iio/humidity/dht11.c
> > @@ -96,6 +96,24 @@ struct dht11 {
> >  	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
> >  };
> >  
> > +#ifdef CONFIG_DYNAMIC_DEBUG
> > +/*
> > + * dht11_edges_print: show the data as actually received by the
> > + *                    driver.
> > + */
> > +static void dht11_edges_print(struct dht11 *dht11)
> > +{
> > +	int i;
> > +
> > +	dev_dbg(dht11->dev, "%d edges detected:\n", dht11->num_edges);
> > +	for (i = 1; i < dht11->num_edges; ++i) {
> > +		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
> > +			dht11->edges[i].ts - dht11->edges[i - 1].ts,
> > +			dht11->edges[i - 1].value ? "high" : "low");
> > +	}
> > +}
> > +#endif /* CONFIG_DYNAMIC_DEBUG */
> Hmm. I guess the ifdef is to avoid having the overhead in all cases.
> I'd be more included to leave it out as the overhead isn't huge...

Actually my reason was that this particular function is very chatty
writing more than 80 lines of output. This can easily push more important
lines out of the ring buffer. So I thought an easy way to turn it off
without recompiling the kernel is appropriate.
 
> Also it's more than possible people will want to use traditional
> non dynamic debug for this...

I don't expect so, but I entirely rely on your judgement in this case.
What do you want to have there instead?

Thanks,
Harald

> > +
> >  static unsigned char dht11_decode_byte(char *bits)
> >  {
> >  	unsigned char ret = 0;
> > @@ -119,8 +137,12 @@ static int dht11_decode(struct dht11 *dht11, int offset)
> >  	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> >  		t = dht11->edges[offset + 2 * i + 2].ts -
> >  			dht11->edges[offset + 2 * i + 1].ts;
> > -		if (!dht11->edges[offset + 2 * i + 1].value)
> > -			return -EIO;  /* lost synchronisation */
> > +		if (!dht11->edges[offset + 2 * i + 1].value) {
> > +			dev_dbg(dht11->dev,
> > +				"lost synchronisation at edge %d\n",
> > +				offset + 2 * i + 1);
> > +			return -EIO;
> > +		}
> >  		bits[i] = t > DHT11_THRESHOLD ? 1 : 0;
> >  	}
> >  
> > @@ -130,8 +152,10 @@ static int dht11_decode(struct dht11 *dht11, int offset)
> >  	temp_dec = dht11_decode_byte(&bits[24]);
> >  	checksum = dht11_decode_byte(&bits[32]);
> >  
> > -	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
> > +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum) {
> > +		dev_dbg(dht11->dev, "invalid checksum\n");
> >  		return -EIO;
> > +	}
> >  
> >  	dht11->timestamp = ktime_get_real_ns();
> >  	if (hum_int < 20) {  /* DHT22 */
> > @@ -182,6 +206,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> >  	mutex_lock(&dht11->lock);
> >  	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> >  		timeres = ktime_get_resolution_ns();
> > +		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
> >  		if (timeres > DHT11_MIN_TIMERES) {
> >  			dev_err(dht11->dev, "timeresolution %dns too low\n",
> >  				timeres);
> > @@ -219,10 +244,13 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> >  
> >  		free_irq(dht11->irq, iio_dev);
> >  
> > +#ifdef CONFIG_DYNAMIC_DEBUG
> > +		dht11_edges_print(dht11);
> > +#endif
> > +
> >  		if (ret == 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
> > -			dev_err(&iio_dev->dev,
> > -				"Only %d signal edges detected\n",
> > -					dht11->num_edges);
> > +			dev_err(dht11->dev, "Only %d signal edges detected\n",
> > +				dht11->num_edges);
> >  			ret = -ETIMEDOUT;
> >  		}
> >  		if (ret < 0)
> > 
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
