Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9B2D60A;
	Sun,  5 May 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935241; cv=none; b=N8ODulYX1ZZIz/3V8FUoUKmFGlIrK7laNOqJnsauEb/3qfKw2QMxMyZU6r5XKgin4nQv7k9/noOFvDETat88e+PRn0rAnhSk8DwIAhPReuZwlYMPmJ+EIPw+ZFHb0bN4Hp8FEISOg3b+uE/k8Bo+4zwp5VcSff1UeZlEL1UNKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935241; c=relaxed/simple;
	bh=E35JbgzFB3vX8SM4Q4jRMbpTBuZcCRNlYDexqfXxnPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tny32RKIjkKOdiQYSU8o0SVMlNDHcPAf3B3rlFHKasVj+WMsYJx7EBvzXkbzTk6FdwQa15ETxpZOe2/k07HE8dHiwjAW2yGdynmbDXBP9llHaL+h1G08g2ZkIY+TMiw+NQtHRJdplheKTSwQDNw7Wk35bhVEoQoowXK4vbIT/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4OveRWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4OveRWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3472C113CC;
	Sun,  5 May 2024 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714935240;
	bh=E35JbgzFB3vX8SM4Q4jRMbpTBuZcCRNlYDexqfXxnPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4OveRWX/Odgzcg0JLkUBXsfdudpCxAmYa4vAJIaKmWaOhml76pvVff/CnLHvbygY
	 eWlr1znCBL4j/Lux50zWaf+xF8yc8Uys9vF9rx5wZyFx6osqRHK+piGhU1iHtObSh2
	 Ao8WWK21Uv9q/hUGfYo156U8WeIQc9kWXCsCaiVWeyf1DhLlaJAI0uiyNrd77yC15W
	 hVRgo1lhdDAHHI4SOsYwxL3uMJ4sDHw/6e3D7YJPGvfJXLWx6Vj7e9+Anx+3S9vWAm
	 DsVqPUdyaQkUsPkgiQ0+HnE4dUE3i8cbx5V81ghliKX7z2CUEcdr8OaU6SyvXPWJfW
	 FrqXD4t8Hxh+A==
Date: Sun, 5 May 2024 19:53:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] iio: pressure: bmp280: Use BME prefix for
 BME280 specifics
Message-ID: <20240505195346.4cbc174b@jic23-huawei>
In-Reply-To: <20240429190046.24252-3-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:38 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Change the rest of the defines and function names that are
> used specifically by the BME280 humidity sensor to BME280
> as it is done for the rest of the BMP{0,1,3,5}80 sensors.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied,

Thanks,

Jonathan
