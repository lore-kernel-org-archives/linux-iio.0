Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70D7081A;
	Mon, 13 Jul 2026 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783902908; cv=none; b=pUwGXrwf2yI3YQLv9TVPKsfEKE0Nm4d6AXf4upWz7kc8IemuDXtZ/T4rSTdvN0Sm9oQwHqkkawJ4pBmzEDTs3nPDu7W+muJqfb7QbqRGg890YgXjXlxhw5nVUx9GiSYr6jQc5votAlHlExhEJp+NUsLofw2AqgnCdJu27znh2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783902908; c=relaxed/simple;
	bh=qt3bBaUV7nCV/9Zm/MWEZTd8OSaYMVdvqY6JKSl9Tqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osRjVn61V6FeJ/lrzNQtiRxgSB4aMzKt4WYW2arX13YG2FOKyIx4a4BsQ7BO7VrngunkIbuOfpgDVzOOZkJjd5wjNKFM2p2dxlclfePwDmhCZ6fGx66VdvVukH/v2G7RFmciG9rWbsnIvht3nBlPMxrzucLUkwJawmCxtb9h58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DogQGB25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DogQGB25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC4E1F000E9;
	Mon, 13 Jul 2026 00:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783902906;
	bh=aZti8aCt64kPz9dygFkIoD6OqtJjCpyDr1/1VVlwcCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DogQGB25HUOqqx2uYR1mxHjQ5GfT9xZWON9teehZg+Z9ofOdYKZekMCEKDmdZZiI9
	 Dx7bmTAnm100E8589IhsMQYyShUkHJhK8y3XCLcjG3bv9z4GMwZYSKyncSv2VjKwtH
	 Te8gvvqi5EmmspezBvywwgqm/Nh3Vwy0P6qhj1inRbNyMLn6XJSOPAcQfojQhPbndu
	 3bcgr/l237ZMnueSekpv69Ri0WlA8VpAjoaf1Aj7uIZCSNPmhx5vX5vpMecbSOrZ9D
	 xQc/AvN2vuKmnfLB+4MpMZLMT8AYOeCifOBifPS9G1zM5RGyoHvQ3FrJqX7tRMm4Rm
	 Jcl5lJDjPiKPA==
Date: Mon, 13 Jul 2026 01:35:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: remove incorrect kernel-doc
 markings in dds.h
Message-ID: <20260713013501.1912f3f3@jic23-huawei>
In-Reply-To: <20260712223004.7-1-bbnpreetsingh@gmail.com>
References: <20260712223004.7-1-bbnpreetsingh@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 22:30:04 +0000
Babanpreet Singh <bbnpreetsingh@gmail.com> wrote:

> The 13 comment blocks in dds.h noting which sysfs attribute each
> convenience macro creates are opened with the kernel-doc /** marker,
> but they are not kernel-doc: there is no identifier to document.
> Running kernel-doc on the file emits 103 warnings:
> 
>   $ scripts/kernel-doc -none drivers/staging/iio/frequency/dds.h
>   Warning: drivers/staging/iio/frequency/dds.h:10 Cannot find
>   identifier on line:
>    * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY
> 
> The header is not scanned during normal builds (build-time kernel-doc
> checks cover .c files), so the warnings only show up when kernel-doc
> is invoked on the file directly.
> 
> The comments have carried the /** marker since the file was introduced
> in commit 4851d97d87c8 ("Staging: IIO: dds.h convenience macros"). The
> attributes themselves are already documented in
> drivers/staging/iio/Documentation/sysfs-bus-iio-dds, so demote the
> comments to plain /* style rather than converting them into kernel-doc
> for the macros. No functional change.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
Applied.

Thanks,

Jonathan
