Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C99C2BF.5030107@iis.fraunhofer.de>
Date: Wed, 22 Sep 2010 10:47:59 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
        Robin.Getz@analog.com
Subject: Re: [RFC PATCH 0/6] staging:iio:imu driver merges, fixes and new
 features.
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------000200070301030407050100"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000200070301030407050100
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id KAA17987

Hi Jonathan,

the merge still has severe problems for adis16400. Ring buffer doesn't=20
read elements (bytes_per_datum is always 8) but the buffer contains=20
zeros for the elements and a valid timestamp.

The temp attribute has a different address for adis300 and adis400, so=20
we need a separate entry here.

The attached patch fixes a few problems, but the ring buffer still does=20
not work.

Am 11.09.2010 16:58, schrieb Jonathan Cameron:
> The first 4 are repeat postings but are now complete (oops).
>
> Cleaning up this driver set has been on my todo list for a while
> and I've finally had a bit of time to see what could be done to
> reduce the huge amount of repeat code found in the 3 IMU drivers.
>
> This is an RFC for two reasons. Firstly I haven't tested this as
> fully yet and will do so before merging.  I will do a whole
> lot more testing on the adis16350 that I have.  Coverage of the
> adis16300 and adis16400 would be great if anyone can do so.
> I also haven't done full testing on all the build combinations yet.
> (there is at least one known issue to clean up!)
> Secondly the event patch in particularly has some elements not seen
> elsewhere before that I would like people to consider.
>
> Right now, only the adis16350 and adis16360 famillies are supported
> by the event support patch.  I'll add support for the other parts
> at a later date unless someone else beats me to it (hint!).  Note
> this patch now actually contains the adis16350_event.c file that
> was missing previously.
>
> There is one effective change to all but the adis16400 ABIs.
> When we originally proposed the [m]_<type>_<modifier>_en
> attributes for scan modes I very carefully stated that the index
> [m] for a given device would not necessarily cover all values between
> 0 and the highest present.  It was exactly this possible driver
> merge that motivated that arguement. By allowing indexes to be
> missed, we can have single drivers supporting various subsets of
> sensor elements.  Here the devices are such that some interleaving
> is possible.  This reduces the storage required for the event code,
> so I have done it where possible.  Note the addition
> of new devices to this driver in future may change this again!
>
> As ever, all comments welcome.  Any tested-bys with a part number
> would be particularly welcome.
>
> Should be trivial to add the adis16367 and adis16385 to this driver.
> Does anyone have one of these parts to test?
>
> Jonathan Cameron (6):
>    staging:iio:adis16350 add non burst buffer fill and fix burst logic
>    staging:iio:adis16350 move datardy trigger to straight interrupt.
>    staging:iio:adis16350 Add optional event support
>    staging:iio:adis16350 add missing registration of temp_offset attr
>    staging:iio:adis16300 merge into adis16350 driver
>    staging:iio:adis16400 merge into adis16350 driver
>
>   drivers/staging/iio/adc/adc.h               |    8 +-
>   drivers/staging/iio/gyro/gyro.h             |   31 +-
>   drivers/staging/iio/imu/Kconfig             |   30 +-
>   drivers/staging/iio/imu/Makefile            |    9 +-
>   drivers/staging/iio/imu/adis16300.h         |  184 -------
>   drivers/staging/iio/imu/adis16300_core.c    |  756 ------------------=
---------
>   drivers/staging/iio/imu/adis16300_ring.c    |  220 --------
>   drivers/staging/iio/imu/adis16300_trigger.c |  125 -----
>   drivers/staging/iio/imu/adis16350.h         |  117 ++++-
>   drivers/staging/iio/imu/adis16350_core.c    |  287 +++++++++--
>   drivers/staging/iio/imu/adis16350_event.c   |  499 ++++++++++++++++++
>   drivers/staging/iio/imu/adis16350_ring.c    |  167 +++++-
>   drivers/staging/iio/imu/adis16350_trigger.c |   40 +-
>   drivers/staging/iio/imu/adis16400.h         |  208 --------
>   drivers/staging/iio/imu/adis16400_core.c    |  752 ------------------=
--------
>   drivers/staging/iio/imu/adis16400_ring.c    |  231 --------
>   drivers/staging/iio/sysfs.h                 |   17 +-
>   17 files changed, 1067 insertions(+), 2614 deletions(-)
>   delete mode 100644 drivers/staging/iio/imu/adis16300.h
>   delete mode 100644 drivers/staging/iio/imu/adis16300_core.c
>   delete mode 100644 drivers/staging/iio/imu/adis16300_ring.c
>   delete mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
>   create mode 100644 drivers/staging/iio/imu/adis16350_event.c
>   delete mode 100644 drivers/staging/iio/imu/adis16400.h
>   delete mode 100644 drivers/staging/iio/imu/adis16400_core.c
>   delete mode 100644 drivers/staging/iio/imu/adis16400_ring.c
>


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------000200070301030407050100
Content-Type: text/plain;
 name="adis16350_merge_fix.patch"
