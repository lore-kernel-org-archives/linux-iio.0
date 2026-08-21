Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CEB30D3FD;
	Fri, 21 Aug 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279622; cv=none; b=c5ZXnw5thOB1fJ9fIq6SrxU8uhMGeS3aS8eh0+2hEX4r8BuLCfMrTrTUqW8hlnp58yCK3Su/MQB028UHaZMpBCvZAYOBz851vn+8/CJetXeMaGME2/Z2thQvXXWj4fFCpVuDltnoRXgKZZg89En2ObfYlRtHGTp3YlTsLlizSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279622; c=relaxed/simple;
	bh=hICsbhSrmYEmKwGMKZaQu46cLxptLAmIKPn+5tLbfA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOP2ui18MNPnhNqocD5cKoUIB80i0A8FdIpzPvaclYm7cguGFFqlspoRj5Wk47Pybyh/bdTMHR5D7oF3qJSMmsDGc/K0cdnvVLj/uZni0S4lWLk7kgD/2Bte2mP9VFv2h0v9m6mXjN1yFgUs3xsqoPxAEtvGAqvXv4y9JWNpC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f54a4cVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f54a4cVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2B81F000E9;
	Fri, 21 Aug 2026 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787279621;
	bh=QpXh+KT1B0l3QcV/ej5UwE+ICSTOw1IVfbDkvPge8K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f54a4cVP3N560x2uuikktHv8Z+YxzcTyABzQRvRgSG4W2fIOZnXxuoIVmLTlhNYfI
	 Ij24/MzNbPq1v4eWMzooTybzVVimc75rNeWQNr8bvTUAe88vS5nKbGALfkhESN9WJq
	 fIAmZbrlYOiuTeyayYLaBxSvtIxS0ktWySHmi/DTjeIyaKvd+a0dh5EKOhBnGOWFHp
	 L4I0bXz6vkV/X1vsucV6HVhrvMU7zKgPng+SSufWHsAD4qaBpvcB15YIV+OpiGnPye
	 uzdw0T+0pBvZcnA1lcccOGPCy6LNlBQpVuBvKYiUYok/Y9B80Pgy5GHx1EWqaMFikS
	 giT931qSsJAKQ==
Date: Fri, 21 Aug 2026 03:33:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com,
 julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, grondon@gmail.com, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 0/5] iio: add Open Sensor Fusion IIO driver
Message-ID: <20260821033334.400af4d3@jic23-huawei>
In-Reply-To: <20260820050608.5440-1-kimjinseob88@gmail.com>
References: <20260820050608.5440-1-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 14:06:03 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Open Sensor Fusion (OSF) is a physical sensor board that reports
> measurements over UART.  Add a serdev driver using the generic
> "opensensorfusion,osf" compatible.
> 
> The compatible is intentionally independent of a board model or firmware
> revision.  A fixed wire header carries the protocol version, while a
> capability report discovers the available sensors and channels at runtime.
> Supported capabilities are exposed as four IIO devices: accelerometer,
> gyroscope, magnetometer, and temperature.
> 

Sashiko has one reasonable sounding comment
https://sashiko.dev/#/patchset/20260820050608.5440-1-kimjinseob88%40gmail.com

What this cover letter is missing is any info on maturity of the
specification.  Is this at a stage where merging it to Linux
makes sense, or are there still elements on the spec side that need
to be resolved?

I'll take a fresh look anyway given it has been a while since
the last version, but others may make their decisions based on that
statement of how mature things are.

Jonathan
