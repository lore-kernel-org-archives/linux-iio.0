Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F133246ED;
	Fri, 11 Sep 2026 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169376; cv=none; b=feWdW11ctLoxf2Z9/4O681Uziq+r44PP0Ss+qPithqG2ecpzSLB6tg6hpjfzO5dSXFmsgDqSzmPbe4jtX19hL2gvtbzmneXbxBDB6kRVHOiGinvaC2JU4J4sdYS4JSs5+C5QyNaFQtMu5JWC7vnHx8PE8c20R/cls/bRTktyF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169376; c=relaxed/simple;
	bh=7lwcmw3oOfQJEkgyBkIMGhKBHj1UPW1+VFZ59Qe3eQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh32qZnAvwnZL3egO9UYi2d22ok1gommVNp4oupNqTNXjih7ar2937J2pMpyp4hdStJ41kBHVMgZwuENdLlyd5hq4p13023PRposT1zCyFFmBgMfxOooqfsSy4b410k+scnmKIxWuIIjuJVxSVax9CWp9Tyq0pcyNtFh0+MC7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X0L5iUHT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0L5iUHT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tlQQvF1b+LoQVB9XRaUbbPD8hANIsVjq3TZJg8ASnTw=; b=X0L5iUHTRwYhwkzF16rcwqBBKs
	1qga73wtg/r0iRou6O98urcmLPTKRa4esBDCXGEsnaoaxFHwdYHK4FFWaBlZM9s45MvloNU6NUNlO
	hRUW73Vrv9bvBNYeqmD2D/O0JyKULSo1zLhtm4ih+xlHcRc5JDB8s0jaKdy7cLyqdliYHZQhxKbA9
	cEEVhBIGuTY9h3nTuZ24zHvzQbZDPEhI/w6qOBIKBU/kFuw+M95M6qF9BY1GLYlubBeJnoqtrO0Nw
	rPj6irzpQXFvbqdsaeOHociOw0IJvOkyLnYPyJ7N9Vyzz9NOhb25FeGl9SsoWCMriFD+11SkWccur
	Rqli2UEw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5AgH-00000000MHz-1aVp;
	Fri, 11 Sep 2026 23:29:17 +0000
Message-ID: <5cd22376-6921-4a2b-acba-371bcbbfa00f@infradead.org>
Date: Fri, 11 Sep 2026 16:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
 linux-i3c@lists.infradead.org
Cc: alexandre.belloni@bootlin.com, vitor.soares@toradex.com,
 samagazaryan@google.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 boris.brezillon@collabora.com, oleksandr.shulzhenko.viktorovych@intel.com,
 tgopinath@linux.microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux@roeck-us.net, Frank.Li@nxp.com, jorge.marques@analog.com,
 pgaj@cadence.com, wsa+renesas@sang-engineering.com,
 tommaso.merciai.xr@bp.renesas.com, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 andy@kernel.org, lorenzo@kernel.org, enelsonmoore@gmail.com,
 rppt@kernel.org, pratyush@kernel.org, giovanni.cabiddu@intel.com,
 gabewhigham@gmail.com, haren@linux.ibm.com, pasha.tatashin@soleen.com,
 jirislaby@kernel.org, adrian.ho.yin.ng@altera.com, ustc.gu@gmail.com,
 jszhang@kernel.org, adrian.hunter@intel.com, akhilrajeev@nvidia.com,
 tze.yee.ng@altera.com, manikanta.guntupalli@amd.com,
 shubhrajyoti.datta@amd.com, jarkko.nikula@linux.intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/26 2:09 PM, Meagan Lloyd wrote:
