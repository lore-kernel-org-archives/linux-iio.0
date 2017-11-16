Return-Path: <SRS0=A4jG=CO=gmail.com=kah.listaddress@kernel.org>
From: Kiernan Hager <kah.listaddress@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kiernan Hager <kah.listaddress@gmail.com>
Subject: [RFC] iio: light: acpi-als: Enable the light sensor on the Zenbook UX430UQ
Date: Wed, 15 Nov 2017 20:27:54 -0700
Message-Id: <20171116032754.20719-1-kah.listaddress@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This makes acpi-als properly enable the light sensor on the Zenbook UX430UQ. I don't know if the checking that I do to make sure that the ACPI method exists is sufficient or if it should disable the sensor when the module is unloaded, so input is appreciated on those matters.

Signed-off-by: Kiernan Hager <kah.listaddress@gmail.com>
---
 drivers/iio/light/acpi-als.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index c35e2f8df339..8fd66166f19f 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -179,6 +179,10 @@ static int acpi_als_add(struct acpi_device *device)
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	unsigned long long temp_val;
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -203,6 +207,18 @@ static int acpi_als_add(struct acpi_device *device)
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	if (acpi_has_method(als->device->handle, "\\_SB.PCI0.LPCB.EC0.ALSC")) {
+		status = acpi_evaluate_integer(als->device->handle,
+					       "\\_SB.PCI0.LPCB.EC0.ALSC",
+					       &arg_list,
+					       &temp_val);
+	}
+
 	return devm_iio_device_register(&device->dev, indio_dev);
 }
 
-- 
2.15.0
