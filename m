Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726D30B53A;
	Thu, 26 Mar 2026 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557644; cv=none; b=bmZ052t4/E1qu44bKWFxhCEBltl+MltOcrrvknnG388hC7DR9p0DEdAa2csoJ7O51h8dfC580zAV7f+kYdQ2WxsVjuePKV6UDBwrla7262HK4P6Gw9t9g574v5VeEKueWxZNXaJFdNlTHzoFuYIoCWTWl9YUVDSzYITR9tBeeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557644; c=relaxed/simple;
	bh=pMa3vHfJeYPnyaCqhDyV4iqYFcK2ACkX6++rC3pF0iE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCEMF6YKXpYhi+Q9nkeU4WsiB910+vNMUGowIHHII3J5zusP3lsNwS6Dv1WyNBzs8H616rjXnfWLUsyD9Q6bQcHbkDEss4YKfoJpD9uEo9xqDu3jNO6N+x+/4YMNMg7ET1lvRsvMcTrO3dWX/MycxUzAkV1nEyLwm905sjbCIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGuwle0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGuwle0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D6FC116C6;
	Thu, 26 Mar 2026 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774557643;
	bh=pMa3vHfJeYPnyaCqhDyV4iqYFcK2ACkX6++rC3pF0iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OGuwle0xy3lcrthDolngH7bpDkDMCgJXkOkxSMv3CqM/UVmrOgOLz+kLtq2X55eeb
	 OgOeS/jlIWwhyGeUdMyqaCGp6Uf7WM2CxzIduq71tFlGsVzyL9eCB3KChMKIXfEd2Z
	 G1j4UbUYLTVmuq9eHliRg5kJTaZDeyV7reXCCErkMEh3VhmqAw3jqHvb8//jHaMjRK
	 zzwggu1S9q6Wub03ari0W62M4V3nIDiQwNtGcDCBXyoP1Ju4YOlXpoRnJRs+0qAIhB
	 n3dAlBwq9aDnQUCm1jKQapjJ/6w6Ic75pO3VxlbaB9Z/A4JYhoOafUAX+Nt6SXY9Vo
	 X3ACco/QPtGbQ==
Date: Thu, 26 Mar 2026 20:40:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Milan Misic <twoexem@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi
 gyroscope
Message-ID: <20260326204036.592c9dd8@jic23-huawei>
In-Reply-To: <acUEJsNN5a6-FaLD@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
	<acUEJsNN5a6-FaLD@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 12:02:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 24, 2026 at 08:36:26PM +0100, Milan Misic wrote:
> > The SHIFT13mi or SHIFTbook tablet device by the German manufacturer
> > SHIFT contains an STM LSM6DSO IMU declared in the DSDT with the
> > hardware ID SMOCF00. Add this ID to the ACPI match table so that the
> > driver binds correctly to this device.
> > 
> > WHO_AM_I register returns 0x6c, confirming LSM6DSO.  
> 
> Based on the provided information,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.