> The i3cdev driver is a character device driver that allows user-space
> to control and interact with I3C devices.
> 
> Currently, it has the ability to perform Single Data Rate (SDR)
> transfers - basic reads/writes.
> 
> With the addition of sysfs driver_override, there is now a
> straightforward and direct way to match the i3cdev driver to any i3c
> device without stepping on the toes of more specialized drivers that are
> loaded automatically.
> 
> This is accomplished by the i3cdev driver not having any entries in the
> i3c_device_id table. After boot, simply set the driver_override to
> "i3cdev" and bind the device manually via the sysfs bind knob. This can
> also be automated with udev rules as well.
> 
> The character device interface will be exposed at:
> /dev/bus/i3c/<bus id>-<Provisional ID>
> 
> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> Assisted-by: Claude:claude-opus-4.8 copilot
> ---
>  Documentation/userspace-api/i3c/i3cdev.rst    | 152 ++++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   7 +
>  drivers/i3c/Kconfig                           |  12 +
>  drivers/i3c/Makefile                          |   1 +
>  drivers/i3c/i3cdev.c                          | 730 ++++++++++++++++++
>  include/uapi/linux/i3c/i3cdev.h               |  70 ++
>  7 files changed, 973 insertions(+)
>  create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
>  create mode 100644 drivers/i3c/i3cdev.c
>  create mode 100644 include/uapi/linux/i3c/i3cdev.h
> 
> diff --git a/Documentation/userspace-api/i3c/i3cdev.rst b/Documentation/userspace-api/i3c/i3cdev.rst
> new file mode 100644
> index 000000000000..ad246bf28919
> --- /dev/null
> +++ b/Documentation/userspace-api/i3c/i3cdev.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +I3C Device Interface
> +====================
> +
> +This interface allows access to I3C devices from userspace.
> +
> +As I3C devices adhere to the I3C protocol, simple transfers can be accomplished
> +using a generic driver. Currently, this interface supports private Single Data
> +Rate (SDR) read and write transfers.
> +
> +The i3cdev module will not auto-bind to devices. Userspace needs to explicitly
> +bind the device to the driver. This is to avoid interfering with the binding of
> +specialized drivers.
> +
> +Once bound, a character device interface will be created at:
> +/dev/bus/i3c/<bus id>-<Provisional ID>.
> +
> +====================
> +Usage
> +====================
> +
> +Any discovered I3C devices by the I3C subsystem will have device folders under /sys/bus/i3c/devices/<bus id>-<Provisional ID>.
> +To allow binding of a device with i3cdev driver, set the driver_override:
> +
> +::
> +
> +    # echo "i3cdev" > /sys/bus/i3c/devices/<bus id>-<Provisional ID>/driver_override
> +
> +If the i3cdev driver is not yet loaded, load it and it will cause the driver to bind
> +to any devices with the override in place.
> +
> +If the i3cdev driver is already loaded, go ahead and perform a manual bind:
> +
> +::
> +
> +    # echo "<bus id>-<Provisional ID>" > /sys/bus/i3c/drivers/i3cdev/bind
> +
> +Set driver override
> +::
> +
> +    # echo "i3cdev" > /sys/bus/i3c/devices/0-deadbeef001/driver_override
> +    # echo "i3cdev" > /sys/bus/i3c/devices/0-deadbeef002/driver_override
> +
> +Bind the device to the driver
> +::
> +
> +    # echo "0-deadbeef001" > /sys/bus/i3c/drivers/i3cdev/bind
> +    # echo "0-deadbeef002" > /sys/bus/i3c/drivers/i3cdev/bind
> +
> +Observe the resulting character device files under /dev/bus/i3c/
> +::
> +
> +    # ls -ltr /dev/bus/i3c/
> +    crw-------    1 root     root      235,   1 Jun 30 17:49 0-deadbeef002
> +    crw-------    1 root     root      235,   0 Jun 30 17:49 0-deadbeef001
> +
> +BASIC CHARACTER DEVICE API
> +===============================
> +The API supports private Single Data Rate (SDR) read and write transfers.
> +Those transaction can be achieved by the following:
> +
> +``read(file, buffer, sizeof(buffer))``
> +  The standard read() operation will work as a simple transaction of private
> +  SDR read data followed a stop.
> +  Return the number of bytes read on success, and a negative error otherwise.
> +
> +``write(file, buffer, sizeof(buffer))``
> +  The standard write() operation will work as a simple transaction of private
> +  SDR write data followed a stop.
> +  Return the number of bytes written on success, and a negative error otherwise.
> +
> +``ioctl(file, I3CDEV_XFER, struct i3cdev_xfers *xfers)``
> +  It combines read/write transactions without a stop in between.
> +  Return 0 on success, and a negative error otherwise.
> +
> +C EXAMPLE (PSEUDO CODE)
> +=======================
> +You need to open (and get a file descriptor) to /dev/bus/i3c/<bus id>-<Provisional ID>,
> +do your operations (read, write, ioctl), and then close it.
> +
> +The following header files should be included in an I3C program::
> +
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <i3c/i3cdev.h>
> +#include <stdint.h>
> +
> +These additionally are used by this example::
> +
> +#include <stdlib.h>
> +#include <assert.h>
> +
> +To work with an I3C device, one must call open and get a file descriptor::
> +
> +	int fd;
> +
> +	fd = open("/dev/bus/i3c/0-deadbeef001", O_RDWR);
> +	if (fd < 0)
> +		exit(EXIT_FAILURE);
> +
> +Now that the file is open, we can do some operations::
> +
> +	int ret;
> +
> +	/* Write function */
> +	uint8_t  buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef};
> +	ret = write(fd, buf, 5);
> +	if (ret != 5) {
> +		/* ERROR HANDLING: I3C transaction failed */
> +	}
> +
> +	/*  Read function */
> +	ret = read(fd, buf, 4);
> +	if (ret < 0) {
> +		/* ERROR HANDLING: I3C transaction failed */
> +	} else {
> +		/* Iterate over buf[] to get the read data */
> +	}
> +
> +	/* IOCTL function */
> +	struct i3cdev_xfer xfers[2] = {0}; /* Must zero out for compatibility */
> +	struct i3cdev_xfers xfers_metadata = { .nxfers = 2,
> +					       .xfers = (uintptr_t) xfers,
> +					       .xfer_size = sizeof(struct i3cdev_xfer)
> +					     };
> +
> +	uint8_t tx_buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef};
> +	uint8_t rx_buf[10];
> +
> +	xfers[0].data = (uintptr_t) tx_buf;
> +	xfers[0].len = 5;
> +	xfers[0].rnw = 0;
> +	xfers[1].data = (uintptr_t) rx_buf;
> +	xfers[1].len = 10;
> +	xfers[1].rnw = 1;
> +
> +	ret = ioctl(fd, I3CDEV_XFER, (uintptr_t) &xfers_metadata);
> +	if (ret < 0) {
> +		/* ERROR HANDLING: I3C transaction failed */
> +	} else {
> +		/* For reads, optionally verify that the response matches expectations */
> +		assert(xfers[1].len == xfers[1].actual_len);
> +
> +		/* For reads, iterate through response data using xfers[i].actual_len */
> +	}
> +
> +The device can be closed when the open file descriptor is no longer required::
> +
> +	close(fd);
> \ No newline at end of file

Fix the warning above, please.
Also:
Documentation/userspace-api/i3c/i3cdev.rst: WARNING: document isn't included in any toctree [toc.not_included]

add that file to the table of contents (somewhere).

thanks.
-- 
~Randy

