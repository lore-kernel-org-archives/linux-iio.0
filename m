Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336737996C;
	Fri,  8 May 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253498; cv=none; b=HyDQ1gtJfUzd1Or5ht5hrLbw+71BXXRqUtVE6T0O8CkTzP7u28VP8DUd79EWQBoUG+DLf3tkvvUky0Jx1FpCKBuP/Ovl4hv8cOd3dj/NrZpOpukzH/OrdlAidijRE/FLfBtA6gNC2EA/Rek3FACVk5nATeA5jSNOjRXYdD4oHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253498; c=relaxed/simple;
	bh=g+PO1ZPQfetzfEdgW0kuymwlhk3d4gVtRR530/mTBOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LM6mc5WLK9ZdV6p8RfXFxtzcQdljjWUyvedqZDmp0CfAeaYb8GTRavLcDW8DUjqIseTtoBfSxncDvNFa8PHzj8e2Y7/66Qa++iF6W2ZpFkS8LdsHiN2E5ybGKAwHM+8lZqHD5oiV7BaqjFerH1Y/l2dkvoElZ1Biqy5QvQGWGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAg6Wgdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAg6Wgdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B489C2BCB0;
	Fri,  8 May 2026 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778253497;
	bh=g+PO1ZPQfetzfEdgW0kuymwlhk3d4gVtRR530/mTBOY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bAg6Wgdv78UdFPk81HDSrncWn9b/sF3sgH+9fU3yBX7JS+uKUWq+jIBqHb6SkuN+h
	 YUMAjMGtB85qsvlqm6BdEeg4f0jbD+QlxOlXkQy+h/V2Tns2w0FSiPzH5kU5EEBkt+
	 noNMxdpzXxFnZSu3An5OGiU9YZYu9C0Uu+AGDK8iJq8JAK16H1YWXeamdZbkMak24f
	 mCPMmN2/2FvN+SuLGVyvzoj4/kzXZyv3Nxdq0OU23/alB5MAXIj8rUys7w1OXJcsJw
	 Tu9mvei1EjKAywXqNv8vEm+RH9kkkvI/8AyCTRQjVpgxNA8+JFhM+iXZaTRzNr0yys
	 8unj87PvDBHrw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 17:18:12 +0200
Message-Id: <DIDE94YBOOP3.KM9I6J4JIJIY@kernel.org>
Subject: Re: [PATCH v1 1/4] driver core: allow certain drivers prohibit
 override via sysfs
Cc: "Mark Brown" <broonie@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
 <20260508095224.1275645-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260508095224.1275645-2-andriy.shevchenko@linux.intel.com>

On Fri May 8, 2026 at 11:42 AM CEST, Andy Shevchenko wrote:
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index d17bd91490ee..16a530b91a00 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -594,7 +594,7 @@ int bus_add_device(struct device *dev)
>  out_subsys:
>  	sysfs_remove_link(&sp->devices_kset->kobj, dev_name(dev));
>  out_override:
> -	if (dev->bus->driver_override)
> +	if (dev->bus->driver_override && !dev->driver->suppress_override_attrs)

I think that doesn't work, when bus_add_device() is called no driver is bou=
nd to
the device yet, so dev->driver should be NULL.

But more in general, I think this isn't an implementation issue, but a
conceptual issue.

The driver_override attribute is on the device, and indicates whether this
device should be forcefully matched against some specific driver.

Now, if we want to suppress this attribute, we can't really let some driver
define whether is should be suppressed for this device.

Which driver would that be? The one that's already bound?

That said, I think the problem you actually want to resolve is not "suppres=
s the
driver_override attribute", but rather "don't bind this driver through
driver_override".

IOW, this is a match() problem not a sysfs attribute problem.

So, I think the change that we actually want, is this one:

diff --git a/include/linux/device.h b/include/linux/device.h
index d54c86d77764..64bcb46edb97 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -839,9 +839,11 @@ static inline int device_match_driver_override(struct =
device *dev,
                                               const struct device_driver *=
drv)
 {
        guard(spinlock)(&dev->driver_override.lock);
-       if (dev->driver_override.name)
-               return !strcmp(dev->driver_override.name, drv->name);
-       return -1;
+       if (!dev->driver_override.name)
+               return -1;
+       if (drv->no_driver_override)
+               return 0;
+       return !strcmp(dev->driver_override.name, drv->name);
 }

 /**
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..d48cd9822634 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -55,6 +55,7 @@ enum probe_type {
  * @owner:     The module owner.
  * @mod_name:  Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @no_driver_override: The driver will not be matched via driver_override=
.
  * @probe_type:        Type of the probe (synchronous or asynchronous) to =
use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -103,6 +104,7 @@ struct device_driver {
        const char              *mod_name;      /* used for built-in module=
s */

        bool suppress_bind_attrs;       /* disables bind/unbind via sysfs *=
/
+       bool no_driver_override;        /* not matchable via driver_overrid=
e */
        enum probe_type probe_type;

        const struct of_device_id       *of_match_table;

This should also get us rid of the SPI patch, since SPI already uses
device_match_driver_override() in spi_match_device().
