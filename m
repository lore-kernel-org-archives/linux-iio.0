Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645938D;
	Wed,  4 Mar 2026 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649214; cv=none; b=hqMhalWqMg+FwhU7SRGJT4bApoZRE/v3h+TrDeu0xhCAMsmAzphtq1QjgY2zgAEbzkb/JKST//VLQpsM9s20JfUD7dWqyZeSX2zzKlWVjIRVAjYv66OIiymGPtHNC8edqyPsS5zE5e2Wnvw8nlNn+wD3e1f2pv8OcZzh6JEm05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649214; c=relaxed/simple;
	bh=TYl+mO3jTFF78LYOjZjVzDB4wpiR2tpbrL1fIlmPiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ergOmQTsJhyz/HGQZTqagQq5b1vW9nSeYZQCci+N54qEfw6BRj2JgaeETUkRSXsmzP7veqOwwfm2/23FLc/gkGGtMnNWnnlYWA6poK0/TBMeX5fh9q37WZCDb8qpfRFrAn1qoqL/XOH3TujoXfxrCbcPyUPnFesH6vMWpQ44Exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnX9G5IJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnX9G5IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926C8C2BC86;
	Wed,  4 Mar 2026 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649214;
	bh=TYl+mO3jTFF78LYOjZjVzDB4wpiR2tpbrL1fIlmPiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnX9G5IJHIAqJiwhY41wj5R4TfHMaDqE1ii9AaTSrwbv9iJ6Qm6oVz4hv7ocV/vmt
	 VRZ3taxDfjg+Ber5v2pNFgLcj5f8o7BvJpYRaZbEhcXyJ1CWRTOYyHG7TqQR4Uy6od
	 M2uP0TOg5Q5HTVSuJDStc/eiP9cm4OOiDsMjqBDcfN2HdDM9RA0I5dNsId2azETua2
	 ToP2BliSOPPXXSHgNYlwnPG3Hi22i5Q0h2quUkT7T2bFlaOVCEsCR7TlKRwezsvGY6
	 52pLVgqttK0B0aVfZNqjdqW471CRFbA/MNe+4WFhLFBwdC3VFVhbFUsiJnVP7tYt/s
	 UPGtErk6TBQzw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org
Subject:
 [PATCH v1 1/2] iio: light: acpi-als: Register ACPI notify handler directly
Date: Wed, 04 Mar 2026 19:32:26 +0100
Message-ID: <8702898.NyiUUSuA9g@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iio/light/acpi-als.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index d5d1a8b9c035..2fe6b493c012 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -90,9 +90,9 @@ static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
 	return 0;
 }
 
-static void acpi_als_notify(struct acpi_device *device, u32 event)
+static void acpi_als_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct iio_dev *indio_dev = acpi_driver_data(device);
+	struct iio_dev *indio_dev = data;
 	struct acpi_als *als = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
@@ -102,7 +102,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 			break;
 		default:
 			/* Unhandled event */
-			dev_dbg(&device->dev,
+			dev_dbg(&als->device->dev,
 				"Unhandled ACPI ALS event (%08x)!\n",
 				event);
 		}
@@ -218,7 +218,17 @@ static int acpi_als_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					       acpi_als_notify, indio_dev);
+}
+
+static void acpi_als_remove(struct acpi_device *device)
+{
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
@@ -234,7 +244,7 @@ static struct acpi_driver acpi_als_driver = {
 	.ids	= acpi_als_device_ids,
 	.ops = {
 		.add	= acpi_als_add,
-		.notify	= acpi_als_notify,
+		.remove	= acpi_als_remove,
 	},
 };
 
-- 
2.51.0




