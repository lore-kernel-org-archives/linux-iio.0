Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [212.40.180.161] ([212.40.180.161]:39636 "EHLO
	smtp-out-039.synserver.de" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752489AbcBIURD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 15:17:03 -0500
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Adriana Reus <adriana.reus@intel.com>, jic23@kernel.org
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
 <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, lucas.de.marchi@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56BA47E2.6080304@metafoo.de>
Date: Tue, 9 Feb 2016 21:11:14 +0100
MIME-Version: 1.0
In-Reply-To: <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/2016 10:20 AM, Adriana Reus wrote:
[...]
> +config INV_MPU6050_SPI
> +	tristate "Invensense MPU6050 devices"

depends on SPI_MASTER

> +	select INV_MPU6050_IIO
> +	select REGMAP_SPI
> +	help
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050-spi.
[...]
[...]
> +static struct spi_driver inv_mpu_driver = {
> +	.probe		=	inv_mpu_probe,
> +	.remove		=	inv_mpu_remove,
> +	.id_table	=	inv_mpu_id,
> +	.driver = {
> +		.owner	=	THIS_MODULE,

Drop the owner field that should no longer be necessary.

> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.name	=	"inv-mpu6000 spi driver",
> +		.pm     =       &inv_mpu_pmops,
> +	},
> +};

