Return-Path: <SRS0=ObhF=PX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC0C43387
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 00:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E90320578
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 00:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfAOATD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:19:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24035 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbfAOATD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jan 2019 19:19:03 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0F0Flti016115;
        Tue, 15 Jan 2019 01:18:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pybxy2exc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 15 Jan 2019 01:18:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D11231;
        Tue, 15 Jan 2019 00:18:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21272112B;
        Tue, 15 Jan 2019 00:18:29 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 15 Jan
 2019 01:18:28 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Tue, 15 Jan 2019 01:18:28 +0100
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Drake <drake@endlessm.com>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH 2/2] iio: st_accel: use ACPI orientation data
Thread-Topic: [PATCH 2/2] iio: st_accel: use ACPI orientation data
Thread-Index: AQHUmDGW++03HAfFJUiIX1WDcJwgAqWLAb0AgCESzICAA4fg4A==
Date:   Tue, 15 Jan 2019 00:18:28 +0000
Message-ID: <49fe1df26d70489ca3b3c52cb5cf561c@SFHDAG2NODE1.st.com>
References: <20181220065933.25964-1-drake@endlessm.com>
        <20181220065933.25964-2-drake@endlessm.com>
        <20181222180914.6d3b5e5e@archlinux> <20190112191305.103daa46@archlinux>
In-Reply-To: <20190112191305.103daa46@archlinux>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_13:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Daniel,

I am not familiar with ACPI and I am not sure why axis orientation is not following the standard there.
What I wonder is if this is related to SMO8840, Acer or in general to ST accelerometers integration. Your patch seems to be fine technically but are you able to confirm it will works even outside the 3 parts tested? The other accel supported by ACPI probing SMO8A90 is affected also?

Denis



-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org> 
Sent: Saturday, January 12, 2019 11:13 AM
To: Daniel Drake <drake@endlessm.com>
Cc: knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux@endlessm.com; lorenzo.bianconi83@gmail.com; Denis CIOCCA <denis.ciocca@st.com>; hadess@hadess.net; hdegoede@redhat.com
Subject: Re: [PATCH 2/2] iio: st_accel: use ACPI orientation data

