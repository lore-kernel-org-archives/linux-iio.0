Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F01C8EB;
	Sun,  2 Aug 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693689; cv=none; b=W2tP4n4R1EWgvH5mf4HIQDqpjED1kIAFoDC6YMuMarmF4wSGc0ToBsLqwHQZdTFrbNe5sVHkRh+n6eQ9gQ8EGJWxp/8QMW0eJPxt/WMk7A3zJzmtKEfcJNEC0G1HITgFgwVgr7PUtvA2ByyRe44m58gMXr0jj3a4wmAL4CAxVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693689; c=relaxed/simple;
	bh=JqtWDhBt4TpKr9yESkn0JzqYMhalwTJh0+GhhiT78jE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQOUt5ZFOdnGxWkvCwxKSbTh472qSzZF4M+0LpBL7PebLYu7VHsKdP9fdjBUXx77g8zR+sRBi7OXT58huZncd/8Y5vewrf660B/b0B0HX8VYjicFj1MAGGJUGJP/mvTg2H7oUwi0WqWJwCfkW/teRTDp41mEHn6EbB2yUNa4JJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH5VT1l3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH5VT1l3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6811F000E9;
	Sun,  2 Aug 2026 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693687;
	bh=U6oo6e/pe1V27HqHXqUlu5ywrMXuoL48dmNN36r27hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TH5VT1l3Hi8xn5wlB6sNc7Y3R5VeN1eCeG3zO7DtrEI0NILQkqsfKAniUYleToJZp
	 llwyRXj9g33BYVmGUMbvJE8bmxiWvZ/Kvez1flsxmOLDSaak07LEA7jb4ikS9ZVEmn
	 Z6dqdGOI5gH04rT20vI53CtWpNMMZYTUnH8NzD9a/5BSzTNPRWvO3HbsBF9/rrjOOh
	 PvosLEuSL6RmK/XAOcJ6jumwxkhiPUHt/NWxYcEEy3WwRQL7/3o1cwKNicEjw6iTvL
	 PErH2INoip4Xb3JEkfSqr7LC+TYGE1qVMLXxJdoUXWUXOnwz4eKU/gRVrjHltqit5P
	 NjSDfhKCTxwvw==
Date: Sun, 2 Aug 2026 19:01:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: imu: bmi270: add BOSC0160 PNP ID for gaming
 handhelds
Message-ID: <20260802190121.73d3f1ed@jic23-huawei>
In-Reply-To: <20260731195325.44453-4-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
	<20260731195325.44453-4-philm@manjaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 21:53:24 +0200
Philip Mueller <philm@manjaro.org> wrote:

> Adding BOSC0160 as PNP ID will enable more gaming
> handhelds using a BMI260 sensor with this PNP ID
> to properly use the bmi270 driver.
Very short wrap. Go up to 75 characters.

As in early one, ACPI ID not PNP ID.  Ideally we'd also have confirmation
from bosch that they have assigned the IDs like this.  I ask in particular
because they have multiple parts with 160 numbers and they aren't
all supported by this driver. E.g. bmg160 which is a gyro only part.

+ Can we have at least one example part that is using this ID as
a comment inline.  Some of those earlier discussions of bosch IDs
identified ones that we were fairly sure were only ever used in
prototype devices.

Jonathan

> 
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Philip Mueller <philm@manjaro.org>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index d7faebcbd2fa..839e71b65f05 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
>  static const struct acpi_device_id bmi270_acpi_match[] = {
>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	{ "BOSC0160", (kernel_ulong_t)&bmi260_chip_info },
>  	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
>  	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */

