Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E03D6686;
	Wed,  4 Mar 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649218; cv=none; b=tUOD0UPHobHaJe/QubUz1vHbN4PFdTtuqFGNutdDHYfJtOIB3ALVBg8OlCu9PwYeXM9BQBe5vfcFP9c4g8hcxjX1FfgZJFoyoPyt9sO5/2DqrgH69wjRFdWcNCHAmhnVX1TdXZVfS9JbdtG9fbHTnru5qIMoF4dWn+cJjSiAiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649218; c=relaxed/simple;
	bh=RQdiDeOtHfF6Pal/tLUKly0TFJY4YYJCU3MQfoJSd30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFpTgLLTCN+K2vqb1G8SDx2evF4fi5skgP06/rYwaLuB8ZbY5eM4xNb80D7C0LSVCLz/FRx5PW+HWHW173avJq2iZz8otF9XRVZeLvLs9VeOONKOaCHJnQwSycAvKK2Mit2BszaLD8I4m2/qMjs0tgSHwQmkvOHnO03QiqVFYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE9wlb0+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE9wlb0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935DDC4CEF7;
	Wed,  4 Mar 2026 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649218;
	bh=RQdiDeOtHfF6Pal/tLUKly0TFJY4YYJCU3MQfoJSd30=;
	h=From:To:Cc:Subject:Date:From;
	b=hE9wlb0+uDLHYpv2GW6Oyf5SE6oY6CxbZ2y8uIo9yqR/nFWcyhOIWV8SwNTuRFO3P
	 KTIed74zgo6T4k7IJsKU9meGMxAkupiLVeQ9uRzO4bfH0Mm35kmJtKl6DXnzI+kU67
	 4//Rdt7TV+kYXG9nGm8+bwgqHNG85kdKlINuxrFtNkISnVxmUgDxSEjYmKjajd0FS2
	 nB9i4sviIbBWzg8tQLP/M8echjkXgkydSPXu6rCTB3Nc2suu89DQ06a3IuCxRWKe65
	 FLZViJ3dcQdNGvnPJpysXm6EcxIoItOTBbLMzftvVAwaSzGeMDkteuihdbrcGISjeM
	 dvYZVyI7VpXxg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org
Subject:
 [PATCH v1 0/2] iio: light: acpi-als: Use platform device for driver binding
Date: Wed, 04 Mar 2026 19:31:23 +0100
Message-ID: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the IIO ACPI Ambient Light
Sensor (ALS) driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



