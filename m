Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:26999 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcDHOKz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Apr 2016 10:10:55 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 1/3] iio:core: mounting matrix support
Date: Fri, 8 Apr 2016 16:12:03 +0200
Message-ID: <f05e647cadb347b9007620068d25451175868651.1460113510.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1460113510.git.gregor.boirie@parrot.com>
References: <cover.1460113510.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Expose a rotation matrix to indicate userspace the chip placement with
respect to the overall hardware system. This is needed to adjust
coordinates sampled from a sensor chip when its position deviates from the
main hardware system.

Final coordinates computation is delegated to userspace since:
* computation may involve floating point arithmetics ;
* it allows an application to combine adjustments with arbitrary
  transformations.

This 3 dimentional space rotation matrix is expressed as 3x3 array of
strings to support floating point numbers. It may be retrieved from a
"in_<type>_mount_matrix" sysfs attribute file. It is declared into a
device / driver specific DTS property or platform data.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 51 +++++++++++++++++++++
 drivers/iio/industrialio-core.c         | 81 +++++++++++++++++++++++++++++++++
 include/linux/iio/sysfs.h               | 25 ++++++++++
 3 files changed, 157 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f155eff..f2badda 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1512,3 +1512,54 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no offset etc.) pH reading of a substance as a negative
 		base-10 logarithm of hydrodium ions in a litre of water.
+
+What:           /sys/bus/iio/devices/iio:deviceX/in_magn_mount_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_anglvel_mount_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_accel_mount_matrix
+KernelVersion:  4.6
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Mounting matrix for IIO sensors. This is a rotation matrix which
+		informs userspace about sensor chip's placement relative to the
+		main hardware it is mounted on.
+		Main hardware placement is defined according to the local
+		reference frame related to the physical quantity the sensor
+		measures.
+		Given that the rotation matrix is defined in a board specific
+		way (platform data and / or device-tree), the main hardware
+		reference frame definition is left to the implementor's choice
+		(see below for a magnetometer example).
+		Applications should apply this rotation matrix to samples so
+		that when main hardware reference frame is aligned onto local
+		reference frame, then sensor chip reference frame is also
+		perfectly aligned with it.
+		Matrix is a 3x3 unitary matrix and typically looks like
+		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Identity matrix
+		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and main hardware
+		are perfectly aligned with each other.
+
+		For example, a mounting matrix for a magnetometer sensor informs
+		userspace about sensor chip's ORIENTATION relative to the main
+		hardware.
+		More specifically, main hardware orientation is defined with
+		respect to the LOCAL EARTH GEOMAGNETIC REFERENCE FRAME where :
+		* Y is in the ground plane and positive towards magnetic North ;
+		* X is in the ground plane, perpendicular to the North axis and
+		  positive towards the East ;
+		* Z is perpendicular to the ground plane and positive upwards.
+
+		An implementor might consider that for a hand-held device, a
+		'natural' orientation would be 'front facing camera at the top'.
+		The main hardware reference frame could then be described as :
+		* Y is in the plane of the screen and is positive towards the
+		  top of the screen ;
+		* X is in the plane of the screen, perpendicular to Y axis, and
+		  positive towards the right hand side of the screen ;
+		* Z is perpendicular to the screen plane and positive out of the
+		  screen.
+		Another example for a quadrotor UAV might be :
+		* Y is in the plane of the propellers and positive towards the
+		  front-view camera;
+		* X is in the plane of the propellers, perpendicular to Y axis,
+		  and positive towards the starboard side of the UAV ;
+		* Z is perpendicular to propellers plane and positive upwards.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 190a593..f9337e8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -177,6 +177,87 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
+/**
+ * iio_show_mount_matrix() - sysfs helper for showing iio device mounting matrix
+ *                           attribute
+ * @matrix:	mounting matrix to show
+ * @buf:	char buffer to be filled with matrix elements
+ */
+ssize_t iio_show_mount_matrix(const struct iio_mount_matrix *matrix,
+			      char *buf)
+{
+	return sprintf(buf, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
+		       matrix->rotation[0], matrix->rotation[1],
+		       matrix->rotation[2], matrix->rotation[3],
+		       matrix->rotation[4], matrix->rotation[5],
+		       matrix->rotation[6], matrix->rotation[7],
+		       matrix->rotation[8]);
+}
+EXPORT_SYMBOL(iio_show_mount_matrix);
+
+static const struct iio_mount_matrix iio_mount_idmatrix = {
+	.rotation = {
+		"1", "0", "0",
+		"0", "1", "0",
+		"0", "0", "1"
+	}
+};
+
+static int iio_setup_mount_idmatrix(const struct device *dev,
+				    struct iio_mount_matrix *matrix)
+{
+	*matrix = iio_mount_idmatrix;
+	dev_info(dev, "mounting matrix not found: using identity...\n");
+	return 0;
+}
+
+/**
+ * of_iio_read_mount_matrix() - retrieve iio device mounting matrix from
+ *                              device-tree "mount-matrix" property
+ * @dev:	device the mounting matrix property is assigned to
+ * @propname:	device specific mounting matrix property name
+ * @matrix:	where to store retrieved matrix
+ *
+ * If device is assigned no mounting matrix property, a default 3x3 identity
+ * matrix will be filled in.
+ *
+ * Return: 0 if success, or a negative error code on failure.
+ */
+#ifdef CONFIG_OF
+int of_iio_read_mount_matrix(const struct device *dev,
+			     const char *propname,
+			     struct iio_mount_matrix *matrix)
+{
+	if (dev->of_node) {
+		int err = of_property_read_string_array(dev->of_node,
+				propname, matrix->rotation,
+				ARRAY_SIZE(iio_mount_idmatrix.rotation));
+
+		if (err == ARRAY_SIZE(iio_mount_idmatrix.rotation))
+			return 0;
+
+		if (err >= 0)
+			/* Invalid number of matrix entries. */
+			return -EINVAL;
+
+		if (err != -EINVAL)
+			/* Invalid matrix declaration format. */
+			return err;
+	}
+
+	/* Matrix was not declared at all: fallback to identity. */
+	return iio_setup_mount_idmatrix(dev, matrix);
+}
+#else
+int of_iio_read_mount_matrix(const struct device *dev,
+			     const char *propname,
+			     struct iio_mount_matrix *matrix)
+{
+	return iio_setup_mount_idmatrix(dev, matrix);
+}
+#endif
+EXPORT_SYMBOL(of_iio_read_mount_matrix);
+
 static int __init iio_init(void)
 {
 	int ret;
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 9cd8f74..39ad842 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -125,4 +125,29 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(in_temp_scale, _string)
 
+/**
+ * struct iio_mount_matrix - iio mounting matrix
+ * @rotation: 3 dimensional space rotation matrix defining sensor alignment with
+ *            main hardware
+ */
+struct iio_mount_matrix {
+	const char *rotation[9];
+};
+
+int of_iio_read_mount_matrix(const struct device *dev,
+			     const char *propname,
+			     struct iio_mount_matrix *matrix);
+
+ssize_t iio_show_mount_matrix(const struct iio_mount_matrix *matrix,
+			      char *buf);
+
+/**
+ * IIO_DEV_ATTR_MOUNT_MATRIX - iio mounting matrix attribute
+ * @_show: output method for the attribute
+ * @_addr: optional associated register address to distinguish between
+ *         sensor chip's sub-devices
+ **/
+#define IIO_DEV_ATTR_MOUNT_MATRIX(_name, _show, _addr) \
+	IIO_DEVICE_ATTR(_name, S_IRUGO, _show, NULL, _addr)
+
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
2.1.4

