Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.org>,
    Richard Weinberger <richard@nod.at>
Subject: Re: [PATCHv2 3/3] iio: dht11: Improve logging
In-reply-to: <56A50301.7030407@kernel.org>
References: <1453047211-16661-1-git-send-email-harald@ccbib.org> <1453047211-16661-3-git-send-email-harald@ccbib.org> <56A50301.7030407@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 10 Apr 2016 17:22:10 +0200
Message-Id: <E1apHBj-0000bd-AP@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan!

Jonathan Cameron writes:
> On 17/01/16 16:13, Harald Geyer wrote:
> > * Unify log messages
> > * Add more DEBUG messages
> > =

> > Apparently this driver is working unreliably on some platforms that I =
can't
> > test. Therefore I want an easy way for bug reporters to provide useful
> > information without making the driver too chatty by default.
> > =

> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> Applied.

I can't find this patch in any repository (while the other patches of the
series are there). Did I miss a reason this was dropped or is this an
oversightr? Should I resend this patch?

TIA,
Harald
 =

> Thanks,
> =

> Jonathan
> > ---
> > changes since V1:
> >  * rebased onto the updated series
> > =

> >  drivers/iio/humidity/dht11.c | 40 ++++++++++++++++++++++++++++++++++-=
-----
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> > =

> > diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11=
.c
> > index 96185f8..4992e8c 100644
> > --- a/drivers/iio/humidity/dht11.c
> > +++ b/drivers/iio/humidity/dht11.c
> > @@ -96,6 +96,24 @@ struct dht11 {
> >  	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
> >  };
> >  =

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
> > +	for (i =3D 1; i < dht11->num_edges; ++i) {
> > +		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
> > +			dht11->edges[i].ts - dht11->edges[i - 1].ts,
> > +			dht11->edges[i - 1].value ? "high" : "low");
> > +	}
> > +}
> > +#endif /* CONFIG_DYNAMIC_DEBUG */
> > +
> >  static unsigned char dht11_decode_byte(char *bits)
> >  {
> >  	unsigned char ret =3D 0;
> > @@ -119,8 +137,12 @@ static int dht11_decode(struct dht11 *dht11, int =
offset)
> >  	for (i =3D 0; i < DHT11_BITS_PER_READ; ++i) {
> >  		t =3D dht11->edges[offset + 2 * i + 2].ts -
> >  			dht11->edges[offset + 2 * i + 1].ts;
> > -		if (!dht11->edges[offset + 2 * i + 1].value)
> > -			return -EIO;  /* lost synchronisation */
> > +		if (!dht11->edges[offset + 2 * i + 1].value) {
> > +			dev_dbg(dht11->dev,
> > +				"lost synchronisation at edge %d\n",
> > +				offset + 2 * i + 1);
> > +			return -EIO;
> > +		}
> >  		bits[i] =3D t > DHT11_THRESHOLD;
> >  	}
> >  =

> > @@ -130,8 +152,10 @@ static int dht11_decode(struct dht11 *dht11, int =
offset)
> >  	temp_dec =3D dht11_decode_byte(&bits[24]);
> >  	checksum =3D dht11_decode_byte(&bits[32]);
> >  =

> > -	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) !=3D checksum=
)
> > +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) !=3D checksum=
) {
> > +		dev_dbg(dht11->dev, "invalid checksum\n");
> >  		return -EIO;
> > +	}
> >  =

> >  	dht11->timestamp =3D ktime_get_real_ns();
> >  	if (hum_int < 20) {  /* DHT22 */
> > @@ -182,6 +206,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> >  	mutex_lock(&dht11->lock);
> >  	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) =
{
> >  		timeres =3D ktime_get_resolution_ns();
> > +		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
> >  		if (timeres > DHT11_MIN_TIMERES) {
> >  			dev_err(dht11->dev, "timeresolution %dns too low\n",
> >  				timeres);
> > @@ -219,10 +244,13 @@ static int dht11_read_raw(struct iio_dev *iio_de=
v,
> >  =

> >  		free_irq(dht11->irq, iio_dev);
> >  =

> > +#ifdef CONFIG_DYNAMIC_DEBUG
> > +		dht11_edges_print(dht11);
> > +#endif
> > +
> >  		if (ret =3D=3D 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
> > -			dev_err(&iio_dev->dev,
> > -				"Only %d signal edges detected\n",
> > -					dht11->num_edges);
> > +			dev_err(dht11->dev, "Only %d signal edges detected\n",
> > +				dht11->num_edges);
> >  			ret =3D -ETIMEDOUT;
> >  		}
> >  		if (ret < 0)
> > =

> =


-- =

If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
