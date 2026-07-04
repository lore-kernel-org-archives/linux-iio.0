Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D437433E93;
	Sat,  4 Jul 2026 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209532; cv=none; b=eEGF+Fo8JegSDU7+zsMMhAa9zdeFG8rf0BkfpHWrNL89ufKZP1Vz3tR0w3lDu2RqpsiR1z2/tD4qmIjzmnZ2AfoBmO2bCbhw2q75o3UOoCNVdw8mYpd1+I3x0gj2YbTYQx0S0hL1k9Pw6+u+ZACezpFOiirahUVYeQJBlHrHvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209532; c=relaxed/simple;
	bh=sm3m1d07l1r2xVI9lk4+ltRQKINNNMfIeFRlwkw2brM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT835bc1fnCeA7JVA6eUNObmn+SEjVk9VNIqSeGljkH9A66IsA8EJ2z6aHGh3U87b2gUGizZFAnL4HMFOoBFtXocfRFTrJEBqvEaAe2Y9FxcFVTBR16LmW3++dpdfqEZJGukrMf8+i9633HYYklt3uQX7iERkxvpaCg1KrG7+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDz+zSsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDz+zSsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6380F1F000E9;
	Sat,  4 Jul 2026 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783209530;
	bh=dsNd4fo+uQwomh+RXq+QSM6uZHT808GK4jL4rKMuYyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dDz+zSslI/RX3JRoOiqyt4V55TRgQKDPCF8aKVt/YEzLxWi4iDTFc71oZDLDCuI2F
	 NsL+09nHStIW083J9W42WcyLQ4LagFLp3HITReodV/VzCCev6GYFV4Fv2N3MD3uOOR
	 h4yz3yW6g6iYhX7+C3s2o9EB8bF+P6unSLv92VfboHSUu/lCuaDS9l7dOdoxDZQvBm
	 FiyhXBDV0aZheviA5BqDMI0sEtZ23VsWvfjgvkRepwkkfFRorz/R8z1ImBAFnSiTRh
	 65LlNwygSXVlrCz05G+msS+vZovdQs4zjfUrySVRaRGO6g2L/9dAtNlVb3uPwT3jO6
	 d8/f9MJG0PPlA==
Date: Sun, 5 Jul 2026 00:58:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260705005847.21503170@jic23-huawei>
In-Reply-To: <akkOMMlfGWzFReHz@ashevche-desk.local>
References: <20260704124224.4579-1-pengpeng@iscas.ac.cn>
	<akkOMMlfGWzFReHz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 16:44:16 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jul 04, 2026 at 08:42:24PM +0800, Pengpeng Hou wrote:
> > The driver has an OF match table wired to .of_match_table, but does
> > not export the table with MODULE_DEVICE_TABLE().
> > 
> > Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> > information is generated for OF based module autoloading.
> > 
> > This is a source-level fix.  It does not claim dynamic hardware
> > reproduction; the evidence is the driver-owned match table, its use by
> > the platform driver, and the missing module alias publication.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git.

thanks

Jonathan

