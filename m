Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79634106D;
	Fri, 20 Feb 2026 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585287; cv=none; b=Hm8c6wxzwY2pN9PW/7DPQmB/pWZj0UtWPi6SouLKtMipf6CxNZBHaTdc9xB0OsmGQOfQ4V5V5tJi85zhed+3GZeffp4FTF0DV4lHzGSkbk7TYBooAch9bYj7s/4LKZwTe01XWuzmtlOFvKXYkWHkoVzvkvo5YtTAMzn1LrZp+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585287; c=relaxed/simple;
	bh=K2LktiNgsvlC8hXV0im+euoFRoFM6yb0b2TirzexPsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPHKly/oDNPzqy1B5KNlVo0czHKMPeVYv+DzVRP9XZhjFQkR8UpUrEh+V6aTeQT+4O3eVEWxFgWTuevYmeGc0BpOuRPTkgTldV9K6FnznNy9sJ8ERMHCTrZfilU9hGp5tbWPUel230YfreahrdF/lj+fMmDkiCRXd4YxQYIlTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGswdZNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGswdZNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7614CC116C6;
	Fri, 20 Feb 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585286;
	bh=K2LktiNgsvlC8hXV0im+euoFRoFM6yb0b2TirzexPsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGswdZNsfsYuItruMDQlZVRuumuXUDBxEk2s4qWtUrUKh8hv2aKFt9OsX8zaj+eLQ
	 tO0GMKeeZ9S/Blq8Y3LFlwGT+D7ejuuYgobgVrqFZiv6HT5I3QU7FpGQpt3jDgM8YE
	 b1FuFoZpush8V0b2jl4iD9MutLZ6FmcGNMKjj3i7vsow3CNi8mCqt2PqFyifI88ZT9
	 SewCsBhFSU2JQX8XNb9CSFZ3+xUjfl781S3AkGh+UrSd+HBYo5Ul8sZO+/Df2cM3fp
	 b009HdIhIzXxcK8+/tbTM46AXJMYpQfli5XuOE+9rk4JcBhel2DrA4IKZFT2LLE1Ue
	 qkfrvvvmrR/fw==
Date: Fri, 20 Feb 2026 11:01:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: magnetometer: si7210: simplify probe with
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260220110109.3c47ec5a@jic23-huawei>
In-Reply-To: <20260216131714.90508-1-antoniu.miclaus@analog.com>
References: <20260216131714.90508-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 15:17:04 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.
> 
> This is a functional change as VDD voltage is now read once at probe
> rather than dynamically on each temperature measurement. However, in
> real deployments it is very rare for VDD to change after initial probe.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied.  Thanks

Jonathan
