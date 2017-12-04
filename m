Return-Path: <SRS0=vSSc=DA=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 4 Dec 2017 09:44:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Javier Martinez Canillas <javierm@redhat.com>,
	<linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<devicetree@vger.kernel.org.>, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] iio: accel: bmc150: Add OF device ID table
Message-ID: <20171204092259.00006250@huawei.com>
In-Reply-To: <313108f3-2815-b030-4fa6-614efc31a8a9@redhat.com>
References: <20171201111058.13483-1-javierm@redhat.com>
	<313108f3-2815-b030-4fa6-614efc31a8a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 4 Dec 2017 09:29:38 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 01-12-17 12:10, Javier Martinez Canillas wrote:
> > The driver doesn't have a struct of_device_id table but supported devices
> > are registered via Device Trees. This is working on the assumption that a
> > I2C device registered via OF will always match a legacy I2C device ID and
> > that the MODALIAS reported will always be of the form i2c:<device>.
> > 
> > But this could change in the future so the correct approach is to have an
> > OF device ID table if the devices are registered via OF.
> > 
> > The I2C device ID table entries have the .driver_data field set, but they
> > are not used in the driver so weren't set in the OF device table entries.
> > 
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> >   drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> > index f85014fbaa12..8ffc308d5fd0 100644
> > --- a/drivers/iio/accel/bmc150-accel-i2c.c
> > +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> > @@ -81,9 +81,21 @@ static const struct i2c_device_id bmc150_accel_id[] = {
> >   
> >   MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
> >   
> > +static const struct of_device_id bmc150_accel_of_match[] = {
> > +	{ .compatible = "bosch,bmc150_accel" },
> > +	{ .compatible = "bosch,bmi055_accel" },  
> 
> These look a bit weird, there is no reason to mirror the i2c_device_ids

There has been a steady move for a long time to add these IDs with the plan
that we would stop automatically matching against the manufacturer free
i2c IDs. Mostly on the basis that was a hack that brought a lot
of effectively unreviewed device tree bindings. As I understand it the
eventual plan is to be able to get rid of that old path entirely...
+CC Wolfram to see what his view is on this.

> here and typically for devicetree / of we only list
> the chip model without some postfix like _accel.
> 

There is a reason for this and we've been round the houses a few times before
with the (admittedly horrible) conclusion that we don't really have a better way.

These are multiple chips in one package wired to the same i2c bus
there is no sensible way of telling the kernel that we actually
have two separate devices with the same part number.  We could just declare
that we will only support them under the IDs of the individual chips but,
without scraping datasheets it's very difficult to tell which two parts
have been combined in a given SKU (some manufacturers document this - some
don't and we just have to figure it out).

> Also if you're doing this you should probably add a:
> Documentation/devicetree/bindings/iio/accel/bmc150.txt
> file documenting the compatible strings, and Cc:
> devicetree@vger.kernel.org for the next version,
> so that the devicetree maintainers get a chance to review
> this.

As stated above these are existing bindings just being formally stated.
We are stuck with them.  I have no problem adding additional bindings and
marking these as deprecated if we come up with some better ones.
+cc devicetree.  Rob / Mark let me know if you want to see these patches
in future.

Most devices are long done now anyway (I think) so the flow is not too
large!

> 
> > +	{ .compatible = "bosch,bma255" },
> > +	{ .compatible = "bosch,bma250e" },
> > +	{ .compatible = "bosch,bma222e" },
> > +	{ .compatible = "bosch,bma280" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
> > +
> >   static struct i2c_driver bmc150_accel_driver = {
> >   	.driver = {
> >   		.name	= "bmc150_accel_i2c",
> > +		.of_match_table = bmc150_accel_of_match,
> >   		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
> >   		.pm	= &bmc150_accel_pm_ops,
> >   	},
> >   
> 
> Otherwise looks good to me,
> 
> Regards,
> 
> Hans
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
