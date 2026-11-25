Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593678;
	b=1twqrKy610i1Yd/2hXFs7DDu9adBdgBkegAwCG0UG0tna1WqT/7/x9cwfwduQ6B0+qkR
	 ViI5gdmg2zW+6qvd/FJO/FUWBmLUfgf6IdOyZEBegoWmFVrKHc0Mo87M4SU1o4V5cZKcY
	 UxF+BTlVpLNwcm8Vxf018Q9G5CxB4c/xbc0ycsXzvk0u9f1g/5NpV1OUj4jHxk9eAhWu5
	 JCIMexP8YEYUd8KfviB36tfAiksKrqPjKWpsEuL0BdkGCCEKppTb7dgzcu9LbkEpHQSXQ
	 K5WAiylH6iBl9BtXwHZS2uRqak02LaHA0vkkHhsrZu6Y9cf3qAgDaZaW35ye4v/yqUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593678;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mdUv3ZTclVmj521HJj+GZ0EdYKn9/5JLrZrmO62g318=;
	b=l8VOI1kiOwJI8vr1HV4GZjqlkkBT9z2F47dC0Jt2+KUU28XJDXyzErTUYK1MC/QTaX/6
	 9jWdxLw+iBSYY1oDSPSwYBvH6UAJVOXbVdLyu20paWTyeyyMnVHIl0fxCBDmx8pJ0l1fG
	 UrVrZzPU5Xi+COiUBo4p1VopahiX2TvvaITWi1JmLvJvZtMrnHP3IH6OZlREQ+lqxADT6
	 f6ySFHH8h1f2XNwaZJFW5uLWiNCUOXmynpz91sMTE+ARu9H6fNeVVxukgKVUIqm7mMJvX
	 oAPrSxcNeT8t4HXKp53EpxbzbOFGd1VUXOmlcAt3QAmHl1YZqHH6tDegZx489HvEPvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrwb6RAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18722606A321;
	Wed, 25 Nov 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrwb6RAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6280D1F000C4;
	Wed, 25 Nov 2026 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593677;
	bh=mdUv3ZTclVmj521HJj+GZ0EdYKn9/5JLrZrmO62g318=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rrwb6RAB7aFgy/TehqSKusA7eb8qFohvGEWOiaCa5LEir3EjsY8D8jLynktybc06B
	 UdOtMQMP+JSyuk8fEOnbxHZYoAwKMUSx9V1OAlcxwvSITCykwBEW8PV8mMG0mDoF8P
	 OInkySAUIf1M3gBGbYThnsOYMHzrKd17tq0KoVlqlGtWqG9LMGxZxQBcNTxjK9BTjU
	 fYCeQPYzYQkHsTohNS1QNXzwtofQ0dPnNHcqZwx22UzsP/6ox8LrdGGTGntCdix5dU
	 sWFS4/Fm5PsHmiyyvEntGAWflMsqG8ioMsGQIK8AbbcNiQ44SL46qEBgo78sySQ/Hh
	 n4Fbc0Q5K2iMQ==
Message-ID: <f71cfc2e-9e74-482c-a56b-8b0507eb9a69@kernel.org>
Date: Wed, 25 Nov 2026 09:01:14 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
To: Rupesh Majhi <zoone.rupert@gmail.com>, u.kleine-koenig@baylibre.com
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-8-zoone.rupert@gmail.com> <awU0bh5ChdbAsArK@monoceros>
 <20261125075043.37440-1-zoone.rupert@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261125075043.37440-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Nov-26 8:50, Rupesh Majhi wrote:
> On Tue, Nov 24, 2026 at 08:03:59AM +0100, Uwe Kleine-König wrote:
>> > +#include <linux/mod_devicetable.h>
>>
>> don't add <linux/mod_devicetable.h>. I don't know what made you think
>> this is needed, but it is not. i2c_device_id is already provided by
>> <linux/i2c.h> without the overhead (and useless dependencies).
> 
> It was for the of_device_id and acpi_device_id tables. v2 will include
> linux/device-id/of.h and linux/device-id/acpi.h for those instead.
You don't need to include these (unless you're going for full IWYU).
They will be pulled by the respective bus headers.

-- 
Kind regards,
Joshua Crofts