Content-Disposition: attachment;
 filename="adis16350_merge_fix.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/im=
u/adis16350.h
index ab98d6c..a37f199 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -22,7 +22,8 @@
 #define ADIS16400_XMAGN_OUT 0x10 /* X-axis magnetometer measurement */
 #define ADIS16400_YMAGN_OUT 0x12 /* Y-axis magnetometer measurement */
 #define ADIS16400_ZMAGN_OUT 0x14 /* Z-axis magnetometer measurement */
-
+#define ADIS16400_TEMP_OUT  0x16 /* Temperature output */
+#define ADIS16400_AUX_ADC   0x18 /* Auxiliary ADC measurement */
=20
 #define ADIS16300_TEMP_OUT  0x10 /* Temperature output */
 #define ADIS16300_XINCLI_OUT 0x12 /* X-axis inclinometer output measurem=
ent */
@@ -52,6 +53,14 @@
 #define ADIS16350_ALM_CTRL  0x2E /* Alarm control */
 #define ADIS16350_AUX_DAC   0x30 /* Auxiliary DAC data */
=20
+#define ADIS16400_ALM_MAG1  0x40 /* Alarm 1 amplitude threshold */
+#define ADIS16400_ALM_MAG2  0x42 /* Alarm 2 amplitude threshold */
+#define ADIS16400_ALM_SMPL1 0x44 /* Alarm 1 sample size */
+#define ADIS16400_ALM_SMPL2 0x46 /* Alarm 2 sample size */
+#define ADIS16400_ALM_CTRL  0x48 /* Alarm control */
+#define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
+
+
 #define ADIS16350_ERROR_ACTIVE			(1<<14)
 #define ADIS16350_NEW_DATA			(1<<15)
=20
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/i=
io/imu/adis16350_core.c
index d8f76c6..b921f1d 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -484,7 +484,7 @@ static int adis16350_initial_setup(struct adis16350_s=
tate *st)
 	/* use high spi speed if possible */
 	ret =3D adis16350_spi_read_reg_16(dev, ADIS16350_SMPL_PRD, &smp_prd);
 	if (!ret && (smp_prd & ADIS16350_SMPL_PRD_DIV_MASK) < 0x0A) {
-		st->us->max_speed_hz =3D ADIS16350_SPI_SLOW;
+		st->us->max_speed_hz =3D ADIS16350_SPI_FAST;
 		spi_setup(st->us);
 	}
=20
@@ -680,29 +680,32 @@ static IIO_DEV_ATTR_MAGN_Y(adis16350_read_14bit_sig=
ned,
 static IIO_DEV_ATTR_MAGN_Z(adis16350_read_14bit_signed,
 		ADIS16400_ZMAGN_OUT);
 static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
+static IIO_DEVICE_ATTR(temp0_raw, S_IRUGO, adis16350_read_12bit_unsigned=
,
+		       NULL, ADIS16300_TEMP_OUT);
+
=20
 static struct attribute *adis16400_attributes[] =3D {
-	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
 	&iio_dev_attr_in_supply_raw.dev_attr.attr,
 	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_gyro_scale.dev_attr.attr,
 	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_scale.dev_attr.attr,
+	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_scale.dev_attr.attr,
 	&iio_dev_attr_accel_x_raw.dev_attr.attr,
 	&iio_dev_attr_accel_y_raw.dev_attr.attr,
 	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_accel_scale.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
+	&iio_const_attr_magn_scale.dev_attr.attr,
 	&iio_dev_attr_magn_x_raw.dev_attr.attr,
 	&iio_dev_attr_magn_y_raw.dev_attr.attr,
 	&iio_dev_attr_magn_z_raw.dev_attr.attr,
-	&iio_const_attr_magn_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_dev_attr_temp0_raw.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
@@ -833,7 +836,7 @@ static int __devinit adis16350_probe(struct spi_devic=
e *spi)
 	}
=20
 	st->indio_dev->dev.parent =3D &spi->dev;
-	st->indio_dev->attrs =3D &adis16350_attribute_group;
+	st->indio_dev->attrs =3D st->variant->attribute_group;
 	st->indio_dev->dev_data =3D (void *)(st);
 	st->indio_dev->driver_module =3D THIS_MODULE;
 	st->indio_dev->modes =3D INDIO_DIRECT_MODE;
@@ -967,5 +970,6 @@ static __exit void adis16350_exit(void)
 module_exit(adis16350_exit);
=20
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
 MODULE_DESCRIPTION("Analog Devices ADIS16350/54/55/60/62/64/65 IMU SPI d=
river");
 MODULE_LICENSE("GPL v2");

--------------000200070301030407050100--