On Sat, 22 Dec 2018 18:09:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Dec 2018 14:59:33 +0800
> Daniel Drake <drake@endlessm.com> wrote:
> 
> > Platform-specific ST accelerometer mount matrix information can be 
> > provided by returning a package of 6 integers from the ACPI _ONT 
> > method. This has been seen on Acer products such as Veriton Z4860G, 
> > Z6860G and A890, which include a ST SMO8840 sensor. We have also 
> > confirmed experimentally that the Windows driver uses such information.
> > 
> > The _ONT data format was explained by a ST vendor contact. However, 
> > strangely enough, the _ONT transformations must be applied after 
> > first applying another mount matrix which we determined 
> > experimentally. ST have not commented on why this is the case, but 
> > we imagine that perhaps earlier devices (before _ONT was introduced) 
> > required this translation and hence it became 'standard.'
> > 
> > Interpret the _ONT data and export the equivalent mount matrix to 
> > userspace.
> > 
> > If no _ONT data is present, no mount matrix is exported.
> > 
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> A trivial point.  Please stick to the local (and most common in 
> kernel) multiline comment syntax of
> /*
>  * asdfsdfs
>  * more...
>  */
> 
> Otherwise looks sensible.  However, I'd really like Dennis or someone 
> else at ST to take a look before I take this.  We are early in the 
> cycle (well it hasn't quite started yet) so plenty of time.  Give me a 
> bump in a few weeks if nothing is happening...

Note  I'm still lookign for Denis or someone else to come back on this one!

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/accel/st_accel_core.c     | 171 +++++++++++++++++++++++++-
> >  include/linux/iio/common/st_sensors.h |   1 +
> >  2 files changed, 171 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/st_accel_core.c 
> > b/drivers/iio/accel/st_accel_core.c
> > index 3e6fd5a8ac5b..54cc1a0c6a1d 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > +#include <linux/acpi.h>
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > @@ -917,12 +918,167 @@ static const struct iio_trigger_ops 
> > st_accel_trigger_ops = {  #define ST_ACCEL_TRIGGER_OPS NULL  #endif
> >  
> > +static const struct iio_mount_matrix * get_mount_matrix(const 
> > +struct iio_dev *indio_dev,
> > +		 const struct iio_chan_spec *chan) {
> > +	struct st_sensor_data *adata = iio_priv(indio_dev);
> > +
> > +	return adata->mount_matrix;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
> > +	{ },
> > +};
> > +
> > +/* Read ST-specific _ONT orientation data from ACPI and generate an
> > + * appropriate mount matrix.
> > + */
> > +static int apply_acpi_orientation(struct iio_dev *indio_dev,
> > +				  struct iio_chan_spec *channels) { #ifdef CONFIG_ACPI
> > +	struct st_sensor_data *adata = iio_priv(indio_dev);
> > +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > +	struct acpi_device *adev;
> > +	union acpi_object *ont;
> > +	union acpi_object *elements;
> > +	acpi_status status;
> > +	int ret = -EINVAL;
> > +	unsigned int val;
> > +	int i, j;
> > +	int final_ont[3][3] = { 0 };
> > +
> > +	/* For some reason, ST's _ONT translation does not apply directly
> > +	 * to the data read from the sensor. Another translation must be
> > +	 * performed first, as described by the matrix below. Perhaps
> > +	 * ST required this specific translation for the first product
> > +	 * where the device was mounted?
> > +	 */
> > +	const int default_ont[3][3] = {
> > +		{  0,  1,  0 },
> > +		{ -1,  0,  0 },
> > +		{  0,  0, -1 },
> > +	};
> > +
> > +
> > +	adev = ACPI_COMPANION(adata->dev);
> > +	if (!adev)
> > +		return 0;
> > +
> > +	/* Read _ONT data, which should be a package of 6 integers. */
> > +	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
> > +	if (status == AE_NOT_FOUND) {
> > +		return 0;
> > +	} else if (ACPI_FAILURE(status)) {
> > +		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
> > +			 status);
> > +		return status;
> > +	}
> > +
> > +	ont = buffer.pointer;
> > +	if (ont->type != ACPI_TYPE_PACKAGE || ont->package.count != 6)
> > +		goto out;
> > +
> > +	/* The first 3 integers provide axis order information.
> > +	 * e.g. 0 1 2 would indicate normal X,Y,Z ordering.
> > +	 * e.g. 1 0 2 indicates that data arrives in order Y,X,Z.
> > +	 */
> > +	elements = ont->package.elements;
> > +	for (i = 0; i < 3; i++) {
> > +		if (elements[i].type != ACPI_TYPE_INTEGER)
> > +			goto out;
> > +
> > +		val = elements[i].integer.value;
> > +		if (val < 0 || val > 2)
> > +			goto out;
> > +
> > +		/* Avoiding full matrix multiplication, we simply reorder the
> > +		 * columns in the default_ont matrix according to the
> > +		 * ordering provided by _ONT.
> > +		 */
> > +		final_ont[0][i] = default_ont[0][val];
> > +		final_ont[1][i] = default_ont[1][val];
> > +		final_ont[2][i] = default_ont[2][val];
> > +	}
> > +
> > +	/* The final 3 integers provide sign flip information.
> > +	 * 0 means no change, 1 means flip.
> > +	 * e.g. 0 0 1 means that Z data should be sign-flipped.
> > +	 * This is applied after the axis reordering from above.
> > +	 */
> > +	elements += 3;
> > +	for (i = 0; i < 3; i++) {
> > +		if (elements[i].type != ACPI_TYPE_INTEGER)
> > +			goto out;
> > +
> > +		val = elements[i].integer.value;
> > +		if (val != 0 && val != 1)
> > +			goto out;
> > +		if (!val)
> > +			continue;
> > +
> > +		/* Flip the values in the indicated column */
> > +		final_ont[0][i] *= -1;
> > +		final_ont[1][i] *= -1;
> > +		final_ont[2][i] *= -1;
> > +	}
> > +
> > +	/* Convert our integer matrix to a string-based iio_mount_matrix */
> > +	adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
> > +					   sizeof(*adata->mount_matrix),
> > +					   GFP_KERNEL);
> > +	if (!adata->mount_matrix) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	for (i = 0; i < 3; i++) {
> > +		for (j = 0; j < 3; j++) {
> > +			int matrix_val = final_ont[i][j];
> > +			char *str_value;
> > +
> > +			switch (matrix_val) {
> > +			case -1:
> > +				str_value = "-1";
> > +				break;
> > +			case 0:
> > +				str_value = "0";
> > +				break;
> > +			case 1:
> > +				str_value = "1";
> > +				break;
> > +			default:
> > +				goto out;
> > +			}
> > +			adata->mount_matrix->rotation[i * 3 + j] = str_value;
> > +		}
> > +	}
> > +
> > +	/* Expose the mount matrix via ext_info */
> > +	for (i = 0; i < indio_dev->num_channels; i++)
> > +		channels[i].ext_info = mount_matrix_ext_info;
> > +
> > +	ret = 0;
> > +	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
> > +
> > +out:
> > +	kfree(buffer.pointer);
> > +	return ret;
> > +#else /* !CONFIG_ACPI */
> > +	return 0;
> > +#endif
> > +}
> > +
> >  int st_accel_common_probe(struct iio_dev *indio_dev)  {
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> >  	struct st_sensors_platform_data *pdata =
> >  		(struct st_sensors_platform_data *)adata->dev->platform_data;
> >  	int irq = adata->get_irq_data_ready(indio_dev);
> > +	struct iio_chan_spec *channels;
> > +	size_t channels_size;
> >  	int err;
> >  
> >  	indio_dev->modes = INDIO_DIRECT_MODE; @@ -941,9 +1097,22 @@ int 
> > st_accel_common_probe(struct iio_dev *indio_dev)
> >  
> >  	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
> >  	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
> > -	indio_dev->channels = adata->sensor_settings->ch;
> >  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
> >  
> > +	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
> > +	channels = devm_kmemdup(&indio_dev->dev,
> > +				adata->sensor_settings->ch,
> > +				channels_size, GFP_KERNEL);
> > +	if (!channels) {
> > +		err = -ENOMEM;
> > +		goto st_accel_power_off;
> > +	}
> > +
> > +	if (apply_acpi_orientation(indio_dev, channels))
> > +		dev_warn(&indio_dev->dev,
> > +			 "failed to apply ACPI orientation data: %d\n", err);
> > +
> > +	indio_dev->channels = channels;
> >  	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
> >  					&adata->sensor_settings->fs.fs_avl[0];
> >  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
> > diff --git a/include/linux/iio/common/st_sensors.h 
> > b/include/linux/iio/common/st_sensors.h
> > index f9bd6e8ab138..fe15694128ac 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -260,6 +260,7 @@ struct st_sensor_settings {  struct 
> > st_sensor_data {
> >  	struct device *dev;
> >  	struct iio_trigger *trig;
> > +	struct iio_mount_matrix *mount_matrix;
> >  	struct st_sensor_settings *sensor_settings;
> >  	struct st_sensor_fullscale_avl *current_fullscale;
> >  	struct regulator *vdd;
> 

